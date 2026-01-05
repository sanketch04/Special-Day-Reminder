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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body>

<h2>User Login</h2>


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

<c:if test="${not empty error}">
    <div class="error">
        ${error}
    </div>
</c:if>

<p><a href="register">Dont Have an Account?</a></p>



<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    
</body>
</html>
