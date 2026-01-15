<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/calendar.css">
<!-- EVENT MODAL -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">


<div id="eventModal" style="
    display:none;
    position:fixed;
    inset:0;
    background:rgba(0,0,0,0.5);
    z-index:1000;
">

  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content p-3">

      <h4 class="mb-3">Add Event</h4>

      <div class="container-fluid">

        <!-- ROW 1 -->
        <div class="row mb-2">
          <div class="col-6">
            <label>Date</label>
            <input type="date" id="eventDate" class="form-control">
          </div>
          <div class="col-6">
            <label>Title</label>
            <input type="text" id="eventTitle" class="form-control">
          </div>
        </div>

        <!-- ROW 2 -->
        <div class="row mb-2">
          <div class="col-6">
            <label>Category</label>
            <select id="eventCategory" class="form-select">
              <option value="MEETING">Meeting</option>
              <option value="HOLIDAY">Holiday</option>
              <option value="REMINDER">Reminder</option>
              <option value="PERSONAL">Personal</option>
              <option value="BIRTHDAY">Birthday</option>
              <option value="ANNIVERSARY">Anniversary</option>
              <option value="OTHER">Other</option>
            </select>
          </div>
          <div class="col-6">
            <label>Reminder (Days)</label>
            <input type="number" id="reminderDays" value="1" min="0"
                   class="form-control">
          </div>
        </div>

        <!-- ROW 3 -->
        <div class="row mb-2">
          <div class="col-12">
            <label>Description</label>
            <textarea id="eventDesc" rows="2" class="form-control"></textarea>
          </div>
        </div>

        <!-- ROW 4 -->
        <div class="row mb-2">
          <div class="col-12">
            <input type="checkbox" id="enableEmail">
            <label class="ms-1">Schedule Email</label>
          </div>
        </div>

        <!-- EMAIL SECTION -->
        <div id="emailOptions" style="display:none">

          <!-- ROW 5 -->
          <div class="row mb-2">
            <div class="col-12">
              <label>Receiver Email</label>
              <input type="email" id="receiverEmail" class="form-control">
            </div>
          </div>

          <!-- ROW 6 -->
          <div class="row mb-2">
            <div class="col-6">
              <label>Send Date</label>
              <input type="date" id="sendDate" class="form-control">
            </div>
            <div class="col-6">
              <label>Send Time</label>
              <input type="time" id="sendTime" class="form-control">
            </div>
          </div>

        </div>

        <!-- ROW 7 -->
        <div class="row mt-3 text-end">
          <div class="col-12">
            <button class="btn btn-primary" onclick="saveEvent()">Save</button>
            <button class="btn btn-secondary" onclick="closeModal()">Cancel</button>
          </div>
        </div>

      </div>

    </div>
  </div>
</div>



<div class="calendar-top flicker-in">

    <div class="calendar-title">
        <div class="calendar-pro">
  <div class="cal-top"></div>

  <div class="ring left"></div>
  <div class="ring right"></div>

  <div class="page page1">
    <div class="dots">
      <span></span><span></span><span></span><span></span>
      <span></span><span></span><span></span><span></span>
      <span></span><span></span><span></span><span></span>
    </div>
  </div>

  <div class="page page2"></div>
</div>

</span>
        <h2>Events Calendar</h2>
    </div>

    <div class="calendar-controls glass">
        <select id="monthSelect">
            <option value="0">January</option>
            <option value="1">February</option>
            <option value="2">March</option>
            <option value="3">April</option>
            <option value="4">May</option>
            <option value="5">June</option>
            <option value="6">July</option>
            <option value="7">August</option>
            <option value="8">September</option>
            <option value="9">October</option>
            <option value="10">November</option>
            <option value="11">December</option>
        </select>

        <select id="yearSelect"></select>
    </div>

</div>


<div class="calendar calendar-container">

    <!-- Week header -->
    <div class="calendar-header calendar-week">
        <div>Sun</div>
        <div>Mon</div>
        <div>Tue</div>
        <div>Wed</div>
        <div>Thu</div>
        <div>Fri</div>
        <div>Sat</div>
    </div>

    <!-- Calendar grid -->
    <div class="calendar-body calendar-grid" id="calendarBody">
        <!-- JS injects .day cells here (UNCHANGED) -->
    </div>

