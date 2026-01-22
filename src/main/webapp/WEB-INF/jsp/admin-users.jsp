<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin · Users | ASmitra</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>
/* PAGE BASE */
body {
    background: #020617;
    color: #e5e7eb;
    font-family: "Inter","Segoe UI",sans-serif;
    padding: 30px;
}

/* HEADER */
.page-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 18px;
}

.page-header h2 {
    font-weight: 800;
}

.back-link {
    text-decoration: none;
    color: #a5b4fc;
}
.back-link:hover { color: #c7d2fe; }

/* SEARCH  */
.search-box {
    margin-bottom: 18px;
    position: relative;
}

.search-box input {
    width: 100%;
    padding: 14px 46px 14px 16px;
    border-radius: 14px;
    border: 1px solid rgba(255,255,255,0.1);
    background: rgba(15,23,42,0.9);
    color: #e5e7eb;
}

/* ================= TABLE ================= */
.table-wrapper {
    background: rgba(15,23,42,0.85);
    border-radius: 22px;
    padding: 18px;
    box-shadow: 0 40px 90px rgba(0,0,0,.75);
    overflow-x: auto;
}

table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0 10px;
    font-size: 14px;
}

thead th {
    background: rgba(15,23,42,0.95);
    padding: 12px;
    font-size: 12px;
    text-transform: uppercase;
    color: #a5b4fc;
}

tbody tr {
    background: rgba(2,6,23,0.85);
    border-radius: 14px;
    opacity: 0;
    transform: translateY(18px) scale(0.985);
    filter: blur(4px);
    position: relative;
    will-change: transform, opacity, clip-path;
}

/* Soft scanning glow */
tbody tr::after {
    content: "";
    position: absolute;
    top: 0;
    left: -40%;
    width: 40%;
    height: 100%;
    background: linear-gradient(
        120deg,
        transparent,
        rgba(99,102,241,0.18),
        transparent
    );
    opacity: 0;
}

/* Active state */
tbody tr.visible {
    opacity: 1;
    transform: translateY(0) scale(1);
    filter: blur(0);
    transition:
        opacity .55s ease,
        transform .7s cubic-bezier(.16,1,.3,1),
        filter .6s ease;
}

tbody tr.visible::after {
    animation: scanSmooth 1.1s cubic-bezier(.16,1,.3,1);
}

@keyframes scanSmooth {
    from { left: -40%; opacity: .5; }
    to   { left: 130%; opacity: 0; }
}

tbody tr.hidden { display: none; }

tbody td {
    padding: 12px;
    vertical-align: middle;
}

/* Hover – very subtle */
tbody tr:hover {
    background: rgba(30,41,59,0.9);
    transform: translateY(-2px);
    transition: transform .25s ease;
}

/*IMAGE */
.user-img {
    width: 46px;
    height: 46px;
    border-radius: 50%;
    object-fit: cover;
}

/* STATUS*/
.status-chip {
    padding: 4px 10px;
    border-radius: 999px;
    font-size: 12px;
    font-weight: 600;
}

.verified {
    background: rgba(34,197,94,.15);
    color: #4ade80;
}
.not-verified {
    background: rgba(239,68,68,.15);
    color: #f87171;
}

/* EMPTY */
.empty {
    text-align: center;
    padding: 40px;
    opacity: .6;
    display: none;
}
</style>
</head>

<body>

<!-- HEADER -->
<div class="page-header">
    <h2>Registered Users</h2>
    <a class="back-link" href="<%= request.getContextPath() %>/admin/dashboard">
        <i class="bi bi-arrow-left"></i> Dashboard
    </a>
</div>

<!-- SEARCH -->
<div class="search-box">
    <input type="text" id="userSearch" placeholder="Search by email, name, phone, state…">
</div>

<!-- TABLE -->
<div class="table-wrapper">
<table>
<thead>
<tr>
    <th>ID</th>
    <th>Photo</th>
    <th>Email</th>
    <th>Status</th>
    <th>Name</th>
    <th>DOB</th>
    <th>Gender</th>
    <th>Phone</th>
    <th>State</th>
    <th>Created</th>
</tr>
</thead>

<tbody>
<c:forEach var="u" items="${users}">
<tr class="user-row">
    <td>${u.id}</td>
    <td>
        <c:if test="${not empty u.profilePhoto}">
            <img class="user-img"
                 src="${pageContext.request.contextPath}/uploads/profile/${u.profilePhoto}">
        </c:if>
    </td>
    <td class="searchable">${u.email}</td>
    <td>
        <c:choose>
            <c:when test="${u.emailVerified}">
                <span class="status-chip verified">Verified</span>
            </c:when>
            <c:otherwise>
                <span class="status-chip not-verified">Not Verified</span>
            </c:otherwise>
        </c:choose>
    </td>
    <td class="searchable">${u.name != null ? u.name : '-'}</td>
    <td>${u.dob != null ? u.dob : '-'}</td>
    <td class="searchable">${u.gender != null ? u.gender : '-'}</td>
    <td class="searchable">${u.phone != null ? u.phone : '-'}</td>
    <td class="searchable">${u.state != null ? u.state : '-'}</td>
    <td>${u.createdAt}</td>
</tr>
</c:forEach>
</tbody>
</table>

<div class="empty" id="noResult">No matching users found</div>
</div>

<!-- SCRIPT -->
<script>
$(function () {

    /* Cinematic stagger reveal */
    $(".user-row").each(function (i) {
        $(this).delay(60 + i * 85).queue(function (next) {
            $(this).addClass("visible");
            next();
        });
    });

    /* Live Search */
    $("#userSearch").on("keyup", function () {
        const val = $(this).val().toLowerCase();
        let count = 0;

        $(".user-row").each(function () {
            const text = $(this).find(".searchable").text().toLowerCase();
            if (text.includes(val)) {
                $(this).removeClass("hidden");
                count++;
            } else {
                $(this).addClass("hidden");
            }
        });

        $("#noResult").toggle(count === 0);
    });

});
</script>

</body>
</html>
