<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/calendar.css">
<!-- EVENT MODAL -->
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
					       readonly
					       style="width:100%"><br><br>
					
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

<script>
let adminEvents = [];
const APP_CTX = "<%= request.getContextPath() %>";

window.onload = function () {

    const yearSelect = document.getElementById("yearSelect");
    const monthSelect = document.getElementById("monthSelect");
    const calendarBody = document.getElementById("calendarBody");

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

    // 🔥 LOAD ADMIN EVENTS
    function loadAdminEvents(monthIndex) {
        const month = Number(monthIndex) + 1; // JS month → DB month
        const url = APP_CTX + "/admin/api/events?month=" + month;

        console.log("FETCHING:", url);

        return fetch(url)
            .then(res => res.json())
            .then(data => {
                console.log("ADMIN EVENTS:", data);
                adminEvents = data;
            })
            .catch(err => console.error(err));
    }

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

            dayDiv.onclick = function () {
                openModal(this.dataset.date);
            };

            const num = document.createElement("div");
            num.className = "date-number";
            num.textContent = d;
            dayDiv.appendChild(num);
            
            
         // ✅ HIGHLIGHT TODAY
            const now = new Date();
            if (
                d === now.getDate() &&
                month === now.getMonth() &&
                year === now.getFullYear()
            ) {
                dayDiv.classList.add("today");
            }


            // ✅ SHOW ADMIN EVENTS
            adminEvents.forEach(ev => {
                if (ev.eventDay === d && ev.eventMonth === (month + 1)) {
                    dayDiv.style.background = "#fff3e0";
                    dayDiv.style.borderLeft = "4px solid #ff9800";

                    const e = document.createElement("div");
                    e.style.fontSize = "12px";
                    e.style.color = "#e65100";
                    e.style.marginTop = "4px";
                    e.textContent = ev.title;
                    dayDiv.appendChild(e);
                }
            });

            calendarBody.appendChild(dayDiv);
            cells++;
        }

        // Fill remaining cells
        while (cells % 7 !== 0) {
            calendarBody.appendChild(document.createElement("div"));
            cells++;
        }
    }

    // 🔥 INITIAL LOAD
    loadAdminEvents(monthSelect.value).then(() => {
        generateCalendar(yearSelect.value, monthSelect.value);
    });

    yearSelect.onchange = () => {
        loadAdminEvents(monthSelect.value).then(() => {
            generateCalendar(yearSelect.value, monthSelect.value);
        });
    };

    monthSelect.onchange = () => {
        loadAdminEvents(monthSelect.value).then(() => {
            generateCalendar(yearSelect.value, monthSelect.value);
        });
    };
};

function openModal(date) {
    // date already comes as yyyy-M-d → normalize
    const parts = date.split("-");
    const formatted =
        parts[0] + "-" +
        parts[1].padStart(2, "0") + "-" +
        parts[2].padStart(2, "0");

    document.getElementById("eventDate").value = formatted;
    document.getElementById("eventModal").style.display = "block";
}


function closeModal() {
    document.getElementById("eventModal").style.display = "none";
}

function saveEvent() {

    const params = new URLSearchParams();
    params.append("eventDate", document.getElementById("eventDate").value);
    params.append("title", document.getElementById("eventTitle").value);
    params.append("category", document.getElementById("eventCategory").value);
    params.append("description", document.getElementById("eventDesc").value);
    params.append("reminderDaysBefore", document.getElementById("reminderDays").value);

    fetch("event/save", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: params.toString()
    })
    .then(res => res.text())
    .then(data => {
        if (data === "SUCCESS") {
            alert("Event saved successfully");
            closeModal();
            location.reload();
        } else if (data === "NOT_LOGGED_IN") {
            alert("Please login again");
        } else {
            alert("Failed to save event");
        }
    });
}


</script>

