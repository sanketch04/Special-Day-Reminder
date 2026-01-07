<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Special Day Reminder</title>
</head>
<body>

<h2>Scheduled Emails</h2>

<table border="1" cellpadding="10">
<tr>
    <th>ID</th>
    <th>Event</th>
    <th>Email</th>
    <th>Date</th>
    <th>Time</th>
    <th>Status</th>
    <th>Action</th>
</tr>

<c:forEach items="${emails}" var="e">
<tr>
    <td>${e.id}</td>
    <td>${e.eventInfo}</td>
    <td>${e.receiverEmail}</td>
    <td>${e.sendDate}</td>
    <td>${e.sendTime}</td>
    <td>
        <c:choose>
            <c:when test="${e.sent}">✅ Sent</c:when>
            <c:otherwise>⏳ Pending</c:otherwise>
        </c:choose>
    </td>
    <td>
        <a href="${pageContext.request.contextPath}/email/edit/${e.id}">Edit</a> |
        <a href="${pageContext.request.contextPath}/email/delete/${e.id}"
           onclick="return confirm('Delete?')">Delete</a>
    </td>
</tr>
</c:forEach>
</table>


</body>
</html>