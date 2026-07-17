<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<title>Dashboard - ShopKart</title>
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<jsp:include page="navbar.jsp" />

<div class="page-wrap">
    <h2 class="page-title">My Account</h2>

    <div class="panel" style="max-width:420px;">
        <p style="color:var(--muted); font-size:0.85rem; margin-bottom:0.2rem;">Username</p>
        <h3 style="margin-top:0;"><%= username %></h3>

        <p style="color:var(--muted); font-size:0.85rem; margin-bottom:0.2rem;">Role</p>
        <p style="font-weight:600;"><%= session.getAttribute("role") %></p>

        <a href="logout" class="btn-amber" style="display:inline-block; text-decoration:none; margin-top:0.5rem;">Logout</a>
    </div>
</div>

</body>
</html>