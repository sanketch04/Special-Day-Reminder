/* ================= OTP PATH ================= */
function getAppContext() {
    return window.location.pathname.split("/")[1]
        ? "/" + window.location.pathname.split("/")[1]
        : "";
}

/* ================= OTP UI HELPERS ================= */
function showOtpMsg(msg, color) {
    const el = document.getElementById("otpMsg");
    if (!el) return;
    el.textContent = msg;
    el.style.color = color;
}

function showStep(stepId) {
    const otpBox = document.getElementById("otpBox");
    const registerFields = document.getElementById("registerFields");

    otpBox.classList.remove("show-step");
    registerFields.classList.remove("show-step");

    if (stepId === "otp") otpBox.classList.add("show-step");
    if (stepId === "form") registerFields.classList.add("show-step");
}

/* ================= OTP TIMER ================= */
let otpTime = 30;
let otpInterval = null;

function startOtpTimer() {
    otpTime = 30;

    const timerText = document.getElementById("timerText");
    const resendBtn = document.getElementById("resendBtn");

    resendBtn.classList.add("d-none");
    timerText.classList.remove("d-none");

    if (otpInterval) clearInterval(otpInterval);

    timerText.textContent = `Resend OTP in ${otpTime}s`;

    otpInterval = setInterval(() => {
        otpTime--;
        timerText.textContent = `Resend OTP in ${otpTime}s`;

        if (otpTime <= 0) {
            clearInterval(otpInterval);
            timerText.classList.add("d-none");
            resendBtn.classList.remove("d-none");
        }
    }, 1000);
}

/* ================= SEND OTP ================= */
function sendOtp() {
    const email = document.getElementById("email").value.trim();
    const sendBtn = document.getElementById("sendOtpBtn");

    if (!email) {
        showOtpMsg("Please enter email first", "red");
        return;
    }

    sendBtn.disabled = true;
    sendBtn.textContent = "Sending...";

    fetch(`${getAppContext()}/send-register-otp`, {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: `email=${encodeURIComponent(email)}`
    })
    .then(res => res.text())
    .then(res => {
        sendBtn.disabled = false;
        sendBtn.textContent = "Send OTP";

        if (res === "OTP_SENT") {
            document.getElementById("otpSection").style.display = "block";
            document.getElementById("email").readOnly = true;

            showOtpMsg("OTP sent to email ✅", "green");
            startOtpTimer();

            // focus first OTP box
            const firstOtp = document.querySelector(".otp-inputs input");
            if (firstOtp) firstOtp.focus();
        }
        else if (res === "ALREADY_REGISTERED") {
            showOtpMsg("Email already registered. Please login.", "red");
        }
        else {
            showOtpMsg("Failed to send OTP", "red");
        }
    })
    .catch(() => {
        sendBtn.disabled = false;
        sendBtn.textContent = "Send OTP";
        showOtpMsg("Server error", "red");
    });
}

/* ================= RESEND OTP ================= */
function resendOtp() {
    // just call send again
    sendOtp();
}

/* ================= COMBINE OTP BOXES ================= */
function getOtpFromBoxes() {
    const boxes = document.querySelectorAll(".otp-inputs input");
    let otp = "";
    boxes.forEach(b => otp += (b.value || ""));
    return otp;
}

/* ================= VERIFY OTP ================= */
function verifyOtp() {
    const email = document.getElementById("email").value.trim();
    const otp = getOtpFromBoxes();

    if (otp.length !== 6) {
        showOtpMsg("Please enter complete 6-digit OTP", "red");
        return;
    }

    fetch(`${getAppContext()}/verify-register-otp`, {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: `email=${encodeURIComponent(email)}&otp=${encodeURIComponent(otp)}`
    })
    .then(res => res.text())
    .then(res => {
        if (res === "VERIFIED") {
            showOtpMsg("Email verified successfully ✅", "green");

            // ✅ Switch step with animation
            document.getElementById("otpBox").classList.remove("show-step");
            document.getElementById("registerFields").classList.add("show-step");
        }
        else {
            showOtpMsg(res || "Invalid OTP", "red");
        }
    })
    .catch(() => showOtpMsg("Server error", "red"));
}

