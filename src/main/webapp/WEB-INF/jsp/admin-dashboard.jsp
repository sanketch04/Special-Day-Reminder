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

<!-- BACKGROUND -->
<div class="admin-bg"></div>

<!-- HEADER -->
<header class="admin-header">
    <h2>Welcome, Admin</h2>
    <p>ASmitra Administration Panel</p>
</header>

<!-- DASHBOARD -->
<section class="admin-dashboard">

    <div class="admin-card fade-up">
        <i class="bi bi-calendar-event"></i>
        <h4>Manage Events</h4>
        <p>Create, update and manage all events</p>
        <a href="<%= ctx %>/admin/eventsAdmin" class="btn-admin">Open</a>
    </div>

    <div class="admin-card fade-up">
        <i class="bi bi-people-fill"></i>
        <h4>View Users</h4>
        <p>Manage registered users</p>
        <a href="<%= ctx %>/admin/users" class="btn-admin">Open</a>
    </div>

    <div class="admin-card fade-up">
        <i class="bi bi-person-badge"></i>
        <h4>Admin Profile</h4>
        <p>View and update admin profile</p>
        <a href="<%= ctx %>/admin/profile" class="btn-admin">Open</a>
    </div>

    <div class="admin-card fade-up danger">
        <i class="bi bi-box-arrow-right"></i>
        <h4>Logout</h4>
        <p>End admin session securely</p>
        <a href="<%= ctx %>/admin/logout" class="btn-admin danger">Logout</a>
    </div>

</section>

<script src="<%= ctx %>/assets/js/admin-dashboard.js"></script>
</body>
</html>
