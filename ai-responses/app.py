import os
import json
import hashlib
import logging
from pathlib import Path
from datetime import date, datetime, timedelta
from typing import Dict, Any, List, Optional

import joblib
import numpy as np
import pandas as pd
import tensorflow as tf
from fastapi import FastAPI, HTTPException, Request
from fastapi.exceptions import RequestValidationError
from fastapi.responses import JSONResponse
from fastapi.encoders import jsonable_encoder
from pydantic import BaseModel, Field
from sklearn.preprocessing import MinMaxScaler
from tensorflow.keras import Sequential
from tensorflow.keras.layers import Input, LSTM, Dense, Dropout
from tensorflow.keras.callbacks import EarlyStopping
from apscheduler.schedulers.background import BackgroundScheduler

# -----------------------------------------------------------------------------
# Configuration
# -----------------------------------------------------------------------------
BASE_DIR = Path(__file__).resolve().parent
DATA_DIR = Path(os.getenv("NUTRIFLUX_DATA_DIR", BASE_DIR / "data"))
SALES_FILE = Path(os.getenv("SALES_CSV", DATA_DIR / "sales_transactions.csv"))
PURCHASE_FILE = Path(os.getenv("PURCHASE_CSV", DATA_DIR / "purchase_history.csv"))
WASTE_FILE = Path(os.getenv("WASTE_CSV", DATA_DIR / "waste_history.csv"))
MODEL_DIR = Path(os.getenv("MODEL_DIR", BASE_DIR / "models"))
BATCH_DIR = Path(os.getenv("BATCH_DIR", BASE_DIR / "batch_output"))
MODEL_DIR.mkdir(parents=True, exist_ok=True)
BATCH_DIR.mkdir(parents=True, exist_ok=True)

WINDOW_SIZE = 30
FORECAST_DAYS = 7
FEATURE_COLUMNS = ["sales", "purchases", "waste", "dow_sin", "dow_cos"]
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("nutriflux-ai")

MODEL_CACHE: Dict[str, Dict[str, Any]] = {}
DAILY_DATA: Dict[str, pd.DataFrame] = {}
PRODUCT_INFO: Dict[str, Dict[str, str]] = {}
SCHEDULED_FORECASTS: Dict[str, Any] = {}

def read_csv_or_fail(path: Path, required_columns: List[str]) -> pd.DataFrame:
    if not path.exists():
        raise FileNotFoundError(
            f"Cannot find {path}. Place the supplied CSV files in the data folder "
            "or configure SALES_CSV, PURCHASE_CSV and WASTE_CSV."
        )
    frame = pd.read_csv(path)
    missing = [column for column in required_columns if column not in frame.columns]
    if missing:
        raise ValueError(f"{path.name} is missing columns: {missing}")
    return frame


