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

<!-- TOP BAR -->
<div class="admin-topbar">
    <div class="container topbar-content">
        <div class="topbar-left">
            <span class="brand">ASmitra Admin</span>
        </div>

        <div class="topbar-right">
            <div class="profile-mini">
                <i class="bi bi-person-circle"></i>
                <span>${admin}</span>

                <!-- Hover Dropdown -->
                <div class="profile-dropdown">
                    <a href="<%= ctx %>/admin/profile">
                        <i class="bi bi-person"></i> View Profile
                    </a>
                    <a href="<%= ctx %>/admin/logout" class="logout">
                        <i class="bi bi-box-arrow-right"></i> Logout
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="admin-bg"></div>

<!-- HEADER -->
<header class="admin-header">
    <div class="container">
        <h1 class="admin-welcome">
            Welcome, <span>${admin}</span>
            <span class="role-badge">Super Admin</span>
        </h1>
        <h2 class="admin-title">Admin Dashboard</h2>
        <p class="admin-subtitle">ASmitra · Special Day Reminder System</p>
    </div>
</header>

<!-- KPI SECTION -->
<section class="admin-kpis container">

    <div class="kpi-card kpi-users">
        <i class="bi bi-people-fill"></i>
        <div>
            <span class="kpi-label">Total Users</span>
            <h3 class="kpi-counter" data-value="${tUser}">0</h3>
        </div>
    </div>

    <div class="kpi-card kpi-events">
        <i class="bi bi-calendar-event"></i>
        <div>
            <span class="kpi-label">Total Events</span>
            <h3 class="kpi-counter" data-value="${tEvents}">0</h3>
        </div>
    </div>

    <div class="kpi-card kpi-admin-events">
        <i class="bi bi-calendar2-check"></i>
        <div>
            <span class="kpi-label">Admin Events</span>
            <h3 class="kpi-counter" data-value="${tAevents}">0</h3>
        </div>
    </div>

    <div class="kpi-card kpi-days">
        <i class="bi bi-calendar-week"></i>
        <div>
            <span class="kpi-label">Days Planned</span>
            <h3 class="kpi-counter" data-value="${tDayPlanned}">0</h3>
        </div>
    </div>

    <div class="kpi-card kpi-emails">
        <i class="bi bi-envelope-check-fill"></i>
        <div>
            <span class="kpi-label">Scheduled Emails</span>
            <h3 class="kpi-counter" data-value="${tEmail}">0</h3>
        </div>
    </div>

    <div class="kpi-card kpi-status">
        <i class="bi bi-shield-check"></i>
        <div>
            <span class="kpi-label">System Status</span>
            <h3 class="status-chip success">Operational</h3>
        </div>
    </div>

</section>

<!-- MAIN ACTIONS -->
<section class="admin-dashboard container">

    <div class="admin-card clickable accent-events">
        <i class="bi bi-calendar-event"></i>
        <h4>Manage Events</h4>
        <p>Create, update and manage special day events</p>
        <a href="<%= ctx %>/admin/eventsAdmin" class="btn-admin">Open</a>
    </div>

    <div class="admin-card clickable accent-users">
        <i class="bi bi-people-fill"></i>
        <h4>View Users</h4>
        <p>Manage registered users</p>
        <a href="<%= ctx %>/admin/users" class="btn-admin">Open</a>
    </div>

    <div class="admin-card clickable accent-assets">
        <i class="bi bi-gift"></i>
        <h4>Festival Assets</h4>
        <p>Upload and manage festival images</p>
        <a href="<%= ctx %>/admin/upload-festival" class="btn-admin">Manage</a>
    </div>

    <div class="admin-card clickable accent-profile">
        <i class="bi bi-person-badge"></i>
        <h4>Admin Profile</h4>
        <p>View and update admin profile</p>
        <a href="<%= ctx %>/admin/profile" class="btn-admin">Open</a>
    </div>

    <div class="admin-card clickable accent-days">
        <i class="bi bi-calendar-check"></i>
        <h4>Day Planned</h4>
        <p>View planned special days</p>
        <a href="<%= ctx %>/admin/dayPlanned" class="btn-admin">Open</a>
    </div>

    <div class="admin-card clickable accent-admin-events">
        <i class="bi bi-clipboard-data"></i>
        <h4>Admin Events</h4>
        <p>View admin event data</p>
        <a href="<%= ctx %>/admin/eventsAdminList" class="btn-admin">Open</a>
    </div>

</section>

<!-- PROFILE OVERVIEW -->
<section class="admin-profile container">

    <div class="profile-card">
        <div class="profile-avatar">
            <i class="bi bi-person-badge"></i>
        </div>

        <div class="profile-info">
            <h4>${admin}</h4>
            <span class="profile-role">Super Admin</span>
            <p>Full system access · Event & user management</p>
        </div>

        <div class="profile-actions">
            <a href="<%= ctx %>/admin/profile" class="btn-admin">View Profile</a>
        </div>
    </div>

</section>


<!-- INSIGHTS -->
<section class="admin-utilities container">

    <div class="utility-card">
        <h5>Today’s Focus</h5>
        <ul>
            <li>Review scheduled reminders</li>
            <li>Check failed email deliveries</li>
            <li>Verify upcoming special days</li>
        </ul>
    </div>

    <div class="utility-card">
        <h5>Reminder Pipeline</h5>
        <ul>
            <li>Email Queue: <b class="text-success">Healthy</b></li>
            <li>WhatsApp Queue: <b class="text-success">Active</b></li>
            <li>Scheduler: <b class="text-success">Running</b></li>
        </ul>
    </div>

    <div class="utility-card danger">
        <h5>Session</h5>
        <p>Logged in as <b>${admin}</b></p>
        <a href="<%= ctx %>/admin/logout" class="btn-admin danger">Logout</a>
    </div>

</section>

<script src="<%= ctx %>/assets/js/admin-dashboard.js"></script>
</body>
</html>
