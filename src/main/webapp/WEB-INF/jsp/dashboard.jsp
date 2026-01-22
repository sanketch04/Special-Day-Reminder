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
        
        <li><a href="${pageContext.request.contextPath}/reminder-file">Schedule Whatsapp</a></li>
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



<!-- ================= EVENTS CAROUSEL ================= -->
<section class="events-section">
    <div class="container">
        <div class="events-carousel">
				
				 <div class="event-card animate-left">
				    <img id="img1">
				    <div class="overlay">
				        <h5 id="title1"></h5>
				    </div>
				</div>
				
				<div class="event-card animate-up">
				    <img id="img2">
				    <div class="overlay">
				        <h5 id="title2"></h5>
				    </div>
				</div>
				
				<div class="event-card animate-right">
				    <img id="img3">
				    <div class="overlay">
				        <h5 id="title3"></h5>
				    </div>
				</div>
        </div>
    </div>
</section>


<!-- ================= PREMIUM EVENTS PANEL (NO IMAGES) ================= -->
<section class="evx-section evx-section-reveal">
    <div class="evx-container">

        <div class="evx-grid">

            <!-- Card 1 -->
            <div class="evx-card evx-reveal" style="--delay: 0ms;">
                <div class="evx-head">
                    <div class="evx-badge evx-badge-today">Today</div>
                    <div class="evx-subtitle">Events happening today</div>
                </div>

                <ul class="evx-list">
                    <c:choose>
                        <c:when test="${not empty todayEvents}">
                            <c:forEach items="${todayEvents}" var="e">
                                <li class="evx-item">
                                    <span class="evx-title">${e.title}</span>
                                    <span class="evx-date">${e.eventDate}</span>
                                </li>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <li class="evx-empty">No events today ✨</li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>

            <!-- Card 2 -->
            <div class="evx-card evx-reveal" style="--delay: 120ms;">
                <div class="evx-head">
                    <div class="evx-badge evx-badge-week">Next 7 Days</div>
                    <div class="evx-subtitle">Upcoming this week</div>
                </div>

                <ul class="evx-list">
                    <c:choose>
                        <c:when test="${not empty next7Events}">
                            <c:forEach items="${next7Events}" var="e">
                                <li class="evx-item">
                                    <span class="evx-title">${e.title}</span>
                                    <span class="evx-date">${e.eventDate}</span>
                                </li>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <li class="evx-empty">No events in next 7 days ✅</li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>

            <!-- Card 3 -->
            <div class="evx-card evx-reveal" style="--delay: 240ms;">
                <div class="evx-head">
                    <div class="evx-badge evx-badge-month">Next 30 Days</div>
                    <div class="evx-subtitle">Full month overview</div>
                </div>

                <ul class="evx-list">
                    <c:choose>
                        <c:when test="${not empty next30Events}">
                            <c:forEach items="${next30Events}" var="e">
                                <li class="evx-item">
                                    <span class="evx-title">${e.title}</span>
                                    <span class="evx-date">${e.eventDate}</span>
                                </li>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <li class="evx-empty">No events in next 30 days 🎯</li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>

        </div>
    </div>
</section>

<!-- ================= AI FLOATING BUTTON ================= -->
<div id="ai-float-btn">
  <img src="${pageContext.request.contextPath}/assets/images/Asmitra-bot.png" class="ai-bot">
</div>

<!-- ================= AI CHAT PANEL ================= -->
<div id="ai-chat-panel">
    <div class="ai-chat-header">
        <span>ASmitra AI</span>
        <button onclick="toggleAIChat()">✕</button>
    </div>

    <iframe 
        src="${pageContext.request.contextPath}/OpenAI/ai-chat"
        frameborder="0"
        class="ai-chat-iframe">
    </iframe>
</div>
<div id="notify-container"></div>


 
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


<script src="${pageContext.request.contextPath}/assets/js/voice.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/dashboard.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/theme_change.js"></script>

<script>
function loadFestivalImagesByMonth(monthIndex) {

    fetch(APP_CTX + "/api/festivals?month=" + monthIndex)
        .then(res => res.json())
        .then(cards => {

            const defaults = [
                APP_CTX + "/assets/festivals/default/default1.jpg",
                APP_CTX + "/assets/festivals/default/default2.jpg",
                APP_CTX + "/assets/festivals/default/default3.jpg"
            ];

            for (let i = 0; i < 3; i++) {
                const img = document.getElementById("img" + (i + 1));
                const title = document.getElementById("title" + (i + 1));

                if (!img || !title) continue;

                img.src = cards[i]?.image || defaults[i]; // ✅ FIX
                title.innerText = cards[i]?.title || "";
            }
        })
        .catch(err => console.error("Festival API error", err));
}

/* =======================
AI CHAT
======================= */
function toggleAIChat() {
 document.getElementById("ai-chat-panel")?.classList.toggle("open");
}
document.getElementById("ai-float-btn")?.addEventListener("click", toggleAIChat);

</script>




</body>
</html>
