<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/calendar.css">
<!-- EVENT MODAL -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">


<div id="eventModal" style="
    display:none;
    position:fixed;
    top:0; left:0;
    width:100%; height:100%;
    background:rgba(0,0,0,0.5);
    z-index:1000;
">

  <div style="
      background:#fff;
      width:400px;
      margin:100px auto;
      padding:20px;
      border-radius:6px;
      position:relative;
  ">

   		<h3>Add Event</h3>

					<label>Date</label><br>
					<input type="date"
						       id="eventDate"
						       name="eventDate"
						       style="width:100%">
						<br><br>
					
					<label>Title</label><br>
					<input type="text"
					       id="eventTitle"
					       name="title"
					       style="width:100%"><br><br>
					
					<label>Category</label><br>
							<select id="eventCategory"
							        name="category"
							        style="width:100%">
							    <option value="MEETING">Meeting</option>
							    <option value="HOLIDAY">Holiday</option>
							    <option value="REMINDER">Reminder</option>
							    <option value="PERSONAL">Personal</option>
							    <option value="BIRTHDAY">Birthday</option>
							    <option value="ANNIVERSARY">Anniversary</option>
							    <option value="FESTIVAL">Festival</option>
							    <option value="APPOINTMENT">Appointment</option>
							    <option value="EXAM">Exam</option>
							    <option value="INTERVIEW">Interview</option>
							    <option value="WORKSHOP">Workshop</option>
							    <option value="TRAINING">Training</option>
							    <option value="DEADLINE">Deadline</option>
							    <option value="PAYMENT">Payment / Bill Due</option>
							    <option value="TRAVEL">Travel</option>
							    <option value="EVENT">Special Event</option>
							    <option value="HEALTH">Health / Medical</option>
							    <option value="OTHER">Other</option>
							</select><br><br>
					<label>Description</label><br>
					<textarea id="eventDesc"
					          name="description"
					          style="width:100%"></textarea><br><br>
					
					<label>Reminder (Days Before)</label><br>
					<input type="number"
					       id="reminderDays"
					       name="reminderDaysBefore"
					       value="1"
					       min="0"
					       style="width:100%"><br><br>
					       
						<label>
					    <input type="checkbox" id="enableEmail">
					    Schedule Email
					</label><br><br>

				<div id="emailOptions" style="display:none">
				
				    <label>Receiver Email</label>
				    <input type="email"
				           id="receiverEmail"
				           name="receiverEmail"
				           style="width:100%"
				           required><br><br>
				
				    <label>Send Date</label>
				    <input type="date"
				           id="sendDate"
				           name="sendDate"
				           style="width:100%"
				           required><br><br>
				
				    <label>Send Time</label>
				    <input type="time"
				           id="sendTime"
				           name="sendTime"
				           style="width:100%"
				           required>
				</div>

					 
					
					<button onclick="saveEvent()">Save</button>
					<button onclick="closeModal()">Cancel</button>
				</div>
			</div>


<h2>Events Calendar</h2>

<div class="controls">
    <select id="yearSelect"></select>
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
</div>

<div class="calendar">

    <div class="calendar-header">
        <div>Sun</div>
        <div>Mon</div>
        <div>Tue</div>
        <div>Wed</div>
        <div>Thu</div>
        <div>Fri</div>
        <div>Sat</div>
    </div>

    <div class="calendar-body" id="calendarBody"></div>

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

<script>

document.getElementById("enableEmail").onchange = function () {
    const checked = this.checked;
    const emailDiv = document.getElementById("emailOptions");
    emailDiv.style.display = checked ? "block" : "none";

    if (checked) {
        document.getElementById("sendDate").value =
            document.getElementById("eventDate").value;
    }
};



function showNotification(text) {
    const n = document.createElement("div");
    n.className = "notify";
    n.innerText = text;
    document.getElementById("notify-container").appendChild(n);
    setTimeout(() => n.remove(), 4000);
}

/* =======================
AI CHAT FIX (GLOBAL BIND)
======================= */
window.toggleAIChat = function () {
 const panel = document.getElementById("ai-chat-panel");
 if (panel) {
     panel.classList.toggle("open");
 } else {
     console.error("AI Chat panel not found");
 }
};

/* =======================
AI BUTTON CLICK BIND
======================= */
document.addEventListener("DOMContentLoaded", function () {
 const btn = document.getElementById("ai-float-btn");
 if (btn) {
     btn.addEventListener("click", toggleAIChat);
 }
});


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
    const category = document.getElementById("eventCategory").value;
    const description = document.getElementById("eventDesc").value;
    const reminderDays = document.getElementById("reminderDays").value;

    const enableEmail = document.getElementById("enableEmail").checked;

    // 1️⃣ SAVE EVENT
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

        const result = (data || "").toUpperCase();
        if (!result.includes("SUCCESS")) {
            alert("Failed to save event");
            return;
        }

        // ✅ Event saved
        addEventToCalendar(date, title);
        showNotification("📅 Event saved");

        // 2️⃣ SCHEDULE EMAIL (ONLY IF ENABLED)
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