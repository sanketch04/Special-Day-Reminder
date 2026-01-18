<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Day Planner | Admin</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>
/* ================= BASE ================= */
body {
    background: #020617;
    color: #e5e7eb;
    font-family: "Poppins", sans-serif;
    padding: 30px;
}

/* ================= CONTAINER ================= */
.table-container {
    max-width: 1200px;
    margin: auto;
    background: rgba(15,23,42,0.88);
    border-radius: 26px;
    padding: 32px;
    box-shadow: 0 45px 110px rgba(0,0,0,.85);
    animation: pageRise .8s cubic-bezier(.16,1,.3,1);
}

@keyframes pageRise {
    from { opacity: 0; transform: translateY(40px) scale(.96); }
    to   { opacity: 1; transform: translateY(0) scale(1); }
}

.table-container h2 {
    font-weight: 700;
    margin-bottom: 24px;
    display: flex;
    align-items: center;
    gap: 10px;
}

/* ================= TABLE ================= */
table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0 12px;
    font-size: 14px;
}

thead th {
    text-transform: uppercase;
    font-size: 12px;
    letter-spacing: .4px;
    color: #a5b4fc;
    padding: 12px;
    background: rgba(15,23,42,.95);
}

/* ================= ROW ANIMATION (WRITING FLOW) ================= */
tbody tr {
    background: rgba(2,6,23,.85);
    border-radius: 16px;
    opacity: 0;
    clip-path: inset(0 100% 0 0);
    transform: translateY(6px);
    position: relative;
}

/* Light scan shimmer */
tbody tr::after {
    content: "";
    position: absolute;
    inset: 0;
    background: linear-gradient(
        120deg,
        transparent,
        rgba(99,102,241,.18),
        transparent
    );
    transform: translateX(-120%);
    opacity: 0;
}

tbody tr.visible {
    opacity: 1;
    clip-path: inset(0 0 0 0);
    transform: translateY(0);
    transition:
        clip-path .75s cubic-bezier(.4,0,.2,1),
        transform .4s ease,
        opacity .3s ease;
}

tbody tr.visible::after {
    animation: scan 0.8s ease;
}

@keyframes scan {
    from { transform: translateX(-120%); opacity: .5; }
    to   { transform: translateX(120%); opacity: 0; }
}

tbody td {
    padding: 14px;
    vertical-align: middle;
}

tbody tr:hover {
    background: rgba(30,41,59,.9);
    transform: scale(1.01);
}

/* Rounded corners */
tbody tr td:first-child { border-radius: 16px 0 0 16px; }
tbody tr td:last-child  { border-radius: 0 16px 16px 0; }

/* ================= STATUS CHIP ================= */
.status {
    padding: 6px 14px;
    border-radius: 999px;
    font-size: 12px;
    font-weight: 600;
    text-transform: capitalize;
    display: inline-block;
}

/* Status Colors */
.status.COMPLETED {
    background: rgba(34,197,94,.15);
    color: #4ade80;
}
.status.PENDING {
    background: rgba(250,204,21,.15);
    color: #facc15;
}
.status.CANCELLED {
    background: rgba(239,68,68,.15);
    color: #f87171;
}

/* ================= RESPONSIVE ================= */
@media (max-width: 768px) {
    body { padding: 16px; }
    table { font-size: 13px; }
}
</style>
</head>

<body>

<div class="table-container">

    <h2>📅 Day Planner Records</h2>

    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Plan Date</th>
            <th>Start</th>
            <th>End</th>
            <th>Status</th>
            <th>Plan Date</th>
            <th>Last Status Change</th>
        </tr>
        </thead>

        <tbody>
        <c:forEach var="dp" items="${dayPlan}">
            <tr class="plan-row">
                <td>${dp.id}</td>
                <td>${dp.title}</td>
                <td>${dp.planDate}</td>
                <td>${dp.startTime}</td>
                <td>${dp.endTime}</td>
                <td>
                    <span class="status ${dp.status}">
                        ${dp.status}
                    </span>
                </td>
                <td>${dp.planDate}</td>
                <td>${dp.lastStatusChange}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

</div>

<!-- ================= JS ================= -->
<script>
$(function () {

    /* Writing-flow animation */
    $(".plan-row").each(function (i) {
        $(this).delay(i * 90).queue(function (next) {
            $(this).addClass("visible");
            next();
        });
    });

});
</script>

</body>
</html>
