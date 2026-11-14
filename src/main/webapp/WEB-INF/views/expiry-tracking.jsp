<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Expiry Tracking | NutriFlux</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/expiry-tracking.css?v=20261113">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700;800&family=Manrope:wght@500;600;700;800&display=swap"
          rel="stylesheet">
</head>

<body>
<div class="layout">

    <aside class="sidebar" id="sidebar">
        <a class="brand" href="${pageContext.request.contextPath}/dashboard">
            <span class="brand-logo">N</span>
            <span>
                <strong>NutriFlux</strong>
                <small>Food intelligence platform</small>
            </span>
        </a>

        <div class="nav-label">WORKSPACE</div>

        <nav class="nav">
            <a href="${pageContext.request.contextPath}/dashboard" class="nav-item">
                <span class="nav-icon">⌂</span>Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/inventory" class="nav-item">
                <span class="nav-icon">▤</span>Inventory
            </a>
            <a href="${pageContext.request.contextPath}/expiry" class="nav-item active">
                <span class="nav-icon">◷</span>Expiry tracking
            </a>
            <a href="${pageContext.request.contextPath}/surplus" class="nav-item">
                <span class="nav-icon">♧</span>Surplus listings
            </a>
            <a href="${pageContext.request.contextPath}/marketplace" class="nav-item">
                <span class="nav-icon">⇄</span>Marketplace
            </a>
            <a href="${pageContext.request.contextPath}/analytics" class="nav-item">
                <span class="nav-icon">▥</span>Impact analytics
            </a>
        </nav>

        <div class="sidebar-bottom">

            <a class="profile" href="${pageContext.request.contextPath}/profile">
                <span class="avatar">
                    <c:out value="${not empty userInitials ? userInitials : 'AP'}"/>
                </span>
                <span class="profile-text">
                    <strong><c:out value="${not empty displayName ? displayName : 'Admin'}"/></strong>
                    <small>Business workspace</small>
                </span>
                <span class="dots">···</span>
            </a>
        </div>
    </aside>

    <main class="main">
        <header class="topbar">
            <div class="crumbs">
                <span>Workspace</span>
                <i>/</i>
                <strong>Expiry tracking</strong>
            </div>

            <div class="top-actions">

                <div class="user">
                    <span class="avatar">
                        <c:out value="${not empty userInitials ? userInitials : 'AP'}"/>
                    </span>
                    <span>
                        <strong><c:out value="${not empty displayName ? displayName : 'Admin'}"/></strong>
                        <small>Business account</small>
                    </span>
                    <b>⌄</b>
                </div>

                <button class="menu-toggle" id="menuToggle" type="button">☰</button>
            </div>
        </header>

        <div class="content">

            <section class="page-head">
                <div>
                    <div class="eyebrow">
                        <span></span>
                        EXPIRY MANAGEMENT
                    </div>
                    <h1>Expiry tracking <em>◷</em></h1>
                    <p>Monitor product expiry, get timely alerts, and take action to reduce food waste.</p>
                </div>

                <div class="head-buttons">
                    <a class="btn btn-light"
                       href="${pageContext.request.contextPath}/inventory">
                        ↑ Import CSV
                    </a>
                    <a class="btn btn-green"
                       href="${pageContext.request.contextPath}/inventory">
                        ＋ Add item
                    </a>
                </div>
            </section>

            <section class="stats">
                <article class="stat stat-red">
                    <div class="stat-icon">▣</div>
                    <div class="stat-copy">
                        <span>Expired Items</span>
                        <strong><c:out value="${expiredItems != null ? expiredItems : 0}"/></strong>
                    </div>
                </article>

                <article class="stat stat-yellow">
                    <div class="stat-icon">⚠</div>
                    <div class="stat-copy">
                        <span>Expiring Today</span>
                        <strong><c:out value="${expiringToday != null ? expiringToday : 0}"/></strong>
                    </div>
                </article>

                <article class="stat stat-green">
                    <div class="stat-icon">▣</div>
                    <div class="stat-copy">
                        <span>Critical Items</span>
                        <strong><c:out value="${totalItems != null ? totalItems : 0}"/></strong>
                    </div>
                </article>

                <article class="stat stat-blue">
                    <div class="stat-icon">◷</div>
                    <div class="stat-copy">
                        <span>Expiring Soon <small>(Next 7 Days)</small></span>
                        <strong><c:out value="${expiringSoon != null ? expiringSoon : 0}"/></strong>
                    </div>
                </article>

            </section>

            <section class="overview-grid">

                <article class="panel overview-panel">
                    <div class="panel-title">
                        <h2>Expiry Overview</h2>
                        <p>Items by expiry status</p>
                    </div>

                    <div class="overview-body">
                        <div class="donut">
                            <div class="donut-center">
                                <strong><c:out value="${totalItems != null ? totalItems : 0}"/></strong>
                                <span>Items</span>
                            </div>
                        </div>

                        <div class="legend">
                            <div>
                                <i class="dot safe"></i>
                                <span>Safe (&gt; 7 days)</span>
                                <strong><c:out value="${safeItems != null ? safeItems : 0}"/></strong>
                                <small style="display: none;">${totalItems > 0 ? (safeItems * 100.0 / totalItems) : 0}</small>
                            </div>
                            <div>
                                <i class="dot soon"></i>
                                <span>Expiring Soon (1 – 7 days)</span>
                                <strong><c:out value="${expiringSoon != null ? expiringSoon : 0}"/></strong>
                                <small style="display: none;">${totalItems > 0 ? (expiringSoon * 100.0 / totalItems) : 0}</small>
                            </div>
                            <div>
                                <i class="dot expired"></i>
                                <span>Expired</span>
                                <strong><c:out value="${expiredItems != null ? expiredItems : 0}"/></strong>
                                <small style="display: none;">${totalItems > 0 ? (expiredItems * 100.0 / totalItems) : 0}</small>
                            </div>
                        </div>
                    </div>
                </article>

                <article class="panel priority-panel">
                    <div class="priority-head">
                        <div class="panel-title">
                            <h2>Priority Alerts</h2>
                            <p>Items that need immediate attention</p>
                        </div>
                        <a href="#expiryList">View all alerts ↗</a>
                    </div>

                    <c:if test="${not empty priorityItems}">
                        <div class="priority-list">
                            <c:forEach var="item" items="${priorityItems}" varStatus="loop">
                                <div class="priority-row">
                                    <span class="food-icon food-${loop.index % 3}">
                                        <c:out value="${loop.index % 3 eq 0 ? '●' : (loop.index % 3 eq 1 ? '▰' : '◆')}"/>
                                    </span>

                                    <span class="food-info">
                                        <strong><c:out value="${item.productName}"/></strong>
                                        <small>
                                            <c:out value="${item.quantity}"/>
                                            <c:out value="${item.unit}"/> ·
                                            <c:if test="${item.daysLeft lt 0}">Expired</c:if>
                                            <c:if test="${item.daysLeft eq 0}">Expires today</c:if>
                                            <c:if test="${item.daysLeft gt 0}">
                                                Expires in <c:out value="${item.daysLeft}"/> day(s)
                                            </c:if>
                                        </small>
                                    </span>

                                    <span class="alert-badge ${item.daysLeft le 0 ? 'badge-red' : 'badge-yellow'}">
                                        <c:if test="${item.daysLeft lt 0}">Expired</c:if>
                                        <c:if test="${item.daysLeft eq 0}">Expires Today</c:if>
                                        <c:if test="${item.daysLeft gt 0}">
                                            <c:out value="${item.daysLeft}"/>
                                            <c:if test="${item.daysLeft gt 1}">Days Left</c:if>
                                            <c:if test="${item.daysLeft eq 1}">Day Left</c:if>
                                        </c:if>
                                    </span>
                                </div>
                            </c:forEach>
                        </div>
                    </c:if>

                    <c:if test="${empty priorityItems}">
                        <div class="priority-empty">
                            <div class="priority-empty-icon">
                                <span>✓</span>
                            </div>
                            <h3>All Clear!</h3>
                            <p>No priority alerts at the moment. Your inventory is looking good.</p>
                        </div>
                    </c:if>
                </article>
            </section>

            <section class="panel table-panel" id="expiryList">
                <div class="table-head">
                    <div>
                        <h2>Inventory Expiry List</h2>
                        <p>Track and manage expiry dates for all inventory items.</p>
                    </div>

                    <div class="filters">
                        <label class="search">
                            <span>⌕</span>
                            <input id="searchInput" type="search"
                                   placeholder="Search by product name or id...">
                        </label>

                        <select id="categoryFilter" aria-label="Filter by food category">
                            <option value="">All Categories</option>
                            <option value="FRUITS">Fruits</option>
                            <option value="VEGETABLES">Vegetables</option>
                            <option value="LEAFY_GREENS">Leafy Greens</option>
                            <option value="ROOT_VEGETABLES">Root Vegetables</option>
                            <option value="HERBS">Herbs</option>
                            <option value="MILK">Milk</option>
                            <option value="DAIRY_PRODUCTS">Dairy Products</option>
                            <option value="CHEESE">Cheese</option>
                            <option value="BUTTER_AND_CREAM">Butter and Cream</option>
                            <option value="YOGURT">Yogurt</option>
                            <option value="EGGS">Eggs</option>
                            <option value="MEAT">Meat</option>
                            <option value="POULTRY">Poultry</option>
                            <option value="SEAFOOD">Seafood</option>
                            <option value="FISH">Fish</option>
                            <option value="RICE">Rice</option>
                            <option value="WHEAT">Wheat</option>
                            <option value="FLOUR">Flour</option>
                            <option value="CEREALS">Cereals</option>
                            <option value="PULSES_AND_LENTILS">Pulses and Lentils</option>
                            <option value="MILLETS">Millets</option>
                            <option value="PASTA_AND_NOODLES">Pasta and Noodles</option>
                            <option value="BREAD">Bread</option>
                            <option value="CAKES_AND_PASTRIES">Cakes and Pastries</option>
                            <option value="BAKERY_PRODUCTS">Bakery Products</option>
                            <option value="CANNED_FOOD">Canned Food</option>
                            <option value="FROZEN_FOOD">Frozen Food</option>
                            <option value="READY_TO_EAT">Ready to Eat</option>
                            <option value="READY_TO_COOK">Ready to Cook</option>
                            <option value="PACKAGED_FOOD">Packaged Food</option>
                            <option value="SNACKS">Snacks</option>
                            <option value="WATER">Water</option>
                            <option value="JUICES">Juices</option>
                            <option value="SOFT_DRINKS">Soft Drinks</option>
                            <option value="TEA_AND_COFFEE">Tea and Coffee</option>
                            <option value="ENERGY_DRINKS">Energy Drinks</option>
                            <option value="OILS_AND_FATS">Oils and Fats</option>
                            <option value="SPICES">Spices</option>
                            <option value="CONDIMENTS">Condiments</option>
                            <option value="SAUCES">Sauces</option>
                            <option value="SUGAR_AND_SWEETENERS">Sugar and Sweeteners</option>
                            <option value="SALT">Salt</option>
                            <option value="NUTS_AND_SEEDS">Nuts and Seeds</option>
                            <option value="DRY_FRUITS">Dry Fruits</option>
                            <option value="SWEETS_AND_DESSERTS">Sweets and Desserts</option>
                            <option value="ORGANIC_FOOD">Organic Food</option>
                            <option value="BABY_FOOD">Baby Food</option>
                            <option value="OTHER">Other</option>
                        </select>

                        <select id="statusFilter" class="filter-select">
                            <option value="">All statuses</option>
                            <option value="safe">Safe</option>
                            <option value="soon">Expiring Soon (4-7 days)</option>
                            <option value="critical">Critical (1-3 days)</option>
                            <option value="today">Expires Today</option>
                            <option value="expired">Expired</option>
                        </select>
                    </div>
                </div>

                <div class="table-scroll">
                    <table>
                        <thead>
                            <tr>
                                <th>PRODUCT</th>
                                <th>CATEGORY</th>
                                <th>QUANTITY</th>
                                <th>UNIT</th>
                                <th>EXPIRY DATE</th>
                                <th>STATUS</th>
                            </tr>
                        </thead>

                        <tbody id="expiryRows">
                            <c:if test="${empty expiryItems}">
                                <tr>
                                    <td colspan="6" class="empty-state">
                                        <div class="empty-content">
                                            <span class="empty-icon">▤</span>
                                            <h3>No inventory found</h3>
                                            <p>Your inventory is empty. Add your first product to start tracking expiry dates.</p>
                                        </div>
                                    </td>
                                </tr>
                            </c:if>

                            <c:forEach var="item" items="${expiryItems}">
                                <tr class="data-row"
                                    data-search="${item.productName} ${item.id}"
                                    data-category="${item.category}"
                                    data-expiry="${item.expiryDate}">

                                    <td>
                                        <div class="product">
                                            <span class="product-icon">▦</span>
                                            <span>
                                                <strong><c:out value="${item.productName}"/></strong>
                                                <small style="display: none;"><c:out value="${item.id}"/></small>
                                            </span>
                                        </div>
                                    </td>

                                    <td><c:out value="${item.category}"/></td>
                                    <td><b><c:out value="${item.quantity}"/></b></td>
                                    <td><c:out value="${item.unit}"/></td>
                                    <td class="expiry-date"><c:out value="${item.expiryDate}"/></td>
                                    <td>
                                        <span class="status expiry-status">Calculating...</span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div class="table-bottom">
                    <span id="rowCount">Showing inventory items</span>
                    <a href="${pageContext.request.contextPath}/inventory">
                        View all inventory ↗
                    </a>
                </div>
            </section>

            <footer class="footer">
                <span>© 2026 NutriFlux · Food intelligence for a better tomorrow.</span>
                <span>Built to reduce waste, one meal at a time.</span>
            </footer>

        </div>
    </main>
