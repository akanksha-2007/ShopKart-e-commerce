<%
    String username = (session != null) ? (String) session.getAttribute("username") : null;
    String role = (session != null) ? (String) session.getAttribute("role") : null;
%>
<div class="navbar-custom">
   <a href="products" class="brand" style="display:flex; align-items:center; gap:0.5rem;">
    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4Z"></path>
        <path d="M3 6h18"></path>
        <path d="M16 10a4 4 0 0 1-8 0"></path>
    </svg>
    ShopKart
</a>

    <div class="navbar-links">
        <a href="products">Products</a>

        <% if (username != null) { %>
            <a href="cart">Cart</a>
            <a href="wishlist">Wishlist</a>
            <a href="orderHistory">My Orders</a>
            <a href="dashboard.jsp">Dashboard</a>

            <% if ("admin".equals(role)) { %>
                <a href="adminDashboard">Admin Dashboard</a>
                <a href="adminProducts">Manage Products</a>
                <a href="adminOrders">Manage Orders</a>
            <% } %>

            <a href="logout" class="logout-pill">Logout (<%= username %>)</a>
        <% } else { %>
            <a href="login.jsp">Login</a>
            <a href="signup.jsp">Signup</a>
        <% } %>
        <button class="theme-toggle" onclick="toggleTheme()">🌙 Dark Mode</button>
    </div>
</div>
<script>
    // Page load hote hi check karo pehle se dark mode set tha kya
    if (localStorage.getItem('theme') === 'dark') {
        document.body.classList.add('dark-mode');
    }

    function toggleTheme() {
        document.body.classList.toggle('dark-mode');
        if (document.body.classList.contains('dark-mode')) {
            localStorage.setItem('theme', 'dark');
        } else {
            localStorage.setItem('theme', 'light');
        }
    }
</script>