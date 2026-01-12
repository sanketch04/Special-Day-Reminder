/* ================= PROFILE DROPDOWN ================= */
function toggleProfileDropdown() {
    document.getElementById("profileMenu").classList.toggle("open");
}

/* Close dropdown on outside click */
document.addEventListener("click", function (e) {
    const dropdown = document.querySelector(".profile-dropdown");
    if (dropdown && !dropdown.contains(e.target)) {
        document.getElementById("profileMenu")?.classList.remove("open");
    }
});

/* ================= THEME SYSTEM (GLOBAL) ================= */
function applyTheme(theme) {
    document.body.classList.remove("theme-light", "theme-dark");
    document.body.classList.add(theme);
}

function toggleTheme() {
    const current = localStorage.getItem("theme") || "theme-light";
    const next = current === "theme-light" ? "theme-dark" : "theme-light";

    localStorage.setItem("theme", next);
    applyTheme(next);
}

/* Apply saved theme on page load */
document.addEventListener("DOMContentLoaded", function () {
    const savedTheme = localStorage.getItem("theme") || "theme-light";
    applyTheme(savedTheme);
});
