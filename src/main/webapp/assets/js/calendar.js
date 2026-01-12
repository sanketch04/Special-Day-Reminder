
/* =======================
   GLOBAL STATE
======================= */
let adminEvents = [];
let yearSelect, monthSelect, calendarBody;

const APP_CTX = "<%= request.getContextPath() %>";

/* =======================
   CALENDAR RENDER
======================= */
function generateCalendar(year, month) {

    calendarBody.innerHTML = "";

    year = parseInt(year);
    month = parseInt(month);

    const firstDay = new Date(year, month, 1).getDay();
    const daysInMonth = new Date(year, month + 1, 0).getDate();

    let cells = 0;

    // Empty cells
    for (let i = 0; i < firstDay; i++) {
        calendarBody.appendChild(document.createElement("div"));
        cells++;
    }

    // Days
    for (let d = 1; d <= daysInMonth; d++) {

        const dayDiv = document.createElement("div");
        dayDiv.className = "day";
        dayDiv.dataset.date = year + "-" + (month + 1) + "-" + d;

        dayDiv.onclick = () => openModal(dayDiv.dataset.date);

        const num = document.createElement("div");
        num.className = "date-number";
        num.textContent = d;
        dayDiv.appendChild(num);

        // Highlight today
        const now = new Date();
        if (
            d === now.getDate() &&
            month === now.getMonth() &&
            year === now.getFullYear()
        ) {
            dayDiv.classList.add("today");
        }

        // Show events
        adminEvents.forEach(ev => {
            if (ev.eventDay === d && ev.eventMonth === (month + 1)) {
                dayDiv.style.background = "#fff3e0";
                dayDiv.style.borderLeft = "4px solid #ff9800";

                const e = document.createElement("div");
                e.className = "event-chip event-" + (ev.category || "OTHER");
                e.textContent = ev.title;

                // Action icons
                const actions = document.createElement("div");
                actions.className = "event-actions";
                actions.innerHTML = `
                    <span title="Edit">✏️</span>
                    <span title="Delete">🗑️</span>
                `;
                e.appendChild(actions);

                // Reminder badge
                if (ev.reminderDaysBefore > 0) {
                    const badge = document.createElement("div");
                    badge.className = "reminder-badge";
                    badge.textContent = "⏰";
                    dayDiv.appendChild(badge);
                }

                dayDiv.appendChild(e);

            }
        });

        calendarBody.appendChild(dayDiv);
        cells++;
    }

    while (cells % 7 !== 0) {
        calendarBody.appendChild(document.createElement("div"));
        cells++;
    }
}

/* =======================
   LIVE ADD EVENT
======================= */
function addEventToCalendar(dateStr, title) {

    const [year, month, day] = dateStr.split("-").map(Number);

    adminEvents.push({
        eventDay: day,
        eventMonth: month,
        title: title
    });

    generateCalendar(yearSelect.value, monthSelect.value);
}

/* =======================
   PAGE LOAD
======================= */
window.onload = function () {

    yearSelect = document.getElementById("yearSelect");
    monthSelect = document.getElementById("monthSelect");
    calendarBody = document.getElementById("calendarBody");

    // Populate years
    for (let y = 2000; y <= 2099; y++) {
        const opt = document.createElement("option");
        opt.value = y;
        opt.textContent = y;
        yearSelect.appendChild(opt);
    }

    const today = new Date();
    yearSelect.value = today.getFullYear();
    monthSelect.value = today.getMonth();

    function loadAdminEvents(monthIndex) {
        const month = Number(monthIndex) + 1;
        const url = APP_CTX + "/admin/api/events?month=" + month;

        return fetch(url)
            .then(res => res.json())
            .then(data => adminEvents = data || [])
            .catch(err => console.error(err));
    }

    loadAdminEvents(monthSelect.value).then(() => {
        generateCalendar(yearSelect.value, monthSelect.value);
    });

    yearSelect.onchange = () =>
        loadAdminEvents(monthSelect.value).then(() =>
            generateCalendar(yearSelect.value, monthSelect.value)
        );

    monthSelect.onchange = () =>
        loadAdminEvents(monthSelect.value).then(() =>
            generateCalendar(yearSelect.value, monthSelect.value)
        );
};

/* =======================
   MODAL
======================= */
function openModal(date) {
    const [y, m, d] = date.split("-");
    document.getElementById("eventDate").value =
        y + "-" + m.padStart(2, "0") + "-" + d.padStart(2, "0");

    document.getElementById("eventModal").style.display = "block";
}

function closeModal() {
    document.getElementById("eventModal").style.display = "none";
}

function clearModalFields() {
    document.getElementById("eventTitle").value = "";
    document.getElementById("eventDesc").value = "";
    document.getElementById("reminderDays").value = 1;
    document.getElementById("eventCategory").selectedIndex = 0;
}

/* =======================
   SAVE EVENT
======================= */
function saveEvent() {

    const date = document.getElementById("eventDate").value;
    const title = document.getElementById("eventTitle").value;

    const params = new URLSearchParams({
        eventDate: date,
        title: title,
        category: document.getElementById("eventCategory").value,
        description: document.getElementById("eventDesc").value,
        reminderDaysBefore: document.getElementById("reminderDays").value
    });

    fetch(APP_CTX + "/event/save", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: params.toString()
    })
    .then(res => res.text())
    .then(data => {

        const result = (data || "").trim().toUpperCase();

        if (result.includes("SUCCESS")) {
            addEventToCalendar(date, title);
            alert("Event saved successfully");
            clearModalFields();
            closeModal();
        }
        else if (result.includes("NOT_LOGGED_IN")) {
            alert("Please login again");
        }
        else {
            alert("Failed to save event");
        }
    })
    .catch(err => console.error(err));
}


/* =======================
   AI CHAT TOGGLE
======================= */
function toggleAIChat() {
    const panel = document.getElementById("ai-chat-panel");
    if (panel) {
        panel.classList.toggle("open");
    }
}






