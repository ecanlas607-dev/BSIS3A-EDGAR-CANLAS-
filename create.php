<?php
require 'config.php';
$error = null;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = trim($_POST['username']);
    $password = $_POST['password'];
    $role = $_POST['role'];

    if (empty($username) || empty($password)) {
        $error = "Kailangan punuan ang lahat ng fields.";
    } else {
        // Check if username already exists
        $check = $pdo->prepare("SELECT UserID FROM Users WHERE Username = ?");
        $check->execute([$username]);

        if ($check->fetch()) {
            $error = "Kuha na ang username na iyan.";
        } else {
            $hashedPassword = password_hash($password, PASSWORD_DEFAULT);
            $stmt = $pdo->prepare("INSERT INTO Users (Username, Password, Role) VALUES (?, ?, ?)");
            $stmt->execute([$username, $hashedPassword, $role]);

            header("Location: index.php?msg=User successfully added.");
            exit;
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Add User</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <div class="container">
    <h1>Add New User</h1>

    <?php if ($error): ?>
      <p class="error-msg"><?= htmlspecialchars($error) ?></p>
    <?php endif; ?>

    <form method="POST" class="form">
      <label>Username</label>
      <input type="text" name="username" required>

      <label>Password</label>
      <input type="password" name="password" required minlength="6">

      <label>Role</label>
      <select name="role">
        <option value="staff">Staff</option>
        <option value="admin">Admin</option>
      </select>

      <button type="submit" class="btn-submit">Add User</button>
      <a href="index.php" class="btn-cancel">Cancel</a>
    </form>
  </div>
</body>
</html>