def load_historical_data() -> None:
    sales = read_csv_or_fail(
        SALES_FILE, ["pid", "pname", "category", "datetime", "sold_qty", "units"]
    )
    purchases = read_csv_or_fail(
        PURCHASE_FILE, ["pid", "pname", "datetime", "purchased_qty", "units"]
    )
    waste = read_csv_or_fail(
        WASTE_FILE, ["pid", "pname", "datetime", "result_qty", "units"]
    )

    for frame in (sales, purchases, waste):
        frame["datetime"] = pd.to_datetime(frame["datetime"], errors="coerce")
        frame.dropna(subset=["pid", "pname", "datetime"], inplace=True)

    for frame, qty_col in (
            (sales, "sold_qty"),
            (purchases, "purchased_qty"),
            (waste, "result_qty"),
    ):
        frame[qty_col] = pd.to_numeric(frame[qty_col], errors="coerce").fillna(0)
        frame[qty_col] = frame[qty_col].clip(lower=0)
        frame["product_key"] = frame["pname"].astype(str).str.strip().str.casefold()

    sales["date"] = sales["datetime"].dt.floor("D")
    purchases["date"] = purchases["datetime"].dt.floor("D")
    waste["date"] = waste["datetime"].dt.floor("D")

    sales_daily = sales.groupby(["product_key", "date"], as_index=False)["sold_qty"].sum()
    purchase_daily = purchases.groupby(["product_key", "date"], as_index=False)["purchased_qty"].sum()
    waste_daily = waste.groupby(["product_key", "date"], as_index=False)["result_qty"].sum()

    names = sales.drop_duplicates("product_key").set_index("product_key")
    for key, row in names.iterrows():
        PRODUCT_INFO[key] = {
            "productName": str(row["pname"]).strip(),
            "category": str(row["category"]),
            "units": str(row["units"]),
        }

    product_keys = set(sales_daily["product_key"])
    for key in product_keys:
        s = sales_daily[sales_daily.product_key == key].set_index("date")["sold_qty"]
        p = purchase_daily[purchase_daily.product_key == key].set_index("date")["purchased_qty"]
        w = waste_daily[waste_daily.product_key == key].set_index("date")["result_qty"]

        start = min(s.index.min(), p.index.min() if len(p) else s.index.min(), w.index.min() if len(w) else s.index.min())
        end = max(s.index.max(), p.index.max() if len(p) else s.index.max(), w.index.max() if len(w) else s.index.max())
        index = pd.date_range(start=start, end=end, freq="D")

        daily = pd.DataFrame(index=index)
        daily["sales"] = s.reindex(index, fill_value=0).astype(float)
        daily["purchases"] = p.reindex(index, fill_value=0).astype(float)
        daily["waste"] = w.reindex(index, fill_value=0).astype(float)
        day_of_week = daily.index.dayofweek
        daily["dow_sin"] = np.sin(2 * np.pi * day_of_week / 7)
        daily["dow_cos"] = np.cos(2 * np.pi * day_of_week / 7)
        daily.index.name = "date"
        DAILY_DATA[key] = daily[FEATURE_COLUMNS].astype(float)

    logger.info("Loaded historical data for %s products", len(DAILY_DATA))


load_historical_data()

# -----------------------------------------------------------------------------
# LSTM model training and persistence
# -----------------------------------------------------------------------------
def model_file_key(product_key: str) -> str:
    return hashlib.sha256(product_key.encode("utf-8")).hexdigest()[:20]


