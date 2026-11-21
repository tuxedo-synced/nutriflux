<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    String contextPath = request.getContextPath();
    String activePage = "ai-prediction";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI Prediction | NutriFlux</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Manrope:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/ai-prediction.css?v=20261121">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<div class="app-shell">
    <aside class="sidebar">
        <a class="brand" href="${pageContext.request.contextPath}/dashboard">
            <span class="brand-mark">N</span>
            <span class="brand-copy"><strong>NutriFlux</strong><small>Food intelligence platform</small></span>
        </a>
        <div class="workspace-label">WORKSPACE</div>
        <nav class="side-nav">
            <a class="nav-link" href="${pageContext.request.contextPath}/dashboard"><span class="nav-icon">⌂</span>Dashboard</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/inventory"><span class="nav-icon">▤</span>Inventory</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/expiry"><span class="nav-icon">◷</span>Expiry tracking</a>
            <a class="nav-link active" href="${pageContext.request.contextPath}/ai-prediction"><span class="nav-icon">✦</span>AI Prediction</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/surplus"><span class="nav-icon">♧</span>Surplus listings</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/marketplace"><span class="nav-icon">⇄</span>Marketplace</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/analytics"><span class="nav-icon">▥</span>Impact analytics</a>
        </nav>
        <div class="sidebar-bottom">
            <a class="profile-mini" href="${pageContext.request.contextPath}/profile"><span class="avatar">AP</span><span><b>Account profile</b><small>Business workspace</small></span><span class="profile-more">•••</span></a>
        </div>
    </aside>

    <main class="main-area">
        <header class="topbar">
            <div class="breadcrumbs"><span>Workspace</span><i>/</i><strong>AI Prediction</strong></div>
            <div class="top-user"><span class="avatar">AP</span><span><b>Admin</b><small>Business account</small></span><span class="chevron">⌄</span></div>
        </header>

        <div class="page-content">
            <section class="welcome-row">
                <div>
                    <div class="eyebrow"><span class="eyebrow-dot"></span> INTELLIGENCE &amp; FORECASTING</div>
                    <h1>AI Predictions <span class="heading-spark">✦</span></h1>
                    <p class="page-subtitle">Forecast demand, identify food waste risks and make smarter purchasing decisions.</p>
                </div>
                <div class="welcome-actions">
                    <span class="model-status"><i></i> Prediction overview</span>
                    <button class="button button-primary" type="button" onclick="window.location.href='${pageContext.request.contextPath}/ai-prediction/refresh'">↻ Refresh predictions</button>
                </div>
            </section>

            <section class="analysis-grid forecast-only-grid">
                <article class="panel forecast-panel">
                    <div class="panel-heading forecast-heading">
                        <div>
                            <h2>Demand forecasting</h2>
                            <p>Expected demand compared with historical sales</p>
                        </div>
                        <form class="forecast-form" method="post"
                              action="${pageContext.request.contextPath}/ai-prediction/analyze">
                            <c:if test="${not empty _csrf}">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            </c:if>
                            <div class="forecast-controls">
                                <div class="product-field">
                                    <label for="productSelect">Select product</label>
                                    <select id="productSelect" name="productName" class="product-select" required>
                                        <option value="" selected disabled>Choose a product</option>
                                        <c:choose>
                                            <c:when test="${not empty listOfProductNames}">
                                                <c:forEach var="productName" items="${listOfProductNames}">
                                                    <option value="<c:out value='${productName}'/>" <c:if test="${productName eq selectedProductName}">selected</c:if>>
                                                        <c:out value="${productName}"/>
                                                    </option>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="" disabled>No products available</option>
                                            </c:otherwise>
                                        </c:choose>
                                    </select>
                                </div>
                                <span class="forecast-period">Next 7 days</span>
                                <button class="button button-primary generate-button" type="submit">
                                    <span aria-hidden="true">✦</span> Generate forecast
                                </button>
                            </div>
                        </form>
                    </div>
                    <c:choose>
                        <c:when test="${not empty GraphPlot
                            and not empty GraphPlot.demandForecast
                            and not empty GraphPlot.demandForecast.next7Days}">

                            <div class="graphplot-result-heading">
                                <div>
                                    <span class="graphplot-product-label">GENERATED FORECAST</span>
                                    <h3><c:out value="${GraphPlot.productName}"/></h3>
                                </div>
                                <span class="graphplot-model-badge">LSTM · 7-day forecast</span>
                            </div>

                            <div class="graphplot-metrics">
                                <div class="graphplot-metric-card">
                                    <span>Predicted weekly demand</span>
                                    <strong>
                                        <c:out value="${GraphPlot.demandForecast.weeklyDemand}"/>
                                        <c:out value="${GraphPlot.units}"/>
                                    </strong>
                                </div>
                                <div class="graphplot-metric-card">
                                    <span>Daily average</span>
                                    <strong>
                                        <c:out value="${GraphPlot.demandForecast.dailyAverage}"/>
                                        <c:out value="${GraphPlot.units}"/>
                                    </strong>
                                </div>
                                <div class="graphplot-metric-card">
                                    <span>Validation MAE</span>
                                    <strong><c:out value="${GraphPlot.demandForecast.validationMAE}"/></strong>
                                </div>
                            </div>

                            <div class="forecast-chart-toolbar">
                                <div class="chart-legend graphplot-legend">
                                    <span><i class="legend-dot dot-actual"></i> Historical demand</span>
                                    <span><i class="legend-dot dot-predicted"></i> Predicted demand</span>
                                </div>
                                <label class="chart-type-control">
                                    <span class="visually-hidden">Chart type</span>
                                    <select id="chartType" class="product-select" aria-label="Chart type">
                                        <option value="line">Line chart</option>
                                        <option value="bar">Bar chart</option>
                                    </select>
                                </label>
                            </div>

                            <div class="graphplot-chart-container">
                                <canvas id="demandForecastChart"
                                        role="img"
                                        aria-label="Historical and predicted demand chart"></canvas>
                            </div>
                            <p class="chart-note">
                                Hover over chart points for exact demand values.
                                Forecast values are model predictions, not guaranteed sales.
                            </p>
                        </c:when>

                        <c:otherwise>
                            <div class="graphplot-empty-state">
                                <span class="graphplot-empty-icon">↗</span>
                                <h3>No forecast generated yet</h3>
                                <p>
                                    Select a product and click
                                    <strong>Generate forecast</strong>
                                    to view its demand prediction.
                                </p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </article>


            </section>

            <section class="panel recommendations-panel">
                <div class="panel-heading">
                    <div>
                        <h2>Waste risk analysis</h2>
                        <p>Risk assessment based on current stock, expiry and predicted demand</p>
                    </div>
                    <a class="text-link" href="${pageContext.request.contextPath}/expiry">Open expiry tracking ↗</a>
                </div>

                <c:choose>
                    <c:when test="${not empty GraphPlot and not empty GraphPlot.wasteRisk}">
                        <div class="risk-result-card">
                            <div class="risk-result-top">
                                <div>
                                    <span class="result-overline">WASTE RISK FOR</span>
                                    <h3><c:out value="${GraphPlot.productName}"/></h3>
                                </div>
                                <span class="risk-badge ${GraphPlot.wasteRisk.riskLevel eq 'HIGH' ? 'high' : (GraphPlot.wasteRisk.riskLevel eq 'MEDIUM' ? 'medium' : 'low')}">
                                    <c:out value="${GraphPlot.wasteRisk.riskLevel}"/> RISK
                                </span>
                            </div>
                            <div class="risk-score-info">
                                <span>Waste risk score</span>
                                <strong><c:out value="${GraphPlot.wasteRisk.riskScore}"/>%</strong>
                            </div>
                            <div class="risk-progress-track">
                                <div class="risk-progress-bar ${GraphPlot.wasteRisk.riskLevel eq 'HIGH' ? 'high' : (GraphPlot.wasteRisk.riskLevel eq 'MEDIUM' ? 'medium' : 'low')}"
                                     style="width: <c:out value='${GraphPlot.wasteRisk.riskScore}'/>%;"></div>
                            </div>
                            <div class="risk-details-grid">
                                <div class="risk-detail"><span>Expiry urgency</span><strong><c:out value="${GraphPlot.wasteRisk.expiryUrgencyScore}"/>%</strong></div>
                                <div class="risk-detail"><span>Stock surplus score</span><strong><c:out value="${GraphPlot.wasteRisk.stockSurplusScore}"/>%</strong></div>
                                <div class="risk-detail"><span>Expected demand before expiry</span><strong><c:out value="${GraphPlot.wasteRisk.expectedDemandBeforeExpiry}"/> <c:out value="${GraphPlot.units}"/></strong></div>
                                <div class="risk-detail"><span>Estimated surplus</span><strong><c:out value="${GraphPlot.wasteRisk.estimatedSurplusQuantity}"/> <c:out value="${GraphPlot.units}"/></strong></div>
                            </div>
                            <c:if test="${not empty GraphPlot.wasteRisk.explanation}">
                                <div class="risk-reason-box">
                                    <strong>Why this risk level?</strong>
                                    <p><c:out value="${GraphPlot.wasteRisk.explanation}"/></p>
                                </div>
                            </c:if>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="graphplot-empty-state smart-empty-state">
                            <span class="graphplot-empty-icon">↗</span>
                            <h3>No waste risk analysis yet</h3>
                            <p>Select a product and generate its forecast to view the waste risk assessment.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>

            <section class="panel reorder-panel">
                <div class="panel-heading">
                    <div>
                        <h2>Smart reorder recommendations</h2>
                        <p>Suggested purchase quantity based on forecast demand, lead time and safety stock</p>
                    </div>
                    <span class="recommendation-tag">AI-assisted planning</span>
                </div>

                <c:choose>
                    <c:when test="${not empty GraphPlot and not empty GraphPlot.stockRecommendation}">
                        <div class="smart-reorder-result">
                            <div class="reorder-result-heading">
                                <div>
                                    <span class="result-overline">RECOMMENDATION FOR</span>
                                    <h3><c:out value="${GraphPlot.productName}"/></h3>
                                </div>
                                <span class="reorder-status-label">Stock planning</span>
                            </div>
                            <div class="reorder-main">
                                <div class="reorder-quantity">
                                    <span>Recommended purchase quantity</span>
                                    <strong><c:out value="${GraphPlot.stockRecommendation.recommendedPurchaseQty}"/> <c:out value="${GraphPlot.units}"/></strong>
                                </div>
                                <div class="reorder-status">
                                    <span>Recommendation</span>
                                    <strong><c:out value="${GraphPlot.stockRecommendation.recommendation}"/></strong>
                                </div>
                            </div>
                            <div class="reorder-details-grid">
                                <div><span>Lead-time demand</span><strong><c:out value="${GraphPlot.stockRecommendation.leadTimeDemand}"/> <c:out value="${GraphPlot.units}"/></strong></div>
                                <div><span>Safety stock</span><strong><c:out value="${GraphPlot.stockRecommendation.safetyStock}"/> <c:out value="${GraphPlot.units}"/></strong></div>
                                <div><span>Target stock</span><strong><c:out value="${GraphPlot.stockRecommendation.targetStock}"/> <c:out value="${GraphPlot.units}"/></strong></div>
                            </div>
                            <c:if test="${not empty GraphPlot.stockRecommendation.reason}">
                                <div class="reorder-reason-box">
                                    <strong>Reason for recommendation</strong>
                                    <p><c:out value="${GraphPlot.stockRecommendation.reason}"/></p>
                                </div>
                            </c:if>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="graphplot-empty-state smart-empty-state">
                            <span class="graphplot-empty-icon">↗</span>
                            <h3>No reorder recommendations yet</h3>
                            <p>Select a product and click <strong>Generate forecast</strong> to view its smart purchase recommendation.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>

            <footer class="page-footer"><span>© 2026 NutriFlux · Food intelligence for a better tomorrow.</span><span>Built to reduce waste, one meal at a time.</span></footer>
        </div>
    </main>
