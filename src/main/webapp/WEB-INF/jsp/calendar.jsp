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
    z-index:1000;">


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






<script src="${pageContext.request.contextPath}/assets/js/calendar.js"></script>

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
   GLOBAL STATE
======================= */

const APP_CTX = "<%= request.getContextPath() %>";

/* =======================
   EMAIL TOGGLE
======================= */
document.getElementById("enableEmail").onchange = function () {
    const emailDiv = document.getElementById("emailOptions");
    emailDiv.style.display = this.checked ? "block" : "none";

    if (this.checked) {
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
   FESTIVAL IMAGES (FIXED)
======================= */
function loadFestivalImagesByMonth(monthIndex) {

    fetch(APP_CTX + "/api/festivals?month=" + monthIndex)
        .then(res => res.json())
        .then(cards => {
            const defaults = [
                APP_CTX + "/assets/festivals/default/default1.jpg",
                APP_CTX + "/assets/festivals/default/default2.jpg",
                APP_CTX + "/assets/festivals/default/default3.jpg"
            ];

            ["img1","img2","img3"].forEach((id, i) => {
                const img = document.getElementById(id);
                if (!img) return;

                img.src = cards[i]?.imageUrl || defaults[i];
            });
        });

}


/* =======================
   LOAD EVENTS
======================= */
function loadAdminEvents(monthIndex) {
    return fetch(APP_CTX + "/admin/api/events?month=" + (monthIndex + 1))
        .then(res => res.json())
        .then(data => adminEvents = data || []);
}

function loadHolidayEvents(year, monthIndex) {
    return fetch(
        APP_CTX + "/admin/api/holidays?year=" + year + "&month=" + (monthIndex + 1)
    )
    .then(res => res.json())
    .then(data => {
        (data || []).forEach(h => {
            adminEvents.push({
                eventDay: h.eventDay,
                eventMonth: h.eventMonth,
                title: h.title,
                category: "HOLIDAY"
            });
        });
    });
}

/* =======================
   MODAL
======================= */
function openModal(date) {
    document.getElementById("eventDate").value = date;
    document.getElementById("eventModal").style.display = "block";
}
function closeModal() {
    document.getElementById("eventModal").style.display = "none";
}

/* =======================
   PAGE LOAD (FINAL)
======================= */
window.onload = function () {

    yearSelect = document.getElementById("yearSelect");
    monthSelect = document.getElementById("monthSelect");
    calendarBody = document.getElementById("calendarBody");

    for (let y = 2000; y <= 2099; y++) {
        yearSelect.add(new Option(y, y));
    }

    const today = new Date();
    yearSelect.value = today.getFullYear();
    monthSelect.value = today.getMonth();

    function reloadCalendar() {
        adminEvents = [];

        const year = Number(yearSelect.value);
        const month = Number(monthSelect.value); // 0–11 ONLY

        loadAdminEvents(month)
            .then(() => loadHolidayEvents(year, month))
            .then(() => {
                generateCalendar(year, month);
                loadFestivalImagesByMonth(month);
            });
    }

    reloadCalendar();
    monthSelect.onchange = reloadCalendar;
    yearSelect.onchange = reloadCalendar;
};
</script>