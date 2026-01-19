<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin · Events</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<style>
body{
    background:#020617;
    color:#e5e7eb;
    font-family:Inter,Segoe UI,sans-serif;
    padding:30px;
}

/* Card */
.table-card{
    max-width:920px;
    margin:auto;
    background:rgba(15,23,42,.9);
    border-radius:28px;
    padding:30px;
    box-shadow:0 50px 120px rgba(0,0,0,.85);
}

/* Header */
.card-header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:22px;
}

.card-header h2{
    font-weight:800;
    margin:0;
}

.back-link{
    display:flex;
    gap:8px;
    padding:10px 16px;
    border-radius:14px;
    background:rgba(2,6,23,.9);
    color:#e5e7eb;
    text-decoration:none;
    border:1px solid rgba(255,255,255,.08);
    transition:.25s;
}

.back-link:hover{
    background:linear-gradient(135deg,#6366f1,#22c55e);
    color:#fff;
    transform:translateY(-2px);
}

/* Search */
.search-box{
    position:relative;
    margin-bottom:22px;
}

.search-box input{
    width:100%;
    padding:14px 46px 14px 16px;
    border-radius:16px;
    border:1px solid rgba(255,255,255,.1);
    background:rgba(2,6,23,.9);
    color:#e5e7eb;
}

.search-box input:focus{
    outline:none;
    border-color:#6366f1;
    box-shadow:0 0 0 3px rgba(99,102,241,.35);
}

.search-box i{
    position:absolute;
    right:16px;
    top:50%;
    transform:translateY(-50%);
    opacity:.6;
}

/* Table */
table{
    width:100%;
    border-collapse:separate;
    border-spacing:0 14px;
    font-size:14px;
}

thead th{
    font-size:12px;
    text-transform:uppercase;
    color:#a5b4fc;
    padding:12px;
}

tbody tr{
    background:rgba(2,6,23,.85);
    border-radius:18px;
    opacity:0;
    transform:translateX(-30px);
}

tbody tr.visible{
    opacity:1;
    transform:translateX(0);
    transition:all .6s cubic-bezier(.2,.8,.2,1);
}

tbody tr:hover{
    background:rgba(30,41,59,.9);
    transform:scale(1.01);
}

tbody tr.removing{
    opacity:0;
    transform:translateX(40px) scale(.95);
    transition:.4s ease;
}

tbody td{
    padding:16px;
}

/* Actions */
.action-btn{
    display:inline-flex;
    align-items:center;
    gap:6px;
    padding:6px 16px;
    border-radius:999px;
    font-size:13px;
    font-weight:600;
    text-decoration:none;
    transition:.25s;
}

.edit-btn{
    background:rgba(99,102,241,.15);
    color:#a5b4fc;
}

.edit-btn:hover{
    background:rgba(99,102,241,.3);
}

.delete-btn{
    background:rgba(239,68,68,.15);
    color:#f87171;
}

.delete-btn:hover{
    background:rgba(239,68,68,.3);
}

/* iOS modal */
.ios-alert{
    background:rgba(28,28,30,.96);
    border-radius:26px;
    padding:28px;
    text-align:center;
}

.ios-icon{
    width:58px;
    height:58px;
    border-radius:50%;
    margin:0 auto 14px;
    background:linear-gradient(135deg,#ff453a,#ff6b6b);
    display:flex;
    align-items:center;
    justify-content:center;
}

.ios-icon i{color:#fff;font-size:26px}
</style>
</head>

<body>

<div class="table-card">

    <div class="card-header">
        <h2>📅 Admin Events</h2>
        <a class="back-link"
           href="${pageContext.request.contextPath}/admin/dashboard">
            <i class="bi bi-arrow-left"></i> Dashboard
        </a>
    </div>

    <div class="search-box">
        <input type="text" id="eventSearch" placeholder="Search events...">
        <i class="bi bi-search"></i>
    </div>

    <table>
        <thead>
            <tr>
                <th>Title</th>
                <th>Date</th>
                <th>Actions</th>
            </tr>
        </thead>

        <tbody>
        <c:forEach items="${events}" var="e">
            <tr class="event-row">
                <td class="searchable">${e.title}</td>
                <td>${e.eventDay}-${e.eventMonth}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/events/edit/${e.id}"
                       class="action-btn edit-btn">
                        <i class="bi bi-pencil"></i> Edit
                    </a>

                    <a href="#" class="action-btn delete-btn" data-id="${e.id}">
                        <i class="bi bi-trash"></i> Delete
                    </a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<!-- DELETE MODAL -->
<div class="modal fade" id="deleteModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content ios-alert">
        <div class="ios-icon">
            <i class="bi bi-trash"></i>
        </div>
        <h4 class="fw-bold">Delete Event?</h4>
        <p class="opacity-75">This action cannot be undone.</p>
        <div class="d-flex gap-3">
            <button class="btn btn-secondary w-100" data-bs-dismiss="modal">Cancel</button>
            <button class="btn btn-danger w-100" id="confirmDelete">Delete</button>
        </div>
    </div>
  </div>
</div>

<!-- SUCCESS MODAL -->
<div class="modal fade" id="successModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content text-center p-4 bg-dark text-light rounded-4">
        <h4 class="fw-bold">Event Deleted</h4>
        <p class="opacity-75">Successfully removed</p>
        <button class="btn btn-success" data-bs-dismiss="modal">OK</button>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
let deleteId=null, deleteRow=null;

$(".event-row").each(function(i){
    $(this).delay(i*80).queue(function(next){
        $(this).addClass("visible"); next();
    });
});

$("#eventSearch").on("keyup",function(){
    const v=$(this).val().toLowerCase();
    $(".event-row").each(function(){
        $(this).toggle($(this).find(".searchable").text().toLowerCase().includes(v));
    });
});

$(".delete-btn").on("click",function(e){
    e.preventDefault();
    deleteId=$(this).data("id");
    deleteRow=$(this).closest("tr");
    new bootstrap.Modal("#deleteModal").show();
});

$("#confirmDelete").on("click",function(){
    fetch("${pageContext.request.contextPath}/admin/events/delete/"+deleteId)
    .then(()=>{
        deleteRow.addClass("removing");
        setTimeout(()=>deleteRow.remove(),400);
        bootstrap.Modal.getInstance(deleteModal).hide();
        new bootstrap.Modal("#successModal").show();
    });
});
</script>

</body>
</html>
