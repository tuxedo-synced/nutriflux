NUTRIFLUX AI MICROSERVICE

1. Folder structure

nutriflux_ai_service/
  app.py
  requirements.txt
  data/
    sales_transactions_uuid(1).csv
    purchase_history_uuid(1).csv
    waste_history_uuid(1).csv
  models/             (created automatically)
  batch_output/       (created automatically)

2. Install

python -m venv venv

Windows:
venv\Scripts\activate

pip install -r requirements.txt

3. Start FastAPI

uvicorn app:app --reload --host 0.0.0.0 --port 8000

4. Train all product LSTM models (first-time setup)

POST http://localhost:8000/api/v1/ai/train

The models and scalers are saved under models/. The analyze endpoint also trains
its requested product automatically if a saved model does not exist.

5. Analyze a product

POST http://localhost:8000/api/v1/ai/analyze
Content-Type: application/json

{
  "productName": "Whole milk",
  "currentStock": 25,
  "expiryDate": "2026-11-27",
  "storageCapacity": 60,
  "leadTimeDays": 2,
  "safetyDays": 2
}

All quantities must use the same unit as that product's historical CSV records.

6. Other endpoints

GET  /health         - just to check fastAPI is working or not .
GET  /api/v1/ai/products
POST /api/v1/ai/train
POST /api/v1/ai/analyze
GET  /api/v1/ai/batch/latest

The scheduler retrains and creates demand forecasts every day at 02:00 Asia/Kolkata.
The scheduled batch can forecast demand, but live risk scoring needs current stock
and expiry date from the Java inventory system.

7. CSV paths

Put the three supplied CSV files in the data/ directory. Or set environment
variables SALES_CSV, PURCHASE_CSV, WASTE_CSV to their full paths.

NOTE
This implementation trains one multivariate LSTM per product. Input features are
30 days of sales, purchases, waste and day-of-week seasonality. It predicts the
next 7 daily sales quantities. The weekly demand is the sum of those 7 values.
The validation MAE is returned as an error metric; it is not a guarantee of
future accuracy. This is a project implementation and should be evaluated on
held-out dates before production use.
