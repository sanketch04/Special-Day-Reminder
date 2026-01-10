const themes = [
    { name: "theme-default", btn: "rgba(255,255,255,0.9)" },
    { name: "theme-dark", btn: "rgba(200,200,200,0.8)" },
    { name: "theme-instagram", btn: "rgba(255,85,120,0.9)" },
    { name: "theme-google", btn: "rgba(66,133,244,0.9)" },
    { name: "theme-hacker", btn: "rgba(0,255,0,0.75)" },
    { name: "theme-neon", btn: "rgba(0,240,255,0.85)" }
];

let currentTheme = localStorage.getItem("themeIndex") || 0;

function applyTheme() {
    document.body.className = themes[currentTheme].name;
    document.documentElement.style.setProperty("--btn-color", themes[currentTheme].btn);
    localStorage.setItem("themeIndex", currentTheme);
}

applyTheme();

function toggleTheme() {
    currentTheme = (currentTheme + 1) % themes.length;
    applyTheme();
}

/* PASSWORD HOLD */
function showPassword() {
    password.type = "text";
}
function hidePassword() {
    password.type = "password";
}

/* PASSWORD STRENGTH */
function checkStrength() {
    const s = document.getElementById("strength");
    if (password.value.length < 4) s.textContent = "Weak";
    else if (password.value.length < 8) s.textContent = "Medium";
    else s.textContent = "Strong";
}

/* REMEMBER ME */
window.onload = () => {
    const saved = localStorage.getItem("email");
    if (saved) email.value = saved;
};

function handleSubmit() {
    const btn = document.getElementById("loginBtn");
    btn.querySelector(".spinner-border").classList.remove("d-none");
    btn.querySelector(".btn-text").textContent = "Logging in...";

    if (rememberMe.checked) {
        localStorage.setItem("email", email.value);
    } else {
        localStorage.removeItem("email");
    }
    return true;
}

/* AUTO HIDE ERROR */
setTimeout(() => {
    document.querySelectorAll(".auto-hide").forEach(e => e.remove());
}, 5000);
