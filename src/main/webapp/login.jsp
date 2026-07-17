<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<title>Login - ShopKart</title>
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<jsp:include page="navbar.jsp" />

<div class="auth-wrap">
    <div class="auth-card">
        <h2>Welcome back</h2>
        <p style="color:var(--muted); margin-top:-0.5rem; margin-bottom:1.5rem; font-size:0.9rem;">
            Log in to continue shopping on ShopKart.
        </p>

        <form action="login" method="post">
            <label>Username or Email</label>
            <input type="text" name="usernameOrEmail" class="form-control-custom" required>

            <label>Password</label>
            <input type="password" name="password" class="form-control-custom" required>

            <button type="submit" class="btn-amber" style="width:100%; margin-top:0.5rem;">Login</button>
        </form>

        <p style="text-align:center; margin-top:1.5rem; font-size:0.9rem; color:var(--muted);">
            New here? <a href="signup.jsp" style="color:var(--deep); font-weight:600;">Create an account</a>
        </p>
        <p style="text-align:center; margin-top:0.5rem; font-size:0.85rem;">
    <a href="forgotPassword.jsp" style="color:var(--muted);">Forgot Password?</a>
</p>
    </div>
</div>

</body>
</html>