def train_product(product_key: str, force_retrain: bool = False) -> Dict[str, Any]:
    if product_key not in DAILY_DATA:
        raise KeyError(product_key)
    if product_key in MODEL_CACHE and not force_retrain:
        return MODEL_CACHE[product_key]

    file_key = model_file_key(product_key)
    model_path = MODEL_DIR / f"{file_key}.keras"
    scaler_path = MODEL_DIR / f"{file_key}_scalers.joblib"

    if not force_retrain and model_path.exists() and scaler_path.exists():
        try:
            saved = joblib.load(scaler_path)
            model = tf.keras.models.load_model(model_path)
            result = {
                "model": model,
                "feature_scaler": saved["feature_scaler"],
                "target_scaler": saved["target_scaler"],
                "mae": saved.get("mae"),
            }
            MODEL_CACHE[product_key] = result
            return result
        except Exception as exc:
            logger.warning("Could not load saved model for %s: %s", product_key, exc)

    daily = DAILY_DATA[product_key].copy()
    if len(daily) < WINDOW_SIZE + FORECAST_DAYS + 30:
        raise ValueError(f"Not enough history to train LSTM for {PRODUCT_INFO[product_key]['productName']}")

    split_at = int(len(daily) * 0.80)
    feature_scaler = MinMaxScaler()
    target_scaler = MinMaxScaler()
    feature_scaler.fit(daily[FEATURE_COLUMNS].iloc[:split_at])
    target_scaler.fit(daily[["sales"]].iloc[:split_at])

    scaled_features = feature_scaler.transform(daily[FEATURE_COLUMNS])
    scaled_sales = target_scaler.transform(daily[["sales"]]).flatten()

    X_train, y_train, X_val, y_val = [], [], [], []
    last_start = len(daily) - WINDOW_SIZE - FORECAST_DAYS + 1
    for i in range(last_start):
        target_start = i + WINDOW_SIZE
        target_end = target_start + FORECAST_DAYS
        x_window = scaled_features[i:i + WINDOW_SIZE]
        y_window = scaled_sales[target_start:target_end]
        if target_end <= split_at:
            X_train.append(x_window)
            y_train.append(y_window)
        elif target_start >= split_at:
            X_val.append(x_window)
            y_val.append(y_window)

    if len(X_train) < 20:
        raise ValueError(f"Not enough training sequences for {PRODUCT_INFO[product_key]['productName']}")

    X_train = np.asarray(X_train, dtype=np.float32)
    y_train = np.asarray(y_train, dtype=np.float32)
    X_val = np.asarray(X_val, dtype=np.float32)
    y_val = np.asarray(y_val, dtype=np.float32)

    tf.keras.utils.set_random_seed(42)
    model = Sequential([
        Input(shape=(WINDOW_SIZE, len(FEATURE_COLUMNS))),
        LSTM(64, return_sequences=True),
        Dropout(0.20),
        LSTM(32),
        Dropout(0.20),
        Dense(32, activation="relu"),
        Dense(FORECAST_DAYS),
    ])
    model.compile(optimizer="adam", loss="mse", metrics=["mae"])

    callbacks = [EarlyStopping(monitor="val_loss" if len(X_val) else "loss", patience=4, restore_best_weights=True)]
    fit_args = {"x": X_train, "y": y_train, "epochs": 20, "batch_size": 32, "verbose": 0, "callbacks": callbacks}
    if len(X_val):
        fit_args["validation_data"] = (X_val, y_val)
    model.fit(**fit_args)

    mae = None
    if len(X_val):
        predicted_scaled = model.predict(X_val, verbose=0).reshape(-1, 1)
        actual_scaled = y_val.reshape(-1, 1)
        predicted = target_scaler.inverse_transform(predicted_scaled).flatten()
        actual = target_scaler.inverse_transform(actual_scaled).flatten()
        mae = float(np.mean(np.abs(actual - predicted)))

    model.save(model_path)
    joblib.dump({"feature_scaler": feature_scaler, "target_scaler": target_scaler, "mae": mae}, scaler_path)

    result = {"model": model, "feature_scaler": feature_scaler, "target_scaler": target_scaler, "mae": mae}
    MODEL_CACHE[product_key] = result
    logger.info("Trained LSTM for %s; validation MAE=%s", product_key, mae)
    return result


def forecast_product(product_key: str) -> Dict[str, Any]:
    trained = train_product(product_key)
    daily = DAILY_DATA[product_key]
    last_window = daily[FEATURE_COLUMNS].tail(WINDOW_SIZE)
    if len(last_window) < WINDOW_SIZE:
        raise ValueError("Insufficient recent history for prediction")

    x = trained["feature_scaler"].transform(last_window)
    prediction_scaled = trained["model"].predict(np.expand_dims(x, axis=0), verbose=0)[0]
    prediction = trained["target_scaler"].inverse_transform(prediction_scaled.reshape(-1, 1)).flatten()
    prediction = np.maximum(prediction, 0)

    start_date = daily.index.max().date() + timedelta(days=1)
    forecast = []
    for offset, value in enumerate(prediction):
        forecast.append({
            "date": (start_date + timedelta(days=offset)).isoformat(),
            "predictedDemand": round(float(value), 2),
        })

    history = [
        {"date": timestamp.date().isoformat(), "actualDemand": round(float(value), 2)}
        for timestamp, value in daily["sales"].tail(30).items()
    ]
    return {
        "history": history,
        "forecast": forecast,
        "dailyAverage": round(float(np.mean(prediction)), 2),
        "weeklyDemand": round(float(np.sum(prediction)), 2),
        "validationMAE": round(trained["mae"], 2) if trained["mae"] is not None else None,
        "forecastStartDate": start_date.isoformat(),
    }

