<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<h2>Verify OTP</h2>

<form action="verify-otp" method="post">

    <input type="hidden" name="email" value="${email}" />

    OTP:
    <input type="text" name="otp" required /><br><br>

    Confirm OTP:
    <input type="text" name="confirmOtp" required /><br><br>

    <button type="submit">Verify OTP</button>
</form>

<c:if test="${not empty error}">
    <p style="color:red">${error}</p>
</c:if>
