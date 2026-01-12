<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>User Registration | ASmitra</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/register.css">
</head>




<body class="theme-light">
<!-- NAVBAR -->
<!-- NAVBAR -->
<nav class="custom-navbar">
    <div class="nav-grid">
        <div></div>

        <div class="brand-title">
            <span class="brand-as">AS</span><span class="brand-mitra">mitra</span>
            
        </div>

        <button class="theme-toggle-btn" onclick="toggleTheme()" aria-label="Change theme">
            <i class="bi bi-palette-fill"></i>
        </button>
    </div>
</nav>

<div class="container register-container">
    <div class="row justify-content-center">
        <div class="col-lg-6 col-md-8">

            <div class="register-card">

                <h2 class="text-center brand-title">
                   
                </h2>
                <p class="subtitle text-center">Create your account</p>

                <form id="registerForm"
                      action="${pageContext.request.contextPath}/register"
                      method="post"
                      enctype="multipart/form-data">

                    <!-- Name -->
                    <div class="mb-3">
                        <label class="form-label">Full Name</label>
                        <input type="text" class="form-control" name="name">
                        <span class="error"></span>
                    </div>

                    <!-- Email + OTP -->
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <div class="d-flex gap-2">
                            <input type="email" class="form-control" id="email" name="email">
                            <button type="button" class="btn btn-secondary btn-sm" onclick="sendOtp()">Send OTP</button>
                        </div>

                        <div id="otpSection" class="mt-2" style="display:none;">
                            <input type="text" class="form-control mt-2" id="otp" placeholder="Enter OTP">
                            <button type="button" class="btn btn-success btn-sm mt-2" onclick="verifyOtp()">Verify OTP</button>
                        </div>

                        <div id="otpMsg" class="mt-2"></div>
                    </div>

                   <!-- Password -->
                  <div class="mb-3 field">
                    <input
                     type="password"
                     id="password"
                     name="password"
                     class="form-control"
                     placeholder=" "
                    >
                    <label>Password</label>

                   <!-- Eye icon -->
                    <span class="password-eye" id="togglePassword">👁️</span>

                   <!-- Password strength bar -->
                    <div class="password-strength">
                     <span id="strengthBar"></span>
                    </div>

                   <span class="error"></span>
                  </div>


                    <!-- Phone -->
                    <div class="mb-3">
                        <label class="form-label">Mobile Number</label>
                        <input type="text" class="form-control" name="phone">
                        <span class="error"></span>
                    </div>

                    <!-- DOB -->
                    <div class="mb-3">
                        <label class="form-label">Date of Birth</label>
                        <input type="date" class="form-control" name="dob">
                        <span class="error"></span>
                    </div>

                    <!-- Gender -->
                    <div class="mb-3">
                        <label class="form-label">Gender</label>
                        <div class="gender-group">
                            <label><input type="radio" name="gender" value="Male"> Male</label>
                            <label><input type="radio" name="gender" value="Female"> Female</label>
                        </div>
                        <span class="error"></span>
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
                        <span class="error"></span>
                    </div>

                    <!-- Profile Photo -->
                    <div class="mb-3">
                        <label class="form-label">Profile Photo</label>
                        <input type="file" class="form-control" name="profileImage" accept="image/*">
                    </div>

                    <button type="submit" class="btn btn-primary w-100" id="registerBtn" disabled>
                        Register
                    </button>
                </form>

                <div class="text-center mt-3">
                    <a href="login">Back to Login</a>
                </div>
            </div>

        </div>
    </div>
</div>


<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- Custom JS -->
<script src="${pageContext.request.contextPath}/assets/js/register.js"></script>

</body>
</html>
