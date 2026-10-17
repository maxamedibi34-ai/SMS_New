<?php
if (session_status() !== PHP_SESSION_ACTIVE) {
    ini_set('session.use_strict_mode', '1');
    session_start();
}
require_once __DIR__ . '/../config/database.php';
function e($v): string { return htmlspecialchars((string)$v, ENT_QUOTES, 'UTF-8'); }
function current_user(): ?array { return $_SESSION['user'] ?? null; }
function require_login(): void { if (!current_user()) { header('Location: ' . BASE_URL . '/login.php'); exit; } }
function require_role(array $roles): void { require_login(); if (!in_array(current_user()['role'], $roles, true)) { http_response_code(403); exit('Ma lihid oggolaansho aad ku gasho boggan.'); } }
function csrf_token(): string { if (empty($_SESSION['csrf'])) $_SESSION['csrf'] = bin2hex(random_bytes(32)); return $_SESSION['csrf']; }
function verify_csrf(): void { if (!hash_equals($_SESSION['csrf'] ?? '', $_POST['csrf'] ?? '')) { http_response_code(419); exit('Codsigu wuu dhacay. Dib u cusboonaysii bogga.'); } }
function log_activity(string $action, string $entity, ?int $entityId = null, ?string $details = null): void {
    if (!current_user()) return;
    $q = db()->prepare('INSERT INTO activity_logs(user_id, action, entity_type, entity_id, details) VALUES(?,?,?,?,?)');
    $q->execute([current_user()['id'], $action, $entity, $entityId, $details]);
}
