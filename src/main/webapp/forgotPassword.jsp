<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<title>Forgot Password - ShopKart</title>
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<jsp:include page="navbar.jsp" />

<div class="auth-wrap">
    <div class="auth-card">
        <h2>Reset Password</h2>
        <p style="color:var(--muted); margin-top:-0.5rem; margin-bottom:1.5rem; font-size:0.9rem;">
            Enter your email and choose a new password.
        </p>

        <form action="resetPassword" method="post">
            <label>Registered Email</label>
            <input type="email" name="email" class="form-control-custom" required>

            <label>New Password</label>
            <input type="password" name="newPassword" class="form-control-custom" minlength="6" required>

            <label>Confirm New Password</label>
            <input type="password" name="confirmPassword" class="form-control-custom" minlength="6" required>

            <button type="submit" class="btn-amber" style="width:100%; margin-top:0.5rem;">Reset Password</button>
        </form>

        <p style="text-align:center; margin-top:1.5rem; font-size:0.9rem; color:var(--muted);">
            Remembered it? <a href="login.jsp" style="color:var(--deep); font-weight:600;">Back to Login</a>
        </p>
    </div>
</div>

</body>
</html>