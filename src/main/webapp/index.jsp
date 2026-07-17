<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<title>ShopKart</title>
<link href="https://fonts.googleapis.com/css2?family=Sora:wght@600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
<style>
  .hero{
    background:linear-gradient(135deg, var(--deep) 0%, var(--deep-2) 100%);
    color:#fff;
    padding:4rem 1.5rem 5rem;
    position:relative;
    overflow:hidden;
  }
  .hero::after{
    content:"";
    position:absolute;
    right:-80px; top:-80px;
    width:280px; height:280px;
    background:var(--amber);
    opacity:0.15;
    border-radius:50%;
  }
  .hero-inner{ max-width:1100px; margin:0 auto; position:relative; }
  .hero h1{
    font-size:2.6rem;
    font-weight:800;
    line-height:1.15;
    max-width:600px;
  }
  .hero p{ color:rgba(255,255,255,0.7); font-size:1.05rem; max-width:500px; }
</style>
</head>
<body>
<jsp:include page="navbar.jsp" />

<section class="hero">
  <div class="hero-inner">
    <div style="color:var(--amber); font-weight:700; font-size:0.8rem; letter-spacing:1.5px; text-transform:uppercase; margin-bottom:0.8rem;">New arrivals</div>
    <h1>Everyday essentials, styled a little better.</h1>
    <p style="margin:1rem 0 2rem;">Curated products, fair prices, and checkout that doesn't make you think twice.</p>
    <a href="products" class="btn-amber" style="text-decoration:none; display:inline-block; font-size:1rem;">Start shopping &rarr;</a>
  </div>
</section>

<div class="page-wrap">
    <h2 class="page-title">Shop by Category</h2>
    <div style="display:grid; grid-template-columns:repeat(auto-fill, minmax(200px,1fr)); gap:1.25rem;">
        <a href="products?category=1" style="text-decoration:none;">
            <div class="panel" style="text-align:center; margin-bottom:0;">
<h3 style="margin:0; color:var(--ink);">Electronics</h3>            </div>
        </a>
        <a href="products?category=2" style="text-decoration:none;">
            <div class="panel" style="text-align:center; margin-bottom:0;">
                <h3 style="margin:0; color:var(--ink);">Fashion</h3>
            </div>
        </a>
        <a href="products?category=3" style="text-decoration:none;">
            <div class="panel" style="text-align:center; margin-bottom:0;">
                <h3 style="margin:0; color:var(--ink);">Home & Kitchen</h3>
            </div>
        </a>
        <a href="products?category=4" style="text-decoration:none;">
            <div class="panel" style="text-align:center; margin-bottom:0;">
                <h3 style="margin:0; color:var(--ink);">Stationery</h3>
            </div>
        </a>
    </div>
</div>

</body>
</html>