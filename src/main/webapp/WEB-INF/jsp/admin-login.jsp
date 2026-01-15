<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin Login | ASmitra</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

<!-- Custom CSS -->
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/assets/css/admin-login.css">
</head>

<body>

<!-- BACKGROUND -->
<div class="admin-bg"></div>

<!-- LOGIN CARD -->
<div class="admin-login-wrapper">
    <div class="admin-login-card">

        <div class="admin-badge">
            <i class="bi bi-shield-lock-fill"></i>
        </div>

        <h2>Admin Access</h2>
        <p class="subtitle">Authorized personnel only</p>

        <form method="post"
              action="${pageContext.request.contextPath}/admin/login">

            <div class="field">
                <input type="email"
                       name="email"
                       required>
                <label>Admin Email</label>
                <i class="bi bi-person-badge field-icon"></i>
            </div>

            <div class="field">
                <input type="password"
                       name="password"
                       required>
                <label>Password</label>
                <i class="bi bi-key field-icon"></i>
            </div>

            <button type="submit" class="btn-admin">
                <span>Secure Login</span>
                <i class="bi bi-arrow-right-circle"></i>
            </button>
        </form>

        <div class="admin-footer">
            <small>ASmitra Administration Panel</small>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
