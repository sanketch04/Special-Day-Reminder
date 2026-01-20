
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Dashboard | ASmitra</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
</head>

<style>



:root {
    --glass-bg: rgba(255,255,255,0.22);
    --glass-border: rgba(255,255,255,0.35);
    --dark-glass: rgba(0,0,0,0.35);
    --primary: #6366f1;
    --secondary: #22d3ee;
    --accent: #f472b6;
}

/* ================= GLOBAL ================= */
body {
    margin: 0;
    font-family: "Segoe UI", system-ui, -apple-system, BlinkMacSystemFont, sans-serif;
    transition: background 0.6s ease, color 0.6s ease;
}

/* ================= THEMES ================= */
.theme-light {
    background: linear-gradient(135deg,#004080,black,#2c5364);
    color: #0f172a;
}

.theme-dark {
    background: linear-gradient(135deg,grey,#eef2f3,#dbeafe);
    color: #020617;
}

/* ================= NAVBAR ================= */
.dashboard-navbar {
    position: sticky;
    top: 0;
    z-index: 1000;

    display: flex;
    align-items: center;
    justify-content: space-between;

    padding: 12px 28px;
    background: linear-gradient(
        to right,
        rgba(255,255,255,0.35),
        rgba(255,255,255,0.15)
    );
    backdrop-filter: blur(18px);
    border-bottom: 1px solid var(--glass-border);
    box-shadow: 0 10px 28px rgba(0,0,0,0.18);
}

/* ================= LEFT ================= */
.nav-left {
    display: flex;
    align-items: center;
    gap: 12px;
    white-space: nowrap;
}

.logo {
    width: 42px;
    height: 42px;
    border-radius: 50%;
    box-shadow: 0 0 0 1px #004080;
}

.brand {
    font-size: 22px;
    font-weight: 700;
}

.brand .as {
    background: linear-gradient(45deg,#ff416c,#ff4b2b);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}

.brand .mitra {
    background: linear-gradient(45deg,#38bdf8,#6366f1);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}

/* ================= CENTER LINKS ================= */
.nav-links {
    list-style: none;
    display: flex;
    align-items: center;
    gap: 18px;
    margin: 0;
    padding: 0;
}

.nav-links li a {
    text-decoration: none;
    font-weight: 500;
    color: #000000;
    padding: 6px 12px;
    border-radius: 10px;
    transition: all 0.35s cubic-bezier(0.22,1,0.36,1);
}

.nav-links li a:hover {
    background: rgba(255,255,255,0.25);
    transform: translateY(-2px);
}

/* ================= RIGHT ================= */
.nav-right {
    display: flex;
    align-items: center;
    gap: 14px;
}

/* ================= PROFILE ================= */
/* PROFILE */
.profile-wrapper {
    display: flex;
    flex-direction: column;
    align-items: center;
}

.profile-pic {
    width: 36px;
    height: 36px;
    border-radius: 50%;
    object-fit: cover;
    border: 2px solid white;
}

.profile-link {
    font-size: 11px;
    text-decoration: none;
    color: inherit;
    opacity: 0.85;
}

/* ================= HAMBURGER ================= */
.nav-toggle {
    display: none;
    flex-direction: column;
    gap: 5px;
    background: none;
    border: none;
    cursor: pointer;
}

.nav-toggle span {
    width: 22px;
    height: 3px;
    background: #333;
    border-radius: 4px;
}

/* ================= MOBILE ================= */
@media (max-width: 992px) {

    .nav-links {
        position: absolute;
        top: 64px;
        left: 0;
        width: 100%;
        flex-direction: column;
        align-items: center;

        background: rgba(255,255,255,0.95);
        backdrop-filter: blur(14px);

        max-height: 0;
        overflow: hidden;
        transition: max-height 0.5s ease;
    }

    .nav-links.open {
        max-height: 420px;
        padding: 10px 0;
    }

    .nav-links li {
        padding: 8px 0;
    }

    .nav-toggle {
        display: flex;
    }
}

/* ================= PROFILE DROPDOWN ================= */
.profile-dropdown {
    position: relative;
}

.profile-trigger {
    cursor: pointer;
}

.profile-menu {
    position: absolute;
    right: 0;
    top: 55px;
    width: 260px;
    background: rgba(255,255,255,0.85);
    backdrop-filter: blur(18px);
    border-radius: 18px;
    box-shadow: 0 25px 60px rgba(0,0,0,0.35);
    padding: 12px;
    display: none;
    flex-direction: column;
    animation: dropdownFade 0.3s ease;
    z-index: 2000;
}

.profile-menu.open {
    display: flex;
}

/* USER INFO */
.profile-info {
    display: flex;
    align-items: center;
    gap: 10px;
    padding-bottom: 10px;
}

.profile-info img {
    width: 42px;
    height: 42px;
    border-radius: 50%;
    object-fit: cover;
}

.profile-info small {
    display: block;
    font-size: 12px;
    opacity: 0.7;
}

/* LINKS */
.profile-menu a,
.profile-menu button {
    padding: 8px 10px;
    text-decoration: none;
    color: #1f2937;
    border-radius: 10px;
    font-size: 14px;
    background: none;
    border: none;
    text-align: left;
    cursor: pointer;
    transition: all 0.25s ease;
}

.profile-menu a:hover,
.profile-menu button:hover {
    background: rgba(0,0,0,0.08);
    transform: translateX(4px);
}

.logout-link {
    color: #dc2626;
    font-weight: 600;
}

/* DIVIDER */
.profile-menu hr {
    border: none;
    height: 1px;
    background: rgba(0,0,0,0.1);
    margin: 6px 0;
}

/* ANIMATION */
@keyframes dropdownFade {
    from {
        opacity: 0;
        transform: translateY(-10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}
.profile-pic:hover {
    transform: scale(1.08);
}

/* ================= MOBILE NAV ================= */
.nav-toggle {
    display: none;
    flex-direction: column;
    gap: 5px;
    background: none;
    border: none;
    cursor: pointer;
}

.nav-toggle span {
    width: 22px;
    height: 3px;
    background: #fff;
    border-radius: 4px;
}

@media (max-width: 992px) {
    .nav-links {
        position: absolute;
        top: 70px;
        left: 0;
        width: 100%;
        flex-direction: column;
        background: rgba(255,255,255,0.95);
        backdrop-filter: blur(16px);
        max-height: 0;
        overflow: hidden;
        transition: max-height 0.5s ease;
    }

    .nav-links.open {
        max-height: 420px;
        padding: 10px 0;
    }

    .nav-toggle {
        display: flex;
    }
}

/* ================= PROFILE DROPDOWN ================= */
.profile-menu {
    position: absolute;
    right: 0;
    top: 60px;
    width: 260px;
    background: rgba(255,255,255,0.9);
    backdrop-filter: blur(18px);
    border-radius: 18px;
    box-shadow: 0 30px 60px rgba(0,0,0,0.35);
    padding: 14px;
    display: none;
    animation: dropdownFade 0.35s ease;
}

.profile-menu.open {
    display: flex;
    flex-direction: column;
}

.profile-menu a,
.profile-menu button {
    padding: 10px;
    border-radius: 10px;
    font-size: 14px;
    transition: all 0.25s ease;
}

.profile-menu a:hover,
.profile-menu button:hover {
    background: rgba(0,0,0,0.08);
    transform: translateX(4px);
}



/* ===== PROFILE IMAGE FIX ===== */
.profile-trigger {
    width: 42px;
    height: 42px;
    border-radius: 50%;
    overflow: hidden;
    cursor: pointer;

    display: flex;
    align-items: center;
    justify-content: center;
}

.profile-trigger img.profile-pic {
    width: 100%;
    height: 100%;
    object-fit: cover;   /* 🔥 MOST IMPORTANT */
    border-radius: 50%;
    display: block;
}


</style>

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/voice.css">

<!-- ================= NAVBAR ================= -->
<nav class="dashboard-navbar">

    <!-- LEFT : LOGO + BRAND -->
    <div class="nav-left">
        <img src="${pageContext.request.contextPath}/assets/images/ASmitra_logo.gif" class="logo">
        <span class="brand">
            <span class="as">AS</span><span class="mitra">mitra</span>
        </span>
    </div>

    <!-- CENTER : NAV LINKS -->
    <ul class="nav-links" id="navLinks">
        <li><a href="${pageContext.request.contextPath}/event/add">Add Event</a></li>
        <li><a href="${pageContext.request.contextPath}/event/list">View Events</a></li>
        <li><a href="${pageContext.request.contextPath}/email/schedule">Schedule Email</a></li>
        <li><a href="${pageContext.request.contextPath}/email/list">Email's</a></li>
        <li><a href="${pageContext.request.contextPath}/planner">Day Planner</a></li>
        <li><a href="${pageContext.request.contextPath}/OpenAI/ai-chat">AI</a></li>
        
        
    </ul>
	
	
<!-- voice-mic section ends -->
    <!-- RIGHT : THEME + PROFILE + HAMBURGER -->
    <div class="nav-right">
        <button class="nav-toggle" onclick="toggleNav()">
            <span></span>
            <span></span>
            <span></span>
        </button>

<button id="voiceBtn" class="voice-btn voice-btn-elite" title="Voice Command">
    <i class="bi bi-mic-fill"></i>
    <span class="voice-ring"></span>
    <span class="voice-ring"></span>
</button>


        <!-- PROFILE DROPDOWN -->
<div class="profile-dropdown">

    <div class="profile-trigger" onclick="toggleProfileDropdown()">
        <img src="${pageContext.request.contextPath}/uploads/profile/${loggedUser.profilePhoto}"
             class="profile-pic">
    </div>

    <div class="profile-menu" id="profileMenu">

        <!-- USER INFO -->
        <div class="profile-info">
            <img src="${pageContext.request.contextPath}/uploads/profile/${loggedUser.profilePhoto}">
            <div>
                <strong>${loggedUser.name}</strong>
                <small>${loggedUser.email}</small>
            </div>
        </div>

        <hr>

        <!-- LINKS -->
        <a href="profile">👤 My Profile</a>
        <a href="settings">⚙️ Account Settings</a>
        <a href="${pageContext.request.contextPath}/event/list">📅 My Events</a>
        <a href="${pageContext.request.contextPath}/email/list">✉️ Scheduled Emails</a>
        <a href="${pageContext.request.contextPath}/OpenAI/ai-chat">🤖 AI Assistant</a>
        <a href="#">🗓 Calendar View</a>

        <hr>

        <!-- THEME TOGGLE -->
        <button class="theme-toggle-btn" onclick="toggleTheme()">
            🌗 Change Theme
        </button>

        <hr>

        <!-- LOGOUT -->
        <a href="${pageContext.request.contextPath}/logout" class="logout-link">
            🚪 Logout
        </a>

    </div>
</div>

    </div>

</nav>








<script src="${pageContext.request.contextPath}/assets/js/voice.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script src="${pageContext.request.contextPath}/assets/js/theme_change.js"></script>

<script>

/* ===== THEME TOGGLE ===== */
function toggleTheme() {
    document.body.classList.toggle("theme-light");
    document.body.classList.toggle("theme-dark");
}

/* ===== MOBILE NAV TOGGLE ===== */
function toggleNav() {
    const nav = document.getElementById("navLinks");
    if (nav) {
        nav.classList.toggle("open");
    }
}


</script>
</body>
</html>



