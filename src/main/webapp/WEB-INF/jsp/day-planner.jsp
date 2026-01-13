<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Day Planner</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
.notify {
    position: fixed;
    bottom: 20px;
    left: 20px;
    background: #323232;
    color: #fff;
    padding: 12px 18px;
    border-radius: 8px;
    box-shadow: 0 5px 15px rgba(0,0,0,.4);
    animation: fadein .3s;
    z-index: 9999;
}
@keyframes fadein {
    from {opacity:0; transform:translateY(10px);}
    to {opacity:1;}
}
</style>
</head>

<body class="bg-dark text-white">

<div class="container mt-4">

    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4>📅 Day Planner</h4>

        <input type="date"
               class="form-control w-auto"
               value="${planDate}"
               onchange="window.location.href='${pageContext.request.contextPath}/planner/' + this.value">
    </div>

    <hr>

    <!-- ADD PLAN -->
    <h5>Add Plan</h5>

    <form method="post"
      action="${pageContext.request.contextPath}/planner/add"
      class="mb-4">




        <input type="hidden" name="planDate" value="${planDate}"/>

        <div class="mb-2">
            <label>Title</label>
            <input type="text" name="title" class="form-control" required>
        </div>

        <div class="mb-2">
            <label>Start Time</label>
            <input type="time" name="startTime" class="form-control" required>
        </div>

        <div class="mb-2">
            <label>End Time</label>
            <input type="time" name="endTime" class="form-control" required>
        </div>

        <button class="btn btn-success">Save Plan</button>
    </form>

    <hr>

    <!-- PLAN LIST -->
    <h5>Plans for ${planDate}</h5>

    <table class="table table-dark table-bordered">
        <tr>
            <th>Title</th>
            <th>Start</th>
            <th>End</th>
            <th>Status</th>
        </tr>

        <c:forEach items="${plans}" var="p">
            <tr data-id="${p.id}" data-status="${p.status}">
                <td>${p.title}</td>
                <td>${p.startTime}</td>
                <td>${p.endTime}</td>
                <td class="status">${p.status}</td>
            </tr>
        </c:forEach>
    </table>

</div>

<script>
function notify(text) {
    const n = document.createElement("div");
    n.className = "notify";
    n.innerText = text;
    document.body.appendChild(n);
    setTimeout(() => n.remove(), 5000);
}

// ✅ SAVE PLAN (AJAX)
document.querySelector("form").addEventListener("submit", function(e) {
    e.preventDefault();

    fetch(this.action, {
        method: "POST",
        body: new FormData(this)
    }).then(() => {
        notify("📌 Plan scheduled successfully");
        setTimeout(() => location.reload(), 800);
    });
});

// 🔁 POLL ONLY FOR NEW EVENTS
setInterval(() => {

    fetch("${pageContext.request.contextPath}/planner/notifications")
        .then(res => res.json())
        .then(data => {

            data.forEach(p => {

                if (p.status === "RUNNING") {
                    notify(
                        "🕒 " + p.title +
                        " started (" + p.startTime + " - " + p.endTime + ")"
                    );
                }

                if (p.status === "COMPLETED") {
                    notify("✅ " + p.title + " completed");
                }

            });

        });

}, 15000);
</script>



<script>
function planSaved() {
    notify("📌 Plan scheduled successfully");

    return true;
}
</script>


</body>
</html>
