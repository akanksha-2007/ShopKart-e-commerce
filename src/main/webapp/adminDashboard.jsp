<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<title>Admin Dashboard - ShopKart</title>
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<jsp:include page="navbar.jsp" />

<div class="page-wrap">
    <h2 class="page-title">Admin Dashboard</h2>

    <div style="display:grid; grid-template-columns:repeat(auto-fit, minmax(200px,1fr)); gap:1.2rem;">
        <div class="panel" style="text-align:center;">
            <p style="color:var(--muted); margin:0 0 0.4rem; font-size:0.85rem;">Total Users</p>
            <h2 style="margin:0; color:var(--ink);"><%= request.getAttribute("totalUsers") %></h2>
        </div>
        <div class="panel" style="text-align:center;">
            <p style="color:var(--muted); margin:0 0 0.4rem; font-size:0.85rem;">Total Products</p>
            <h2 style="margin:0; color:var(--ink);"><%= request.getAttribute("totalProducts") %></h2>
        </div>
        <div class="panel" style="text-align:center;">
            <p style="color:var(--muted); margin:0 0 0.4rem; font-size:0.85rem;">Total Orders</p>
            <h2 style="margin:0; color:var(--ink);"><%= request.getAttribute("totalOrders") %></h2>
        </div>
        <div class="panel" style="text-align:center;">
            <p style="color:var(--muted); margin:0 0 0.4rem; font-size:0.85rem;">Total Sales</p>
            <h2 style="margin:0; color:var(--amber-dark);">₹<%= request.getAttribute("totalSales") %></h2>
        </div>
    </div>

    <div style="margin-top:1.5rem; display:flex; gap:1rem; flex-wrap:wrap;">
        <a href="adminProducts" class="btn-amber" style="text-decoration:none;">Manage Products</a>
        <a href="adminOrders" class="btn-amber" style="text-decoration:none;">Manage Orders</a>
    </div>
</div>

</body>
</html>