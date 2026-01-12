<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>User Profile | ASmitra</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Profile CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/profile.css">
</head>

<body class="theme-light">

<div class="profile-layout">

    <!-- ================= LEFT : PROFILE CARD ================= -->
    <div class="profile-left">
        <div class="profile-card">

            <h2>User Profile</h2>

            <c:if test="${not empty success}">
                <div class="profile-msg success">${success}</div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="profile-msg error">${error}</div>
            </c:if>

            <!-- PROFILE IMAGE -->
            <div class="profile-image-wrapper">
                <div class="avatar-mask" id="avatarMask">
                    <img id="avatarPreview"
                         src="${pageContext.request.contextPath}/uploads/profile/${loggedUser.profilePhoto}"
                         alt="Profile Photo">
                </div>
            </div>

            <!-- IMAGE CONTROLS -->
            <div class="avatar-controls">
                <label>Zoom</label>
                <input type="range" id="zoomRange"
                       min="1" max="500" step="0.1" value="1">
            </div>

            <!-- STORE ADJUSTMENTS (OPTIONAL BACKEND USE) -->
            <input type="hidden" name="imgScale" id="imgScale" value="1">
            <input type="hidden" name="imgX" id="imgX" value="0">
            <input type="hidden" name="imgY" id="imgY" value="0">

            <!-- PROFILE FORM -->
            <form class="profile-form"
                  action="update-profile"
                  method="post"
                  enctype="multipart/form-data">

                <label>Email</label>
                <input type="email"
                       value="${loggedUser.email}"
                       readonly>

                <label>Phone</label>
                <input type="text"
                       name="phone"
                       value="${loggedUser.phone}"
                       required>

                <label>State</label>
                <input type="text"
                       name="state"
                       value="${loggedUser.state}"
                       required>

                <label>Change Profile Photo</label>
                <input type="file"
                       name="profileImage"
                       accept="image/*">

                <button type="submit" class="btn-profile">
                    Update Profile
                </button>
            </form>

        </div>
    </div>

    <!-- ================= RIGHT : INFO PANEL ================= -->
    <div class="profile-right">

        <div class="side-card">
            <h5>Account Information</h5>
            <p><strong>Email:</strong> ${loggedUser.email}</p>
            <p>
                <strong>Status:</strong>
                <span class="badge bg-success">Active</span>
            </p>
        </div>

        <div class="side-card">
            <h5>Security</h5>
            <p>Email Verified <span class="badge bg-success">✔</span></p>
            <p>Password Strength <span class="badge bg-warning">Medium</span></p>
        </div>

        <div class="side-card">
            <h5>Quick Actions</h5>
            <a href="${pageContext.request.contextPath}/dashboard"
               class="side-link">Go to Dashboard</a>
            <a href="${pageContext.request.contextPath}/logout"
               class="side-link danger">Logout</a>
        </div>

        <div class="side-card help">
            <h5>Need Help?</h5>
            <p><strong>support@asmitra.com</strong></p>
        </div>

    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Profile JS -->
<script src="${pageContext.request.contextPath}/assets/js/profile.js"></script>

</body>
</html>
