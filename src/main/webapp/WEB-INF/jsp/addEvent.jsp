<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Event | ASmitra</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <style>
        /* ==========================
           INDUSTRY UI TOKENS
        ========================== */
        :root{
            --bg1: #eef2ff;
            --bg2: #f8fafc;

            --card: rgba(255,255,255,0.72);
            --cardBorder: rgba(255,255,255,0.55);

            --text: #0f172a;
            --muted: rgba(15,23,42,0.55);

            --stroke: rgba(15,23,42,0.12);

            --primary: #6366f1;
            --primaryDark: #4338ca;
            --primaryGlow: rgba(99,102,241,0.25);

            --success: #22c55e;
            --danger: #ef4444;

            --radiusXL: 28px;
            --radiusLG: 18px;
            --radiusMD: 16px;

            --shadowXL: 0 40px 100px rgba(0,0,0,0.18);
            --shadowLG: 0 20px 60px rgba(0,0,0,0.12);
            --shadowMD: 0 12px 28px rgba(0,0,0,0.10);
        }

        *{ box-sizing: border-box; }

        /* ==========================
           PAGE BACKGROUND
        ========================== */
        body{
            margin: 0;
            min-height: 100vh;
            font-family: 'Inter', system-ui, -apple-system, Segoe UI, sans-serif;
            color: var(--text);
            overflow-x: hidden;

            background:
              radial-gradient(1000px 520px at 18% 10%, rgba(99,102,241,0.28), transparent 58%),
              radial-gradient(900px 520px at 85% 22%, rgba(34,211,238,0.18), transparent 56%),
              radial-gradient(900px 560px at 50% 100%, rgba(244,114,182,0.14), transparent 60%),
              linear-gradient(135deg, var(--bg1), var(--bg2));
        }

        /* ==========================
           PAGE LAYOUT (WITH NAVBAR)
           - Navbar is sticky, so we add padding-top
        ========================== */
        .page-wrap{
            width: 100%;
            min-height: calc(100vh - 70px);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 38px 14px 50px;
        }

        /* ==========================
           CARD (GLASS)
        ========================== */
        .event-card{
            width: 100%;
            max-width: 680px;

            background: var(--card);
            border: 1px solid var(--cardBorder);
            border-radius: var(--radiusXL);

            backdrop-filter: blur(22px);
            -webkit-backdrop-filter: blur(22px);

            padding: 42px 40px;

            box-shadow: var(--shadowXL);
            position: relative;
            overflow: hidden;

            transform: translateY(0);
            transition: transform .25s ease, box-shadow .25s ease, border-color .25s ease;
            animation: rise .55s ease both;
        }

        .event-card::before{
            content: "";
            position: absolute;
            inset: -2px;
            background: radial-gradient(420px 160px at 28% 8%, rgba(255,255,255,0.7), transparent 60%);
            opacity: 0.40;
            pointer-events: none;
        }

        .event-card:hover{
            transform: translateY(-2px);
            box-shadow: var(--shadowXL), 0 18px 40px rgba(99,102,241,0.10);
            border-color: rgba(99,102,241,0.22);
        }

        @keyframes rise{
            from{ opacity: 0; transform: translateY(26px) scale(.985); }
            to{ opacity: 1; transform: translateY(0) scale(1); }
        }

        /* ==========================
           HEADER
        ========================== */
        .card-head{
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            margin-bottom: 22px;
        }

        .title-area{
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .title{
            font-weight: 800;
            letter-spacing: -0.6px;
            font-size: 22px;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .title .title-icon{
            width: 40px;
            height: 40px;
            border-radius: 14px;
            display: grid;
            place-items: center;
            background: rgba(99,102,241,0.12);
            border: 1px solid rgba(99,102,241,0.18);
            box-shadow: 0 12px 26px rgba(99,102,241,0.12);
        }

        .subtitle{
            margin: 0;
            font-size: 13px;
            color: var(--muted);
            line-height: 1.35;
        }

        .badge-soft{
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 12px;
            border-radius: 999px;
            font-weight: 700;
            font-size: 12px;
            background: rgba(34,197,94,0.10);
            border: 1px solid rgba(34,197,94,0.22);
            color: rgba(22,101,52,0.95);
            user-select: none;
            white-space: nowrap;
        }

        /* ==========================
           FORM GRID
        ========================== */
        .form-grid{
            display: grid;
            grid-template-columns: 1fr;
            gap: 16px;
        }

        @media (min-width: 768px){
            .form-grid.two-col{
                grid-template-columns: 1fr 1fr;
            }
        }

        /* ==========================
           FIELD (LABEL + CONTROL)
        ========================== */
        .field{
            margin: 0;
        }

        .field label{
            font-size: 13px;
            font-weight: 700;
            color: rgba(15,23,42,0.65);
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .field label i{
            color: rgba(99,102,241,0.85);
            font-size: 14px;
        }

        .control{
            width: 100%;
            border-radius: var(--radiusMD);
            padding: 14px 14px;
            border: 1px solid var(--stroke);
            background: rgba(255,255,255,0.92);
            font-size: 15px;
            outline: none;

            transition: border-color .25s ease, box-shadow .25s ease, transform .18s ease, background .25s ease;
        }

        textarea.control{
            resize: none;
            min-height: 120px;
        }

        .control:hover{
            transform: translateY(-1px);
            border-color: rgba(99,102,241,0.22);
        }

        .control:focus{
            transform: translateY(-1px);
            border-color: rgba(99,102,241,0.55);
            box-shadow: 0 0 0 6px var(--primaryGlow);
            background: rgba(255,255,255,0.98);
        }

        .hint{
            font-size: 12px;
            color: rgba(15,23,42,0.45);
            margin-top: 6px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .hint i{ font-size: 13px; }

        /* ==========================
           CATEGORY SELECT (PREMIUM)
        ========================== */
        .category-select{
            cursor: pointer;
            appearance: none;
            -webkit-appearance: none;
            background-image:
                linear-gradient(45deg, transparent 50%, rgba(15,23,42,0.55) 50%),
                linear-gradient(135deg, rgba(15,23,42,0.55) 50%, transparent 50%);
            background-position:
                calc(100% - 18px) calc(50% - 4px),
                calc(100% - 12px) calc(50% - 4px);
            background-size: 6px 6px, 6px 6px;
            background-repeat: no-repeat;
            padding-right: 36px;
        }

        /* Scrollbar inside select (Chrome/Edge) */
        .category-select::-webkit-scrollbar{ width: 8px; }
        .category-select::-webkit-scrollbar-track{
            background: #f1f5f9;
            border-radius: 10px;
        }
        .category-select::-webkit-scrollbar-thumb{
            background: linear-gradient(180deg, var(--primary), var(--primaryDark));
            border-radius: 10px;
        }
        .category-select::-webkit-scrollbar-thumb:hover{
            background: linear-gradient(180deg, #4f46e5, #3730a3);
        }

        /* ==========================
           ACTION BUTTONS
        ========================== */
        .actions{
            margin-top: 18px;
            display: grid;
            grid-template-columns: 1fr;
            gap: 12px;
        }

        @media (min-width: 768px){
            .actions{
                grid-template-columns: 1fr 1fr;
            }
        }

        .btn-save{
            border: none;
            border-radius: var(--radiusMD);
            padding: 14px 16px;
            width: 100%;

            font-weight: 800;
            letter-spacing: 0.2px;
            color: #fff;

            background: linear-gradient(135deg, var(--primary), var(--primaryDark));
            box-shadow: 0 16px 40px rgba(99,102,241,0.32);

            transition: transform .2s ease, box-shadow .25s ease, filter .25s ease;
        }

        .btn-save:hover{
            transform: translateY(-2px);
            filter: brightness(1.05);
            box-shadow: 0 18px 52px rgba(99,102,241,0.46);
        }

        .btn-save:disabled{
            opacity: 0.75;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }

        .btn-back{
            width: 100%;
            border-radius: var(--radiusMD);
            padding: 14px 16px;
            font-weight: 800;

            background: rgba(15,23,42,0.06);
            border: 1px solid rgba(15,23,42,0.10);

            transition: transform .2s ease, box-shadow .25s ease, background .25s ease;
        }

        .btn-back:hover{
            transform: translateY(-1px);
            background: rgba(99,102,241,0.10);
            border-color: rgba(99,102,241,0.18);
            box-shadow: var(--shadowMD);
        }

        /* ==========================
           SMALL POLISH (MOBILE)
        ========================== */
        @media (max-width: 576px){
            .event-card{
                padding: 30px 22px;
                border-radius: 22px;
            }

            .title{
                font-size: 20px;
            }

            .title .title-icon{
                width: 38px;
                height: 38px;
                border-radius: 14px;
            }
        }
    </style>
</head>

<body>

<jsp:include page="navbar.jsp" />

<div class="page-wrap">

    <div class="event-card">

        <div class="card-head">
            <div class="title-area">
                <h2 class="title">
                    <span class="title-icon"><i class="bi bi-calendar-plus"></i></span>
                    Add New Event
                </h2>
                <p class="subtitle">
                    Add an event with date, category, reminder settings and optional description.
                </p>
            </div>

            <span class="badge-soft">
                <i class="bi bi-shield-check"></i> Secure Save
            </span>
        </div>

        <form action="save" method="post" id="eventForm" autocomplete="off">

            <!-- Title -->
            <div class="field">
                <label><i class="bi bi-type"></i> Title</label>
                <input type="text" class="control" name="title" required
                       placeholder="Meeting, Birthday, Reminder...">
                <div class="hint"><i class="bi bi-info-circle"></i> Keep it short & clear.</div>
            </div>

            <!-- Two column row: Date + Category -->
            <div class="form-grid two-col">
                <div class="field">
                    <label><i class="bi bi-calendar-event"></i> Date</label>
                    <input type="date" class="control" name="eventDate" required>
                </div>

                <div class="field">
                    <label><i class="bi bi-tag"></i> Category</label>
                    <select name="category" class="control category-select" required>
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
            </div>

            <!-- Description -->
            <div class="field">
                <label><i class="bi bi-card-text"></i> Description</label>
                <textarea name="description" class="control" rows="4"
                          placeholder="Optional description..."></textarea>
                <div class="hint"><i class="bi bi-chat-left-text"></i> Add notes like location, agenda, or link.</div>
            </div>

            <!-- Reminder -->
            <div class="field">
                <label><i class="bi bi-bell"></i> Reminder Days Before</label>
                <input type="number" class="control" name="reminderDaysBefore" value="1" min="0">
                <div class="hint">
                    <i class="bi bi-lightbulb"></i> Enter <b>0</b> for no reminder.
                </div>
            </div>

            <!-- Actions -->
            <div class="actions">
                <button type="submit" class="btn-save" id="saveBtn">
                    <i class="bi bi-check2-circle me-1"></i> Save Event
                </button>

                <a href="../dashboard" class="btn btn-back">
                    <i class="bi bi-arrow-left me-1"></i> Back
                </a>
            </div>

        </form>

    </div>

</div>

<!-- UX JS (NO backend impact) -->
<script>
$(function () {

    // Prevent multiple submits + give feedback
    $("#eventForm").on("submit", function () {
        $("#saveBtn").html('<i class="bi bi-hourglass-split me-1"></i> Saving...').prop("disabled", true);
    });

});
</script>

</body>
</html>
