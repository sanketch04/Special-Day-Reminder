const fadeElements = document.querySelectorAll(".fade-up");

const observer = new IntersectionObserver(entries => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.classList.add("visible");
        }
    });
}, { threshold: 0.2 });

fadeElements.forEach(el => observer.observe(el));

document.addEventListener("DOMContentLoaded", () => {

    document.querySelectorAll(".kpi-counter").forEach(counter => {

        const target = parseInt(counter.dataset.value || "0", 10);
        let count = 0;

        const increment = Math.max(1, Math.floor(target / 40));

        const timer = setInterval(() => {
            count += increment;
            if (count >= target) {
                counter.textContent = target;
                clearInterval(timer);
            } else {
                counter.textContent = count;
            }
        }, 30);

    });

});

document.querySelectorAll(".kpi-card").forEach(card => {
    card.addEventListener("mouseenter", () => {
        card.style.outline = "2px solid rgba(99,102,241,0.4)";
        card.style.outlineOffset = "4px";
    });
    card.addEventListener("mouseleave", () => {
        card.style.outline = "none";
    });
});