<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sdr.entity.Event" %>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    
    <style>
.profile-pic {
    width: 150px;
    height: 150px;
    border-radius: 50%;
    object-fit: cover; 
    border: 2px solid #ddd;
}
</style>
    
</head>
<body>

<h2>Dashboard</h2>

<a href="profile">My Profile</a>


<img src="${pageContext.request.contextPath}/uploads/profile/${loggedUser.profilePhoto}"
     class="profile-pic">


<a href="event/add">Add New Event</a> |
<a href="event/list">View All Events</a> |
<a href="logout">Logout</a>

<hr>

<h3>Today's Events</h3>
<ul>
    <c:forEach items="${todayEvents}" var="e">
        <li>${e.title} - ${e.eventDate}</li>
    </c:forEach>
</ul>

<h3>Next 7 Days</h3>
<ul>
    <c:forEach items="${next7Events}" var="e">
        <li>${e.title} - ${e.eventDate}</li>
    </c:forEach>
</ul>

<h3>Next 30 Days</h3>
<ul>
    <c:forEach items="${next30Events}" var="e">
        <li>${e.title} - ${e.eventDate}</li>
    </c:forEach>
</ul>

<jsp:include page="calendar.jsp"/>
</body>
</html>
