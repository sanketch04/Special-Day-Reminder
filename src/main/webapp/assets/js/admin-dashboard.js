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

document.addEventListener("DOMContentLoaded", () => {

    /* ============================
       REVEAL ANIMATION TRIGGER
    ============================ */
    const reveals = document.querySelectorAll(".reveal");

    setTimeout(() => {
        reveals.forEach(el => el.classList.add("active"));
    }, 150);

});

// Subtle avatar tilt based on mouse position
document.querySelectorAll(".profile-mini").forEach(el => {
    el.addEventListener("mousemove", e => {
        const rect = el.getBoundingClientRect();
        const x = e.clientX - rect.left - rect.width / 2;
        const y = e.clientY - rect.top - rect.height / 2;

        el.style.transform =
            `rotateX(${(-y / 12)}deg) rotateY(${(x / 12)}deg)`;
    });

    el.addEventListener("mouseleave", () => {
        el.style.transform = "rotateX(0) rotateY(0)";
    });
});

/* =========================================
   KPI COUNTER FIX (PRODUCTION SAFE)
========================================= */

document.addEventListener("DOMContentLoaded", () => {

    const counters = document.querySelectorAll(".kpi-counter");
    const animated = new Set();

    const animateCounter = (counter) => {
        if (animated.has(counter)) return;

        const target = parseInt(counter.dataset.value || "0", 10);
        let current = 0;
        const duration = 900;
        const startTime = performance.now();

        const update = (now) => {
            const progress = Math.min((now - startTime) / duration, 1);
            const ease = 1 - Math.pow(1 - progress, 3); // easeOutCubic

            current = Math.floor(ease * target);
            counter.textContent = current;

            if (progress < 1) {
                requestAnimationFrame(update);
            } else {
                counter.textContent = target;
                animated.add(counter);
            }
        };

        requestAnimationFrame(update);
    };

    /* Animate immediately */
    counters.forEach(animateCounter);
});

