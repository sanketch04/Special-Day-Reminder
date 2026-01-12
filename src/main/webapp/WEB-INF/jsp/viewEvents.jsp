<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>ASmitra | Special Day Reminder</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <!-- Custom Css -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/viewEvents.css">

</head>

<body>

<div class="page-wrapper">

    <!-- Header -->
    <div class="d-flex flex-column flex-sm-row justify-content-between align-items-sm-center gap-3 mb-4">
        <div>
            <div class="page-title">My Events</div>
            <div class="text-muted small">Manage your scheduled events</div>
        </div>

        <a href="../dashboard" class="btn btn-outline-secondary btn-sm rounded-pill align-self-start align-self-sm-center">
            <i class="bi bi-arrow-left"></i> Dashboard
        </a>
    </div>

    <!-- Table -->
    <div class="card">
        <div class="card-body p-0 table-responsive">
            <table class="table mb-0">
                <thead>
                <tr>
                    <th class="ps-4">Title</th>
                    <th>Date</th>
                    <th>Category</th>
                    <th class="text-end pe-4">Action</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${events}" var="e">
                    <tr>
                        <td class="ps-4 fw-semibold">${e.title}</td>
                        <td>${e.eventDate}</td>
                        <td>
                            <span class="badge badge-category">${e.category}</span>
                        </td>
                        <td class="text-end pe-4">
                            <a href="edit/${e.id}" class="btn btn-light btn-icon me-1">
                                <i class="bi bi-pencil"></i>
                            </a>
                            <button class="btn btn-danger btn-icon"
                                    onclick="openDeleteModal(${e.id}, '${e.title}')">
                                <i class="bi bi-trash"></i>
                            </button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

</div>

<!-- DELETE MODAL -->
<div class="modal fade" id="deleteModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered modal-sm">
    <div class="modal-content p-4 text-center">

        <div class="modal-icon icon-danger">
            <i class="bi bi-trash3"></i>
        </div>

        <h5 class="modal-title mb-2">Delete this event?</h5>
        <p class="modal-text mb-3">
            This action is permanent and cannot be undone.
        </p>

        <div id="eventTitleText" class="event-pill mb-4"></div>

        <div class="d-flex justify-content-center gap-3 flex-wrap">
            <button class="btn btn-outline-secondary btn-pill"
                    data-bs-dismiss="modal">
                Cancel
            </button>
            <a id="confirmDeleteBtn"
               class="btn btn-danger-soft btn-pill">
                Delete
            </a>
        </div>

    </div>
  </div>
</div>

<!-- SUCCESS MODAL -->
<div class="modal fade" id="updateSuccessModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered modal-sm">
    <div class="modal-content p-4 text-center">

        <div class="modal-icon icon-success">
            <i class="bi bi-check-lg"></i>
        </div>

        <h5 class="modal-title mb-2">Event Updated</h5>
        <p class="modal-text mb-4">
            Your changes have been saved successfully.
        </p>

        <button class="btn btn-success-soft btn-pill"
                data-bs-dismiss="modal">
            Done
        </button>

    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Show success modal ONCE -->
<c:if test="${param.updated == 'true'}">
<script>
$(function () {
    new bootstrap.Modal(
        document.getElementById("updateSuccessModal")
    ).show();

    const cleanUrl = window.location.origin + window.location.pathname;
    window.history.replaceState({}, document.title, cleanUrl);
});
</script>
</c:if>

<script>
function openDeleteModal(id, title) {
    $("#confirmDeleteBtn").attr("href", "delete/" + id);
    $("#eventTitleText").text(title);

    new bootstrap.Modal(
        document.getElementById("deleteModal")
    ).show();
}
</script>

</body>
</html>
