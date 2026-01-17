<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<form action="${pageContext.request.contextPath}/login"
      method="post"
      onsubmit="return handleSubmit()">

    <div class="field">
        <input type="email" id="email" name="email" required>
        <label>Email</label>
    </div>

    <div class="field password-field">
        <input type="password" id="password" name="password" required oninput="checkStrength()">
        <label>Password</label>

        <i class="bi bi-eye-slash-fill toggle-eye"
           onmousedown="showPassword()"
           onmouseup="hidePassword()"></i>

        <small id="strength"></small>
    </div>

    <div class="remember-me">
        <input type="checkbox" id="rememberMe">
        <label for="rememberMe">Remember me</label>
    </div>

    <button id="loginBtn" class="btn btn-login w-100">
        <span class="btn-text">Login</span>
        <span class="spinner-border spinner-border-sm d-none"></span>
    </button>

    <div class="below-links">
        <a href="<c:url value='/forgot-password'/>">Forgot Password?</a>
        <a href="<c:url value='/register'/>">New user? Sign up</a>
    </div>
</form>
