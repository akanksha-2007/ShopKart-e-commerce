<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<title>Order Confirmed - ShopKart</title>
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
<style>
  .confirm-wrap{
    min-height:80vh;
    display:flex;
    align-items:center;
    justify-content:center;
    padding:2rem 1rem;
  }
  .confirm-card{
    background:var(--card);
    border:1px solid var(--border);
    border-radius:20px;
    padding:3rem 2.5rem;
    max-width:480px;
    width:100%;
    text-align:center;
    box-shadow:0 20px 50px rgba(18,49,63,0.1);
  }

  .checkmark-circle{
    width:100px;
    height:100px;
    margin:0 auto 1.5rem;
  }
  .checkmark-circle svg{ width:100%; height:100%; }
  .check-bg{
    fill:none;
    stroke:#1E7A34;
    stroke-width:3;
    stroke-dasharray:157;
    stroke-dashoffset:157;
    animation:circleDraw 0.6s ease forwards;
  }
  .check-mark{
    fill:none;
    stroke:#1E7A34;
    stroke-width:4;
    stroke-linecap:round;
    stroke-linejoin:round;
    stroke-dasharray:36;
    stroke-dashoffset:36;
    animation:checkDraw 0.4s ease 0.6s forwards;
  }
  @keyframes circleDraw{
    to{ stroke-dashoffset:0; }
  }
  @keyframes checkDraw{
    to{ stroke-dashoffset:0; }
  }

  .confirm-title{
    font-size:2rem;
    font-weight:800;
    margin:0 0 0.3rem;
    opacity:0;
    animation:fadeUp 0.5s ease 0.9s forwards;
  }
  .confirm-sub{
    color:var(--muted);
    font-size:1rem;
    margin-bottom:1.8rem;
    opacity:0;
    animation:fadeUp 0.5s ease 1.05s forwards;
  }
  .confirm-details{
    background:var(--paper);
    border-radius:12px;
    padding:1.2rem;
    text-align:left;
    margin-bottom:1.8rem;
    opacity:0;
    animation:fadeUp 0.5s ease 1.2s forwards;
  }
  .confirm-details p{
    margin:0.4rem 0;
    font-size:0.92rem;
    display:flex;
    justify-content:space-between;
  }
  .confirm-details p b{ color:var(--ink); }
  .confirm-actions{
    opacity:0;
    animation:fadeUp 0.5s ease 1.35s forwards;
    display:flex;
    gap:0.8rem;
    justify-content:center;
    flex-wrap:wrap;
  }
  @keyframes fadeUp{
    from{ opacity:0; transform:translateY(10px); }
    to{ opacity:1; transform:translateY(0); }
  }
</style>
</head>
<body>
<jsp:include page="navbar.jsp" />

<div class="confirm-wrap">
    <div class="confirm-card">
        <div class="checkmark-circle">
            <svg viewBox="0 0 52 52">
                <circle class="check-bg" cx="26" cy="26" r="25"/>
                <path class="check-mark" d="M14 27l7 7 17-17"/>
            </svg>
        </div>

        <h1 class="confirm-title">Hurray! 🎉</h1>
        <p class="confirm-sub">Your order has been placed successfully.</p>

        <div class="confirm-details">
            <p><span>Order ID</span> <b>#<%= request.getAttribute("orderId") %></b></p>
            <p><span>Total Amount</span> <b>₹<%= request.getAttribute("totalAmount") %></b></p>
            <p><span>Expected Delivery</span> <b><%= request.getAttribute("deliveryDate") %></b></p>
        </div>

        <div class="confirm-actions">
            <a href="orderHistory" class="btn-amber" style="text-decoration:none;">View My Orders</a>
            <a href="products" class="btn-outline-danger-custom" style="text-decoration:none; border-color:var(--amber-dark); color:var(--amber-dark);">Continue Shopping</a>
        </div>
    </div>
</div>

</body>
</html>