def calculate_risk(current_stock: float, expiry_days: int, forecast: Dict[str, Any]) -> Dict[str, Any]:
    daily_predictions = [item["predictedDemand"] for item in forecast["forecast"]]

    if expiry_days <= 0:
        expected_demand_before_expiry = 0.0
    elif expiry_days <= FORECAST_DAYS:
        expected_demand_before_expiry = float(sum(daily_predictions[:expiry_days]))
    else:
        expected_demand_before_expiry = float(sum(daily_predictions))
        expected_demand_before_expiry += (expiry_days - FORECAST_DAYS) * float(np.mean(daily_predictions))

    if expiry_days <= 0:
        expiry_score = 100.0
    else:
        expiry_score = max(0.0, min(100.0, ((14.0 - expiry_days) / 14.0) * 100.0))

    if current_stock <= 0:
        surplus_score = 0.0
    elif expected_demand_before_expiry <= 0:
        surplus_score = 100.0
    else:
        coverage_ratio = current_stock / expected_demand_before_expiry
        surplus_score = max(0.0, min(100.0, (coverage_ratio - 1.0) * 50.0))

    risk_score = round((0.40 * expiry_score) + (0.60 * surplus_score), 2)
    if risk_score >= 65:
        level = "HIGH"
    elif risk_score >= 35:
        level = "MEDIUM"
    else:
        level = "LOW"

    surplus_qty = max(0.0, current_stock - expected_demand_before_expiry)
    return {
        "riskScore": risk_score,
        "riskLevel": level,
        "expiryUrgencyScore": round(expiry_score, 2),
        "stockSurplusScore": round(surplus_score, 2),
        "expectedDemandBeforeExpiry": round(expected_demand_before_expiry, 2),
        "estimatedSurplusQuantity": round(surplus_qty, 2),
        "explanation": (
            "Product is already expired" if expiry_days <= 0 else
            "Current stock is high compared with demand before expiry" if surplus_score >= 65 else
            "Expiry is approaching; monitor stock and sales" if expiry_score >= 50 else
            "Stock and expiry are currently within the calculated risk range"
        ),
    }


def calculate_reorder(
        current_stock: float,
        lead_time_days: int,
        safety_days: int,
        expiry_days: Optional[int],
        forecast: Dict[str, Any],
) -> Dict[str, Any]:
    """Calculate a forecast-based reorder recommendation.

    If the current inventory expires on or before the expected delivery date,
    it is not counted as usable stock for the replenishment calculation.

    This function assumes the supplied expiry date applies to the entire
    aggregated stock quantity. If inventory contains multiple batches with
    different expiry dates, batch-level quantities and dates are needed for
    an accurate calculation.
    """
    values = [
        max(0.0, float(item.get("predictedDemand", 0.0)))
        for item in forecast.get("forecast", [])
    ]

    if not values:
        raise ValueError("Forecast contains no predicted demand values.")

    current_stock = max(0.0, float(current_stock))
    lead_time_days = max(1, int(lead_time_days))
    safety_days = max(0, int(safety_days))

    avg_daily = float(np.mean(values))

    # Calculate demand during supplier lead time. If lead time exceeds the
    # forecast horizon, extend using the average forecast demand.
    lead_time_demand = (
        float(sum(values[:lead_time_days]))
        if lead_time_days <= len(values)
        else float(sum(values)) + (lead_time_days - len(values)) * avg_daily
    )

    safety_stock = avg_daily * safety_days
    target_stock = lead_time_demand + safety_stock

    # Existing stock that expires on/before delivery cannot be counted as
    # available stock when the replenishment arrives.
    expires_before_delivery = (
            expiry_days is not None and expiry_days <= lead_time_days
    )
    usable_stock = 0.0 if expires_before_delivery else current_stock

    recommended_qty = max(0.0, target_stock - usable_stock)

    if recommended_qty > 0:
        recommendation = "REORDER"
        if expires_before_delivery:
            reason = (
                "REORDER: Current inventory expires on or before the expected "
                "delivery date and is not counted as usable replenishment stock."
            )
        else:
            reason = (
                "REORDER: Available stock is below forecast lead-time demand "
                "plus safety stock."
            )
    else:
        recommendation = "DO_NOT_REORDER"
        reason = "Current unexpired stock meets the target stock level."

    return {
        "leadTimeDemand": round(lead_time_demand, 2),
        "safetyStock": round(safety_stock, 2),
        "targetStock": round(target_stock, 2),
        "recommendedPurchaseQty": round(recommended_qty, 2),
        "recommendation": recommendation,
        "reason": reason,
    }


