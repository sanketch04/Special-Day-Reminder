<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Error | ASmitra</title>

    <style>
        :root {
            --primary: #4f46e5;
            --danger: #ef4444;
            --bg1: #0f172a;
            --bg2: #020617;
        }

        body {
            margin: 0;
            height: 100vh;
            font-family: "Segoe UI", sans-serif;
            background: radial-gradient(circle at top, var(--bg1), var(--bg2));
            display: flex;
            align-items: center;
            justify-content: center;
            perspective: 1200px;
            overflow: hidden;
            color: #fff;
        }

        /* ===== BACKGROUND FLOAT ===== */
        body::before {
            content: "";
            position: absolute;
            inset: -50%;
            background:
                radial-gradient(circle, rgba(79,70,229,0.15), transparent 60%),
                radial-gradient(circle, rgba(239,68,68,0.15), transparent 60%);
            animation: bgMove 14s linear infinite;
        }

        @keyframes bgMove {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* ===== CARD ===== */
        .error-card {
            position: relative;
            background: linear-gradient(145deg, #111827, #020617);
            width: 420px;
            padding: 40px 30px;
            border-radius: 18px;
            text-align: center;
            transform-style: preserve-3d;
            animation: float 4s ease-in-out infinite;
            box-shadow:
                0 25px 60px rgba(0,0,0,.6),
                inset 0 0 0 1px rgba(255,255,255,.05);
        }

        @keyframes float {
            0%,100% { transform: translateY(0) rotateX(0deg); }
            50% { transform: translateY(-14px) rotateX(4deg); }
        }

        .error-card:hover {
            transform: rotateY(8deg) rotateX(6deg) scale(1.02);
        }

        /* ===== ERROR TEXT ===== */
        .error-code {
            font-size: 64px;
            font-weight: 800;
            letter-spacing: 2px;
            color: var(--danger);
            text-shadow:
                0 0 12px rgba(239,68,68,.6),
                0 0 32px rgba(239,68,68,.4);
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%,100% { transform: scale(1); }
            50% { transform: scale(1.06); }
        }

        .error-title {
            font-size: 24px;
            margin: 10px 0 14px;
        }

        .error-message {
            font-size: 15px;
            color: #cbd5f5;
            margin-bottom: 30px;
        }

        /* ===== BUTTONS ===== */
        .actions a {
            display: inline-block;
            padding: 12px 22px;
            margin: 6px;
            border-radius: 10px;
            text-decoration: none;
            font-size: 14px;
            transition: all .25s ease;
            transform-style: preserve-3d;
        }

        .btn-primary {
            background: linear-gradient(135deg, #6366f1, #4f46e5);
            color: #fff;
            box-shadow: 0 12px 30px rgba(79,70,229,.4);
        }

        .btn-secondary {
            background: rgba(255,255,255,.08);
            knows: #fff;
            box-shadow: inset 0 0 0 1px rgba(255,255,255,.1);
        }

        .actions a:hover {
            transform: translateY(-4px) scale(1.05);
            box-shadow: 0 18px 40px rgba(0,0,0,.5);
        }

        /* ===== SMALL BRAND ===== */
        .brand {
            margin-top: 22px;
            font-size: 13px;
            color: #94a3b8;
        }
    </style>
</head>

<body>

<div class="error-card">
    <div class="error-code">ERROR</div>

    <div class="error-title">Something went wrong</div>

    <div class="error-message">
        ${error != null ? error : "Unexpected system error occurred."}
    </div>

    <div class="actions">
        <a href="${pageContext.request.contextPath}/login" class="btn-primary">
            Go to Login
        </a>
        <a href="javascript:history.back()" class="btn-secondary">
            Go Back
        </a>
    </div>

    <div class="brand">
        ASmitra · Special Day Reminder
    </div>
</div>

</body>
</html>
