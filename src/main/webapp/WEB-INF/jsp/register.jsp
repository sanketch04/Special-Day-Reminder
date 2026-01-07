<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>User Registration</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body class="bg-light">

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">

            <div class="card shadow">
                <div class="card-header text-center">
                    <h4>User Registration</h4>
                </div>

                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/register" method="post" enctype="multipart/form-data">

                        <!-- Name -->
                        <div class="mb-3">
                            <label class="form-label">Full Name</label>
                            <input type="text" class="form-control" name="name">
                            <span class="text-danger small error"></span>
                        </div>

                        <!-- Email -->
                        <div class="mb-3">
					    <label>Email</label>
					    <input type="email" class="form-control" id="email" name="email">
					
					    <button type="button" class="btn btn-sm btn-secondary mt-2"
					            onclick="sendOtp()">Send OTP</button>
					
					    <div id="otpSection" style="display:none;">
					        <input type="text" class="form-control mt-2"
					               id="otp" placeholder="Enter OTP">
					
					        <button type="button" class="btn btn-sm btn-success mt-2"
					                onclick="verifyOtp()">Verify OTP</button>
					    </div>
					
					    <div id="otpMsg" class="mt-2 text-success"></div>
					</div>

                        
                        <c:if test="${not empty error}">
    						<div class="alert alert-danger">${error}</div>
						</c:if>

                        <!-- Password -->
                        <div class="mb-3">
                            <label class="form-label">Password</label>
                            <input type="password" class="form-control" name="password">
                            <span class="text-danger small error"></span>
                        </div>

                        <!-- Phone -->
                        <div class="mb-3">
                            <label class="form-label">Mobile Number</label>
                            <input type="text" class="form-control" name="phone">
                            <span class="text-danger small error"></span>
                        </div>

                        <!-- Birth Date -->
						<div class="mb-3">
						    <label class="form-label">Date of Birth</label>
						    <input type="date" class="form-control" name="dob">
						    <span class="text-danger small error"></span>
						</div>

                        <!-- Gender -->
                        <div class="mb-3">
                            <label class="form-label">Gender</label><br>
                            <input type="radio" name="gender" value="Male"> Male
                            <input type="radio" name="gender" value="Female" class="ms-3"> Female
                            <br>
                            <span class="text-danger small error"></span>
                        </div>

                        <!-- State -->
                        <div class="mb-3">
                            <label class="form-label">State</label>
                            <select class="form-select" name="state">
                                <option value="">Select State</option>
                                <option>Maharashtra</option>
                                <option>Karnataka</option>
                                <option>Tamil Nadu</option>
                                <option>Delhi</option>
                                <option>Gujarat</option>
                            </select>
                            <span class="text-danger small error"></span>
                        </div>
                        
                         <!-- Profile Photo -->
						    <div>
						        Profile Photo:
						        <input type="file" name="profileImage" accept="image/*" required>
						    </div>
						
						    <br>

                        <button type="submit" class="btn btn-primary w-100" id="registerBtn" disabled>
							    Register
						</button>
                    </form>
                </div>

                <div class="card-footer text-center">
                    <a href="login">Back to Login</a>
                </div>
                
            </div>

        </div>
    </div>
</div>


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

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

	<!-- Validation Script -->
	<script src="${pageContext.request.contextPath}/assets/js/registerJs.js"></script>


</body>
</html>
