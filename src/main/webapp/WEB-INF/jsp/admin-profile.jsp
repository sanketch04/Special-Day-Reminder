<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    

<style>
.profile-pic {
    width: 150px;
    height: 150px;
    border-radius: 50%;
    object-fit: cover;
    border: 2px solid #ddd;
}
</style>

<h2>Admin Profile</h2>

<c:if test="${not empty success}">
    <p style="color:green">${success}</p>
</c:if>

<c:if test="${not empty error}">
    <p style="color:red">${error}</p>
</c:if>

<!-- PROFILE IMAGE -->
<c:choose>
    <c:when test="${not empty ADMIN_LOGGED_IN.profilePhoto}">
        <img src="${pageContext.request.contextPath}/uploads/admin/${ADMIN_LOGGED_IN.profilePhoto}"
             class="profile-pic">
    </c:when>
    <c:otherwise>
        <img src="${pageContext.request.contextPath}/assets/images/default-image.png"
             class="profile-pic">
    </c:otherwise>
</c:choose>


<br><br>

<form action="${pageContext.request.contextPath}/admin/profile/update"
      method="post"
      enctype="multipart/form-data">

    <label>Name</label><br>
    <input type="text"
           name="name"
           value="${ADMIN_LOGGED_IN.name}"
           required><br><br>

    <label>Email</label><br>
    <input type="email"
           value="${ADMIN_LOGGED_IN.email}"
           readonly><br><br>

    <label>Change Profile Photo</label><br>
    <input type="file"
           name="photo"
           accept="image/*"><br><br>

    <button type="submit" disable>Update Profile</button>
</form>
