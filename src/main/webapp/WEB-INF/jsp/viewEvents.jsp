<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>All Events</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>

<h2>My Events</h2>

<table border="1">
    <tr>
        <th>Title</th>
        <th>Date</th>
        <th>Category</th>
        <th>Action</th>
    </tr>

    <c:forEach items="${events}" var="e">
        <tr>
            <td>${e.title}</td>
            <td>${e.eventDate}</td>
            <td>${e.category}</td>
            <td>
                <a href="edit/${e.id}">Edit</a> |
                <a href="#"
				   class="btn btn-danger btn-sm"
				   onclick="openDeleteModal(${e.id}, '${e.title}')">
				   Delete
				</a>
            </td>
        </tr>
    </c:forEach>
</table>

<br>
<a href="../dashboard">Back to Dashboard</a>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <div class="modal-header bg-danger text-white">
        <h5 class="modal-title">Confirm Delete</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <div class="modal-body">
        Are you sure you want to delete this event?
      </div>
       <p>
        <strong>&nbsp;&nbsp; Event Title:</strong>
        <span id="eventTitleText" class="text-primary"></span>
    	</p>

      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
          Cancel
        </button>
        <a id="confirmDeleteBtn" class="btn btn-danger">
          Yes, Delete
        </a>
      </div>

    </div>
  </div>
</div>

<!-- Update Success Modal -->
<div class="modal fade" id="updateSuccessModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">

      <div class="modal-header bg-success text-white">
        <h5 class="modal-title">Success</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <div class="modal-body">
        ✅ Event updated successfully!
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-success" data-bs-dismiss="modal">
          OK
        </button>
      </div>

    </div>
  </div>
</div>



<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
<c:if test="${param.updated == 'true'}">
<script>
document.addEventListener("DOMContentLoaded", function () {
    const modal = new bootstrap.Modal(
        document.getElementById("updateSuccessModal")
    );
    modal.show();
});
</script>
</c:if>
    
    
 <script>
function openDeleteModal(eventId, eventTitle) {

    document.getElementById("confirmDeleteBtn").href = "delete/" + eventId;

    document.getElementById("eventTitleText").innerText = eventTitle;

    const modal = new bootstrap.Modal(
        document.getElementById("deleteModal")
    );
    modal.show();
}
</script>

    
</body>
</html>
