
/* ===== FADE-UP ON SCROLL ===== */
const fadeElements = document.querySelectorAll(".fade-up");

const observer = new IntersectionObserver(entries => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.classList.add("visible");
        }
    });
}, { threshold: 0.2 });

fadeElements.forEach(el => observer.observe(el));

/* ===== EVENT CARD ENTRY ANIMATION ===== */
window.addEventListener("load", () => {
    document.querySelectorAll(".animate-left, .animate-up, .animate-right")
        .forEach(card => {
            setTimeout(() => {
                card.classList.add("animate-show");
            }, 200);
        });
});

/* ===== THEME TOGGLE ===== */
function toggleTheme() {
    document.body.classList.toggle("theme-light");
    document.body.classList.toggle("theme-dark");
}

/* ===== MOBILE NAV TOGGLE ===== */
function toggleNav() {
    const nav = document.getElementById("navLinks");
    if (nav) {
        nav.classList.toggle("open");
    }
}


