<?php
require_once __DIR__ . '/includes/bootstrap.php';
if (current_user()) { header('Location: dashboard.php'); exit; }
$error = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    verify_csrf();
    $username = trim($_POST['username'] ?? '');
    $password = $_POST['password'] ?? '';
    $stmt = db()->prepare('SELECT id, username, password, full_name, role, is_active, failed_attempts, locked_until FROM users WHERE username = ? LIMIT 1');
    $stmt->execute([$username]); $user = $stmt->fetch();
    if ($user && (int)$user['is_active'] === 1 && (empty($user['locked_until']) || strtotime($user['locked_until']) <= time()) && password_verify($password, $user['password'])) {
        session_regenerate_id(true); unset($user['password']); $_SESSION['user'] = $user;
        db()->prepare('UPDATE users SET last_login = NOW(), failed_attempts = 0, locked_until = NULL WHERE id = ?')->execute([$user['id']]);
        header('Location: dashboard.php'); exit;
    }
    if ($user && (empty($user['locked_until']) || strtotime($user['locked_until']) <= time())) {
        $attempts = (int)($user['failed_attempts'] ?? 0) + 1;
        db()->prepare('UPDATE users SET failed_attempts = ?, locked_until = IF(? >= 5, DATE_ADD(NOW(), INTERVAL 15 MINUTE), locked_until) WHERE id = ?')->execute([$attempts, $attempts, $user['id']]);
    }
    $error = 'Magaca isticmaalaha ama erayga sirta ah waa khaldan yahay, ama akoonku wuu xiran yahay.';
}
?><!doctype html><html lang="so"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Gelitaan | SMS</title><link rel="stylesheet" href="assets/style.css"></head><body class="login-body"><main class="login-card"><div class="brand-mark">SMS</div><p class="eyebrow">SCHOOL MANAGEMENT SYSTEM</p><h1>Ku soo dhowow</h1><p class="muted">Geli akoonkaaga si aad u sii waddo.</p><?php if ($error): ?><div class="alert error"><?=e($error)?></div><?php endif; ?><form method="post"><input type="hidden" name="csrf" value="<?=e(csrf_token())?>"><label>Magaca isticmaalaha<input name="username" autocomplete="username" required autofocus></label><label>Erayga sirta ah<input type="password" name="password" autocomplete="current-password" required></label><button class="btn primary full" type="submit">Soo gal</button></form><p class="small muted">Tani waa bilowga mashruuca. Samee akoonka Admin adigoo raacaya README.</p></main></body></html>
