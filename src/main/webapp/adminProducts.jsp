<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
<title>Admin - Manage Products</title>
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<jsp:include page="navbar.jsp" />

<div class="page-wrap">
    <h2 class="page-title">Manage Products</h2>

    <div class="panel">
        <h3 style="margin-top:0;">Add New Product</h3>
        <form action="addProduct" method="post">
            <label>Name</label>
            <input type="text" name="name" class="form-control-custom" required>

            <label>Brand</label>
            <input type="text" name="brand" class="form-control-custom">

            <label>Description</label>
            <input type="text" name="description" class="form-control-custom">

            <label>Price</label>
            <input type="number" step="0.01" name="price" class="form-control-custom" required>

            <label>Quantity</label>
            <input type="number" name="quantity" class="form-control-custom" required>

            <label>Image filename</label>
            <input type="text" name="image" class="form-control-custom" placeholder="e.g. product1.jpg">

            <label>Category</label>
            <select name="categoryId" class="form-control-custom">
                <option value="1">Electronics</option>
                <option value="2">Fashion</option>
                <option value="3">Home & Kitchen</option>
                <option value="4">Stationery</option>
            </select>

            <button type="submit" class="btn-amber">Add Product</button>
        </form>
    </div>

    <div class="panel">
        <h3 style="margin-top:0;">Existing Products</h3>
        <%
            List<Map<String, Object>> products = (List<Map<String, Object>>) request.getAttribute("products");
        %>
        <table class="table-custom">
            <tr><th>Name</th><th>Brand</th><th>Price</th><th>Stock</th><th>Action</th></tr>
            <%
                for (Map<String, Object> product : products) {
            %>
            <tr>
                <td><%= product.get("name") %></td>
                <td><%= product.get("brand") %></td>
                <td>₹<%= product.get("price") %></td>
                <td><%= product.get("quantity") %></td>
                <td style="display:flex; gap:0.5rem;">
                    <a href="editProduct?id=<%= product.get("id") %>" class="btn-amber" style="text-decoration:none; padding:0.4rem 0.9rem; font-size:0.85rem;">Edit</a>
                    <form action="deleteProduct" method="post" style="display:inline;">
                        <input type="hidden" name="productId" value="<%= product.get("id") %>">
                        <button type="submit" class="btn-outline-danger-custom">Delete</button>
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