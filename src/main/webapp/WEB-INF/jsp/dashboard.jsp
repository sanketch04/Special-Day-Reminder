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
 /* ===== FOOTER ===== */
.custom-footer {
    backdrop-filter: blur(14px);
    background: rgba(0,0,0,0.25);
    text-align: center;
    padding: 26px 16px;
    color: #fff;
}

.custom-footer a {
    color: #ffdfdf;
    text-decoration: none;
}

/* ===== ANIMATION ===== */
.animate-fade {
    animation: fadeUp 0.9s ease;
}

@keyframes fadeUp {
    from { opacity: 0; transform: translateY(25px); }
    to { opacity: 1; transform: translateY(0); }
}


</style>



<!-- ================= NAVBAR ================= -->
<nav class="dashboard-navbar">

    <!-- LEFT : LOGO + BRAND -->
    <div class="nav-left">
        <img src="${pageContext.request.contextPath}/assets/images/logo.png" class="logo">
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
        <li><a href="${pageContext.request.contextPath}/OpenAI/ai-chat">AI</a></li>
        <li><a href="${pageContext.request.contextPath}/planner">Day Planner</a></li>
        <li><a href="${pageContext.request.contextPath}/logout" class="logout">Logout</a></li>
    </ul>

    <!-- RIGHT : THEME + PROFILE + HAMBURGER -->
    <div class="nav-right">
        <button class="nav-toggle" onclick="toggleNav()">
            <span></span>
            <span></span>
            <span></span>
        </button>

        <button class="theme-btn" onclick="toggleTheme()">
            <i class="bi bi-moon-stars-fill"></i>
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
        <a href="#">🤖 AI Assistant</a>
        <a href="#">🗓 Calendar View</a>

        <hr>

        <!-- THEME TOGGLE -->
        <button class="theme-toggle-btn" onclick="toggleTheme()">
            🌗 Toggle Theme
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



<!-- ================= EVENTS CAROUSEL ================= -->
<section class="events-section">
    <div class="container">
        <div class="events-carousel">

            <div class="event-card animate-left">
                <img src="${pageContext.request.contextPath}/assets/images/national_youth_day.webp">
                <div class="overlay">
                    <h5>Today</h5>
                    <ul>
                        <c:forEach items="${todayEvents}" var="e">
                            <li>${e.title} – ${e.eventDate}</li>
                        </c:forEach>
                    </ul>
                </div>
            </div>

            <div class="event-card animate-up">
                <img src="${pageContext.request.contextPath}/assets/images/indian_army_day.jpg">
                <div class="overlay">
                    <h5>Next 7 Days</h5>
                    <ul>
                        <c:forEach items="${next7Events}" var="e">
                            <li>${e.title} – ${e.eventDate}</li>
                        </c:forEach>
                    </ul>
                </div>
            </div>

            <div class="event-card animate-right">
                <img src="${pageContext.request.contextPath}/assets/images/republic_day.avif">
                <div class="overlay">
                    <h5>Next 30 Days</h5>
                    <ul>
                        <c:forEach items="${next30Events}" var="e">
                            <li>${e.title} – ${e.eventDate}</li>
                        </c:forEach>
                    </ul>
                </div>
            </div>

        </div>
    </div>
</section>

<!-- ================= CALENDAR ================= -->
<section class="calendar-section fade-up">
    <div class="calendar-glass">
        <%@ include file="calendar.jsp" %>
    </div>
</section>


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
<script src="${pageContext.request.contextPath}/assets/js/dashboard.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/theme_change.js"></script>


</body>
</html>
