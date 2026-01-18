<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin Dashboard | ASmitra</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

<!-- Custom CSS -->
<link rel="stylesheet" href="<%= ctx %>/assets/css/admin-dashboard.css">
</head>

<body>

<div class="admin-bg"></div>

<!-- HEADER -->
<header class="admin-header">
	<h1>Welcome ${admin}</h1>
    <h2>Admin Dashboard</h2>
    <p>ASmitra · Special Day Reminder System</p>
</header>

<!-- KPI SECTION -->
<section class="admin-kpis container">

    <div class="kpi-card">
        <i class="bi bi-people-fill"></i>
        <div>
            <span class="kpi-label">Total Users</span>
            <h3 class="kpi-counter" data-value="${tUser}">0</h3>
        </div>
    </div>

    <div class="kpi-card">
        <i class="bi bi-calendar-event"></i>
        <div>
            <span class="kpi-label">Total Events</span>
            <h3 class="kpi-counter" data-value="${tEvents}">0</h3>
        </div>
    </div>

    <div class="kpi-card">
        <i class="bi bi-bell-fill"></i>
        <div>
            <span class="kpi-label">Upcoming Reminders</span>
            <h3>Today</h3>
        </div>
    </div>

    <div class="kpi-card">
        <i class="bi bi-shield-check"></i>
        <div>
            <span class="kpi-label">System Status</span>
            <h3 class="text-success">Operational</h3>
        </div>
    </div>

</section>

<!-- MAIN ACTIONS -->
<section class="admin-dashboard container">

    <div class="admin-card">
        <i class="bi bi-calendar-event"></i>
        <h4>Manage Events</h4>
        <p>Create, update and manage special day events</p>
        <a href="<%= ctx %>/admin/eventsAdmin" class="btn-admin">Open</a>
    </div>

    <div class="admin-card">
        <i class="bi bi-people-fill"></i>
        <h4>View Users</h4>
        <p>Manage registered users</p>
        <a href="<%= ctx %>/admin/users" class="btn-admin">Open</a>
    </div>

    <div class="admin-card">
        <i class="bi bi-gift"></i>
        <h4>Festival Assets</h4>
        <p>Upload festival images</p>
        <a href="<%= ctx %>/admin/upload-festival" class="btn-admin">Manage</a>
    </div>

    <div class="admin-card">
        <i class="bi bi-person-badge"></i>
        <h4>Admin Profile</h4>
        <p>View and update admin profile</p>
        <a href="<%= ctx %>/admin/profile" class="btn-admin">Open</a>
    </div>

</section>

<!-- UTILITIES -->
<section class="admin-utilities container">

    <div class="utility-card">
        <h5>Quick Actions</h5>
        <ul>
            <li>➕ Add New Special Day</li>
            <li>📧 Configure Reminder Emails</li>
            <li>📱 Manage WhatsApp Reminders</li>
        </ul>
    </div>

    <div class="utility-card">
        <h5>Recent Activity</h5>
        <ul>
            <li>Event reminder scheduled</li>
            <li>User registered</li>
            <li>Festival image uploaded</li>
        </ul>
    </div>

    <!-- LOGOUT (RESTORED & PROPER) -->
    <div class="utility-card danger">
        <h5>Session</h5>
        <p>Logged in as <b>Admin</b></p>
        <a href="<%= ctx %>/admin/logout" class="btn-admin danger">Logout</a>
    </div>

</section>

<!-- JS -->
<script src="<%= ctx %>/assets/js/admin-dashboard.js"></script>
</body>
</html>
