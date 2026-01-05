
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<style>
        .error { color: red; }
    </style>
<h2>Reset Password</h2>


<h2>Reset Password</h2>

<form action="reset-password" method="post">

    <input type="hidden" name="email" value="${email}" />

    New Password:
    <input type="password" name="newPassword" required /><br><br>

    Confirm Password:
    <input type="password" name="confirmPassword" required /><br><br>

    <button type="submit">Reset Password</button>
</form>


<% if (request.getAttribute("error") != null) { %>
    <p class="error"><%= request.getAttribute("error") %></p>
<% } %>
