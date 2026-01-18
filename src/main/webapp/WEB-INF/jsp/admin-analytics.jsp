<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Analytics | ASmitra Admin</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!-- Shared Admin CSS -->
<link rel="stylesheet" href="<%= ctx %>/assets/css/admin-dashboard.css">
</head>

<body>

<!-- TOP BAR -->
<div class="admin-topbar">
    <div class="container topbar-content">
        <span class="brand">ASmitra · Analytics</span>

        <div class="profile-mini">
            <i class="bi bi-person-circle"></i>
            <span>${admin}</span>
            <div class="profile-dropdown">
                <a href="<%= ctx %>/admin/dashboard">
                    <i class="bi bi-speedometer2"></i> Dashboard
                </a>
                <a href="<%= ctx %>/admin/logout" class="logout">
                    <i class="bi bi-box-arrow-right"></i> Logout
                </a>
            </div>
        </div>
    </div>
</div>

<div class="admin-bg"></div>

<!-- HEADER -->
<header class="admin-header">
    <div class="container">
        <h2 class="admin-title">System Analytics</h2>
        <p class="admin-subtitle">Users · Events · Growth · Trends</p>
    </div>
</header>

<!-- ANALYTICS -->
<section class="admin-analytics container">

    <div class="row g-4">

        <!-- USER -->
        <div class="col-12 col-md-6">
            <div class="analytics-card h-100 analytics-reveal">

                <h5>User Growth</h5>
                <div class="analytics-badges">
				    <span class="analytics-badge">Live Data</span>
				    <span class="analytics-badge">Auto Synced</span>
				</div>            
                <div class="chart-box">
                    <canvas id="userChart"></canvas>
                </div>
            </div>
        </div>

        <!-- EVENTS -->
        <div class="col-12 col-md-6">
            <div class="analytics-card h-100 analytics-reveal">

                <h5>Event Distribution</h5>
                <div class="analytics-badges">
				    <span class="analytics-badge">Live Data</span>
				    <span class="analytics-badge">Auto Synced</span>
				</div>   
                <div class="chart-box">
                    <canvas id="eventChart"></canvas>
                </div>
            </div>
        </div>

        <!-- EMAIL -->
        <div class="col-12 col-md-6">
            <div class="analytics-card h-100 analytics-reveal">

                <h5>Email Scheduling</h5>
                <div class="analytics-badges">
				    <span class="analytics-badge">Live Data</span>
				    <span class="analytics-badge">Auto Synced</span>
				</div>   
                <div class="chart-box">
                    <canvas id="emailChart"></canvas>
                </div>
            </div>
        </div>

        <!-- DAYS -->
        <div class="col-12 col-md-6">
           <div class="analytics-card h-100 analytics-reveal">

                <h5>Days Planned Overview</h5>
                <div class="analytics-badges">
				    <span class="analytics-badge">Live Data</span>
				    <span class="analytics-badge">Auto Synced</span>
				</div>   
                <div class="chart-box">
                    <canvas id="dayChart"></canvas>
                </div>
            </div>
        </div>

    </div>

</section>

<!-- BACKEND DATA -->
<script>
window.analyticsData = {
    totalUsers: ${tUser},
    totalEvents: ${tEvents},
    adminEvents: ${tAevents},
    totalEmails: ${tEmail},
    totalDays: ${tDayPlanned}
};
</script>

<script src="<%= ctx %>/assets/js/admin-analytics.js"></script>

</body>
</html>
