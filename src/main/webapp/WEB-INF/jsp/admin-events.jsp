<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<h2>Admin Events</h2>
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
<form action="${pageContext.request.contextPath}/admin/events/save" method="post">
    Title:
    <input type="text" name="title" required>

    Day:
    <input type="number" name="eventDay" min="1" max="31" required>
    Month:
    <select name="eventMonth">
        <option value="1">Jan</option>
        <option value="2">Feb</option>
        <option value="3">Mar</option>
        <option value="4">Apr</option>
        <option value="5">May</option>
        <option value="6">Jun</option>
        <option value="7">Jul</option>
        <option value="8">Aug</option>
        <option value="9">Sep</option>
        <option value="10">Oct</option>
        <option value="11">Nov</option>
        <option value="12">Dec</option>
    </select>
    <button type="submit">Save</button>
</form>

<hr>

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
