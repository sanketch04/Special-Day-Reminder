<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String ctx = request.getContextPath();
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h2>Welcome Admin</h2>

<a href="<%= ctx %>/admin/eventsAdmin">Manage Events</a><br>
<a href="<%= ctx %>/admin/users">View Users</a><br>
<a href="<%= ctx %>/admin/profile">Profile</a><br>
<a href="<%= ctx %>/admin/logout">Logout</a>



</body>
</html>