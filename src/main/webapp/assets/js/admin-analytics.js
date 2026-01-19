document.addEventListener("DOMContentLoaded", () => {

    const data = window.analyticsData || {};

    /* ======================
       USER GROWTH (LINE)
    ====================== */
    const userChartEl = document.getElementById("userChart");
    if (userChartEl) {
        new Chart(userChartEl, {
            type: "line",
            data: {
                labels: ["Start", "Current"],
                datasets: [{
                    label: "Users",
                    data: [0, data.totalUsers || 0],
                    borderColor: "#22c55e",
                    backgroundColor: "rgba(34,197,94,0.2)",
                    tension: 0.4,
                    fill: true,
                    pointRadius: 5
                }]
            },
            options: baseLineOptions()
        });
    }

    /* ======================
       EVENT DISTRIBUTION (DOUGHNUT)
    ====================== */
    const eventChartEl = document.getElementById("eventChart");
    if (eventChartEl) {
        const adminEvents = data.adminEvents || 0;
        const userEvents = Math.max((data.totalEvents || 0) - adminEvents, 0);

        new Chart(eventChartEl, {
            type: "doughnut",
            data: {
                labels: ["Admin Events", "User Events"],
                datasets: [{
                    data: [adminEvents, userEvents],
                    backgroundColor: ["#a78bfa", "#60a5fa"],
                    borderWidth: 0,
                    cutout: "65%"
                }]
            },
            options: basePieOptions()
        });
    }

    /* ======================
       EMAIL SCHEDULING (BAR)
    ====================== */
    const emailChartEl = document.getElementById("emailChart");
    if (emailChartEl) {
        new Chart(emailChartEl, {
            type: "bar",
            data: {
                labels: ["Emails"],
                datasets: [{
                    label: "Scheduled Emails",
                    data: [data.totalEmails || 0],
                    backgroundColor: "#fb923c",
                    borderRadius: 10
                }]
            },
            options: baseBarOptions()
        });
    }

    /* ======================
       DAYS PLANNED (AREA / OGIVE-LIKE)
    ====================== */
    const dayChartEl = document.getElementById("dayChart");
    if (dayChartEl) {
        new Chart(dayChartEl, {
            type: "line",
            data: {
                labels: ["Planned"],
                datasets: [{
                    label: "Days Planned",
                    data: [data.totalDays || 0],
                    borderColor: "#facc15",
                    backgroundColor: "rgba(250,204,21,0.3)",
                    fill: true,
                    tension: 0.3,
                    pointRadius: 6
                }]
            },
            options: baseLineOptions()
        });
    }

});

/* ======================
   COMMON OPTIONS
====================== */

function baseBarOptions() {
    return {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            legend: { display: false },
            tooltip: tooltipStyle()
        },
        scales: {
            y: baseYAxis(),
            x: baseXAxis()
        }
    };
}

function baseLineOptions() {
    return {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            legend: { display: false },
            tooltip: tooltipStyle()
        },
        scales: {
            y: baseYAxis(),
            x: baseXAxis()
        }
    };
}

function basePieOptions() {
    return {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            legend: {
                position: "bottom",
                labels: {
                    color: "#e5e7eb",
                    padding: 16,
                    boxWidth: 14
                }
            },
            tooltip: tooltipStyle()
        }
    };
}

/* ======================
   SHARED AXES & TOOLTIP
====================== */

function baseYAxis() {
    return {
        beginAtZero: true,
        ticks: {
            color: "#e5e7eb",
            precision: 0
        },
        grid: {
            color: "rgba(255,255,255,0.06)"
        }
    };
}

function baseXAxis() {
    return {
        ticks: {
            color: "#e5e7eb"
        },
        grid: {
            display: false
        }
    };
}

function tooltipStyle() {
    return {
        backgroundColor: "#020617",
        titleColor: "#e5e7eb",
        bodyColor: "#e5e7eb",
        borderColor: "rgba(255,255,255,0.1)",
        borderWidth: 1
    };
}

document.addEventListener("DOMContentLoaded", () => {

    const cards = document.querySelectorAll(".analytics-reveal");

    const observer = new IntersectionObserver(
        entries => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add("active");
                }
            });
        },
        {
            threshold: 0.25
        }
    );

    cards.forEach(card => observer.observe(card));
});
