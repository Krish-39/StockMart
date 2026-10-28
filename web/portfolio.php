<?php
declare(strict_types=1);

require __DIR__ . '/includes/auth.php';

stockmart_start_session();

if (empty($_SESSION['user_id'])) {
    header('Location: login.php');
    exit;
}
?>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Portfolio | StockMart</title>

<link rel="icon" href="assets/logo.png">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet" href="css/style.css">

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</head>

<body>

<nav class="navbar navbar-expand-lg navbar-dark">

<div class="container">

<a class="navbar-brand d-flex align-items-center" href="index.html">

    <img src="assets/logo.png" class="navbar-logo">

    <div class="ms-3">

        <h5 class="mb-0 fw-bold">

            StockMart

        </h5>

        <small>

            Your Market, Your Edge

        </small>

    </div>

</a>

<button class="navbar-toggler"
data-bs-toggle="collapse"
data-bs-target="#navbar">

<span class="navbar-toggler-icon"></span>

</button>

<div class="collapse navbar-collapse" id="navbar">

<ul class="navbar-nav ms-auto">

<li class="nav-item">
<a class="nav-link" href="index.html">Home</a>
</li>

<li class="nav-item">
<a class="nav-link" href="markets.html">Markets</a>
</li>

<li class="nav-item">
<a class="nav-link active" href="portfolio.php">Portfolio</a>
</li>

<li class="nav-item">
<a class="nav-link" href="pro.html">Pro</a>
</li>

<li class="nav-item">
<a class="nav-link" href="logout.php">Logout</a>
</li>

</ul>

</div>

</div>

</nav>

<div class="container py-5">

<h1 class="mb-5">

My Portfolio

</h1>

<div class="portfolio-card mb-5">

<h6>

Total Portfolio Value

</h6>

<h1 id="portfolioValue">

Loading...

</h1>

<span
id="todayGain"
class="badge bg-success">

Loading...

</span>

</div>

<h3 class="section-title">

Your Holdings

</h3>

<div
class="row g-4"
id="holdings">

</div>

<div class="stock-card mt-5">

<h3 class="mb-4">

Portfolio Allocation

</h3>

<canvas id="portfolioChart"></canvas>

</div>

</div>

<footer>

© 2026 StockMart

</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script src="js/config.example.js"></script>
<script src="js/config.local.js"></script>
<script src="js/api.js"></script>

<script src="js/portfolio.js"></script>

</body>

</html>