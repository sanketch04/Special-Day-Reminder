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

<!-- MENU -->
<div class="menu-container">
    <button class="menu-btn" onclick="toggleMenu()">
        <i class="bi bi-three-dots-vertical"></i>
    </button>

    <div class="menu-popup" id="menuPopup">
        <a href="#">About</a>
        <a href="<c:url value='/register'/>"> Sign UP</a>

         <a href="<c:url value='/forgot-password'/>">Forgot Password?</a>
        <a href="#">Other Projects</a>
        <hr>
        <button onclick="toggleTheme()" class="theme-switch">
            <i class="bi bi-moon-stars-fill"></i> Toggle Theme
        </button>
    </div>
</div>

<!-- SPLIT / STACK CONTAINER -->
<div class="split-container">

    <!-- LEFT -->
    <div class="left-panel">
        <video autoplay muted loop playsinline class="bg-video">
            <source src="${pageContext.request.contextPath}/assets/video/login_bg.mp4" type="video/mp4">
        </video>

        <div class="brand-wrapper slide-in-brand">
            <h1 class="brand-logo">
                <span class="brand-as">AS</span><span class="brand-mitra">mitra</span>
            </h1>
            <p class="tagline">Remember Moments, Not Just Dates</p>
        </div>

        <!-- MOBILE LOGIN OVER VIDEO -->
        <div class="mobile-login">
            <jsp:include page="login-form.jsp" />
        </div>
       </div>

    <!-- RIGHT -->
    <div class="right-panel">
        <div class="login-card slide-in-login desktop-login">

            <h1 class="welcome-text">Welcome back</h1>
            <p class="subtitle">Login to your account</p>

            <c:if test="${not empty error}">
                <div class="alert alert-danger auto-hide">${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post">


                <div class="field">
                    <input type="email" id="email" name="email" required>
                    <label>Email</label>
                </div>

                <div class="field password-field">
                    <input type="password" id="password" name="password" required oninput="checkStrength()">
                    <label>Password</label>

                    <i class="bi bi-eye-slash-fill toggle-eye"
                       onmousedown="showPassword()"
                       onmouseup="hidePassword()"></i>

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
                <a href="<c:url value='/register'/>">New user? Sign up</a>
            </div>
        </div>
    </div>
</div>

<!-- FOOTER -->
<footer class="meta-footer">
    <div class="meta-links">
        Meta · About · Blog · Jobs · Help · API · Privacy · Terms · Locations ·
        Instagram Lite · Meta AI · Threads · Contact uploading and non-users · Meta Verified
    </div>
    <div class="copyright">
        © 2026 ASmitra. All rights reserved.
    </div>
</footer>

<script src="${pageContext.request.contextPath}/assets/js/login.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/theme_change.js"></script>
</body>
</html>
