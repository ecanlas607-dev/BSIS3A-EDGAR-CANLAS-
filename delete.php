<?php
require 'config.php';

$id = $_GET['id'] ?? null;

if ($id) {
    $stmt = $pdo->prepare("DELETE FROM Users WHERE UserID = ?");
    $stmt->execute([$id]);
}

header("Location: index.php?msg=User successfully deleted.");
exit;
?>
