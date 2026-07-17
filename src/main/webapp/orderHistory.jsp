<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
<title>My Orders - ShopKart</title>
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<jsp:include page="navbar.jsp" />

<div class="page-wrap">
    <h2 class="page-title">My Orders</h2>
    <%
        List<Map<String, Object>> orders = (List<Map<String, Object>>) request.getAttribute("orders");
        for (Map<String, Object> order : orders) {
            List<Map<String, Object>> items = (List<Map<String, Object>>) order.get("items");
            String status = (String) order.get("status");
            String badgeClass = "badge-" + status.replace(" ", "-");
    %>
    <div class="panel">
        <div style="display:flex; justify-content:space-between; flex-wrap:wrap; margin-bottom:0.8rem;">
            <div>
                <p style="margin:0; font-weight:700;">Order #<%= order.get("orderId") %></p>
                <p style="margin:0; color:var(--muted); font-size:0.85rem;"><%= order.get("orderDate") %></p>
            </div>
            <span class="badge-status <%= badgeClass %>"><%= status %></span>
        </div>

        <p style="font-size:0.9rem;"><b>Expected Delivery:</b> <%= order.get("expectedDelivery") %></p>

        <table class="table-custom">
            <tr><th>Product</th><th>Quantity</th><th>Price</th></tr>
            <%
                for (Map<String, Object> item : items) {
            %>
            <tr>
                <td><%= item.get("name") %></td>
                <td><%= item.get("quantity") %></td>
                <td>₹<%= item.get("price") %></td>
            </tr>
            <%
                }
            %>
        </table>

        <h3 style="text-align:right; margin-top:1rem;">Total: ₹<%= order.get("totalAmount") %></h3>
        <% if ("Placed".equals(status)) { %>
    <form action="cancelOrder" method="post" style="text-align:right; margin-top:0.5rem;">
        <input type="hidden" name="orderId" value="<%= order.get("orderId") %>">
        <button type="submit" class="btn-outline-danger-custom">Cancel Order</button>
    </form>
<% } %>
    </div>
    <%
        }
    %>
</div>

</body>
</html>