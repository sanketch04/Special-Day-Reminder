<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>User Registration | ASmitra</title>

    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/register.css">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/cropperjs@1.6.2/dist/cropper.min.css">
    
    <!-- Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    
</head>

<body class="theme-light">

<div class="register-wrapper">
    <div class="register-card">

        <p class="subtitle text-center">Create your account</p>

        <form id="registerForm"
              action="${pageContext.request.contextPath}/register"
              method="post"
              enctype="multipart/form-data">

            <!-- ✅ STEP 1: EMAIL + OTP ONLY -->
            <div id="otpBox" class="fade-step show-step">

                <div class="mb-3">
                    <label class="form-label">Email</label>

                    <div class="d-flex gap-2">
                        <input type="email" class="form-control" id="email" name="email" required>
                        <button type="button" class="btn btn-secondary btn-sm" id="sendOtpBtn" onclick="sendOtp()">Send OTP</button>
                    </div>

                    <!-- OTP Section -->
                    <div id="otpSection" class="mt-3" style="display:none;">
                        <label class="form-label">Enter OTP</label>

                        <!-- ✅ 6 OTP Boxes -->
                        <div class="otp-inputs">
                            <input type="text" maxlength="1" inputmode="numeric" class="otp-box">
                            <input type="text" maxlength="1" inputmode="numeric" class="otp-box">
                            <input type="text" maxlength="1" inputmode="numeric" class="otp-box">
                            <input type="text" maxlength="1" inputmode="numeric" class="otp-box">
                            <input type="text" maxlength="1" inputmode="numeric" class="otp-box">
                            <input type="text" maxlength="1" inputmode="numeric" class="otp-box">
                        </div>

                        <!-- Hidden OTP input to send combined value -->
                        <input type="hidden" id="otp">

                        <button type="button" class="btn btn-success btn-sm mt-3 w-100" onclick="verifyOtp()">
                            Verify OTP
                        </button>

                        <!-- Timer + Resend -->
                        <div class="otp-timer mt-2 text-center">
                            <span id="timerText">Resend OTP in 30s</span>
                            <button type="button" id="resendBtn" class="btn btn-link p-0 d-none" onclick="resendOtp()">
                                Resend OTP
                            </button>
                        </div>
                    </div>

                    <div id="otpMsg" class="mt-2 text-center"></div>
                </div>

            </div>

            <!-- ✅ STEP 2: FULL FORM -->
            <div id="registerFields" class="fade-step">

                <!-- Name -->
                <div class="field">
                    <input type="text" name="name" placeholder=" " required>
                    <label>Full Name</label>
                </div>

                <!-- Password -->
                <div class="field">
                    <input type="password" id="password" name="password" placeholder=" " required>
                    <label>Password</label>

                    <span class="password-eye" id="togglePassword">👁️</span>

                    <div class="password-strength">
                        <span id="strengthBar"></span>
                    </div>
                </div>

                <!-- Phone -->
                <div class="field">
                    <input type="text" name="phone" placeholder=" " required>
                    <label>Mobile Number</label>
                </div>

                <!-- DOB -->
                <div class="field">
                    <input type="date" name="dob" required>
                    <label>Date of Birth</label>
                </div>

                <!-- Gender -->
                <div class="mb-3">
                    <label class="form-label">Gender</label>
                    <div class="gender-group">
                        <label><input type="radio" name="gender" value="Male" required> Male</label>
                        <label><input type="radio" name="gender" value="Female" required> Female</label>
                    </div>
                </div>

                <!-- State -->
                <div class="field">
                    <select name="state" required>
                        <option value="" selected disabled>Select State</option>
                        <option>Maharashtra</option>
                        <option>Karnataka</option>
                        <option>Tamil Nadu</option>
                        <option>Delhi</option>
                        <option>Gujarat</option>
                    </select>
                    
                </div>
                
                

 								 <!-- Profile Photo -->
					<div class="mb-3">
					    <label class="form-label">Profile Photo</label>

  						  	<div class="profile-upload">
  							       <div class="profile-preview">
    							        <img id="profilePreviewImg" src="" alt="Preview" />
   							          <div class="profile-placeholder" id="profilePlaceholder">
          								      <i class="bi bi-person-fill"></i>
           							  </div>
       							    </div>

      		  					   <div class="profile-upload-actions">
        							    <!-- IMPORTANT: real file input -->
      						     		 <input type="file" class="form-control" id="profileImage" accept="image/*">

          							 	 <!-- Hidden final cropped file input (submitted to backend) -->
        						    	<input type="file" id="finalProfileImage" name="profileImage" style="display:none;">

					            <div class="d-flex gap-2 mt-2">
 					               <button type="button" class="btn btn-outline-secondary btn-sm" id="editPhotoBtn" disabled>
 					                   Edit Photo
       				        	 </button>

                  		       <button type="button" class="btn btn-outline-danger btn-sm" id="removePhotoBtn" style="display:none;">
                 			   Remove
                           </button>
                

                        </div>
                       </div>
                     </div>
                    </div>
  
                           <button type="submit" class="btn btn-primary w-100">
                              Register
                           </button>

            </div>

        </form>

        <div class="text-center mt-3">
            <a href="login">Back to Login</a>
        </div>

    </div>
</div>




<!-- ✅ Crop Modal -->
<div class="modal fade" id="cropModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content crop-modal">

      <div class="modal-header">
        <h5 class="modal-title">Adjust Profile Photo</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <div class="modal-body">
        <div class="crop-area">
          <img id="cropImage" src="" alt="Crop" />
        </div>

        <div class="crop-controls mt-3">
          <button type="button" class="btn btn-light btn-sm" id="zoomInBtn">Zoom +</button>
          <button type="button" class="btn btn-light btn-sm" id="zoomOutBtn">Zoom -</button>
          <button type="button" class="btn btn-light btn-sm" id="rotateLeftBtn">Rotate ⟲</button>
          <button type="button" class="btn btn-light btn-sm" id="rotateRightBtn">Rotate ⟳</button>
          <button type="button" class="btn btn-light btn-sm" id="resetBtn">Reset</button>
        </div>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
          Cancel
        </button>
        <button type="button" class="btn btn-primary" id="saveCropBtn">
          Save
        </button>
      </div>

    </div>
  </div>
</div>

<!-- Bootstrap JS (needed for modal) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Cropper JS -->
<script src="https://cdn.jsdelivr.net/npm/cropperjs@1.6.2/dist/cropper.min.js"></script>


<script src="${pageContext.request.contextPath}/assets/js/register.js"></script>
</body>
</html>
