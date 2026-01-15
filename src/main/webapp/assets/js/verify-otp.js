const inputs = document.querySelectorAll(".otp-inputs input");
const timerEl = document.getElementById("timer");
const resendLink = document.getElementById("resendLink");

inputs[0].focus();

/* AUTO MOVE */
inputs.forEach((input, index) => {
    input.addEventListener("input", () => {
        if (input.value && index < inputs.length - 1) {
            inputs[index + 1].focus();
        }
    });

    input.addEventListener("keydown", e => {
        if (e.key === "Backspace" && !input.value && index > 0) {
            inputs[index - 1].focus();
        }
    });
});

/* PASTE SUPPORT */
inputs[0].addEventListener("paste", e => {
    const paste = e.clipboardData.getData("text").trim();
    if (paste.length === 6) {
        inputs.forEach((input, i) => input.value = paste[i]);
    }
});

/* COMBINE OTP */
function combineOtp() {
    let otp = "";
    inputs.forEach(i => otp += i.value);

    if (otp.length !== 6) {
        alert("Please enter complete OTP");
        return false;
    }

    document.getElementById("otp").value = otp;
    document.getElementById("confirmOtp").value = otp;
    return true;
}

/* RESEND TIMER */
let time = 30;
const interval = setInterval(() => {
    time--;
    timerEl.textContent = `Resend OTP in ${time}s`;

    if (time <= 0) {
        clearInterval(interval);
        timerEl.classList.add("d-none");
        resendLink.classList.remove("d-none");
    }
}, 1000);
