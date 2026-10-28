<?php
declare(strict_types=1);

require __DIR__ . '/includes/auth.php';

stockmart_start_session();

$message = '';
$messageType = 'info';

if (isset($_GET['registered'])) {
    $message = 'Registration successful. Please log in.';
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = post_string('email');
    $password = is_string($_POST['password'] ?? null) ? $_POST['password'] : '';

    if (!csrf_valid($_POST['csrf'] ?? null)) {
        $message = 'Your session expired. Please try again.';
        $messageType = 'danger';
    } else {
        $statement = stockmart_db()->prepare(
            'SELECT id, name, password_hash FROM users WHERE email = :email'
        );
        $statement->execute(['email' => $email]);
        $user = $statement->fetch();

        if ($user && password_verify($password, $user['password_hash'])) {
            // New session id on login prevents session fixation.
            session_regenerate_id(true);
            $_SESSION['user_id'] = (int) $user['id'];
            $_SESSION['user_name'] = $user['name'];
            unset($_SESSION['csrf']);

            header('Location: portfolio.php');
            exit;
        }

        $message = 'Invalid email or password.';
        $messageType = 'danger';
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Login | StockMart</title>
<link rel="icon" href="assets/logo.png">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="index.html">
            <img src="assets/logo.png" class="navbar-logo" alt="StockMart logo">
            <div class="ms-3">
                <h5 class="mb-0 fw-bold">StockMart</h5>
                <small>Your Market, Your Edge</small>
            </div>
        </a>
    </div>
</nav>

<div class="container py-5" style="max-width:600px;">
    <div class="stock-card">
        <h2 class="text-center mb-4">Welcome Back</h2>

        <?php if ($message !== ''): ?>
            <div class="alert alert-<?= e($messageType) ?>" role="alert"><?= e($message) ?></div>
        <?php endif; ?>

        <form method="POST" novalidate>
            <input type="hidden" name="csrf" value="<?= e(csrf_token()) ?>">

            <div class="mb-3">
                <label class="form-label" for="email">Email</label>
                <input type="email" id="email" name="email" class="form-control"
                       autocomplete="email" value="<?= e(post_string('email')) ?>" required>
            </div>

            <div class="mb-4">
                <label class="form-label" for="password">Password</label>
                <input type="password" id="password" name="password" class="form-control"
                       autocomplete="current-password" required>
            </div>

            <button class="btn btn-success w-100" type="submit">Login</button>
        </form>

        <hr>

        <p class="text-center">
            Don't have an account? <a href="register.php">Register</a>
        </p>
    </div>
</div>

</body>
</html>