</div>

<c:if test="${not empty GraphPlot
    and not empty GraphPlot.demandForecast
    and not empty GraphPlot.demandForecast.next7Days}">
<script>
document.addEventListener("DOMContentLoaded", function () {
    const canvas = document.getElementById("demandForecastChart");
    const chartTypeSelect = document.getElementById("chartType");

    if (!canvas || typeof Chart === "undefined") return;

    const historicalLabels = [
        <c:forEach items="${GraphPlot.demandForecast.history}" var="item" varStatus="status">
            "<c:out value='${item.date}'/>"<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];

    const historicalValues = [
        <c:forEach items="${GraphPlot.demandForecast.history}" var="item" varStatus="status">
            <c:out value="${item.actualDemand}"/><c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];

    const predictedLabels = [
        <c:forEach items="${GraphPlot.demandForecast.next7Days}" var="item" varStatus="status">
            "<c:out value='${item.date}'/>"<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];

    const predictedValues = [
        <c:forEach items="${GraphPlot.demandForecast.next7Days}" var="item" varStatus="status">
            <c:out value="${item.predictedDemand}"/><c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];

    const labels = historicalLabels.concat(predictedLabels);
    const actualData = historicalValues.concat(predictedLabels.map(() => null));

    // Start the forecast line at the final historical value to show continuity.
    const forecastData = historicalValues.map((value, index) =>
        index === historicalValues.length - 1 ? value : null
    ).concat(predictedValues);

    const unit = "<c:out value='${GraphPlot.units}'/>";

    const config = {
        type: "line",
        data: {
            labels: labels,
            datasets: [
                {
                    label: "Historical demand",
                    data: actualData,
                    borderColor: "#78a987",
                    backgroundColor: "rgba(120,169,135,0.10)",
                    borderWidth: 3,
                    pointRadius: 4,
                    pointHoverRadius: 8,
                    tension: 0.35,
                    fill: false,
                    spanGaps: false
                },
                {
                    label: "Predicted demand",
                    data: forecastData,
                    borderColor: "#a9cb78",
                    backgroundColor: "rgba(169,203,120,0.13)",
                    borderWidth: 3,
                    borderDash: [7, 5],
                    pointRadius: 5,
                    pointHoverRadius: 9,
                    pointBackgroundColor: "#a9cb78",
                    pointBorderColor: "#ffffff",
                    pointBorderWidth: 2,
                    tension: 0.35,
                    fill: false,
                    spanGaps: false
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            interaction: {
                mode: "index",
                intersect: false
            },
            plugins: {
                legend: {
                    display: true,
                    position: "bottom",
                    labels: {
                        usePointStyle: true,
                        padding: 20
                    }
                },
                tooltip: {
                    enabled: true,
                    backgroundColor: "#173f2d",
                    titleColor: "#ffffff",
                    bodyColor: "#eaf3e9",
                    padding: 12,
                    displayColors: true,
                    callbacks: {
                        label: function (context) {
                            if (context.parsed.y === null) return null;
                            return context.dataset.label + ": "
                                + Number(context.parsed.y).toFixed(2)
                                + " " + unit;
                        }
                    }
                }
            },
            scales: {
                x: {
                    grid: { display: false },
                    ticks: {
                        color: "#89948c",
                        maxRotation: 0,
                        autoSkip: true
                    },
                    title: {
                        display: true,
                        text: "Date",
                        color: "#89948c"
                    }
                },
                y: {
                    beginAtZero: true,
                    grid: { color: "#edf0eb" },
                    ticks: { color: "#89948c" },
                    title: {
                        display: true,
                        text: "Demand (" + unit + ")",
                        color: "#89948c"
                    }
                }
            }
        }
    };

    const demandChart = new Chart(canvas, config);

    if (chartTypeSelect) {
        chartTypeSelect.addEventListener("change", function () {
            demandChart.config.type = this.value;
            demandChart.update();
        });
    }
});
</script>
</c:if>

</body>
</html>