</div>




<!-- ================= AI FLOATING BUTTON ================= -->
<div id="ai-float-btn">

    🤖
</div>

<!-- ================= AI CHAT PANEL ================= -->
<div id="ai-chat-panel">
    <div class="ai-chat-header">
        <span>ASmitra AI</span>
        <button onclick="toggleAIChat()">✕</button>
    </div>

    <iframe
        src="${pageContext.request.contextPath}/OpenAI/ai-chat"
        frameborder="0"
        class="ai-chat-iframe">
    </iframe>
</div>
<div id="notify-container"></div>


<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
  setInterval(() => {
    $(".calendar-pro").addClass("flip");

    setTimeout(() => {
      $(".calendar-pro").removeClass("flip");
    }, 700);
  }, 2500);
</script>

<script>
/* =======================
   EMAIL TOGGLE
======================= */
document.getElementById("enableEmail").onchange = function () {
    const checked = this.checked;
    const emailDiv = document.getElementById("emailOptions");
    emailDiv.style.display = checked ? "block" : "none";

    if (checked) {
        document.getElementById("sendDate").value =
            document.getElementById("eventDate").value;
    }
};

/* =======================
   NOTIFICATION
======================= */
function showNotification(text) {
    const n = document.createElement("div");
    n.className = "notify";
    n.innerText = text;
    document.getElementById("notify-container").appendChild(n);
    setTimeout(() => n.remove(), 4000);
}

/* =======================
   AI CHAT
======================= */
window.toggleAIChat = function () {
    const panel = document.getElementById("ai-chat-panel");
    if (panel) panel.classList.toggle("open");
};

document.addEventListener("DOMContentLoaded", function () {
    const btn = document.getElementById("ai-float-btn");
    if (btn) btn.addEventListener("click", toggleAIChat);
});

/* =======================
   GLOBAL STATE
======================= */
let adminEvents = [];
let yearSelect, monthSelect, calendarBody;

const APP_CTX = "<%= request.getContextPath() %>";

