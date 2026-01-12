<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Login | ASmitra</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/login.css">
</head>

<body class="theme-light">


<!-- NAVBAR -->
<nav class="custom-navbar">
    <div class="nav-grid">
        <div></div>

        <div class="brand-title">
            <span class="brand-as">AS</span><span class="brand-mitra">mitra</span>
            <div class="login-context">User Login</div>
        </div>

        <button class="theme-toggle-btn" onclick="toggleTheme()" aria-label="Change theme">
            <i class="bi bi-palette-fill"></i>
        </button>
    </div>
</nav>

<!-- LOGIN -->
<div class="login-wrapper">
    <div class="login-card animate-fade">

        <h1 class="welcome-text">Welcome back !</h1>
        <p class="subtitle">Login to your account</p>

        <c:if test="${not empty error}">
            <div class="alert alert-danger auto-hide">${error}</div>
        </c:if>

        <form action="login" method="post" onsubmit="return handleSubmit()">

            <div class="field">
                <input type="email" id="email" name="email" required>
                <label for="email">Email</label>
            </div>

            <div class="field password-field">
                <input type="password" id="password" name="password" required oninput="checkStrength()">
                <label for="password">Password</label>

                <i class="bi bi-eye-slash-fill toggle-eye"
                   onmousedown="showPassword()"
                   onmouseup="hidePassword()"
                   ontouchstart="showPassword()"
                   ontouchend="hidePassword()"></i>

                <small id="strength"></small>
            </div>

            <div class="remember-me">
                <input type="checkbox" id="rememberMe">
                <label for="rememberMe">Remember me</label>
            </div>

            <button id="loginBtn" class="btn btn-login w-100">
                <span class="btn-text">Login</span>
                <span class="spinner-border spinner-border-sm d-none"></span>
            </button>
        </form>
           
           <div class="below-links">
           <a href="<c:url value='/forgot-password'/>">Forgot Password?</a>
                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
           <a href="<c:url value='/register'/>">NEW User? Sign UP</a>
           </div>

    </div>
</div>

<!-- FOOTER -->
<footer class="custom-footer">
    <p>© 2026 <strong>ASmitra</strong> · Special Day Reminder</p>

    <p class="footer-links">
        <i class="bi bi-envelope"></i> atharvgujare@gmail.com |
        <i class="bi bi-envelope"></i> sanketchounde@gmail.com
    </p>

    <p class="footer-links">
        <i class="bi bi-github"></i>
        <a href="https://github.com/AtharvGujare" target="_blank">Atharv</a> ·
        <a href="https://github.com/SanketChounde" target="_blank">Sanket</a>
    </p>

    <small>Created by Sanket Chounde & Atharv Gujare</small>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/login.js"></script>

<script src="${pageContext.request.contextPath}/assets/js/theme_change.js"></script>
</body>
</html>
