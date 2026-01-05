<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form method="post"
      action="${pageContext.request.contextPath}/admin/register"
      enctype="multipart/form-data">

    <input type="text" name="name" placeholder="Name" required />

    <input type="email" name="email" placeholder="Email" required />

    <input type="password" name="password" placeholder="Password" required />

    <!-- ✅ PHOTO -->
    <input type="file" name="photo" accept="image/*" required />

    <button type="submit">Register Admin</button>
</form>


<c:if test="${not empty error}">
    <p style="color:red">${error}</p>
</c:if>

</body>
</html>