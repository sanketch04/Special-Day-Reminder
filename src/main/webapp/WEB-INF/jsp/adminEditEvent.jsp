<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Edit Admin Event</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

<style>
body {
    background:#020617;
    color:#e5e7eb;
    font-family:Inter,Segoe UI,sans-serif;
}

/* Header */
.page-header{
    max-width:520px;
    margin:40px auto 0;
    display:flex;
    justify-content:space-between;
    align-items:center;
}

/* Card */
.edit-card{
    max-width:520px;
    margin:24px auto 90px;
    background:rgba(15,23,42,.92);
    border-radius:26px;
    padding:36px;
    box-shadow:0 45px 120px rgba(0,0,0,.85);
    animation:rise .8s cubic-bezier(.16,1,.3,1);
}

@keyframes rise{
    from{opacity:0;transform:translateY(40px) scale(.96)}
    to{opacity:1;transform:translateY(0) scale(1)}
}

.form-control{
    background:rgba(2,6,23,.9);
    border:1px solid rgba(255,255,255,.1);
    color:#e5e7eb;
    border-radius:16px;
    padding:14px;
}

.form-control:focus{
    border-color:#6366f1;
    box-shadow:0 0 0 3px rgba(99,102,241,.35);
}

.btn-primary{
    background:linear-gradient(135deg,#4f46e5,#6366f1);
    border:none;
    border-radius:18px;
    font-weight:700;
}

.back-link{
    display:flex;
    gap:8px;
    padding:10px 16px;
    border-radius:14px;
    background:rgba(15,23,42,.9);
    color:#e5e7eb;
    text-decoration:none;
    transition:.25s;
}

.back-link:hover{
    background:linear-gradient(135deg,#6366f1,#22c55e);
    color:#fff;
    transform:translateY(-2px);
}

/* iOS modal */
.ios-alert{
    background:rgba(28,28,30,.96);
    border-radius:26px;
    padding:30px 24px;
    text-align:center;
}

.ios-icon{
    width:60px;
    height:60px;
    border-radius:50%;
    margin:0 auto 14px;
    background:linear-gradient(135deg,#22c55e,#4ade80);
    display:flex;
    align-items:center;
    justify-content:center;
}

.ios-icon i{color:#fff;font-size:28px}
</style>
</head>

<body>

<!-- HEADER -->
<div class="page-header">
    <h3>✏️ Edit Event</h3>
    <a class="back-link"
       href="${pageContext.request.contextPath}/admin/eventsAdminList">
        <i class="bi bi-arrow-left"></i> Events
    </a>
</div>

<!-- FORM -->
<div class="edit-card">

<form id="editForm"
      action="${pageContext.request.contextPath}/admin/eventsUpdate"
      method="post">

<input type="hidden" name="id" value="${event.id}">

<div class="mb-3">
    <label class="form-label">Title</label>
    <input type="text" name="title"
           value="${event.title}"
           class="form-control" required>
</div>

<div class="mb-3">
    <label class="form-label">Description</label>
    <textarea name="description"
              class="form-control"
              rows="3">${event.description}</textarea>
</div>

<div class="row">
    <div class="col">
        <label class="form-label">Day</label>
        <input type="number" name="eventDay"
               min="1" max="31"
               value="${event.eventDay}"
               class="form-control" required>
    </div>

    <div class="col">
        <label class="form-label">Month</label>
        <select name="eventMonth" class="form-control">
            <c:forEach begin="1" end="12" var="m">
                <option value="${m}"
                    <c:if test="${event.eventMonth == m}">selected</c:if>>
                    ${m}
                </option>
            </c:forEach>
        </select>
    </div>
</div>

<div class="mt-4 d-flex justify-content-between">
    <a href="${pageContext.request.contextPath}/admin/eventsAdminList"
       class="btn btn-secondary">Cancel</a>

    <button id="submitBtn" type="submit" class="btn btn-primary">
        Update Event
    </button>
</div>

</form>
</div>

<!-- SUCCESS MODAL -->
<div class="modal fade" id="successModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content ios-alert">
        <div class="ios-icon">
            <i class="bi bi-check-lg"></i>
        </div>
        <h4 class="fw-bold">Event Updated</h4>
        <p class="opacity-75">Changes saved successfully</p>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
const form = document.getElementById("editForm");
const btn  = document.getElementById("submitBtn");

form.addEventListener("submit", function(e){
    e.preventDefault();
    btn.disabled = true;

    const modal = new bootstrap.Modal(
        document.getElementById("successModal")
    );
    modal.show();

    setTimeout(() => {
        HTMLFormElement.prototype.submit.call(form);
    }, 1200);
});
</script>

</body>
</html>


