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

<h2>User Profile</h2>

<c:if test="${not empty success}">
    <p style="color:green">${success}</p>
</c:if>

<c:if test="${not empty error}">
    <p style="color:red">${error}</p>
</c:if>

<img src="${pageContext.request.contextPath}/uploads/profile/${loggedUser.profilePhoto}"
     class="profile-pic">

<form action="update-profile" method="post" enctype="multipart/form-data">

    <label>Email</label><br>
    <input type="email" value="${loggedUser.email}" readonly><br><br>

    <label>Phone</label><br>
    <input type="text" name="phone"
           value="${loggedUser.phone}" required><br><br>

    <label>State</label><br>
    <input type="text" name="state"
           value="${loggedUser.state}" required><br><br>

    <label>Change Profile Photo</label><br>
    <input type="file" name="profileImage" accept="image/*"><br><br>

    <button type="submit">Update Profile</button>
</form>
