<?php
require 'config.php';
$error = null;

$id = $_GET['id'] ?? $_POST['id'] ?? null;
if (!$id) {
    header("Location: index.php");
    exit;
}

// Handle update submission
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = trim($_POST['username']);
    $role = $_POST['role'];
    $newPassword = $_POST['password'];

    if (empty($username)) {
        $error = "Hindi puwedeng blangko ang username.";
    } else {
        if (!empty($newPassword)) {
            // Password was changed — hash the new one
            $hashedPassword = password_hash($newPassword, PASSWORD_DEFAULT);
            $stmt = $pdo->prepare("UPDATE Users SET Username = ?, Password = ?, Role = ? WHERE UserID = ?");
            $stmt->execute([$username, $hashedPassword, $role, $id]);
        } else {
            // Keep existing password
            $stmt = $pdo->prepare("UPDATE Users SET Username = ?, Role = ? WHERE UserID = ?");
            $stmt->execute([$username, $role, $id]);
        }
        header("Location: index.php?msg=User successfully updated.");
        exit;
    }
}

// Fetch current user data to pre-fill form
$stmt = $pdo->prepare("SELECT * FROM Users WHERE UserID = ?");
$stmt->execute([$id]);
$user = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$user) {
    header("Location: index.php");
    exit;
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Edit User</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <div class="container">
    <h1>Edit User</h1>

    <?php if ($error): ?>
      <p class="error-msg"><?= htmlspecialchars($error) ?></p>
    <?php endif; ?>

    <form method="POST" class="form">
      <input type="hidden" name="id" value="<?= htmlspecialchars($user['UserID']) ?>">

      <label>Username</label>
      <input type="text" name="username" value="<?= htmlspecialchars($user['Username']) ?>" required>

      <label>New Password <small>(iwan blangko kung ayaw palitan)</small></label>
      <input type="password" name="password" minlength="6">

      <label>Role</label>
      <select name="role">
        <option value="staff" <?= $user['Role'] === 'staff' ? 'selected' : '' ?>>Staff</option>
        <option value="admin" <?= $user['Role'] === 'admin' ? 'selected' : '' ?>>Admin</option>
      </select>

      <button type="submit" class="btn-submit">Save Changes</button>
      <a href="index.php" class="btn-cancel">Cancel</a>
    </form>
  </div>
</body>
</html>
