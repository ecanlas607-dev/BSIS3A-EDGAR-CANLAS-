<?php
require 'config.php';

$stmt = $pdo->query("SELECT * FROM Users ORDER BY UserID DESC");
$users = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>User Accounts - Admin Panel</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <div class="container">
    <h1>User Accounts</h1>
    <a href="create.php" class="btn-add">+ Add New User</a>

    <?php if (isset($_GET['msg'])): ?>
      <p class="success-msg"><?= htmlspecialchars($_GET['msg']) ?></p>
    <?php endif; ?>

    <table>
      <thead>
        <tr>
          <th>ID</th>
          <th>Username</th>
          <th>Role</th>
          <th>Created At</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($users as $user): ?>
          <tr>
            <td><?= htmlspecialchars($user['UserID']) ?></td>
            <td><?= htmlspecialchars($user['Username']) ?></td>
            <td><?= htmlspecialchars($user['Role']) ?></td>
            <td><?= htmlspecialchars($user['CreatedAt']) ?></td>
            <td class="actions">
              <a href="edit.php?id=<?= $user['UserID'] ?>" class="btn-edit">Edit</a>
              <a href="delete.php?id=<?= $user['UserID'] ?>"
                 class="btn-delete"
                 onclick="return confirm('Sigurado ka bang gusto mong i-delete ang user na ito?');">Delete</a>
            </td>
          </tr>
        <?php endforeach; ?>
        <?php if (empty($users)): ?>
          <tr><td colspan="5" style="text-align:center;">Walang users na naka-record.</td></tr>
        <?php endif; ?>
      </tbody>
    </table>
  </div>
</body>
</html>
