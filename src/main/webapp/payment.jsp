<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String productId = request.getParameter("productId");
    String quantity = request.getParameter("quantity");
    boolean isBuyNow = (productId != null && !productId.isEmpty());
%>
<!DOCTYPE html>
<html>
<head>
<title>Payment - ShopKart</title>
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<jsp:include page="navbar.jsp" />

<div class="auth-wrap">
    <div class="auth-card" style="max-width:440px;">
        <h2>Payment Details</h2>
        <p style="color:var(--muted); margin-top:-0.5rem; margin-bottom:1.5rem; font-size:0.85rem;">
            This is a demo checkout. No real payment is processed.
        </p>

        <form action="<%= isBuyNow ? "buyNow" : "checkout" %>" method="post">
            <% if (isBuyNow) { %>
                <input type="hidden" name="productId" value="<%= productId %>">
                <input type="hidden" name="quantity" value="<%= quantity %>">
            <% } %>

            <label>Name on Card</label>
            <input type="text" class="form-control-custom" pattern="[A-Za-z ]{3,40}" title="Only letters and spaces" placeholder="e.g. Khwaish Sharma" required>

            <label>Card Number</label>
            <input type="text" class="form-control-custom" maxlength="16" pattern="[0-9]{16}" title="Enter exactly 16 digits" placeholder="1234567890123456" required>

            <div style="display:flex; gap:1rem;">
                <div style="flex:1;">
                    <label>Expiry</label>
                    <input type="text" class="form-control-custom" pattern="(0[1-9]|1[0-2])\/[0-9]{2}" title="Format: MM/YY (e.g. 08/27)" placeholder="MM/YY" required>
                </div>
                <div style="flex:1;">
                    <label>CVV</label>
                    <input type="text" class="form-control-custom" maxlength="3" pattern="[0-9]{3}" title="Enter exactly 3 digits" placeholder="123" required>
                </div>
            </div>

            <button type="submit" class="btn-amber" style="width:100%; margin-top:0.5rem;">Pay & Place Order</button>
        </form>
    </div>
</div>

</body>
</html>