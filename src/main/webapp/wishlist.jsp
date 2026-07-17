<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
<title>My Wishlist - ShopKart</title>
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<jsp:include page="navbar.jsp" />

<div class="page-wrap">
    <h2 class="page-title">My Wishlist</h2>

    <%
        List<Map<String, Object>> wishlistItems = (List<Map<String, Object>>) request.getAttribute("wishlistItems");
    %>

    <% if (wishlistItems.isEmpty()) { %>
        <p style="color:var(--muted);">Your wishlist is empty. <a href="products" style="color:var(--deep); font-weight:600;">Browse products</a></p>
    <% } else { %>
    <div class="product-grid">
        <%
            for (Map<String, Object> item : wishlistItems) {
        %>
        <div class="product-card">
            <img src="<%= item.get("image") %>" alt="<%= item.get("name") %>" style="width:100%; height:150px; object-fit:cover;">
            <div class="product-body">
                <div class="product-title"><%= item.get("name") %></div>
                <div class="product-price">₹<%= item.get("price") %></div>

                <form action="addToCart" method="post" style="margin-top:0.6rem;">
                    <input type="hidden" name="productId" value="<%= item.get("productId") %>">
                    <input type="hidden" name="quantity" value="1">
                    <button type="submit" class="btn-amber" style="width:100%;">Move to Cart</button>
                </form>
                <form action="removeFromWishlist" method="post" style="margin-top:0.5rem;">
                    <input type="hidden" name="wishlistId" value="<%= item.get("wishlistId") %>">
                    <button type="submit" class="btn-outline-danger-custom" style="width:100%;">Remove</button>
                </form>
            </div>
        </div>
        <%
            }
        %>
    </div>
    <% } %>
</div>

</body>
</html>