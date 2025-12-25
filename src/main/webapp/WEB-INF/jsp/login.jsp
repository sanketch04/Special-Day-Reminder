<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>

    <style>
        .error {
            color: red;
            margin-bottom: 10px;
        }
    </style>
</head>

<body>

<h2>User Login</h2>

<c:if test="${not empty error}">
    <div class="error">
        ${error}
    </div>
</c:if>

<form action="login" method="post">
    Email:
    <input type="email" name="email" required>
    <br><br>

    Password:
    <input type="password" name="password" required>
    <br><br>

    <button type="submit">Login</button>
</form>

<p>
    <a href="forgot-password">Forgot Password?</a>
</p>

<% if (request.getAttribute("error") != null) { %>
    <p class="error"><%= request.getAttribute("error") %></p>
<% } %>

<p>New user? <a href="register">Register here</a></p>

</body>
</html>
