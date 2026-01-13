<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Event</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <style>
        :root {
            --primary: #6366f1;
            --primary-dark: #4338ca;
            --glass: rgba(255,255,255,0.85);
        }

        body {
            min-height: 100vh;
            background: radial-gradient(circle at top, #e0e7ff, #f8fafc);
            font-family: 'Inter', system-ui, sans-serif;
            display: grid;
            place-items: center;
            color: #0f172a;
        }

        .event-card {
            width: 100%;
            max-width: 620px;
            background: var(--glass);
            backdrop-filter: blur(16px);
            border-radius: 28px;
            padding: 40px;
            box-shadow:
                0 40px 100px rgba(0,0,0,.25),
                inset 0 0 0 1px rgba(255,255,255,.6);
            animation: rise .6s ease;
        }

        @keyframes rise {
            from {
                opacity: 0;
                transform: translateY(30px) scale(.96);
            }
            to {
                opacity: 1;
                transform: none;
            }
        }

        h2 {
            font-weight: 700;
            margin-bottom: 28px;
            letter-spacing: -0.6px;
            text-align: center;
        }

        /* Fields */
        .field {
            margin-bottom: 22px;
        }

        .field label {
            font-size: 13px;
            font-weight: 600;
            color: #64748b;
            margin-bottom: 6px;
            display: block;
        }

        .field input,
        .field select,
        .field textarea {
            width: 100%;
            border-radius: 16px;
            padding: 16px;
            border: 1px solid #e5e7eb;
            font-size: 15px;
            background: #fff;
            transition: all .25s ease;
        }

        .field textarea {
            resize: none;
        }

        .field input:focus,
        .field select:focus,
        .field textarea:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 5px rgba(99,102,241,.18);
            outline: none;
            transform: translateY(-1px);
        }

        /* Buttons */
        .btn-save {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            border: none;
            color: #fff;
            padding: 14px;
            font-weight: 600;
            border-radius: 16px;
            transition: all .3s ease;
        }

        .btn-save:hover {
            transform: translateY(-2px);
            box-shadow: 0 18px 40px rgba(99,102,241,.45);
        }

        .btn-back {
            background: #e5e7eb;
            border-radius: 16px;
            font-weight: 600;
            padding: 14px;
            transition: all .25s ease;
        }

        .btn-back:hover {
            background: #d1d5db;
            transform: translateY(-1px);
        }

        /* Small helper text */
        .hint {
            font-size: 12px;
            color: #94a3b8;
            margin-top: 4px;
        }

        @media (max-width: 576px) {
            .event-card {
                padding: 28px 22px;
            }
        }
/*category*/
.category-select {
    width: 100%;
    padding: 12px 14px;
    border-radius: 12px;
    border: 1px solid #e5e7eb;
    background-color: #ffffff;
    font-size: 15px;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.25s ease;
}

/* Hover */
.category-select:hover {
    border-color: #6366f1;
}

/* Focus */
.category-select:focus {
    outline: none;
    border-color: #6366f1;
    box-shadow: 0 0 0 4px rgba(99,102,241,0.15);
}

/* ==============================
   SCROLLBAR (Chrome / Edge)
============================== */
.category-select::-webkit-scrollbar {
    width: 8px;
}

.category-select::-webkit-scrollbar-track {
    background: #f1f5f9;
    border-radius: 10px;
}

.category-select::-webkit-scrollbar-thumb {
    background: linear-gradient(180deg, #6366f1, #4338ca);
    border-radius: 10px;
}

.category-select::-webkit-scrollbar-thumb:hover {
    background: linear-gradient(180deg, #4f46e5, #3730a3);
}

.category-select option {
    padding: 10px;
    font-weight: 500;
}

/* Selected option (Windows fix) */
.category-select option:checked {
    background-color: #eef2ff;
    color: #1e1b4b;
}
        
    </style>
</head>

<body>

<div class="event-card">

    <h2>➕ Add New Event</h2>

    <form action="save" method="post" id="eventForm">

        <div class="field">
            <label>Title</label>
            <input type="text" name="title" required placeholder="Meeting, Birthday, Reminder...">
        </div>

        <div class="field">
            <label>Date</label>
            <input type="date" name="eventDate" required>
        </div>

        <div class="field">
            <label>Category</label>
            <select name="category"  class="category-select">
			    <option>Work</option>
			    <option>Meeting</option>
			    <option>Personal</option>
			    <option>Birthday</option>
			    <option>Anniversary</option>
			    <option>Holiday</option>
			    <option>Reminder</option>
			    <option>Appointment</option>
			    <option>Interview</option>
			    <option>Exam</option>
			    <option>Deadline</option>
			    <option>Conference</option>
			    <option>Workshop</option>
			    <option>Training</option>
			    <option>Travel</option>
			    <option>Festival</option>
			    <option>Health / Medical</option>
			    <option>Payment / Bill</option>
			    <option>Family</option>
			    <option>Friends</option>
			    <option>Shopping</option>
			    <option>Fitness</option>
			    <option>Other</option>
			</select>

        </div>

        <div class="field">
            <label>Description</label>
            <textarea name="description" rows="4"
                      placeholder="Optional description..."></textarea>
        </div>

        <div class="field">
            <label>Reminder Days Before</label>
            <input type="number" name="reminderDaysBefore" value="1" min="0">
            <div class="hint">0 means no reminder</div>
        </div>

        <div class="row g-3 mt-3">
            <div class="col-12 col-md-6">
                <button type="submit" class="btn-save w-100">
                    Save Event
                </button>
            </div>
            <div class="col-12 col-md-6">
                <a href="../dashboard" class="btn btn-back w-100">
                    Back
                </a>
            </div>
        </div>

    </form>

</div>

<!-- UX JS (NO backend impact) -->
<script>
$(function () {

    // Subtle submit animation
    $("#eventForm").on("submit", function () {
        $(".btn-save").text("Saving...").prop("disabled", true);
    });

});
</script>

</body>
</html>
