<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            padding: 20px;
            color: #000;
        }

        .controls {
            margin-bottom: 20px;
        }

        select {
            padding: 6px;
            font-size: 14px;
        }

        .calendar {
            max-width: 900px;
            border: 1px solid #ccc;
        }

        /* Header */
        .calendar-header {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            background: #f2f2f2;
            border-bottom: 1px solid #ccc;
        }

        .calendar-header div {
            text-align: center;
            padding: 10px;
            font-weight: bold;
            color: #000 !important;
        }

        /* Body */
        .calendar-body {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            background: #fff;
        }

        .calendar-body > div {
            border: 1px solid #e0e0e0;
            height: 100px;
            padding: 6px;
            background: #fff;
            color: #000 !important;
        }

        .day {
            cursor: pointer;
            position: relative;
        }

        .day:hover {
            background-color: #f9f9f9;
        }

        .date-number {
            font-size: 16px;
            font-weight: bold;
            color: #000 !important;
        }
    </style>
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
    <input type="text" id="eventDate" readonly style="width:100%"><br><br>

    <label>Title</label><br>
    <input type="text" id="eventTitle" style="width:100%"><br><br>

    <label>Description</label><br>
    <textarea id="eventDesc" style="width:100%"></textarea><br><br>

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
window.onload = function () {

    const yearSelect = document.getElementById("yearSelect");
    const monthSelect = document.getElementById("monthSelect");
    const calendarBody = document.getElementById("calendarBody");

    // Populate years 2000–2099
    for (let y = 2000; y <= 2099; y++) {
        const opt = document.createElement("option");
        opt.value = y;
        opt.textContent = y;
        yearSelect.appendChild(opt);
    }

    const today = new Date();
    yearSelect.value = today.getFullYear();
    monthSelect.value = today.getMonth();

    function generateCalendar(year, month) {
        calendarBody.innerHTML = "";

        year = parseInt(year);
        month = parseInt(month);

        const firstDay = new Date(year, month, 1).getDay();
        const daysInMonth = new Date(year, month + 1, 0).getDate();

        let cells = 0;

        // Empty cells before first day
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
            calendarBody.appendChild(dayDiv);
            cells++;
        }

        // Empty cells after last day
        while (cells % 7 !== 0) {
            calendarBody.appendChild(document.createElement("div"));
            cells++;
        }
    }

    generateCalendar(yearSelect.value, monthSelect.value);

    yearSelect.onchange = () =>
        generateCalendar(yearSelect.value, monthSelect.value);

    monthSelect.onchange = () =>
        generateCalendar(yearSelect.value, monthSelect.value);
};

function openModal(date) {
    document.getElementById("eventDate").value = date;
    document.getElementById("eventModal").style.display = "block";
}

function closeModal() {
    document.getElementById("eventModal").style.display = "none";
}

function saveEvent() {

    const date = document.getElementById("eventDate").value;
    const title = document.getElementById("eventTitle").value;
    const desc = document.getElementById("eventDesc").value;

    if (title.trim() === "") {
        alert("Title required");
        return;
    }

    fetch("event/save", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body:
            "eventDate=" + encodeURIComponent(date) +
            "&title=" + encodeURIComponent(title) +
            "&description=" + encodeURIComponent(desc)
    })
    .then(res => res.text())
    .then(data => {
        if (data === "SUCCESS") {
            alert("Event saved");
            closeModal();
        } else if (data === "DATE_MISSING") {
            alert("Date missing");
        } else {
            alert("Please login again");
        }
    });
}



</script>
