<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h2 style="color:red">Oops!</h2>

<p>${error}</p>

<a href="${pageContext.request.contextPath}/login">
    Go back to Login
</a>