<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h2>Forgot Password</h2>

<form method="post"
      action="${pageContext.request.contextPath}/send-otp">

    <label>Email</label><br>

    <input type="email"
           name="email"
           placeholder="Enter registered email"
           required>

    <br><br>

    <button type="submit">Send OTP</button>
</form>

<c:if test="${not empty error}">
    <p style="color:red">${error}</p>
</c:if>
