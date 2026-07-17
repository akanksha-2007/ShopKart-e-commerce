<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
<title>Admin - Manage Orders</title>
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<jsp:include page="navbar.jsp" />

<div class="page-wrap">
    <h2 class="page-title">All Orders (Admin)</h2>
    <%
        List<Map<String, Object>> orders = (List<Map<String, Object>>) request.getAttribute("orders");
    %>
    <div class="panel">
        <table class="table-custom">
            <tr>
                <th>Order ID</th><th>User</th><th>Total</th><th>Date</th><th>Status</th><th>Update</th>
            </tr>
            <%
                for (Map<String, Object> order : orders) {
            %>
            <tr>
                <td><%= order.get("orderId") %></td>
                <td><%= order.get("username") %></td>
                <td>₹<%= order.get("totalAmount") %></td>
                <td><%= order.get("orderDate") %></td>
                <td><%= order.get("status") %></td>
                <td>
                    <form action="updateOrderStatus" method="post" style="display:flex; gap:0.4rem;">
                        <input type="hidden" name="orderId" value="<%= order.get("orderId") %>">
                        <select name="newStatus" class="form-control-custom" style="margin-bottom:0; padding:0.4rem;">
                            <option value="Placed">Placed</option>
                            <option value="Shipped">Shipped</option>
                            <option value="Delivered">Delivered</option>
                            <option value="Return Requested">Return Requested</option>
                            <option value="Refunded">Refunded</option>
                        </select>
                        <button type="submit" class="btn-amber">Update</button>
                    </form>
                </td>
            </tr>
            <%
                }
            %>
        </table>
    </div>
</div>

</body>
</html>