/* ================= OTP BOX UX (AUTO NEXT / BACKSPACE / PASTE) ================= */
document.addEventListener("DOMContentLoaded", () => {
    // show OTP step first
    showStep("otp");

    const otpInputs = document.querySelectorAll(".otp-inputs input");

    otpInputs.forEach((input, index) => {
        input.addEventListener("input", () => {
            input.value = input.value.replace(/[^0-9]/g, ""); // only digits

            if (input.value && index < otpInputs.length - 1) {
                otpInputs[index + 1].focus();
            }
        });

        input.addEventListener("keydown", (e) => {
            if (e.key === "Backspace" && !input.value && index > 0) {
                otpInputs[index - 1].focus();
            }
        });
    });

    // Paste support
    if (otpInputs.length > 0) {
        otpInputs[0].addEventListener("paste", (e) => {
            const paste = e.clipboardData.getData("text").trim();
            if (/^\d{6}$/.test(paste)) {
                otpInputs.forEach((inp, i) => inp.value = paste[i]);
                otpInputs[5].focus();
            }
        });
    }

    /* ================= PASSWORD SHOW/HIDE + STRENGTH ================= */
    const pwd = document.getElementById("password");
    const eye = document.getElementById("togglePassword");
    const bar = document.getElementById("strengthBar");

    if (pwd && eye) {
        eye.addEventListener("click", () => {
            pwd.type = pwd.type === "password" ? "text" : "password";
            eye.textContent = pwd.type === "password" ? "👁️" : "🙈";
        });
    }

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

/* ================= PROFILE PHOTO CROP + ADJUST ================= */
let cropper = null;
let selectedFile = null;

const fileInput = document.getElementById("profileImage");
const finalFileInput = document.getElementById("finalProfileImage");

const previewImg = document.getElementById("profilePreviewImg");
const placeholder = document.getElementById("profilePlaceholder");

const editBtn = document.getElementById("editPhotoBtn");
const removeBtn = document.getElementById("removePhotoBtn");

const cropModalEl = document.getElementById("cropModal");
const cropImageEl = document.getElementById("cropImage");

const modal = cropModalEl ? new bootstrap.Modal(cropModalEl) : null;

function enablePreviewUI() {
    if (editBtn) editBtn.disabled = false;
    if (removeBtn) removeBtn.style.display = "inline-block";
}

function resetPreviewUI() {
    if (previewImg) {
        previewImg.src = "";
        previewImg.style.display = "none";
    }
    if (placeholder) placeholder.style.display = "flex";
    if (editBtn) editBtn.disabled = true;
    if (removeBtn) removeBtn.style.display = "none";
    if (fileInput) fileInput.value = "";
    if (finalFileInput) finalFileInput.value = "";
    selectedFile = null;
}

function openCropper(file) {
    const url = URL.createObjectURL(file);
    cropImageEl.src = url;

    modal.show();

    // Wait a moment for modal to render properly
    setTimeout(() => {
        if (cropper) cropper.destroy();

        cropper = new Cropper(cropImageEl, {
            aspectRatio: 1,          // ✅ square crop
            viewMode: 1,
            dragMode: "move",
            autoCropArea: 1,
            responsive: true,
            background: false,
            guides: false
        });
    }, 200);
}

/* Choose new photo -> open crop */
if (fileInput) {
    fileInput.addEventListener("change", () => {
        const file = fileInput.files[0];
        if (!file) return;

        if (!file.type.startsWith("image/")) {
            alert("Please select a valid image file.");
            fileInput.value = "";
            return;
        }

        selectedFile = file;
        openCropper(file);
    });
}

/* Edit button -> re-open cropper */
if (editBtn) {
    editBtn.addEventListener("click", () => {
        if (!selectedFile) return;
        openCropper(selectedFile);
    });
}

/* Remove */
if (removeBtn) {
    removeBtn.addEventListener("click", () => {
        resetPreviewUI();
    });
}

/* Crop controls */
document.getElementById("zoomInBtn")?.addEventListener("click", () => cropper?.zoom(0.1));
document.getElementById("zoomOutBtn")?.addEventListener("click", () => cropper?.zoom(-0.1));
document.getElementById("rotateLeftBtn")?.addEventListener("click", () => cropper?.rotate(-90));
document.getElementById("rotateRightBtn")?.addEventListener("click", () => cropper?.rotate(90));
document.getElementById("resetBtn")?.addEventListener("click", () => cropper?.reset());

/* Save cropped image */
document.getElementById("saveCropBtn")?.addEventListener("click", async () => {
    if (!cropper) return;

    const canvas = cropper.getCroppedCanvas({
        width: 400,
        height: 400,
        imageSmoothingQuality: "high"
    });

    // Show preview in circle
    if (previewImg) {
        previewImg.src = canvas.toDataURL("image/png");
        previewImg.style.display = "block";
    }
    if (placeholder) placeholder.style.display = "none";

    // Convert canvas -> Blob -> File
    canvas.toBlob((blob) => {
        if (!blob) return;

        const croppedFile = new File([blob], "profile.png", { type: "image/png" });

        // Put cropped file into hidden input so it will be submitted
        const dt = new DataTransfer();
        dt.items.add(croppedFile);
        finalFileInput.files = dt.files;

        enablePreviewUI();
        modal.hide();
    }, "image/png", 0.95);
});

/* Destroy cropper when modal closes */
cropModalEl?.addEventListener("hidden.bs.modal", () => {
    if (cropper) {
        cropper.destroy();
        cropper = null;
    }
});

