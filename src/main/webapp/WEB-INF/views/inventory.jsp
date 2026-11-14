<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventory | NutriFlux</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Manrope:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/inventory.css?v=20261113">
    <script src="https://cdn.jsdelivr.net/npm/jsbarcode@3.11.6/dist/JsBarcode.all.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"></script>
</head>
<body>
<div class="app-shell">
    <aside class="sidebar">
        <a class="brand" href="${pageContext.request.contextPath}/dashboard">
            <span class="brand-mark">N</span>
            <span class="brand-copy">
                <strong>NutriFlux</strong>
                <small>Food intelligence platform</small>
            </span>
        </a>

        <div class="workspace-label">WORKSPACE</div>

        <nav class="side-nav">
            <a class="nav-link" href="${pageContext.request.contextPath}/dashboard">
                <span class="nav-icon">⌂</span>Dashboard
            </a>
            <a class="nav-link active" href="${pageContext.request.contextPath}/inventory">
                <span class="nav-icon">▤</span>Inventory
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/expiry">
                <span class="nav-icon">◷</span>Expiry tracking
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/surplus">
                <span class="nav-icon">♧</span>Surplus listings
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/marketplace">
                <span class="nav-icon">⇄</span>Marketplace
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/analytics">
                <span class="nav-icon">▥</span>Impact analytics
            </a>
        </nav>

        <div class="sidebar-bottom">
            <a class="profile-mini" href="${pageContext.request.contextPath}/profile">
                <span class="avatar">AP</span>
                <span>
                    <b>Account profile</b>
                    <small>Business workspace</small>
                </span>
                <span class="profile-more">•••</span>
            </a>
        </div>
    </aside>

    <main class="main-area">
        <header class="topbar">
            <div class="breadcrumbs">
                <span>Workspace</span>
                <i>/</i>
                <strong>Inventory</strong>
            </div>

            <div class="topbar-actions">
                <button class="icon-button" type="button" aria-label="Notifications">
                    ♧<em></em>
                </button>
                <div class="top-user">
                    <span class="avatar">AP</span>
                    <span>
                        <b>Admin</b>
                        <small>Business account</small>
                    </span>
                    <span class="chevron">⌄</span>
                </div>
            </div>
        </header>

        <div class="page-content">
            <section class="welcome-row">
                <div>
                    <div class="eyebrow">
                        <span class="eyebrow-dot"></span>
                        INVENTORY MANAGEMENT
                    </div>
                    <h1>Inventory <span>▤</span></h1>
                    <p class="page-subtitle">
                        Manage your food stock, monitor quantities and keep track of available items.
                    </p>
                </div>

                <div class="welcome-actions">
                    <button class="button button-light" type="button" id="uploadButton">
                        ↑ Import CSV
                    </button>
                    <button class="button button-primary" type="button" id="openAddForm">
                        ＋ Add item
                    </button>
                </div>
            </section>

            <section class="inventory-metrics">
                <article class="metric-card">
                    <div class="metric-top">
                        <span>Total items</span>
                        <span class="metric-icon green">▤</span>
                    </div>
                    <div class="metric-value" id="totalItems">0</div>
                    <div class="metric-foot">Across all categories</div>
                </article>

                <article class="metric-card">
                    <div class="metric-top">
                        <span>Available stock</span>
                        <span class="metric-icon blue">✓</span>
                    </div>
                    <div class="metric-value" id="availableStock">0</div>
                    <div class="metric-foot">Healthy inventory</div>
                </article>

                <article class="metric-card">
                    <div class="metric-top">
                        <span>Expiring soon</span>
                        <span class="metric-icon amber">◷</span>
                    </div>
                    <div class="metric-value" id="expiringSoon">0</div>
                    <div class="metric-foot">Requires monitoring</div>
                </article>

                <article class="metric-card">
                    <div class="metric-top">
                        <span>Out of stock</span>
                        <span class="metric-icon red">!</span>
                    </div>
                    <div class="metric-value" id="outOfStock">0</div>
                    <div class="metric-foot">Needs replenishment</div>
                </article>
            </section>

            <section class="inventory-toolbar">
                <div class="toolbar-heading">
                    <div>
                        <h2>All inventory items</h2>
                        <p>View and manage your stored food products.</p>
                    </div>
                </div>

                <div class="toolbar-controls">
                    <div class="search-box">
                        <span>⌕</span>
                        <input type="search" id="searchInput" placeholder="Search inventory...">
                    </div>

                    <select id="categoryFilter" class="filter-select">
                        <option value="">All categories</option>
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
                        <option value="FRESH">Fresh</option>
                        <option value="EXPIRED_SOON">Expiring Soon (4-7 days)</option>
                        <option value="CRITICAL">Critical (1-3 days)</option>
                        <option value="EXPIRED">Expired</option>
                    </select>
                </div>
            </section>

            <section class="panel table-panel">
                <div class="table-wrapper">
                    <table class="inventory-table" id="inventoryTable">
                        <thead>
                        <tr>
                            <th>PRODUCT</th>
                            <th>CATEGORY</th>
                            <th>QUANTITY</th>
                            <th>UNIT</th>
                            <th>EXPIRY DATE</th>
                            <th>STATUS</th>
                            <th>ACTION</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:forEach var="item" items="${listOfProducts}">
                            <tr class="inventory-data-row"
                                data-product-name="<c:out value='${item.productName}'/>"
                                data-category="<c:out value='${item.category}'/>"
                                data-days-left="${item.daysLeft}"
                                data-status="">
                                <td>
                                    <div class="product-cell">
                                        <span class="product-icon produce">●</span>
                                        <span>
                                            <b><c:out value="${item.productName}" /></b>
                                            <small style="display:none;"><c:out value="${item.id}" /></small>
                                        </span>
                                    </div>
                                </td>
                                <td><c:out value="${item.category}" /></td>
                                <td><c:out value="${item.quantity}" /></td>
                                <td><c:out value="${item.unit}" /></td>
                                <td><c:out value="${item.expiryDate}" /></td>
                                <td>
                                    <span class="status-badge" data-status="">Calculating...</span>
                                </td>
                                <td>
                                    <div class="row-action-wrap">
                                        <button class="show-qr-btn"
                                                type="button"
                                                data-barcode="<c:out value='${item.barcode}'/>"
                                                data-product="<c:out value='${item.productName}'/>"
                                                onclick="showInventoryQr(this)">
                                            <span aria-hidden="true">▦</span> Show QR
                                        </button>

                                        <button class="row-action" type="button"
                                                aria-label="Open product actions"
                                                aria-haspopup="true"
                                                aria-expanded="false">•••</button>

                                        <div class="row-action-menu" role="menu">
                                            <button class="row-action-menu-item update-action"
                                                    type="button"
                                                    role="menuitem"
                                                    data-id="<c:out value='${item.id}'/>"
                                                    data-name="<c:out value='${item.productName}'/>"
                                                    data-category="<c:out value='${item.category}'/>"
                                                    data-quantity="<c:out value='${item.quantity}'/>"
                                                    data-unit="<c:out value='${item.unit}'/>"
                                                    data-expiry="<c:out value='${item.expiryDate}'/>">
                                                <span class="menu-item-icon">✎</span> Update
                                            </button>

                                            <form class="row-delete-form"
                                                  action="${pageContext.request.contextPath}/inventory/delete/${item.id}"
                                                  method="post"
                                                  onsubmit="return confirm('Are you sure you want to delete this inventory item?');">
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                                <button class="row-action-menu-item delete-action" type="submit" role="menuitem">
                                                    <span class="menu-item-icon">⌫</span> Delete
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    </table>
                </div>

                <div class="table-footer">
                    <span>Showing <b id="visibleCount">0</b> inventory items</span>
                </div>
            </section>

            <section class="panel add-item-panel" id="addItemPanel">
                <div class="panel-heading">
                    <div>
                        <h2 id="formTitle">Add inventory item</h2>
                        <p id="formDescription">Enter the details of a new food product.</p>
                    </div>
                    <button type="button" class="close-form" id="closeAddForm">×</button>
                </div>

                <form id="inventoryForm"
                      action="${pageContext.request.contextPath}/inventory/create"
                      method="post"
                      class="add-item-form">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

                    <div class="form-grid">
                        <div class="form-field">
                            <label for="productName">Product name</label>
                            <input type="text" id="productName" name="productName" placeholder="Enter product name" required>
                        </div>

                        <div class="form-field">
                            <label for="category">Category</label>
                            <select id="category" name="category" required>
                                <option value="">Select category</option>
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
                        </div>

                        <div class="form-field">
                            <label for="quantity">Quantity</label>
                            <input type="number" id="quantity" name="quantity" min="0" step="0.01" placeholder="Enter quantity" required>
                        </div>

                        <div class="form-field">
                            <label for="unit">Unit</label>
                            <select id="unit" name="unit" required>
                                <option value="">Select unit</option>
                                <option value="kg">Kilograms</option>
                                <option value="Litres">Litres</option>
                                <option value="Units">Units</option>
                                <option value="Packs">Packs</option>
                                <option value="Bags">Bags</option>
                            </select>
                        </div>

                        <div class="form-field">
                            <label for="expiryDate">Expiry date</label>
                            <input type="date" id="expiryDate" name="expiryDate" required>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="reset" class="button button-light" id="clearForm">Clear</button>
                        <button type="submit" class="button button-primary" id="submitForm">Save inventory item</button>
                    </div>
                </form>
            </section>

            <section class="panel import-panel" id="importPanel">
                <div>
                    <h2>Import inventory using CSV</h2>
                    <p>Upload a CSV file containing your inventory records.</p>
                </div>

                <form action="${pageContext.request.contextPath}/inventory/import" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                    <label class="upload-area" for="csvFile">
                        <span class="upload-icon">↑</span>
                        <strong>Choose a CSV file</strong>
                        <small id="fileName">CSV files only</small>
                    </label>
                    <input type="file" id="csvFile" name="file" accept=".csv,text/csv" hidden>
                    <button type="submit" class="button button-primary">Import inventory</button>
                </form>
            </section>

            <footer class="page-footer">
                <span>© 2026 NutriFlux · Food intelligence for a better tomorrow.</span>
                <span>Built to reduce waste, one meal at a time.</span>
            </footer>
        </div>
    </main>
