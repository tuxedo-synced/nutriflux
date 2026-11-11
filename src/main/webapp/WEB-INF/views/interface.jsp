<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String contextPath = request.getContextPath();
    String activePage = "dashboard";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | NutriFlux</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Manrope:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/interface.css">
</head>
<body>
<div class="app-shell">
    <aside class="sidebar">
        <a class="brand" href="${pageContext.request.contextPath}/interface">
            <span class="brand-mark">N</span>
            <span class="brand-copy"><strong>NutriFlux</strong><small>Food intelligence platform</small></span>
        </a>

        <div class="workspace-label">WORKSPACE</div>
        <nav class="side-nav">
            <a class="nav-link active" href="${pageContext.request.contextPath}/interface"><span class="nav-icon">⌂</span>Dashboard</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/inventory"><span class="nav-icon">▤</span>Inventory</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/expiry"><span class="nav-icon">◷</span>Expiry tracking</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/surplus"><span class="nav-icon">♧</span>Surplus listings</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/marketplace"><span class="nav-icon">⇄</span>Marketplace</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/analytics"><span class="nav-icon">▥</span>Impact analytics</a>
        </nav>

        <div class="sidebar-bottom">
            <a class="profile-mini" href="${pageContext.request.contextPath}/profile">
                <span class="avatar">AP</span>
                <span><b>Account profile</b><small>Business workspace</small></span>
                <span class="profile-more">•••</span>
            </a>
            </div>
    </aside>

    <main class="main-area">
        <header class="topbar">
            <div class="breadcrumbs"><span>Workspace</span><i>/</i><strong>Dashboard</strong></div>
            <div class="topbar-actions">
                <button class="icon-button" type="button" aria-label="Notifications">♧<em></em></button>
                <div class="top-user"><span class="avatar">AP</span><span><b>Admin</b><small>Business account</small></span><span class="chevron">⌄</span></div>
            </div>
        </header>

        <div class="page-content">
            <section class="welcome-row">
                <div>
                    <div class="eyebrow"><span class="eyebrow-dot"></span> YOUR FOOD OPERATIONS, AT A GLANCE</div>
                    <h1>Good morning, Admin <span>✳</span></h1>
                    <p class="page-subtitle">Here’s what’s happening across your inventory and food recovery operations.</p>
                </div>
                <div class="welcome-actions">
                    <button class="button button-light" type="button" onclick="window.location.href='${pageContext.request.contextPath}/inventory'">＋ Add inventory</button>
                    <button class="button button-primary" type="button" onclick="window.location.href='${pageContext.request.contextPath}/surplus'">＋ Create surplus listing</button>
                </div>
            </section>

            <section class="metric-grid">
                <article class="metric-card">
                    <div class="metric-top"><span>Total inventory items</span><span class="metric-icon green">▤</span></div>
                    <div class="metric-value">1,284</div>
                    <div class="metric-foot"><span class="trend positive">↗ 8.2%</span><span>vs. last month</span></div>
                    <div class="metric-line green-line"><i style="width:72%"></i></div>
                </article>
                <article class="metric-card">
                    <div class="metric-top"><span>At-risk items</span><span class="metric-icon amber">◷</span></div>
                    <div class="metric-value">36</div>
                    <div class="metric-foot"><span class="trend negative">↗ 3 items</span><span>need attention</span></div>
                    <div class="metric-line amber-line"><i style="width:38%"></i></div>
                </article>
                <article class="metric-card">
                    <div class="metric-top"><span>Food waste prevented</span><span class="metric-icon blue">♧</span></div>
                    <div class="metric-value">842 <small>kg</small></div>
                    <div class="metric-foot"><span class="trend positive">↗ 12.4%</span><span>this month</span></div>
                    <div class="metric-line blue-line"><i style="width:81%"></i></div>
                </article>
                <article class="metric-card">
                    <div class="metric-top"><span>Successful donations</span><span class="metric-icon purple">⇄</span></div>
                    <div class="metric-value">64</div>
                    <div class="metric-foot"><span class="trend positive">↗ 6.1%</span><span>completed pickups</span></div>
                    <div class="metric-line purple-line"><i style="width:64%"></i></div>
                </article>
            </section>

            <section class="content-grid">
                <article class="panel inventory-panel">
                    <div class="panel-heading">
                        <div><h2>Inventory health</h2><p>Stock status across all categories</p></div>
                        <a class="text-link" href="${pageContext.request.contextPath}/inventory">View inventory ↗</a>
                    </div>
                    <div class="inventory-summary">
                        <div class="donut-wrap"><div class="donut"><div class="donut-center"><strong>1,284</strong><small>Total items</small></div></div></div>
                        <div class="legend-list">
                            <div><span class="legend-dot dot-safe"></span><span>Healthy stock</span><b>1,038 <small>81%</small></b></div>
                            <div><span class="legend-dot dot-watch"></span><span>Expiring soon</span><b>210 <small>16%</small></b></div>
                            <div><span class="legend-dot dot-risk"></span><span>High risk</span><b>36 <small>3%</small></b></div>
                        </div>
                    </div>
                    <div class="panel-divider"></div>
                    <div class="category-heading"><strong>Inventory by category</strong><span>Current quantity</span></div>
                    <div class="category-bars">
                        <div class="category-row"><span>Produce</span><div class="bar-track"><i style="width:86%"></i></div><b>420</b></div>
                        <div class="category-row"><span>Dairy</span><div class="bar-track"><i style="width:65%"></i></div><b>318</b></div>
                        <div class="category-row"><span>Bakery</span><div class="bar-track"><i style="width:48%"></i></div><b>236</b></div>
                        <div class="category-row"><span>Packaged</span><div class="bar-track"><i style="width:63%"></i></div><b>310</b></div>
                    </div>
                </article>

                <article class="panel risk-panel">
                    <div class="panel-heading">
                        <div><h2>Needs your attention</h2><p>Items approaching their expiry date</p></div>
                        <span class="count-pill">3 urgent</span>
                    </div>
                    <div class="risk-list">
                        <div class="risk-item"><span class="food-thumb tomato">●</span><div class="risk-info"><b>Fresh tomatoes</b><small>Produce · 24 kg remaining</small></div><span class="expiry urgent">Expires today</span></div>
                        <div class="risk-item"><span class="food-thumb milk">▰</span><div class="risk-info"><b>Whole milk</b><small>Dairy · 18 litres remaining</small></div><span class="expiry soon">1 day left</span></div>
                        <div class="risk-item"><span class="food-thumb bread">▰</span><div class="risk-info"><b>Whole wheat bread</b><small>Bakery · 32 packs remaining</small></div><span class="expiry soon">2 days left</span></div>
                    </div>
                    <a class="panel-bottom-link" href="${pageContext.request.contextPath}/expiry">Review all expiry alerts <span>→</span></a>
                </article>
            </section>

            <section class="content-grid lower-grid">
                <article class="panel activity-panel">
                    <div class="panel-heading">
                        <div><h2>Food recovery overview</h2><p>Surplus food redistributed over the last 7 days</p></div>
                        <span class="select-static">Last 7 days⌄</span>
                    </div>
                    <div class="chart-legend"><span><i class="legend-dot dot-safe"></i> Food recovered (kg)</span><strong>286 kg <small>this week</small></strong></div>
                    <div class="chart-area">
                        <div class="y-labels"><span>300</span><span>200</span><span>100</span><span>0</span></div>
                        <div class="chart-columns">
                            <div class="chart-col"><i style="height:42%"></i><small>Mon</small></div><div class="chart-col"><i style="height:62%"></i><small>Tue</small></div><div class="chart-col"><i style="height:50%"></i><small>Wed</small></div><div class="chart-col"><i style="height:78%"></i><small>Thu</small></div><div class="chart-col"><i style="height:58%"></i><small>Fri</small></div><div class="chart-col"><i style="height:90%"></i><small>Sat</small></div><div class="chart-col"><i style="height:68%"></i><small>Sun</small></div>
                        </div>
                    </div>
                </article>
                <article class="panel roadmap-panel">
                    <div class="panel-heading"><div><h2>Implementation roadmap</h2><p>8-week project progress</p></div><a class="text-link" href="${pageContext.request.contextPath}/documentation">View plan ↗</a></div>
                    <div class="roadmap-progress"><div><strong>Week 2 of 8</strong><span>25% completed</span></div><div class="progress-track"><i style="width:25%"></i></div></div>
                    <div class="roadmap-step done"><span class="step-check">✓</span><div><b>Week 1 · Inventory foundation</b><small>Manual entry and bulk upload</small></div><span class="step-status">Complete</span></div>
                    <div class="roadmap-step current"><span class="step-number">02</span><div><b>Week 2 · Expiry tracking</b><small>Alerts, taxonomy and barcode scan</small></div><span class="step-status">In progress</span></div>
                    <div class="roadmap-step"><span class="step-number">03</span><div><b>Week 3 · Data preparation</b><small>Historical sales and waste data</small></div><span class="step-status">Upcoming</span></div>
                </article>
            </section>

            <footer class="page-footer"><span>© 2026 NutriFlux · Food intelligence for a better tomorrow.</span><span>Built to reduce waste, one meal at a time.</span></footer>
        </div>
    </main>
</div>
</body>
</html>