</div>

<script>
(function () {
    const search = document.getElementById('searchInput');
    const category = document.getElementById('categoryFilter');
    const status = document.getElementById('statusFilter');
    const rows = Array.from(document.querySelectorAll('#expiryRows .data-row'));
    const count = document.getElementById('rowCount');

    function calculateExpiryStatus() {
        const now = new Date();
        const today = new Date(now.getFullYear(), now.getMonth(), now.getDate());

        rows.forEach(row => {
            const expiryValue = row.dataset.expiry;
            const statusElement = row.querySelector('.expiry-status');
            const dateElement = row.querySelector('.expiry-date');

            if (!expiryValue || !statusElement) {
                if (statusElement) {
                    statusElement.className = 'status expired';
                    statusElement.textContent = 'Date unavailable';
                }
                row.dataset.status = '';
                return;
            }
            const parts = expiryValue.split('-').map(Number);
            if (parts.length !== 3 || parts.some(Number.isNaN)) {
                statusElement.className = 'status expired';
                statusElement.textContent = 'Invalid expiry date';
                row.dataset.status = '';
                return;
            }

            const expiry = new Date(parts[0], parts[1] - 1, parts[2]);
            const daysLeft = Math.round((expiry - today) / 86400000);

            let statusKey;
            let statusLabel;

            if (daysLeft < 0) {
                statusKey = 'expired';
                statusLabel = 'Expired';
            } else if (daysLeft === 0) {
                statusKey = 'today';
                statusLabel = 'Expires Today';
            } else if (daysLeft <= 3) {
                statusKey = 'critical';
                statusLabel = 'Critical';
            } else if (daysLeft <= 7) {
                statusKey = 'soon';
                statusLabel = 'Expiring Soon';
            } else {
                statusKey = 'safe';
                statusLabel = 'Safe';
            }

            statusElement.className = 'status ' + statusKey;
            statusElement.textContent = statusLabel;
            row.dataset.status = statusKey;

            if (dateElement) {
                dateElement.textContent = expiry.toLocaleDateString('en-GB', {
                    day: '2-digit', month: 'short', year: 'numeric'
                });
            }
        });
    }

    function applyFilters() {
        const term = search.value.trim().toLowerCase();
        let visible = 0;

        rows.forEach(row => {
            const matches =
                (row.dataset.search || '').toLowerCase().includes(term) &&
                (!category.value || row.dataset.category === category.value) &&
                (!status.value || row.dataset.status === status.value);

            row.hidden = !matches;
            if (matches) visible++;
        });

        count.textContent = 'Showing ' + visible + ' of ' + rows.length + ' inventory items';
    }

    calculateExpiryStatus();
    applyFilters();

    search.addEventListener('input', applyFilters);
    category.addEventListener('change', applyFilters);
    status.addEventListener('change', applyFilters);

    document.getElementById('menuToggle').addEventListener('click', function () {
        document.getElementById('sidebar').classList.toggle('open');
    });
})();
</script>

</body>
</html>
