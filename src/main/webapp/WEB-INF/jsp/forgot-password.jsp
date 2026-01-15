<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Forgot Password | ASmitra</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/forgot-password.css">
</head>

<body class="theme-light">

<!-- NAVBAR (MINIMAL) -->
<nav class="custom-navbar">
    <div class="nav-center">
        <span class="brand-as">AS</span><span class="brand-mitra">mitra</span>
    </div>
</nav>

<!-- FORGOT PASSWORD -->
<div class="forgot-wrapper">
    <div class="forgot-card animate-fade">

        <h2>Forgot Password</h2>
        <p class="subtitle">
            Enter your registered email to receive an OTP
        </p>

        <form method="post"
              action="${pageContext.request.contextPath}/send-otp">

            <div class="field">
                <input type="email"
                       name="email"
                       placeholder="Enter registered email"
                       required>
                <label>Email Address</label>
            </div>

            <button type="submit" class="btn-forgot">
                <i class="bi bi-envelope-paper"></i>
                Send OTP
            </button>
        </form>

        <c:if test="${not empty error}">
            <div class="error-box">
                <i class="bi bi-exclamation-circle"></i>
                ${error}
            </div>
        </c:if>

        <div class="back-link">
            <a href="${pageContext.request.contextPath}/login">
                ← Back to Login
            </a>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/theme_change.js"></script>
</body>
</html>
