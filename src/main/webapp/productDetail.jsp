<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<title>Product Detail - ShopKart</title>
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<jsp:include page="navbar.jsp" />

<%
    int stock = (Integer) request.getAttribute("quantity");
%>

<div class="page-wrap">
    <div class="panel" style="display:grid; grid-template-columns:1fr 1fr; gap:2rem;">
        <img src="<%= request.getAttribute("image") %>" style="width:100%; border-radius:12px; object-fit:cover; max-height:400px;">

        <div>
            <div class="product-cat"><%= request.getAttribute("category") %></div>
            <h2 style="margin:0.3rem 0;"><%= request.getAttribute("name") %></h2>
            <p style="color:var(--muted);">Brand: <%= request.getAttribute("brand") %></p>
            <div class="product-price" style="font-size:1.5rem; margin:0.8rem 0;">₹<%= request.getAttribute("price") %></div>
            <p style="color:var(--ink);"><%= request.getAttribute("description") %></p>
            <p style="color:var(--muted); font-size:0.9rem;">Stock: <%= stock %></p>

            <% if (stock > 0) { %>
                <form action="addToCart" method="post" style="display:flex; gap:0.5rem; margin-top:1rem;">
                    <input type="hidden" name="productId" value="<%= request.getAttribute("id") %>">
                    <input type="number" name="quantity" value="1" min="1" max="<%= stock %>" class="form-control-custom" style="margin-bottom:0; width:80px;">
                    <button type="submit" class="btn-amber" style="flex:1;">Add to Cart</button>
                </form>
                <a href="payment.jsp?productId=<%= request.getAttribute("id") %>&quantity=1" class="btn-outline-danger-custom" style="display:block; text-align:center; text-decoration:none; margin-top:0.6rem;">Buy Now</a>
                <form action="addToWishlist" method="post" style="margin-top:0.6rem;">
                    <input type="hidden" name="productId" value="<%= request.getAttribute("id") %>">
                    <button type="submit" style="width:100%; background:none; border:1px solid var(--border); color:var(--ink); padding:0.5rem; border-radius:8px; cursor:pointer;">♡ Add to Wishlist</button>
                </form>
            <% } else { %>
                <button class="btn-amber" disabled style="width:100%; opacity:0.5; margin-top:1rem;">Out of Stock</button>
            <% } %>
        </div>
    </div>
</div>

</body>
</html>