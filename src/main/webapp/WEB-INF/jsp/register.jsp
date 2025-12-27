<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>User Registration</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" name="email">
                            <span class="text-danger small error"></span>
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

                        <button type="submit" class="btn btn-primary w-100">
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

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Validation Script -->
<script>
$(function () {

    $("#registerForm").on("submit", function (e) {
        let valid = true;
        $(".error").text("");

        // RegEx patterns
        const nameRegex     = /^[A-Za-z ]{3,50}$/;
        const emailRegex    = /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/;
        const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{6,}$/;
        const phoneRegex    = /^[6-9]\d{9}$/;
        const stateRegex    = /^[A-Za-z ]{2,}$/;

        const name     = $("[name='name']").val().trim();
        const email    = $("[name='email']").val().trim();
        const password = $("[name='password']").val();
        const phone    = $("[name='phone']").val().trim();
        const dob = $("[name='dob']").val();
        const gender   = $("[name='gender']:checked").val();
        const state    = $("[name='state']").val();

        if (!nameRegex.test(name)) {
            setError("name", "Enter valid name (min 3 letters)");
            valid = false;
        }

        if (!emailRegex.test(email)) {
            setError("email", "Enter valid email address");
            valid = false;
        }

        if (!passwordRegex.test(password)) {
            setError("password", "Password must contain letter, number & special char");
            valid = false;
        }

        if (!phoneRegex.test(phone)) {
            setError("phone", "Enter valid 10-digit Indian mobile number");
            valid = false;
        }


        if (!dob) {
            setError("dob", "Please select your birth date");
            valid = false;
        } else {
            const birthDate = new Date(dob);
            const today = new Date();

            let age = today.getFullYear() - birthDate.getFullYear();
            const m = today.getMonth() - birthDate.getMonth();
            if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
                age--;
            }

            if (age < 18 || age > 60) {
                setError("dob", "Age must be between 18 and 60");
                valid = false;
            }
        }

        if (!gender) {
            $("[name='gender']").closest(".mb-3")
                .find(".error").text("Please select gender");
            valid = false;
        }

        if (!stateRegex.test(state)) {
            setError("state", "Please select a valid state");
            valid = false;
        }

        if (!valid) e.preventDefault();
    });

    function setError(field, message) {
        $("[name='" + field + "']")
            .closest(".mb-3")
            .find(".error")
            .text(message);
    }
});
</script>

<script>
$(function () {

    // Regex patterns
    const nameRegex     = /^[A-Za-z ]{3,50}$/;
    const emailRegex    = /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/;
    const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{6,}$/;
    const phoneRegex    = /^[6-9]\d{9}$/;
    const stateRegex    = /^[A-Za-z ]{2,}$/;

    // NAME
    $("[name='name']").on("blur", function () {
        const val = $(this).val().trim();
        if (!nameRegex.test(val)) {
            showError(this, "Enter valid name (min 3 letters)");
        } else {
            clearError(this);
        }
    });

    // EMAIL
    $("[name='email']").on("blur", function () {
        const val = $(this).val().trim();
        if (!emailRegex.test(val)) {
            showError(this, "Enter valid email address");
        } else {
            clearError(this);
        }
    });

    // PASSWORD
    $("[name='password']").on("blur", function () {
        const val = $(this).val();
        if (!passwordRegex.test(val)) {
            showError(this, "Password must contain letter, number & special char");
        } else {
            clearError(this);
        }
    });

    // PHONE
    $("[name='phone']").on("blur", function () {
        const val = $(this).val().trim();
        if (!phoneRegex.test(val)) {
            showError(this, "Enter valid 10-digit Indian mobile number");
        } else {
            clearError(this);
        }
    });

    // DOB
    $("[name='dob']").on("blur", function () {
        const dob = $(this).val();
        if (!dob) {
            showError(this, "Please select your birth date");
            return;
        }

        const birthDate = new Date(dob);
        const today = new Date();

        let age = today.getFullYear() - birthDate.getFullYear();
        const m = today.getMonth() - birthDate.getMonth();
        if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
            age--;
        }

        if (age < 18 || age > 60) {
            showError(this, "Age must be between 18 and 60");
        } else {
            clearError(this);
        }
    });

    // GENDER
    $("[name='gender']").on("change", function () {
        clearGenderError();
    });

    // STATE
    $("[name='state']").on("blur change", function () {
        const val = $(this).val();
        if (!stateRegex.test(val)) {
            showError(this, "Please select a valid state");
        } else {
            clearError(this);
        }
    });

    // ---------- Helper functions ----------
    function showError(field, message) {
        $(field)
            .closest(".mb-3")
            .find(".error")
            .text(message);
    }

    function clearError(field) {
        $(field)
            .closest(".mb-3")
            .find(".error")
            .text("");
    }

    function clearGenderError() {
        $("[name='gender']")
            .closest(".mb-3")
            .find(".error")
            .text("");
    }

});
</script>

<script>
$(function () {

    const validationState = {
        name: false,
        email: false,
        password: false,
        phone: false,
        dob: false,
        gender: false,
        state: false
    };

    function updateButtonState() {
        const allValid = Object.values(validationState).every(v => v === true);
        $("#registerBtn").prop("disabled", !allValid);
    }

    function markValid(field) {
        validationState[field] = true;
        updateButtonState();
    }

    function markInvalid(field) {
        validationState[field] = false;
        updateButtonState();
    }

    // NAME
    $("[name='name']").on("blur", function () {
        const val = $(this).val().trim();
        if (/^[A-Za-z ]{3,50}$/.test(val)) {
            markValid("name");
        } else {
            markInvalid("name");
        }
    });

    // EMAIL
    $("[name='email']").on("blur", function () {
        const val = $(this).val().trim();
        if (/^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/.test(val)) {
            markValid("email");
        } else {
            markInvalid("email");
        }
    });

    // PASSWORD
    $("[name='password']").on("blur", function () {
        const val = $(this).val();
        if (/^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{6,}$/.test(val)) {
            markValid("password");
        } else {
            markInvalid("password");
        }
    });

    // PHONE
    $("[name='phone']").on("blur", function () {
        const val = $(this).val().trim();
        if (/^[6-9]\d{9}$/.test(val)) {
            markValid("phone");
        } else {
            markInvalid("phone");
        }
    });

    // DOB
    $("[name='dob']").on("blur", function () {
        const dob = $(this).val();
        if (!dob) {
            markInvalid("dob");
            return;
        }

        const birthDate = new Date(dob);
        const today = new Date();

        let age = today.getFullYear() - birthDate.getFullYear();
        const m = today.getMonth() - birthDate.getMonth();
        if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
            age--;
        }

        if (age >= 18 && age <= 60) {
            markValid("dob");
        } else {
            markInvalid("dob");
        }
    });

    // GENDER
    $("[name='gender']").on("change", function () {
        markValid("gender");
    });

    // STATE
    $("[name='state']").on("change blur", function () {
        const val = $(this).val();
        if (/^[A-Za-z ]{2,}$/.test(val)) {
            markValid("state");
        } else {
            markInvalid("state");
        }
    });

});
</script>


</body>
</html>
