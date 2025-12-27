$(function () {

    const nameRegex     = /^[A-Za-z ]{3,50}$/;
    const emailRegex    = /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/;
    const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{6,}$/;
    const phoneRegex    = /^[6-9]\d{9}$/;
    const stateRegex    = /^[A-Za-z ]{2,}$/;

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

    function showError(field, message) {
        $(field).closest(".mb-3").find(".error").text(message);
    }

    function clearError(field) {
        $(field).closest(".mb-3").find(".error").text("");
    }

    function clearGenderError() {
        $("[name='gender']").closest(".mb-3").find(".error").text("");
    }

    $("[name='name']").on("blur", function () {
        nameRegex.test(this.value.trim())
            ? (clearError(this), markValid("name"))
            : (showError(this, "Enter valid name (min 3 letters)"), markInvalid("name"));
    });

    $("[name='email']").on("blur", function () {
        emailRegex.test(this.value.trim())
            ? (clearError(this), markValid("email"))
            : (showError(this, "Enter valid email address"), markInvalid("email"));
    });

    $("[name='password']").on("blur", function () {
        passwordRegex.test(this.value)
            ? (clearError(this), markValid("password"))
            : (showError(this, "Password must contain letter, number & special char"), markInvalid("password"));
    });

    $("[name='phone']").on("blur", function () {
        phoneRegex.test(this.value.trim())
            ? (clearError(this), markValid("phone"))
            : (showError(this, "Enter valid 10-digit Indian mobile number"), markInvalid("phone"));
    });

    $("[name='dob']").on("blur", function () {
        const dob = this.value;
        if (!dob) return markInvalid("dob");

        const birthDate = new Date(dob);
        const today = new Date();
        let age = today.getFullYear() - birthDate.getFullYear();
        const m = today.getMonth() - birthDate.getMonth();
        if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) age--;

        (age >= 18 && age <= 60)
            ? (clearError(this), markValid("dob"))
            : (showError(this, "Age must be between 18 and 60"), markInvalid("dob"));
    });

    $("[name='gender']").on("change", function () {
        clearGenderError();
        markValid("gender");
    });

    $("[name='state']").on("change blur", function () {
        stateRegex.test(this.value)
            ? (clearError(this), markValid("state"))
            : (showError(this, "Please select a valid state"), markInvalid("state"));
    });

    $("#registerForm").on("submit", function (e) {
        if (!Object.values(validationState).every(v => v === true)) {
            e.preventDefault();
        }
    });

});