</div>

<!-- QR code popup -->
<div class="qr-modal" id="qrModal" aria-hidden="true">
    <div class="qr-modal-backdrop" data-qr-close></div>
    <section class="qr-modal-dialog"
             role="dialog"
             aria-modal="true"
             aria-labelledby="qrModalTitle">
        <button type="button" class="qr-modal-close"
                aria-label="Close QR code popup"
                data-qr-close>&times;</button>

        <div class="qr-modal-heading">
            <span class="qr-modal-icon" aria-hidden="true">▦</span>
            <div>
                <h2 id="qrModalTitle">Product QR code</h2>
                <p id="qrProductName">Inventory item</p>
            </div>
        </div>

        <div class="qr-code-frame">
            <div id="qrCodeContainer"></div>
        </div>

        <p class="qr-barcode-value" id="qrBarcodeValue"></p>
        <p class="qr-modal-hint">Scan this QR code to identify this inventory item.</p>

        <button type="button" class="qr-modal-done" data-qr-close>Close</button>
    </section>
</div>

<script>
/* Generate the QR from the saved database barcode. The encoded value stays
   identical across reloads as long as item.barcode does not change. */
function showInventoryQr(button) {
    const barcode = (button.dataset.barcode || "").trim();
    const productName = button.dataset.product || "Inventory item";
    const modal = document.getElementById("qrModal");
    const container = document.getElementById("qrCodeContainer");

    if (!barcode) {
        alert("This inventory item has no barcode saved. Add a barcode before viewing its QR code.");
        return;
    }

    if (typeof QRCode === "undefined") {
        alert("QR code library could not be loaded. Please check your internet connection and reload the page.");
        return;
    }

    container.innerHTML = "";
    document.getElementById("qrProductName").textContent = productName;
    document.getElementById("qrBarcodeValue").textContent = "Barcode: " + barcode;

    new QRCode(container, {
        text: barcode,
        width: 220,
        height: 220,
        correctLevel: QRCode.CorrectLevel.H
    });

    modal.classList.add("is-open");
    modal.setAttribute("aria-hidden", "false");
    document.body.classList.add("qr-modal-open");
}

