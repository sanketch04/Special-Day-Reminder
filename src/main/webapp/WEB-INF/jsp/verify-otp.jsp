<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Verify OTP | ASmitra</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/verify-otp.css">
</head>

<body class="theme-light">

<!-- NAVBAR -->
<nav class="custom-navbar">
    <div class="nav-center">
        <span class="brand-as">AS</span><span class="brand-mitra">mitra</span>
    </div>
</nav>

<!-- OTP VERIFY -->
<div class="otp-wrapper">
    <div class="otp-card animate-fade">

        <h2>Verify OTP</h2>
        <p class="subtitle">Enter the 6-digit OTP sent to your email</p>

        <form action="verify-otp" method="post" onsubmit="return combineOtp()">

            <input type="hidden" name="email" value="${email}">
            <input type="hidden" name="otp" id="otp">
            <input type="hidden" name="confirmOtp" id="confirmOtp">

            <!-- OTP INPUTS -->
            <div class="otp-inputs">
                <input type="text" maxlength="1">
                <input type="text" maxlength="1">
                <input type="text" maxlength="1">
                <input type="text" maxlength="1">
                <input type="text" maxlength="1">
                <input type="text" maxlength="1">
            </div>

            <button type="submit" class="btn-verify">
                <i class="bi bi-shield-check"></i>
                Verify OTP
            </button>
        </form>

        <!-- TIMER -->
       

        <c:if test="${not empty error}">
            <div class="error-box">
                <i class="bi bi-exclamation-circle"></i>
                ${error}
            </div>
        </c:if>

        <div class="back-link">
            <a href="${pageContext.request.contextPath}/login">← Back to Login</a>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/verify-otp.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/theme_change.js"></script>
</body>
</html>