app = FastAPI(
    title="NutriFlux AI Waste Prediction Service",
    version="1.0.0",
    description="LSTM demand forecasting, waste risk scoring and stock recommendations.",
)


@app.exception_handler(RequestValidationError)
async def validation_exception_handler(request: Request, exc: RequestValidationError):
    """Log invalid incoming request bodies to diagnose Spring-to-FastAPI 422s."""
    logger.error("========== FASTAPI REQUEST VALIDATION ERROR ==========")
    logger.error("Method: %s", request.method)
    logger.error("Path: %s", request.url.path)
    logger.error("Content-Type: %s", request.headers.get("content-type"))
    logger.error("Content-Length: %s", request.headers.get("content-length"))
    logger.error("Validation errors: %s", exc.errors())
    logger.error("Received request body: %r", exc.body)
    logger.error("=======================================================")

    return JSONResponse(
        status_code=422,
        content={"detail": jsonable_encoder(exc.errors())},
    )


class AnalyzeRequest(BaseModel):
    productName: str = Field(..., min_length=1, examples=["Whole milk"])
    currentStock: float = Field(..., ge=0)
    expiryDate: Optional[date] = None
    leadTimeDays: int = Field(default=7, ge=1, le=60)
    safetyDays: int = Field(default=7, ge=0, le=30)


def resolve_product(product_name: str) -> str:
    key = product_name.strip().casefold()
    if key not in DAILY_DATA:
        available = [info["productName"] for info in PRODUCT_INFO.values()]
        raise HTTPException(status_code=404, detail={
            "message": f"Product '{product_name}' was not found in historical datasets.",
            "availableProducts": available,
        })
    return key


@app.get("/health")
def health():
    return {"status": "UP", "service": "NutriFlux AI", "productsLoaded": len(DAILY_DATA)}


@app.get("/api/v1/ai/products")
def get_products():
    return {"products": list(PRODUCT_INFO.values()), "count": len(PRODUCT_INFO)}


@app.post("/api/v1/ai/train")
def train_all_models():
    results = []
    for key, info in PRODUCT_INFO.items():
        try:
            trained = train_product(key, force_retrain=True)
            results.append({"productName": info["productName"], "status": "TRAINED", "validationMAE": trained["mae"]})
        except Exception as exc:
            logger.exception("Training failed for %s", info["productName"])
            results.append({"productName": info["productName"], "status": "FAILED", "error": str(exc)})
    return {"trained": sum(x["status"] == "TRAINED" for x in results), "failed": sum(x["status"] == "FAILED" for x in results), "results": results}


