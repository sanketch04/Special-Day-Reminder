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
        <th>Name</th>
        <th>Password</th>
        <th>Age</th>
        <th>Gender</th>
        <th>Phone</th>
        <th>State</th>
        <th>Created Date</th>
        <th>OTP Expiry</th>
        <th>Reset OTP</th>
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
            <td>${u.name}</td>
            <td>${u.password}</td>
            <td>${u.age}</td>
            <td>${u.gender}</td>
            <td>${u.phone}</td>
            <td>${u.state}</td>
            <td>${u.createdAt}</td>
            <td>${u.otpExpiry}</td>
            <td>${u.resetOtp}</td>
        </tr>
    </c:forEach>
</table>

<c:if test="${empty users}">
    <p>No users found.</p>
</c:if>

</body>
</html>
