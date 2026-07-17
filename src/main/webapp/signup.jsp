<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<title>Sign Up - ShopKart</title>
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<jsp:include page="navbar.jsp" />

<div class="auth-wrap">
    <div class="auth-card">
        <h2>Create account</h2>
        <p style="color:var(--muted); margin-top:-0.5rem; margin-bottom:1.5rem; font-size:0.9rem;">
            Join ShopKart to start shopping.
        </p>

        <form action="signup" method="post">
            <label>Username</label>
            <input type="text" name="username" class="form-control-custom" required>

            <label>Email</label>
            <input type="email" name="email" class="form-control-custom" required>

            <label>Password</label>
            <input type="password" name="password" class="form-control-custom" required>

            <button type="submit" class="btn-amber" style="width:100%; margin-top:0.5rem;">Sign Up</button>
        </form>

        <p style="text-align:center; margin-top:1.5rem; font-size:0.9rem; color:var(--muted);">
            Already have an account? <a href="login.jsp" style="color:var(--deep); font-weight:600;">Login</a>
        </p>
    </div>
</div>

</body>
</html>