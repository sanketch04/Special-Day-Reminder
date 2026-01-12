/* =====================================================
   THEME HANDLING (FIXED & SAFE)
===================================================== */


function toggleTheme() {
    currentTheme = (currentTheme + 1) % themes.length;
    applyTheme();
}

(function () {
    const THEMES = ["theme-light", "theme-dark"];
    let savedTheme = localStorage.getItem("theme");

    if (!savedTheme || !THEMES.includes(savedTheme)) {
        savedTheme = "theme-light";
        localStorage.setItem("theme", savedTheme);
    }

    // Apply theme safely (DO NOT overwrite other classes)
    document.body.classList.remove(...THEMES);
    document.body.classList.add(savedTheme);
})();

/* Optional: if navbar theme button exists */
function toggleTheme() {
    const THEMES = ["theme-light", "theme-dark"];
    let current = localStorage.getItem("theme") || "theme-light";

    const next = current === "theme-light" ? "theme-dark" : "theme-light";

    document.body.classList.remove(...THEMES);
    document.body.classList.add(next);

    localStorage.setItem("theme", next);
}

/* =====================================================
   OTP LOGIC (UNCHANGED FUNCTIONALITY)
===================================================== */

function sendOtp() {
    const email = document.getElementById("email").value.trim();

    if (!email) {
        showOtpMsg("Please enter email first", "red");
        return;
    }

    fetch(`${window.location.pathname.split("/")[1] ? "/" + window.location.pathname.split("/")[1] : ""}/send-register-otp`, {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: `email=${encodeURIComponent(email)}`
    })
    .then(res => res.text())
    .then(res => {
        if (res === "OTP_SENT") {
            document.getElementById("otpSection").style.display = "block";
            showOtpMsg("OTP sent to email", "green");
        }
        else if (res === "ALREADY_REGISTERED") {
            showOtpMsg("Email already registered. Please login.", "red");
        }
        else {
            showOtpMsg("Failed to send OTP", "red");
        }
    })
    .catch(() => showOtpMsg("Server error", "red"));
}

function verifyOtp() {
    const email = document.getElementById("email").value.trim();
    const otp = document.getElementById("otp").value.trim();

    if (!otp) {
        showOtpMsg("Please enter OTP", "red");
        return;
    }

    fetch(`${window.location.pathname.split("/")[1] ? "/" + window.location.pathname.split("/")[1] : ""}/verify-register-otp`, {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: `email=${encodeURIComponent(email)}&otp=${encodeURIComponent(otp)}`
    })
    .then(res => res.text())
    .then(res => {
        if (res === "VERIFIED") {
            showOtpMsg("Email verified successfully ✅", "green");
            document.getElementById("registerBtn").disabled = false;
        }
        else {
            showOtpMsg(res || "Invalid OTP", "red");
        }
    })
    .catch(() => showOtpMsg("Server error", "red"));
}

function showOtpMsg(msg, color) {
    const el = document.getElementById("otpMsg");
    if (!el) return;
    el.textContent = msg;
    el.style.color = color;
}

/* =====================================================
   BASIC CLIENT-SIDE VALIDATION (NON-BREAKING)
===================================================== */

document.addEventListener("DOMContentLoaded", () => {
    const form = document.getElementById("registerForm");
    if (!form) return;

    form.addEventListener("submit", e => {
        let valid = true;

        form.querySelectorAll("input[required], select[required]").forEach(input => {
            const error = input.closest(".mb-3")?.querySelector(".error");
            if (!input.value.trim()) {
                if (error) error.textContent = "This field is required";
                valid = false;
            } else {
                if (error) error.textContent = "";
            }
        });

        if (!valid) e.preventDefault();
    });
});

/* ================= THEME ================= */
(function () {
    const themes = ["theme-light", "theme-dark"];
    const saved = localStorage.getItem("theme") || "theme-light";
    document.body.classList.remove(...themes);
    document.body.classList.add(saved);
})();

function toggleTheme() {
    const current = localStorage.getItem("theme") || "theme-light";
    const next = current === "theme-light" ? "theme-dark" : "theme-light";
    document.body.classList.remove("theme-light", "theme-dark");
    document.body.classList.add(next);
    localStorage.setItem("theme", next);
}

/* ================= SHOW / HIDE PASSWORD ================= */
document.addEventListener("DOMContentLoaded", () => {
    const pwd = document.getElementById("password");
    const eye = document.getElementById("togglePassword");

    if (pwd && eye) {
        eye.addEventListener("click", () => {
            pwd.type = pwd.type === "password" ? "text" : "password";
            eye.textContent = pwd.type === "password" ? "👁️" : "🙈";
        });
    }

    /* ================= PASSWORD STRENGTH ================= */
	/* ================= PASSWORD STRENGTH ================= */
    const bar = document.getElementById("strengthBar");

    if (pwd && bar) {
        pwd.addEventListener("input", () => {
            const val = pwd.value;
            let score = 0;

            if (val.length >= 6) score++;
            if (/[A-Z]/.test(val)) score++;
            if (/[0-9]/.test(val)) score++;
            if (/[^A-Za-z0-9]/.test(val)) score++;

            bar.className = "";
            if (score <= 1) {
                bar.style.width = "30%";
                bar.classList.add("strength-weak");
            } else if (score === 2 || score === 3) {
                bar.style.width = "65%";
                bar.classList.add("strength-medium");
            } else {
                bar.style.width = "100%";
                bar.classList.add("strength-strong");
            }
        });
    }
});