@app.post("/api/v1/ai/analyze")
def analyze_product(request: AnalyzeRequest):
    """
    Accept the JSON request from Spring Boot, generate the LSTM demand
    forecast, calculate expiry-related waste risk when expiryDate is
    provided, and calculate the stock reorder recommendation.
    """
    key = resolve_product(request.productName)

    try:
        forecast = forecast_product(key)
    except Exception as exc:
        logger.exception("Forecast failed for %s", request.productName)
        raise HTTPException(
            status_code=500,
            detail=f"Could not generate forecast: {str(exc)}",
        )

    # Expiry is optional because a selected historical product may not
    # currently exist in the user's inventory.
    expiry_days = (
        (request.expiryDate - date.today()).days
        if request.expiryDate is not None
        else None
    )

    if expiry_days is None:
        risk = {
            "riskScore": None,
            "riskLevel": "UNKNOWN",
            "expiryUrgencyScore": None,
            "stockSurplusScore": None,
            "expectedDemandBeforeExpiry": None,
            "estimatedSurplusQuantity": None,
            "explanation": (
                "No inventory expiry date is available; "
                "expiry-based waste risk cannot be calculated."
            ),
        }
    else:
        risk = calculate_risk(request.currentStock, expiry_days, forecast)

    reorder = calculate_reorder(
        current_stock=request.currentStock,
        lead_time_days=request.leadTimeDays,
        safety_days=request.safetyDays,
        expiry_days=expiry_days,
        forecast=forecast,
    )

    product_info = PRODUCT_INFO[key]
    return {
        "productName": product_info["productName"],
        "category": product_info["category"],
        "units": product_info["units"],
        "generatedAt": datetime.now().isoformat(timespec="seconds"),
        "expiryDaysRemaining": expiry_days,
        "demandForecast": {
            "history": forecast["history"],
            "next7Days": forecast["forecast"],
            "dailyAverage": forecast["dailyAverage"],
            "weeklyDemand": forecast["weeklyDemand"],
            "validationMAE": forecast["validationMAE"],
        },
        "wasteRisk": risk,
        "stockRecommendation": reorder,
    }


# -----------------------------------------------------------------------------
# Scheduled batch prediction: retrain and forecast every day at 02:00 IST
# -----------------------------------------------------------------------------
def run_scheduled_batch() -> None:
    logger.info("Starting scheduled NutriFlux batch prediction")
    batch = {
        "generatedAt": datetime.now().isoformat(timespec="seconds"),
        "note": "Demand forecasts only. Live stock and expiry risk require current inventory data from Java.",
        "products": [],
    }
    for key, info in PRODUCT_INFO.items():
        try:
            trained = train_product(key, force_retrain=True)
            prediction = forecast_product(key)
            batch["products"].append({
                "productName": info["productName"],
                "category": info["category"],
                "units": info["units"],
                "weeklyDemand": prediction["weeklyDemand"],
                "dailyAverage": prediction["dailyAverage"],
                "next7Days": prediction["forecast"],
                "validationMAE": trained["mae"],
            })
        except Exception as exc:
            logger.exception("Batch prediction failed for %s", info["productName"])
            batch["products"].append({"productName": info["productName"], "status": "FAILED", "error": str(exc)})

    SCHEDULED_FORECASTS.clear()
    SCHEDULED_FORECASTS.update(batch)
    output_file = BATCH_DIR / "latest_batch_forecasts.json"
    with output_file.open("w", encoding="utf-8") as file:
        json.dump(batch, file, indent=2)
    logger.info("Batch prediction completed: %s", output_file)


scheduler = BackgroundScheduler(timezone="Asia/Kolkata")
scheduler.add_job(run_scheduled_batch, trigger="cron", hour=2, minute=0, id="daily_lstm_batch", replace_existing=True)


@app.on_event("startup")
def start_scheduler():
    if not scheduler.running:
        scheduler.start()


@app.on_event("shutdown")
def stop_scheduler():
    if scheduler.running:
        scheduler.shutdown(wait=False)


@app.get("/api/v1/ai/batch/latest")
def get_latest_batch():
    output_file = BATCH_DIR / "latest_batch_forecasts.json"
    if not output_file.exists():
        return {"message": "No scheduled batch has run yet. The first run is scheduled for 02:00 IST.", "products": []}
    with output_file.open("r", encoding="utf-8") as file:
        return json.load(file)