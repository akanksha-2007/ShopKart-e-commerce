<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
<title>My Cart - ShopKart</title>
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<jsp:include page="navbar.jsp" />

<div class="page-wrap">
    <h2 class="page-title">My Cart</h2>
    <%
        List<Map<String, Object>> cartItems = (List<Map<String, Object>>) request.getAttribute("cartItems");
        Double totalBill = (Double) request.getAttribute("totalBill");
    %>

    <div class="panel">
        <table class="table-custom">
            <tr>
                <th>Product</th><th>Price</th><th>Quantity</th><th>Subtotal</th><th>Action</th>
            </tr>
            <%
                for (Map<String, Object> item : cartItems) {
            %>
            <tr>
    <td><%= item.get("name") %></td>
    <td>₹<%= item.get("price") %></td>
    <td>
        <form action="updateCart" method="post" style="display:flex; gap:0.4rem; align-items:center;">
            <input type="hidden" name="cartId" value="<%= item.get("cartId") %>">
            <input type="number" name="quantity" value="<%= item.get("quantity") %>" min="1" class="form-control-custom" style="margin-bottom:0; width:60px;">
            <button type="submit" class="btn-amber" style="padding:0.3rem 0.7rem; font-size:0.8rem;">Update</button>
        </form>
    </td>
    <td>₹<%= item.get("subtotal") %></td>
    <td>
        <form action="removeFromCart" method="post" style="display:inline;">
            <input type="hidden" name="cartId" value="<%= item.get("cartId") %>">
            <button type="submit" class="btn-outline-danger-custom">Remove</button>
        </form>
    </td>
            </tr>
            <%
                }
            %>
        </table>
    </div>

    <div class="panel" style="display:flex; justify-content:space-between; align-items:center;">
        <h3 style="margin:0;">Total Bill: ₹<%= totalBill %></h3>
<a href="payment.jsp" class="btn-amber" style="text-decoration:none; display:inline-block;">Proceed to Checkout</a>
    </div>
</div>

</body>
</html>