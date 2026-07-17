<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
<title>Products - ShopKart</title>
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<jsp:include page="navbar.jsp" />

<div class="page-wrap">
    <h2 class="page-title">Our Products</h2>
<form action="products" method="get" style="margin-bottom:1rem; display:flex; gap:0.5rem; max-width:400px;">
    <input type="text" name="search" placeholder="Search products..." class="form-control-custom" style="margin-bottom:0;">
    <button type="submit" class="btn-amber">Search</button>
</form>

<div style="margin-bottom:1rem;">
    <a href="products?sort=low" class="btn-amber" style="text-decoration:none; padding:0.4rem 1rem; font-size:0.8rem;">Price: Low to High</a>
    <a href="products?sort=high" class="btn-amber" style="text-decoration:none; padding:0.4rem 1rem; font-size:0.8rem;">Price: High to Low</a>
</div>

    <div style="margin-bottom:1.5rem; display:flex; gap:0.6rem; flex-wrap:wrap;">
        <a href="products" class="btn-amber" style="text-decoration:none; padding:0.5rem 1.2rem; font-size:0.85rem;">All</a>
        <a href="products?category=1" class="btn-amber" style="text-decoration:none; padding:0.5rem 1.2rem; font-size:0.85rem;">Electronics</a>
        <a href="products?category=2" class="btn-amber" style="text-decoration:none; padding:0.5rem 1.2rem; font-size:0.85rem;">Fashion</a>
        <a href="products?category=3" class="btn-amber" style="text-decoration:none; padding:0.5rem 1.2rem; font-size:0.85rem;">Home & Kitchen</a>
        <a href="products?category=4" class="btn-amber" style="text-decoration:none; padding:0.5rem 1.2rem; font-size:0.85rem;">Stationery</a>
    </div>

    <%
        List<Map<String, Object>> products = (List<Map<String, Object>>) request.getAttribute("products");
    %>

    <div class="product-grid">
        <%
            for (Map<String, Object> product : products) {
                int stock = (Integer) product.get("quantity");
        %>
        <div class="product-card">
            <a href="productDetail?id=<%= product.get("id") %>">
    <img src="<%= product.get("image") %>" alt="<%= product.get("name") %>" style="width:100%; height:150px; object-fit:cover; cursor:pointer;">
</a>
            <div class="product-body">
                <div class="product-cat"><%= product.get("category") %></div>
               <a href="productDetail?id=<%= product.get("id") %>" style="text-decoration:none; color:inherit;">
    <div class="product-title"><%= product.get("name") %> <span style="color:var(--muted); font-weight:400;">— <%= product.get("brand") %></span></div>
</a>
                <div class="product-price">₹<%= product.get("price") %></div>
                <div style="color:var(--muted); font-size:0.8rem; margin:0.3rem 0 0.8rem;">Stock: <%= stock %></div>

                <% if (stock > 0) { %>
                    <form action="addToCart" method="post" style="display:flex; gap:0.5rem;">
                        <input type="hidden" name="productId" value="<%= product.get("id") %>">
                        <input type="number" name="quantity" value="1" min="1" max="<%= stock %>" class="form-control-custom" style="margin-bottom:0; width:70px;">
                        <button type="submit" class="btn-amber" style="flex:1;">Add to Cart</button>
                    </form>
                    <a href="payment.jsp?productId=<%= product.get("id") %>&quantity=1" class="btn-outline-danger-custom" style="display:block; text-align:center; text-decoration:none; margin-top:0.5rem;">Buy Now</a>
                    <form action="addToWishlist" method="post" style="margin-top:0.5rem;">
    <input type="hidden" name="productId" value="<%= product.get("id") %>">
    <button type="submit" style="width:100%; background:none; border:1px solid var(--border); color:var(--ink); padding:0.5rem; border-radius:8px; cursor:pointer;">♡ Add to Wishlist</button>
</form>
                <% } else { %>
                    <button class="btn-amber" disabled style="width:100%; opacity:0.5; cursor:not-allowed;">Out of Stock</button>
                <% } %>
            </div>
        </div>
        <%
            }
        %>
    </div>
</div>

</body>
</html>