function closeInventoryQr() {
    const modal = document.getElementById("qrModal");
    if (!modal) return;

    modal.classList.remove("is-open");
    modal.setAttribute("aria-hidden", "true");
    document.body.classList.remove("qr-modal-open");
}

document.addEventListener("click", event => {
    if (event.target.closest("[data-qr-close]")) {
        closeInventoryQr();
    }
});

document.addEventListener("keydown", event => {
    if (event.key === "Escape") {
        closeInventoryQr();
    }
});

document.addEventListener("DOMContentLoaded", () => {
    const searchInput = document.getElementById("searchInput");
    const categoryFilter = document.getElementById("categoryFilter");
    const statusFilter = document.getElementById("statusFilter");
    const inventoryBody = document.querySelector("#inventoryTable tbody");
    const visibleCount = document.getElementById("visibleCount");

    if (!inventoryBody) return;

    const tableRows = Array.from(
        inventoryBody.querySelectorAll(".inventory-data-row")
    );

    // Status is based on daysLeft calculated by the Inventory entity.
    // JavaScript only maps that value to a display/filter status.
    function getExpiryStatus(daysLeft) {
        if (!Number.isFinite(daysLeft)) return "UNKNOWN";
        if (daysLeft <= 0) return "EXPIRED";
        if (daysLeft <= 3) return "CRITICAL";
        if (daysLeft <= 7) return "EXPIRED_SOON";
        return "FRESH";
    }

    function updateExpiryStatuses() {
        tableRows.forEach(row => {
            const daysLeft = Number(row.dataset.daysLeft);
            const status = getExpiryStatus(daysLeft);
            const badge = row.querySelector(".status-badge");

            row.dataset.status = status;

            if (badge) {
                badge.dataset.status = status;
                const statusLabels = {
                    FRESH: "Fresh",
                    EXPIRED_SOON: "Expiring Soon (4-7 days)",
                    CRITICAL: "Critical (1-3 days)",
                    EXPIRED: "Expired",
                    UNKNOWN: "Unknown"
                };
                badge.textContent = statusLabels[status];
            }
        });
    }

    function updateInventoryMetrics() {
        let total = 0;
        let available = 0;
        let expiring = 0;
        let outOfStock = 0;

        tableRows.forEach(row => {
            total++;

            const status = row.dataset.status;
            const quantity =
                parseFloat(row.cells[2]?.textContent.trim()) || 0;

            if (quantity > 0) {
                available++;
            } else {
                outOfStock++;
            }

            if (status === "EXPIRED_SOON" || status === "CRITICAL") {
                expiring++;
            }
        });

        document.getElementById("totalItems").textContent =
            total.toLocaleString("en-IN");

        document.getElementById("availableStock").textContent =
            available.toLocaleString("en-IN");

        document.getElementById("expiringSoon").textContent =
            expiring.toLocaleString("en-IN");

        document.getElementById("outOfStock").textContent =
            outOfStock.toLocaleString("en-IN");
    }

    updateExpiryStatuses();
    updateInventoryMetrics();

    const emptyRow = document.createElement("tr");
    emptyRow.id = "emptyInventoryRow";

    const emptyCell = document.createElement("td");
    emptyCell.colSpan = 7;
    emptyCell.className = "empty-inventory";

    emptyCell.innerHTML = `
        <div class="empty-state">
            <span class="empty-icon">▤</span>
            <strong>No inventory found</strong>
            <p>Your inventory is empty. Import a CSV file or add your first product.</p>
        </div>
    `;

    emptyRow.appendChild(emptyCell);

    const noMatchesRow = document.createElement("tr");
    noMatchesRow.id = "noMatchesRow";

    const noMatchesCell = document.createElement("td");
    noMatchesCell.colSpan = 7;
    noMatchesCell.className = "empty-inventory";

    noMatchesCell.innerHTML = `
        <div class="empty-state">
            <span class="empty-icon">⌕</span>
            <strong>No matching products</strong>
            <p>Try another product name or change your category/status filters.</p>
        </div>
    `;

    noMatchesRow.appendChild(noMatchesCell);

    function normalize(value) {
        return (value || "").trim().toUpperCase();
    }

    function filterInventory() {
        const searchTerm = searchInput
            ? searchInput.value.trim().toLowerCase()
            : "";

        const selectedCategory = normalize(categoryFilter?.value);
        const selectedStatus = normalize(statusFilter?.value);

        let visibleRows = 0;

        tableRows.forEach(row => {
            const productName = (
                row.dataset.productName ||
                row.cells[0]?.textContent ||
                ""
            ).toLowerCase();

            const category = normalize(
                row.dataset.category || row.cells[1]?.textContent
            );

            const status = normalize(row.dataset.status);

            const searchableText = row.textContent.toLowerCase();

            const matchesSearch =
                !searchTerm ||
                searchableText.includes(searchTerm) ||
                productName.includes(searchTerm);

            const matchesCategory =
                !selectedCategory || category === selectedCategory;

            const matchesStatus =
                !selectedStatus || status === selectedStatus;

            const isVisible =
                matchesSearch && matchesCategory && matchesStatus;

            row.hidden = !isVisible;

            if (isVisible) visibleRows++;
        });

        if (visibleCount) {
            visibleCount.textContent = visibleRows;
        }

        if (tableRows.length === 0) {
            if (!emptyRow.isConnected) {
                inventoryBody.appendChild(emptyRow);
            }
            noMatchesRow.remove();
            return;
        }

        emptyRow.remove();

        if (visibleRows === 0) {
            if (!noMatchesRow.isConnected) {
                inventoryBody.appendChild(noMatchesRow);
            }
        } else {
            noMatchesRow.remove();
        }
    }

    searchInput?.addEventListener("input", filterInventory);
    categoryFilter?.addEventListener("change", filterInventory);
    statusFilter?.addEventListener("change", filterInventory);

    filterInventory();

    document.addEventListener("click", event => {
        const clickedButton = event.target.closest(".row-action");

        document.querySelectorAll(".row-action-wrap.menu-open").forEach(wrap => {
            if (!clickedButton || !wrap.contains(clickedButton)) {
                wrap.classList.remove("menu-open");
                wrap.querySelector(".row-action")
                    ?.setAttribute("aria-expanded", "false");
            }
        });

        if (clickedButton) {
            const wrap = clickedButton.closest(".row-action-wrap");
            const shouldOpen = !wrap.classList.contains("menu-open");

            wrap.classList.toggle("menu-open", shouldOpen);
            clickedButton.setAttribute("aria-expanded", String(shouldOpen));
        }
    });

    document.addEventListener("keydown", event => {
        if (event.key === "Escape") {
            document.querySelectorAll(".row-action-wrap.menu-open").forEach(wrap => {
                wrap.classList.remove("menu-open");
                wrap.querySelector(".row-action")
                    ?.setAttribute("aria-expanded", "false");
            });
        }
    });

    const addItemPanel = document.getElementById("addItemPanel");
    const openAddForm = document.getElementById("openAddForm");
    const closeAddForm = document.getElementById("closeAddForm");
    const inventoryForm = document.getElementById("inventoryForm");
    const formTitle = document.getElementById("formTitle");
    const formDescription = document.getElementById("formDescription");
    const submitForm = document.getElementById("submitForm");

    const productNameInput = document.getElementById("productName");
    const categoryInput = document.getElementById("category");
    const quantityInput = document.getElementById("quantity");
    const unitInput = document.getElementById("unit");
    const expiryInput = document.getElementById("expiryDate");

    const createUrl = "${pageContext.request.contextPath}/inventory/create";
    const updateUrl = "${pageContext.request.contextPath}/inventory/update/";

    function showInventoryForm() {
        addItemPanel?.classList.add("visible");
        addItemPanel?.scrollIntoView({
            behavior: "smooth",
            block: "start"
        });
    }

    function setCreateMode() {
        inventoryForm?.reset();

        if (inventoryForm) inventoryForm.action = createUrl;
        if (formTitle) formTitle.textContent = "Add inventory item";
        if (formDescription) {
            formDescription.textContent = "Enter the details of a new food product.";
        }
        if (submitForm) submitForm.textContent = "Save inventory item";
    }

    openAddForm?.addEventListener("click", () => {
        setCreateMode();
        showInventoryForm();
    });

    document.addEventListener("click", event => {
        const updateButton = event.target.closest(".update-action");
        if (!updateButton) return;

        const itemId = updateButton.dataset.id;
        if (!itemId || !inventoryForm) return;

        inventoryForm.action = updateUrl + encodeURIComponent(itemId);

        productNameInput.value = updateButton.dataset.name || "";
        categoryInput.value = updateButton.dataset.category || "";
        quantityInput.value = updateButton.dataset.quantity || "";
        unitInput.value = updateButton.dataset.unit || "";
        expiryInput.value = updateButton.dataset.expiry || "";

        if (formTitle) formTitle.textContent = "Update inventory item";
        if (formDescription) {
            formDescription.textContent = "Update the details of this food product.";
        }
        if (submitForm) submitForm.textContent = "Update item";

        updateButton.closest(".row-action-wrap")?.classList.remove("menu-open");

        updateButton.closest(".row-action-wrap")
            ?.querySelector(".row-action")
            ?.setAttribute("aria-expanded", "false");

        showInventoryForm();
    });

    closeAddForm?.addEventListener("click", () => {
        addItemPanel?.classList.remove("visible");
    });

    const uploadButton = document.getElementById("uploadButton");
    const importPanel = document.getElementById("importPanel");
    const csvFile = document.getElementById("csvFile");
    const fileName = document.getElementById("fileName");

    uploadButton?.addEventListener("click", () => {
        importPanel?.scrollIntoView({
            behavior: "smooth",
            block: "start"
        });
    });

    csvFile?.addEventListener("change", function () {
        if (fileName) {
            fileName.textContent = this.files?.length
                ? this.files[0].name
                : "CSV files only";
        }
    });
});
</script>
</body>
</html>
