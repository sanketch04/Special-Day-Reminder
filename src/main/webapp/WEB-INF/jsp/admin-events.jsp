<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin Events | ASmitra</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>


<!-- Custom CSS -->
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/assets/css/admin-event-css.css">
</head>

<body>

<!-- ===============================
     EVENT FORM
================================ -->
<div class="event-card">
    <h2>Admin Event</h2>
    <p>Create a special day event for all users</p>

    <form action="${pageContext.request.contextPath}/admin/events/save" method="post">

        <div class="mb-3">
            <label class="form-label">Event Title</label>
            <input type="text" name="title" class="form-control" placeholder="e.g. Independence Day" required>
        </div>

        <div class="row g-3">
            <div class="col-6">
                <label class="form-label">Day</label>
                <input type="number" name="eventDay" class="form-control" min="1" max="31" required>
            </div>

            <div class="col-6">
                <label class="form-label">Month</label>
                <select name="eventMonth" class="form-select">
                    <option value="1">January</option>
                    <option value="2">February</option>
                    <option value="3">March</option>
                    <option value="4">April</option>
                    <option value="5">May</option>
                    <option value="6">June</option>
                    <option value="7">July</option>
                    <option value="8">August</option>
                    <option value="9">September</option>
                    <option value="10">October</option>
                    <option value="11">November</option>
                    <option value="12">December</option>
                </select>
            </div>
        </div>

        <button type="submit" class="btn-save mt-4">
            <i class="bi bi-check-circle me-1"></i> Save Event
        </button>
    </form>
</div>

<!-- ===============================
     SUCCESS MODAL
================================ -->
<div class="modal fade" id="successModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <div class="success-icon">
                <i class="bi bi-check-lg"></i>
            </div>

            <h4 class="modal-title">Event Saved</h4>
            <p class="modal-text">Your event has been added successfully 🎉</p>

            <button id="successOkBtn" class="btn-ok" data-bs-dismiss="modal">OK</button>

        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- AUTO SHOW MODAL ON SUCCESS -->
<c:if test="${success}">
<script>
document.addEventListener("DOMContentLoaded", function () {

    const modalEl = document.getElementById('successModal');
    const modal = new bootstrap.Modal(modalEl);
    modal.show();

    // Redirect AFTER modal is closed
    modalEl.addEventListener('hidden.bs.modal', function () {
        window.location.href = 
            '<c:url value="/admin/dashboard"/>';
    });

});
</script>
</c:if>



</body>
</html>
