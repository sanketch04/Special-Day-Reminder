<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>User Registration | ASmitra</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/register.css">
</head>

<body class="theme-default">

<!-- NAVBAR -->
<nav class="custom-navbar">
    <div class="nav-grid">
        <div></div>

        <div class="brand-title">
            <span class="brand-as">AS</span><span class="brand-mitra">mitra</span>
            <div class="login-context">User Registration</div>
        </div>

        <button class="theme-toggle-btn" onclick="toggleTheme()">
            <i class="bi bi-palette-fill"></i>
        </button>
    </div>
</nav>

<!-- REGISTER -->
<div class="register-wrapper">
    <div class="register-card animate-fade">

        <h1 class="welcome-text">Create Account</h1>
        <p class="subtitle">Register to get started</p>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register"
              method="post"
              enctype="multipart/form-data"
              onsubmit="return validateRegisterForm()">

            <!-- Full Name -->
            <div class="field">
                <label>Full Name</label>
                <input type="text" name="name">
                <span class="error"></span>
            </div>

            <!-- Email + OTP -->
            <div class="field">
                <label>Email</label>
                <input type="email" id="email" name="email">

                <button type="button"
                        class="btn btn-sm btn-secondary mt-2"
                        onclick="sendOtp()">Send OTP</button>

                <div id="otpSection" class="mt-2" style="display:none;">
                    <input type="text" class="form-control mt-2"
                           id="otp" placeholder="Enter OTP">

                    <button type="button"
                            class="btn btn-sm btn-success mt-2"
                            onclick="verifyOtp()">Verify OTP</button>
                </div>

                <div id="otpMsg" class="mt-2 small"></div>
            </div>

            <!-- Password -->
            <div class="field">
                <label>Password</label>
                <input type="password" name="password" id="password">
                <span class="error"></span>
            </div>

            <!-- Mobile -->
            <div class="field">
                <label>Mobile Number</label>
                <input type="text" name="phone">
                <span class="error"></span>
            </div>

            <!-- DOB -->
            <div class="field">
                <label>Date of Birth</label>
                <input type="date" name="dob">
                <span class="error"></span>
            </div>

            <!-- ✅ FIXED GENDER SECTION -->
            <div class="field">
                <label>Gender</label>

                <div class="gender-group">
                    <label class="gender-option">
                        <input type="radio" name="gender" value="Male">
                        <span>Male</span>
                    </label>

                    <label class="gender-option">
                        <input type="radio" name="gender" value="Female">
                        <span>Female</span>
                    </label>
                </div>

                <span class="error"></span>
            </div>

            <!-- State -->
            <div class="field">
                <label>State</label>
                <select class="form-select" name="state">
                    <option value="">Select State</option>
                    <option>Maharashtra</option>
                    <option>Karnataka</option>
                    <option>Tamil Nadu</option>
                    <option>Delhi</option>
                    <option>Gujarat</option>
                </select>
                <span class="error"></span>
            </div>

            <!-- Profile Photo -->
            <div class="field">
                <label>Profile Photo</label>
                <input type="file" name="profileImage" accept="image/*" required>
            </div>

            <button type="submit"
                    class="btn btn-register w-100"
                    id="registerBtn"
                    disabled>
                Register
            </button>
        </form>

        <div class="text-center mt-3">
            <a href="login">Back to Login</a>
        </div>
    </div>
</div>

<!-- FOOTER -->
<footer class="custom-footer">
    <p>© 2026 <strong>ASmitra</strong> · Special Day Reminder</p>

    <p class="footer-links">
        <i class="bi bi-envelope"></i> atharvgujare@gmail.com |
        <i class="bi bi-envelope"></i> sanketchounde@gmail.com
    </p>

    <p class="footer-links">
        <i class="bi bi-github"></i>
        <a href="https://github.com/AtharvGujare" target="_blank">Atharv</a> ·
        <a href="https://github.com/SanketChounde" target="_blank">Sanket</a>
    </p>

    <small>Created by Sanket Chounde & Atharv Gujare</small>
</footer>



<script>
function sendOtp() {
    $.post("${pageContext.request.contextPath}/send-register-otp",
        { email: $("#email").val() },
        function(res) {

            if (res === "OTP_SENT") {
                $("#otpSection").show();
                $("#otpMsg").text("OTP sent to email").css("color","green");

            } else if (res === "ALREADY_REGISTERED") {
                $("#otpMsg").text("Email already registered. Please login.")
                            .css("color","red");
            }
        }
    );
}


function verifyOtp() {
    $.post("${pageContext.request.contextPath}/verify-register-otp",
        {
            email: $("#email").val(),
            otp: $("#otp").val()
        },
        function(res) {
            if (res === "VERIFIED") {
                $("#otpMsg").text("Email verified successfully ✅");
                $("#registerBtn").prop("disabled", false);
            } else {
                $("#otpMsg").text(res).css("color","red");
            }
        }
    );
}
</script>

<!-- jQuery (REQUIRED for OTP) -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Custom JS -->
<script src="${pageContext.request.contextPath}/assets/js/register.js"></script>



</body>
</html>
