<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.my-table {
    border-collapse: collapse;
}

.my-table th,
.my-table td {
    border: 1px solid #000;
    padding: 8px; 
}

</style>
</head>
<body>


<table class="my-table">
    <tr>
        <th>Title</th>
        <th>Date</th>
        <th>Delete</th>
    </tr>
    <c:forEach items="${events}" var="e">
        <tr>
            <td>${e.title}</td>
            <td>${e.eventDay}-${e.eventMonth}</td>
            <td>
            <a href="${pageContext.request.contextPath}/admin/events/edit/${e.id}">Edit</a>
            <a href="${pageContext.request.contextPath}/admin/events/delete/${e.id}">Delete</a>
            </td>
        </tr>
    </c:forEach>
</table>

</body>
</html>