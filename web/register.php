<?php
declare(strict_types=1);

require __DIR__ . '/includes/auth.php';

stockmart_start_session();

const MIN_PASSWORD_LENGTH = 8;

$message = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = post_string('name');
    $email = post_string('email');
    $password = is_string($_POST['password'] ?? null) ? $_POST['password'] : '';
    $confirm = is_string($_POST['confirm'] ?? null) ? $_POST['confirm'] : '';

    if (!csrf_valid($_POST['csrf'] ?? null)) {
        $message = 'Your session expired. Please try again.';
    } elseif ($name === '' || mb_strlen($name) > 100) {
        $message = 'Please enter your name (up to 100 characters).';
    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $message = 'Please enter a valid email address.';
    } elseif (strlen($password) < MIN_PASSWORD_LENGTH) {
        $message = 'Password must be at least ' . MIN_PASSWORD_LENGTH . ' characters.';
    } elseif ($password !== $confirm) {
        $message = 'Passwords do not match.';
    } else {
        try {
            $statement = stockmart_db()->prepare(
                'INSERT INTO users (name, email, password_hash) VALUES (:name, :email, :hash)'
            );
            $statement->execute([
                'name' => $name,
                'email' => $email,
                'hash' => password_hash($password, PASSWORD_DEFAULT),
            ]);

            header('Location: login.php?registered=1');
            exit;
        } catch (PDOException $error) {
            // SQLite reports UNIQUE violations as SQLSTATE 23000.
            if ($error->getCode() === '23000') {
                $message = 'An account with this email already exists.';
            } else {
                error_log('StockMart registration failed: ' . $error->getMessage());
                $message = 'Registration failed. Please try again.';
            }
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Register | StockMart</title>
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
        <h2 class="text-center mb-4">Create Account</h2>

        <?php if ($message !== ''): ?>
            <div class="alert alert-danger" role="alert"><?= e($message) ?></div>
        <?php endif; ?>

        <form method="POST" novalidate>
            <input type="hidden" name="csrf" value="<?= e(csrf_token()) ?>">

            <div class="mb-3">
                <label class="form-label" for="name">Full Name</label>
                <input type="text" id="name" name="name" class="form-control" maxlength="100"
                       autocomplete="name" value="<?= e(post_string('name')) ?>" required>
            </div>

            <div class="mb-3">
                <label class="form-label" for="email">Email</label>
                <input type="email" id="email" name="email" class="form-control"
                       autocomplete="email" value="<?= e(post_string('email')) ?>" required>
            </div>

            <div class="mb-3">
                <label class="form-label" for="password">Password</label>
                <input type="password" id="password" name="password" class="form-control"
                       minlength="<?= MIN_PASSWORD_LENGTH ?>" autocomplete="new-password" required>
                <div class="form-text">At least <?= MIN_PASSWORD_LENGTH ?> characters.</div>
            </div>

            <div class="mb-4">
                <label class="form-label" for="confirm">Confirm Password</label>
                <input type="password" id="confirm" name="confirm" class="form-control"
                       autocomplete="new-password" required>
            </div>

            <button class="btn btn-success w-100" type="submit">Register</button>
        </form>

        <hr>

        <p class="text-center">
            Already have an account? <a href="login.php">Login</a>
        </p>
    </div>
</div>

</body>
</html>
