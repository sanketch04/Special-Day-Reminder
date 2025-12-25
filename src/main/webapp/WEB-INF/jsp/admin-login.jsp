<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form method="post" action="${pageContext.request.contextPath}/admin/login">

    <input type="email" name="email" placeholder="Admin Email" required />
    <input type="password" name="password" placeholder="Password" required />

    <button type="submit">Admin Login</button>
</form>

</body>
</html>