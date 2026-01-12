<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Scheduled Emails</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <!-- Custom css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/scheduledEmaillist.css">
</head>

<body>

<div class="page-wrapper">

    <div class="page-header">
        <h2>📧 Scheduled Emails</h2>
        <a href="${pageContext.request.contextPath}/dashboard"
           class="btn btn-outline-secondary rounded-pill">
            ←Dashboard
        </a>
    </div>

    <div class="glass-card">

        <c:choose>

            <c:when test="${not empty emails}">
                <table class="table align-middle">
                    <thead>
                    <tr>
                        <th>Event</th>
                        <th>Email</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Status</th>
                        <th style="width:200px">Action</th>
                    </tr>
                    </thead>

                    <tbody>
                    <c:forEach items="${emails}" var="e">
                        <tr>
                            <td>${e.eventInfo}</td>
                            <td>${e.receiverEmail}</td>
                            <td>${e.sendDate}</td>
                            <td>${e.sendTime}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${e.sent}">
                                        <span class="badge-sent">✅ Sent</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge-pending">⏳ Pending</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <td class="d-flex gap-2">
                                <!-- EDIT -->
                                <c:choose>
                                    <c:when test="${e.sent}">
                                        <button class="btn btn-edit-disabled btn-sm" disabled
                                                title="You cannot edit a sent email">
                                            Edit
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/email/edit/${e.id}"
                                           class="btn btn-edit btn-sm">
                                            Edit
                                        </a>
                                    </c:otherwise>
                                </c:choose>

                                <!-- DELETE (ALWAYS ENABLED) -->
                                <button type="button"
                                        class="btn btn-delete btn-sm"
                                        onclick="openDeleteModal(${e.id}, '${e.eventInfo}')">
                                    Delete
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:when>

            <c:otherwise>
                <div class="text-center py-5">
                    <div style="font-size:48px">📭</div>
                    <h5 class="mt-3 fw-semibold">No scheduled emails</h5>
                    <p class="text-muted">
                        You haven’t scheduled any emails yet.
                    </p>
                </div>
            </c:otherwise>

        </c:choose>

    </div>
</div>

<!-- DELETE MODAL -->
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title">Delete Scheduled Email</h5>
                <button class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">
                This action <strong>cannot be undone</strong>.
                <p class="mt-2">
                    Event: <strong id="deleteEventText"></strong>
                </p>
            </div>

            <div class="modal-footer">
                <button class="btn btn-secondary" data-bs-dismiss="modal">
                    Cancel
                </button>
                <a id="confirmDeleteBtn" class="btn btn-danger">
                    Yes, Delete
                </a>
            </div>

        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
const deleteModal = new bootstrap.Modal(
    document.getElementById("deleteModal")
);

function openDeleteModal(id, eventInfo) {
    document.getElementById("confirmDeleteBtn").href =
        "${pageContext.request.contextPath}/email/delete/" + id;

    document.getElementById("deleteEventText").innerText = eventInfo;

    deleteModal.show();
}
</script>

</body>
</html>
