<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>All Events</title>
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
                <a href="delete/${e.id}">Delete</a>
            </td>
        </tr>
    </c:forEach>
</table>

<br>
<a href="../dashboard">Back to Dashboard</a>

</body>
</html>
