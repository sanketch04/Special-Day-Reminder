<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin - Users</title>

<style>
    body {
        font-family: Arial;
        padding: 20px;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 15px;
    }
    th, td {
        border: 1px solid #ccc;
        padding: 8px;
        font-size: 14px;
    }
    th {
        background: #f2f2f2;
    }
    img {
        width: 50px;
        height: 50px;
        border-radius: 50%;
        object-fit: cover;
    }
</style>
</head>

<body>

<h2>Registered Users</h2>

<a href="<%= request.getContextPath() %>/admin/dashboard">⬅ Back</a>

<table>
    <tr>
    <th>ID</th>
    <th>Photo</th>
    <th>Email</th>
    <th>Email Verified</th>
    <th>Name</th>
    <th>Date Of Birth</th>
    <th>Gender</th>
    <th>Phone</th>
    <th>State</th>
    <th>Created Date</th>
</tr>


    <c:forEach var="u" items="${users}">
   <tr>
    <td>${u.id}</td>

    <td>
        <c:if test="${not empty u.profilePhoto}">
            <img src="${pageContext.request.contextPath}/uploads/profile/${u.profilePhoto}">
        </c:if>
    </td>

    <td>${u.email}</td>

    <td>
        <c:choose>
            <c:when test="${u.emailVerified}">✅ Verified</c:when>
            <c:otherwise>❌ Not Verified</c:otherwise>
        </c:choose>
    </td>

    <td>${u.name != null ? u.name : '-'}</td>
    <td>${u.dob != null ? u.dob : '-'}</td>
    <td>${u.gender != null ? u.gender : '-'}</td>
    <td>${u.phone != null ? u.phone : '-'}</td>
    <td>${u.state != null ? u.state : '-'}</td>
    <td>${u.createdAt}</td>
</tr>

</c:forEach>

</table>

<c:if test="${empty users}">
    <p>No users found.</p>
</c:if>

</body>
</html>
