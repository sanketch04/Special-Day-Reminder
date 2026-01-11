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

<body class="theme-light">

<!-- ================= NAVBAR ================= -->
<nav class="dashboard-navbar">

    <div class="nav-left">
        <img src="${pageContext.request.contextPath}/assets/images/ASmitra_logo.png" class="logo">
        <span class="brand">
            <span class="as">AS</span><span class="mitra">mitra</span>
        </span>
    </div>

    <!-- HAMBURGER -->
    <button class="nav-toggle" onclick="toggleNav()">
        <span></span>
        <span></span>
        <span></span>
    </button>

    <!-- NAV LINKS -->
       <ul class="nav-links">
        <li> <a href="${pageContext.request.contextPath}/event/add">Add Event</a></li>
        <li><a href="${pageContext.request.contextPath}/event/list">View Events</a></li>
        <li> <a href="${pageContext.request.contextPath}/email/schedule">Schedule Email</a></li>
        <li><a href="${pageContext.request.contextPath}/email/list">Emails</a></li>
        <li><a href="${pageContext.request.contextPath}/OpenAI/ai-chat">AI</a></li>
        <li><a href="${pageContext.request.contextPath}/logout">Logout</a></li>
       </ul>


    <div class="nav-right">
        <button class="theme-btn" onclick="toggleTheme()">
            <i class="bi bi-moon-stars-fill"></i>
        </button>

        <div class="profile-wrapper">
                <img src="${pageContext.request.contextPath}/uploads/profile/${loggedUser.profilePhoto}"
                 class="profile-pic">

            <a href="profile" class="profile-link">My Profile</a>
        </div>
    </div>
</nav>

<!-- ================= EVENTS CAROUSEL ================= -->
<section class="events-section">
    <div class="container">
        <div class="events-carousel">

            <div class="event-card animate-left">
                <img src="${pageContext.request.contextPath}/assets/images/today.jpg">
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
                <img src="${pageContext.request.contextPath}/assets/images/week.jpg">
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
                <img src="${pageContext.request.contextPath}/assets/images/month.jpg">
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/dashboard.js"></script>
</body>
</html>
