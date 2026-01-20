<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reset Password | ASmitra</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        * { box-sizing: border-box; }

        body{
            margin: 0;
            font-family: "Segoe UI", Arial, sans-serif;
            min-height: 100vh;
            background:
              radial-gradient(1200px 600px at 20% 10%, rgba(99,102,241,0.25), transparent 55%),
              radial-gradient(900px 500px at 90% 25%, rgba(56,189,248,0.22), transparent 55%),
              radial-gradient(900px 600px at 50% 100%, rgba(244,63,94,0.15), transparent 55%),
              linear-gradient(135deg,#f6f8ff,#eef2ff);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 28px 14px;
        }

        .card-glass{
            width: 100%;
            max-width: 520px;
            padding: 36px 32px;
            border-radius: 22px;
            background: rgba(255,255,255,0.70);
            border: 1px solid rgba(255,255,255,0.55);
            backdrop-filter: blur(22px);
            -webkit-backdrop-filter: blur(22px);
            box-shadow: 0 30px 80px rgba(0,0,0,0.18);
        }

        .title{
            font-weight: 800;
            font-size: 22px;
            margin-bottom: 4px;
            color: #111827;
        }

        .subtitle{
            color: rgba(17,24,39,0.65);
            font-size: 14px;
            margin-bottom: 20px;
        }

        .field{
            position: relative;
            margin-bottom: 16px;
        }

        .field input{
            width: 100%;
            padding: 14px 44px 14px 14px;
            border-radius: 14px;
            border: 1px solid rgba(15,23,42,0.15);
            outline: none;
            transition: 0.25s ease;
            background: rgba(255,255,255,0.9);
        }

        .field input:focus{
            border-color: rgba(79,70,229,0.55);
            box-shadow: 0 0 0 6px rgba(79,70,229,0.18);
        }

        .eye-btn{
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            font-size: 18px;
            opacity: 0.75;
            user-select: none;
        }

        .eye-btn:hover{ opacity: 1; }

        .msg-error{
            background: rgba(239,68,68,0.08);
            border: 1px solid rgba(239,68,68,0.25);
            color: #b91c1c;
            padding: 10px 12px;
            border-radius: 14px;
            font-weight: 600;
            font-size: 14px;
            margin-top: 10px;
        }

        .msg-success{
            background: rgba(34,197,94,0.10);
            border: 1px solid rgba(34,197,94,0.30);
            color: #166534;
            padding: 10px 12px;
            border-radius: 14px;
            font-weight: 600;
            font-size: 14px;
            margin-top: 10px;
        }

        .hint{
            font-size: 13px;
            color: rgba(17,24,39,0.65);
        }

        .match-status{
            font-size: 13px;
            font-weight: 700;
            margin-top: 8px;
        }

        .match-ok{ color: #16a34a; }
        .match-bad{ color: #ef4444; }

        .btn-primary{
            border-radius: 14px;
            padding: 12px 14px;
            font-weight: 700;
            border: none;
            background: linear-gradient(135deg,#4f46e5,#6366f1);
            box-shadow: 0 16px 40px rgba(79,70,229,0.30);
            transition: 0.25s ease;
        }

        .btn-primary:hover{
            transform: translateY(-1px);
            box-shadow: 0 18px 50px rgba(79,70,229,0.42);
        }

        @media (max-width: 576px){
            .card-glass{ padding: 28px 20px; }
        }
    </style>
</head>

<body>

<div class="card-glass">
    <div class="text-center mb-3">
        <div class="title">Reset Password</div>
        <div class="subtitle">Create a strong new password for your account</div>
    </div>

    <form action="reset-password" method="post" id="resetForm">

        <input type="hidden" name="email" value="${email}" />

        <!-- New Password -->
        <div class="field">
            <input type="password" name="newPassword" id="newPassword" placeholder="New Password" required />
            <span class="eye-btn" id="toggleNew"><i class="bi bi-eye"></i></span>
        </div>

        <div class="hint mb-2">
            Use 8+ characters with uppercase, number, and symbol.
        </div>

        <!-- Confirm Password -->
        <div class="field">
            <input type="password" name="confirmPassword" id="confirmPassword" placeholder="Confirm Password" required />
            <span class="eye-btn" id="toggleConfirm"><i class="bi bi-eye"></i></span>
        </div>

        <div id="matchStatus" class="match-status"></div>

        <button type="submit" class="btn btn-primary w-100 mt-2" id="resetBtn">
            Reset Password
        </button>
    </form>

    <% if (request.getAttribute("error") != null) { %>
        <div class="msg-error mt-3">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>

    <% if (request.getAttribute("success") != null) { %>
        <div class="msg-success mt-3">
            <%= request.getAttribute("success") %>
        </div>
    <% } %>

</div>

<script>
    const newPwd = document.getElementById("newPassword");
    const confirmPwd = document.getElementById("confirmPassword");
    const matchStatus = document.getElementById("matchStatus");

    const toggleNew = document.getElementById("toggleNew");
    const toggleConfirm = document.getElementById("toggleConfirm");

    function toggleVisibility(input){
        input.type = input.type === "password" ? "text" : "password";
    }

    toggleNew.addEventListener("click", () => toggleVisibility(newPwd));
    toggleConfirm.addEventListener("click", () => toggleVisibility(confirmPwd));

    function checkMatch(){
        if(!newPwd.value && !confirmPwd.value){
            matchStatus.textContent = "";
            matchStatus.className = "match-status";
            return;
        }

        if(confirmPwd.value.length === 0){
            matchStatus.textContent = "";
            matchStatus.className = "match-status";
            return;
        }

        if(newPwd.value === confirmPwd.value){
            matchStatus.textContent = "Passwords match ✅";
            matchStatus.className = "match-status match-ok";
        }else{
            matchStatus.textContent = "Passwords do not match ❌";
            matchStatus.className = "match-status match-bad";
        }
    }

    newPwd.addEventListener("input", checkMatch);
    confirmPwd.addEventListener("input", checkMatch);

    // Prevent submit if mismatch
    document.getElementById("resetForm").addEventListener("submit", (e) => {
        if(newPwd.value !== confirmPwd.value){
            e.preventDefault();
            matchStatus.textContent = "Passwords do not match ❌";
            matchStatus.className = "match-status match-bad";
        }
    });
</script>

</body>
</html>
