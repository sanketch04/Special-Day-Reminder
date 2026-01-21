<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>WhatsApp Message Sender</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #0f172a;
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }

        .box {
            background: rgba(255,255,255,0.08);
            padding: 25px;
            border-radius: 14px;
            width: 420px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.4);
        }

        h2 {
            margin-top: 0;
            text-align: center;
            color: #25D366;
        }

        label {
            display: block;
            margin-top: 14px;
            font-size: 14px;
            opacity: 0.9;
        }

        input, textarea {
            width: 100%;
            margin-top: 6px;
            padding: 10px;
            border-radius: 10px;
            border: none;
            outline: none;
            font-size: 15px;
        }

        textarea {
            resize: none;
            height: 90px;
        }

        button {
            margin-top: 18px;
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 10px;
            background: #25D366;
            color: black;
            font-weight: bold;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            opacity: 0.9;
        }

        .note {
            margin-top: 12px;
            font-size: 13px;
            opacity: 0.7;
            text-align: center;
        }
    </style>
</head>

<body>
<div class="box">
    <h2>Send WhatsApp Message</h2>

    <label>Receiver Mobile Number (with country code)</label>
    <input type="text" id="phone" placeholder="Example: 919876543210">

    <label>Message</label>
    <textarea id="msg" placeholder="Type message..."></textarea>

    <button onclick="openWhatsApp()">Open WhatsApp</button>

    <div class="note">
        ✅ WhatsApp will open with message ready. You must click <b>Send</b>.
    </div>
</div>

<script>
    function openWhatsApp() {
        let phone = document.getElementById("phone").value.trim();
        let msg = document.getElementById("msg").value.trim();

        if (phone === "") {
            alert("Please enter receiver number!");
            return;
        }

        // remove spaces and + sign if user enters it
        phone = phone.replace(/\s+/g, "").replace("+", "");

        // encode message for URL
        let encodedMsg = encodeURIComponent(msg);

        // WhatsApp URL (works on mobile + desktop)
        let url = "https://wa.me/" + phone + "?text=" + encodedMsg;

        window.open(url, "_blank");
    }
</script>

</body>
</html>
