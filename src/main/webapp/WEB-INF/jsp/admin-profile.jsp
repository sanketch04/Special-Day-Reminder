<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin Profile | ASmitra</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>

/* ================= PAGE BASE ================= */
body {
    background: #020617;
    color: #e5e7eb;
    font-family: "Inter","Segoe UI",sans-serif;
    padding: 30px;
}
/* ================= PROFILE CARD ================= */
.profile-wrapper {
    max-width: 520px;
    margin: 90px auto;
    background: rgba(15,23,42,0.88);
    border-radius: 28px;
    padding: 42px;
    box-shadow: 0 45px 110px rgba(0,0,0,.85);
    backdrop-filter: blur(14px);
    animation: riseIn .9s cubic-bezier(.16,1,.3,1);
}

@keyframes riseIn {
    from { opacity: 0; transform: translateY(50px) scale(.95); }
    to   { opacity: 1; transform: translateY(0) scale(1); }
}

/* ================= HEADER ================= */
.profile-wrapper h2 {
    text-align: center;
    font-weight: 800;
    margin-bottom: 6px;
}

.profile-sub {
    text-align: center;
    font-size: 14px;
    opacity: .65;
    margin-bottom: 32px;
}

/* ================= AVATAR ================= */
.avatar-box {
    position: relative;
    width: 150px;
    height: 150px;
    margin: 0 auto 26px;
    border-radius: 50%;
    background: linear-gradient(135deg,#4f46e5,#6366f1);
    padding: 5px;
    animation: pulse 3s infinite ease-in-out;
}

@keyframes pulse {
    0%,100% { box-shadow: 0 0 0 0 rgba(99,102,241,.4); }
    50%     { box-shadow: 0 0 0 14px rgba(99,102,241,0); }
}

.avatar-box img {
    width: 100%;
    height: 100%;
    border-radius: 50%;
    object-fit: cover;
    background: #020617;
}

/* Camera overlay */
.avatar-upload {
    position: absolute;
    bottom: 6px;
    right: 6px;
    width: 42px;
    height: 42px;
    border-radius: 50%;
    background: linear-gradient(135deg,#22c55e,#4ade80);
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    box-shadow: 0 8px 24px rgba(0,0,0,.5);
}

.avatar-upload i {
    color: #fff;
    font-size: 18px;
}

/* ================= ALERTS ================= */
.alert-msg {
    text-align: center;
    font-size: 14px;
    margin-bottom: 18px;
}

.success { color: #4ade80; }
.error   { color: #f87171; }

/* ================= FORM ================= */
.form-label {
    font-size: 13px;
    opacity: .7;
}

.form-control {
    background: rgba(2,6,23,0.85);
    border: 1px solid rgba(255,255,255,0.1);
    color: #e5e7eb;
    border-radius: 16px;
    padding: 14px;
}

.form-control:focus {
    border-color: #6366f1;
    box-shadow: 0 0 0 3px rgba(99,102,241,.3);
    background: rgba(2,6,23,0.95);
}

/* ================= BUTTON ================= */
.btn-save {
    width: 100%;
    margin-top: 26px;
    padding: 15px;
    border-radius: 18px;
    border: none;
    background: linear-gradient(135deg,#4f46e5,#6366f1);
    color: #fff;
    font-weight: 700;
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 10px;
    transition: all .3s ease;
}

.btn-save:hover {
    transform: translateY(-2px);
    box-shadow: 0 20px 55px rgba(99,102,241,.6);
}

.btn-save.loading {
    pointer-events: none;
    opacity: .8;
}

/* Hide file input */
input[type=file] { display: none; }
</style>
</head>

<body>

<div class="profile-wrapper">

    <h2>Admin Profile</h2>
    <p class="profile-sub">Manage your identity & access</p>

    <c:if test="${not empty success}">
        <div class="alert-msg success">${success}</div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert-msg error">${error}</div>
    </c:if>

    <!-- FORM START -->
    <form action="${pageContext.request.contextPath}/admin/profile/update"
          method="post"
          enctype="multipart/form-data">

        <!-- AVATAR -->
        <div class="avatar-box">
            <c:choose>
                <c:when test="${not empty ADMIN_LOGGED_IN.profilePhoto}">
                    <img id="avatarPreview"
                         src="${pageContext.request.contextPath}/uploads/admin/${ADMIN_LOGGED_IN.profilePhoto}">
                </c:when>
                <c:otherwise>
                    <img id="avatarPreview"
                         src="${pageContext.request.contextPath}/assets/images/default-image.png">
                </c:otherwise>
            </c:choose>

            <!-- ✅ REAL FILE INPUT (INSIDE FORM) -->
            <label class="avatar-upload">
                <i class="bi bi-camera-fill"></i>
                <input type="file"
                       name="photo"
                       id="photoInput"
                       accept="image/*">
            </label>
        </div>

        <div class="mb-3">
            <label class="form-label">Name</label>
            <input type="text"
                   name="name"
                   class="form-control"
                   value="${ADMIN_LOGGED_IN.name}"
                   required>
        </div>

        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email"
                   class="form-control"
                   value="${ADMIN_LOGGED_IN.email}"
                   readonly>
        </div>

        <button type="submit" class="btn-save" id="saveBtn">
            <i class="bi bi-check-circle"></i>
            Update Profile
        </button>

    </form>
    <!-- FORM END -->

</div>

<script>
$(function () {

    /* Live avatar preview */
    $("#photoInput").on("change", function () {
        const file = this.files[0];
        if (!file) return;

        const reader = new FileReader();
        reader.onload = e => $("#avatarPreview").attr("src", e.target.result);
        reader.readAsDataURL(file);
    });

    /* Submit loading */
    $("form").on("submit", function () {
        $("#saveBtn")
            .addClass("loading")
            .html('<span class="spinner-border spinner-border-sm"></span> Updating...');
    });

});
</script>

</body>
</html>
