<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Workspace — NutriFlux</title>
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=DM+Mono:wght@400;500&family=DM+Sans:wght@400;500;600;700&family=Manrope:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/interface.css">
</head>
<body>
<div class="dashboard">
<aside class="sidebar">
<a class="brand" href="${pageContext.request.contextPath}/home"><span class="brand-mark">n.</span><span>nutriflux<span class="brand-dot">.</span></span></a>
<div class="workspace-label">WORKSPACE <span>01</span></div>
<nav class="side-nav"><a class="active" href="${pageContext.request.contextPath}/interface"><span>⌂</span> Overview</a><a href="#"><span>◫</span> Food listings <i>08</i></a><a href="#"><span>⌁</span> Connections</a><a href="#"><span>◷</span> Activity</a><a href="#"><span>▤</span> Impact report</a></nav>
<div class="sidebar-bottom"><div class="help-card"><span>✳</span><strong>Need a hand?</strong><p>Our community guide can help you get started.</p><a href="#">Open guide ↗</a></div><a class="side-logout" href="${pageContext.request.contextPath}/logout">↗ <span>Log out</span></a></div>
</aside>
<main class="dashboard-main">
<header class="dashboard-top"><div class="crumb">WORKSPACE <span>/</span> OVERVIEW</div><div class="top-actions"><button class="icon-button" aria-label="Notifications">♧<i></i></button><div class="profile"><span class="profile-avatar">NF</span><span><strong>Welcome back</strong><small>Community member</small></span><span class="profile-chevron">⌄</span></div></div></header>
<section class="welcome-row"><div><div class="date-line">YOUR FOOD CIRCULARITY DESK <span>✳</span></div><h1>Make today<br><em>count.</em></h1><p>Here's what's happening across your food network.</p></div><a class="primary-action" href="#">＋ <span>Create a listing</span></a></section>
<section class="metrics-grid">
<article class="metric-card metric-dark"><div class="metric-top"><span>FOOD RESCUED</span><span>↗</span></div><strong>248<span class="metric-unit"> kg</span></strong><div class="metric-bottom"><span class="metric-bar"><i style="width:72%"></i></span><small>THIS MONTH</small></div></article>
<article class="metric-card"><div class="metric-top"><span>ACTIVE LISTINGS</span><span>◫</span></div><strong>08</strong><div class="metric-bottom"><span class="metric-status">● 3 need attention</span><small>RIGHT NOW</small></div></article>
<article class="metric-card"><div class="metric-top"><span>CONNECTIONS MADE</span><span>⌁</span></div><strong>36</strong><div class="metric-bottom"><span class="metric-status">↑ 12% this month</span><small>ALL TIME</small></div></article>
</section>
<section class="content-grid">
<div class="listings-panel"><div class="panel-heading"><div><span class="panel-kicker">THE GOOD STUFF</span><h2>Recent listings</h2></div><a href="#">View all ↗</a></div>
<div class="listing-table"><div class="table-head"><span>FOOD ITEM</span><span>QUANTITY</span><span>STATUS</span></div>
<div class="listing-row"><div class="food-item"><span class="food-thumb thumb-tomato">●</span><span><strong>Fresh tomatoes</strong><small>Added 20 min ago</small></span></div><span class="quantity">18 kg</span><span class="status status-live">Available</span></div>
<div class="listing-row"><div class="food-item"><span class="food-thumb thumb-bread">▰</span><span><strong>Artisan bread</strong><small>Added 2 hours ago</small></span></div><span class="quantity">24 units</span><span class="status status-pending">Pending pickup</span></div>
<div class="listing-row"><div class="food-item"><span class="food-thumb thumb-greens">✳</span><span><strong>Seasonal greens</strong><small>Added yesterday</small></span></div><span class="quantity">6 kg</span><span class="status status-live">Available</span></div>
<div class="listing-row"><div class="food-item"><span class="food-thumb thumb-fruit">◒</span><span><strong>Mixed citrus</strong><small>Added yesterday</small></span></div><span class="quantity">12 kg</span><span class="status status-done">Completed</span></div>
</div></div>
<aside class="activity-panel"><div class="panel-heading"><div><span class="panel-kicker">IN THE LOOP</span><h2>Recent activity</h2></div><span class="activity-live">LIVE</span></div>
<div class="activity-item"><span class="activity-dot dot-green"></span><div><p><strong>Pickup confirmed</strong><br>Artisan bread · 24 units</p><small>12 minutes ago</small></div></div>
<div class="activity-item"><span class="activity-dot dot-orange"></span><div><p><strong>New connection</strong><br>Green Basket Community</p><small>1 hour ago</small></div></div>
<div class="activity-item"><span class="activity-dot dot-lime"></span><div><p><strong>Listing published</strong><br>Fresh tomatoes · 18 kg</p><small>3 hours ago</small></div></div>
<a class="activity-link" href="#">See all activity ↗</a></aside>
</section>
<section class="bottom-banner"><div class="banner-mark">✳</div><div><span>ONE GOOD CONNECTION AT A TIME</span><h2>Got food to share?</h2><p>Put your surplus to work. Someone nearby could use it today.</p></div><a href="#">Create a listing ↗</a></section>
<footer class="dashboard-footer"><span>NUTRIFLUX / COMMUNITY WORKSPACE</span><span>GOOD FOOD. BETTER ROUTES.</span></footer>
</main>
</div>
</body>
</html>