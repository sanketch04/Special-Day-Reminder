<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>ASmitra - AI Assistant</title>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
body {
    font-family: Arial, sans-serif;
    background: #0f172a;
    color: #e5e7eb;
}

.chat-box {
    width: 70%;
    margin: 40px auto;
    background: #020617;
    padding: 20px;
    border-radius: 12px;
}

h2 {
    margin: 0;
    color: #38bdf8;
}

.messages {
    height: 420px;
    overflow-y: auto;
    padding: 15px;
    margin-top: 15px;
}

/* ✅ MODERN SCROLLBAR */
.messages::-webkit-scrollbar {
    width: 6px;
}
.messages::-webkit-scrollbar-track {
    background: transparent;
}
.messages::-webkit-scrollbar-thumb {
    background: #334155;
    border-radius: 10px;
}
.messages::-webkit-scrollbar-thumb:hover {
    background: #475569;
}

.user {
    text-align: right;
    margin: 10px 0;
}

.user span {
    background: #2563eb;
    padding: 10px 14px;
    border-radius: 12px;
    display: inline-block;
    max-width: 70%;
}

.ai {
    text-align: left;
    margin: 10px 0;
}

.ai span {
    background: #020617;
    border: 1px solid #334155;
    padding: 12px 16px;
    border-radius: 12px;
    display: inline-block;
    max-width: 75%;
    line-height: 1.6;
}

.loading {
    font-style: italic;
    color: #94a3b8;
}

.quick-btn {
    margin: 5px;
    background: #020617;
    color: #e5e7eb;
    border: 1px solid #334155;
    padding: 6px 12px;
    border-radius: 8px;
    cursor: pointer;
}

.quick-btn:hover {
    background: #1e293b;
}

input {
    width: 80%;
    padding: 12px;
    border-radius: 10px;
    border: 1px solid #334155;
    background: #020617;
    color: #e5e7eb;
}

button.send {
    padding: 12px 18px;
    margin-left: 8px;
    border-radius: 10px;
    border: none;
    background: #38bdf8;
    cursor: pointer;
}
.chat-header {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 10px;
}

.chat-logo {
    width: 38px;
    height: 38px;
    border-radius: 8px;
    object-fit: cover;
}

</style>

<script>
function sendMessage(text = null) {
    let input = $("#msg");
    let message = text ? text : input.val();
    if ($.trim(message) === "") return;

    $(".messages").append(
        "<div class='user'><span>" + message + "</span></div>"
    );

    input.val("");
    $(".messages").append("<div class='loading'>ASmitra is typing...</div>");
    $(".messages").scrollTop($(".messages")[0].scrollHeight);

    $.post(
        "${pageContext.request.contextPath}/OpenAI/chat/send",
        { message: message },
        function(data) {
            $(".loading").remove();

            /* ✅ EMAIL FORMAT CLEANUP (MAIN FIX) */
            let formatted = data;

            // Decode escaped HTML if any
            formatted = $("<textarea/>").html(formatted).text();

            // Normalize line breaks
            formatted = formatted.replace(/\r\n|\r|\n/g, "<br>");

            // Remove excessive <br>
            formatted = formatted
                .replace(/(<br>\s*){3,}/gi, "<br><br>")
                .replace(/<br>\s*--\s*<br>/gi, "<br><br>")
                .replace(/\*\*(.*?)\*\*/g, "<strong>$1</strong>");

            let aiDiv = $("<div class='ai'><span></span></div>");
            aiDiv.find("span").html(formatted);
            $(".messages").append(aiDiv);

            $(".messages").scrollTop($(".messages")[0].scrollHeight);
        }
    );
}

$(document).ready(function () {

    // ENTER KEY SUPPORT
    $("#msg").keypress(function (e) {
        if (e.which === 13) {
            e.preventDefault();
            sendMessage();
        }
    });

    // WELCOME MESSAGE
    let welcome =
        "Hello 👋 I’m <strong>ASmitra</strong>, your AI assistant.<br><br>" +
        "I can help you write professional emails, wishes, explain events, and more.";

    let welcomeDiv = $("<div class='ai'><span></span></div>");
    welcomeDiv.find("span").html(welcome);
    $(".messages").append(welcomeDiv);
});
</script>

</head>
<body>

<div class="chat-box">

<div class="chat-header">
    <img src="${pageContext.request.contextPath}/assets/images/ai-logo.gif"
     alt="ASmitra Logo"
     class="chat-logo">
    <h2>ASmitra</h2>
</div>

<!-- Changes in Project By SANKET -->

<!-- QUICK OPTIONS -->
<button class="quick-btn" onclick="sendMessage('Write a birthday wish')">🎂 Birthday Wish</button>
<button class="quick-btn" onclick="sendMessage('Write an anniversary message')">💍 Anniversary</button>
<button class="quick-btn" onclick="sendMessage('Explain today’s important events')">📅 Events</button>
<button class="quick-btn" onclick="sendMessage('Write a professional email')">📧 Email</button>

<div class="messages"></div>

<br>

<!-- ✅ BETTER INPUT PROMPT -->
<input type="text" id="msg" placeholder="Message ASmitra…" />
<button class="send" onclick="sendMessage()">Send</button>

</div>

</body>
</html>