/* =======================
   CALENDAR RENDER (UNCHANGED)
======================= */
function generateCalendar(year, month) {

    calendarBody.innerHTML = "";
    year = parseInt(year);
    month = parseInt(month);

    const firstDay = new Date(year, month, 1).getDay();
    const daysInMonth = new Date(year, month + 1, 0).getDate();

    let cells = 0;

    for (let i = 0; i < firstDay; i++) {
        calendarBody.appendChild(document.createElement("div"));
        cells++;
    }

    for (let d = 1; d <= daysInMonth; d++) {

        const dayDiv = document.createElement("div");
        dayDiv.className = "day";
        dayDiv.dataset.date = year + "-" + (month + 1) + "-" + d;
        dayDiv.onclick = () => openModal(dayDiv.dataset.date);

        const num = document.createElement("div");
        num.className = "date-number";
        num.textContent = d;
        dayDiv.appendChild(num);

        const now = new Date();
        if (d === now.getDate() &&
            month === now.getMonth() &&
            year === now.getFullYear()) {
            dayDiv.classList.add("today");
        }

        adminEvents.forEach(ev => {
            if (ev.eventDay === d && ev.eventMonth === (month + 1)) {

                const e = document.createElement("div");
                e.className = "event-chip event-" + (ev.category || "OTHER");
                e.textContent = ev.title;

                if (ev.category !== "HOLIDAY") {
                    const actions = document.createElement("div");
                    actions.className = "event-actions";
                    actions.innerHTML = `<span>✏️</span><span>🗑️</span>`;
                    e.appendChild(actions);
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
   LOAD DB EVENTS (UNCHANGED)
======================= */
function loadAdminEvents(monthIndex) {
    const month = Number(monthIndex) + 1;
    const url = APP_CTX + "/admin/api/events?month=" + month;

    return fetch(url)
        .then(res => res.json())
        .then(data => adminEvents = data || []);
}

/* =======================
   LOAD HOLIDAYS (NEW – SAFE)
======================= */
function loadHolidayEvents(year, monthIndex) {

    const month = Number(monthIndex) + 1;
    const url =
        APP_CTX + "/admin/api/holidays?year=" + year + "&month=" + month;

    return fetch(url)
        .then(res => res.json())
        .then(data => {

            (data || []).forEach(h => {
                adminEvents.push({
                    eventDay: h.eventDay,
                    eventMonth: h.eventMonth,
                    title: h.title,
                    category: "HOLIDAY",
                    reminderDaysBefore: 0
                });
            });
        });
}

/* =======================
   PAGE LOAD (FLOW PRESERVED)
======================= */
window.onload = function () {

    yearSelect = document.getElementById("yearSelect");
    monthSelect = document.getElementById("monthSelect");
    calendarBody = document.getElementById("calendarBody");

    for (let y = 2000; y <= 2099; y++) {
        const opt = document.createElement("option");
        opt.value = y;
        opt.textContent = y;
        yearSelect.appendChild(opt);
    }

    const today = new Date();
    yearSelect.value = today.getFullYear();
    monthSelect.value = today.getMonth();

    function reloadCalendar() {
        adminEvents = [];
        loadAdminEvents(monthSelect.value)
            .then(() => loadHolidayEvents(yearSelect.value, monthSelect.value))
            .then(() => generateCalendar(yearSelect.value, monthSelect.value));
    }

    reloadCalendar();
    yearSelect.onchange = reloadCalendar;
    monthSelect.onchange = reloadCalendar;
};

/* =======================
   MODAL & SAVE (UNCHANGED)
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



/* =======================
SAVE EVENT (RESTORED – ORIGINAL FLOW)
======================= */
function saveEvent() {

 const date = document.getElementById("eventDate").value;
 const title = document.getElementById("eventTitle").value;
 const category = document.getElementById("eventCategory").value;
 const description = document.getElementById("eventDesc").value;
 const reminderDays = document.getElementById("reminderDays").value;

 const enableEmail = document.getElementById("enableEmail").checked;

 if (!date || !title) {
     alert("Date and title are required");
     return;
 }

 /* 1️⃣ SAVE EVENT TO DB (UNCHANGED) */
 const params = new URLSearchParams();
 params.append("eventDate", date);
 params.append("title", title);
 params.append("category", category);
 params.append("description", description);
 params.append("reminderDaysBefore", reminderDays);

 fetch(APP_CTX + "/event/save", {
     method: "POST",
     headers: { "Content-Type": "application/x-www-form-urlencoded" },
     body: params.toString()
 })
 .then(res => res.text())
 .then(data => {

     if (!data || !data.toUpperCase().includes("SUCCESS")) {
         alert("Failed to save event");
         return;
     }

     /* ✅ Add event instantly to UI */
     const [y, m, d] = date.split("-").map(Number);
     adminEvents.push({
         eventDay: d,
         eventMonth: m,
         title: title,
         category: category,
         reminderDaysBefore: reminderDays
     });

     generateCalendar(yearSelect.value, monthSelect.value);
     showNotification("📅 Event saved");

     /* 2️⃣ EMAIL SCHEDULING (UNCHANGED) */
     if (enableEmail) {

         const receiverEmail =
             document.getElementById("receiverEmail").value;
         const sendDate =
             document.getElementById("sendDate").value;
         const sendTime =
             document.getElementById("sendTime").value;

         if (!receiverEmail || !sendDate || !sendTime) {
             alert("Please fill email, date and time");
             return;
         }

         const emailParams = new URLSearchParams();
         emailParams.append("eventInfo", title);
         emailParams.append("receiverEmail", receiverEmail);
         emailParams.append("message", "Reminder for event: " + title);
         emailParams.append("sendDate", sendDate);
         emailParams.append("sendTime", sendTime);

         const now = new Date();
         const sendDateTime = new Date(sendDate + "T" + sendTime);

         if (sendDateTime <= now) {
             alert("Send time must be in the future");
             return;
         }

         fetch(APP_CTX + "/email/schedule", {
             method: "POST",
             headers: { "Content-Type": "application/x-www-form-urlencoded" },
             body: emailParams.toString()
         })
         .then(() => {
             showNotification("📧 Email scheduled");
         });
     }

     clearModalFields();
     closeModal();
 })
 .catch(err => console.error(err));
}

</script>
