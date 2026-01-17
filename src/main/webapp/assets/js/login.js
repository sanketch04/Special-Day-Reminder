/* ================= THEME HANDLED BY theme_change.js ================= */
/* ================= DOM READY ================= */
/* ================= DOM READY ================= */
document.addEventListener("DOMContentLoaded", () => {

    const emailInput = document.getElementById("email");
    const passwordInput = document.getElementById("password");
    const rememberMe = document.getElementById("rememberMe");
    const loginBtn = document.getElementById("loginBtn");

    /* REMEMBER ME */
    const savedEmail = localStorage.getItem("email");
    if (savedEmail && emailInput) {
        emailInput.value = savedEmail;
        if (rememberMe) rememberMe.checked = true;
    }

    /* AUTO HIDE ERROR */
    setTimeout(() => {
        document.querySelectorAll(".auto-hide").forEach(e => e.remove());
    }, 5000);

});

/* ================= PASSWORD VISIBILITY ================= */
function showPassword() {
    const pwd = document.getElementById("password");
    if (pwd) pwd.type = "text";
}

function hidePassword() {
    const pwd = document.getElementById("password");
    if (pwd) pwd.type = "password";
}

/* ================= PASSWORD STRENGTH ================= */
function checkStrength() {
    const pwd = document.getElementById("password");
    const strength = document.getElementById("strength");

    if (!pwd || !strength) return;

    if (pwd.value.length < 4) {
        strength.textContent = "Weak";
        strength.style.color = "#ef4444";
    } else if (pwd.value.length < 8) {
        strength.textContent = "Medium";
        strength.style.color = "#f59e0b";
    } else {
        strength.textContent = "Strong";
        strength.style.color = "#22c55e";
    }
}

/* ================= LOGIN SUBMIT + PAGE TRANSITION ================= */
function handleSubmit() {

    const btn = document.getElementById("loginBtn");
    const spinner = btn?.querySelector(".spinner-border");
    const text = btn?.querySelector(".btn-text");

    const email = document.getElementById("email");
    const remember = document.getElementById("rememberMe");

    if (spinner) spinner.classList.remove("d-none");   // ✅ FIXED
    if (text) text.textContent = "Logging in...";
    if (btn) btn.disabled = true;

    if (remember?.checked && email) {
        localStorage.setItem("email", email.value);
    } else {
        localStorage.removeItem("email");
    }

    /* PAGE EXIT ANIMATION */
    document.body.classList.add("page-exit");

    /* DELAY SUBMIT */
    setTimeout(() => {
        document.forms[0].submit();
    }, 450);

    return false; // prevent instant submit
}

function toggleMenu() {
    const menu = document.getElementById("menuPopup");
    menu.classList.toggle("show");
}


