<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<title>Edit Product - ShopKart</title>
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<jsp:include page="navbar.jsp" />

<div class="page-wrap">
    <h2 class="page-title">Edit Product</h2>

    <div class="panel" style="max-width:500px;">
        <form action="updateProduct" method="post">
            <input type="hidden" name="id" value="<%= request.getAttribute("id") %>">

            <label>Name</label>
            <input type="text" name="name" class="form-control-custom" value="<%= request.getAttribute("name") %>" required>

            <label>Brand</label>
            <input type="text" name="brand" class="form-control-custom" value="<%= request.getAttribute("brand") %>">

            <label>Description</label>
            <input type="text" name="description" class="form-control-custom" value="<%= request.getAttribute("description") %>">

            <label>Price</label>
            <input type="number" step="0.01" name="price" class="form-control-custom" value="<%= request.getAttribute("price") %>" required>

            <label>Quantity</label>
            <input type="number" name="quantity" class="form-control-custom" value="<%= request.getAttribute("quantity") %>" required>

            <label>Image filename</label>
            <input type="text" name="image" class="form-control-custom" value="<%= request.getAttribute("image") %>">

            <label>Category ID</label>
            <input type="number" name="categoryId" class="form-control-custom" value="<%= request.getAttribute("categoryId") %>">

            <button type="submit" class="btn-amber">Save Changes</button>
        </form>
    </div>
</div>

</body>
</html>