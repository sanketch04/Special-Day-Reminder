<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>ASmitra - AI Assistant</title>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
/* ================= GLOBAL ================= */
* {
    box-sizing: border-box;
    font-family: "Segoe UI", Arial, sans-serif;
}

body {
    margin: 0;
    background: #020617;
    color: #e5e7eb;
    overflow: hidden;
    cursor: url("https://cur.cursors-4u.net/cursors/cur-9/cur816.cur"), auto;
}


body::after {
    content: "";
    position: fixed;
    inset: 0;
    background: repeating-linear-gradient(
        to bottom,
        rgba(255,255,255,0.03),
        rgba(255,255,255,0.03) 1px,
        transparent 2px,
        transparent 4px
    );
    pointer-events: none;
    animation: scan 8s linear infinite;
}

@keyframes scan {
    from { transform: translateY(-100%); }
    to { transform: translateY(100%); }
}

/* ================= VIDEO BACKGROUND ================= */
.bg-video {
    position: fixed;
    inset: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
    z-index: -2;
    filter: brightness(0.35) contrast(1.1);
}

.bg-overlay {
    position: fixed;
    inset: 0;
   background: radial-gradient(
        circle at center,
        rgba(56,189,248,0.06),
        rgba(2,6,23,0.35) 70%
    );
    z-index: -1;
}

/* ================= HUD CHAT BOX ================= */
.chat-box {
    width: 70%;
    height: 550px;                 /* FIXED HEIGHT */
    margin: 40px auto;
    padding: 22px;
    display: flex;
    flex-direction: column; 


    /* ULTRA GLASS */
    background: rgba(255, 255, 255, 0.06);
    backdrop-filter: blur(14px) saturate(180%);
    -webkit-backdrop-filter: blur(14px) saturate(180%);

    border-radius: 18px;
    border: 1px solid rgba(56, 189, 248, 0.35);

    /* HOLOGRAPHIC GLOW */
    box-shadow:
        0 0 35px rgba(56,189,248,0.35),
        inset 0 0 30px rgba(56,189,248,0.15);

    position: relative;
}


/* ================= DOCK MODE ================= */
.chat-box.docked {

    /* SIZE */
    width: 90px !important;
    height: 90px !important;

    /* POSITION */
    position: fixed !important;
    bottom: 24px;
    right: 24px;
    margin: 0 !important;

    /* SHAPE */
    border-radius: 50% !important;
    padding: 0 !important;

    /* VISUAL */
    background: radial-gradient(
        circle at center,
        rgba(56,189,248,0.45),
        rgba(2,6,23,0.85)
    ) !important;

    border: 2px solid rgba(56,189,248,0.9);

    box-shadow:
        0 0 35px rgba(56,189,248,1),
        0 0 80px rgba(56,189,248,0.7),
        inset 0 0 25px rgba(56,189,248,0.5);

    backdrop-filter: blur(18px) saturate(200%);
    -webkit-backdrop-filter: blur(18px) saturate(200%);

    /* ANIMATION */
    animation: jarvisPulse 2.4s infinite ease-in-out;

    z-index: 9999;
    cursor: pointer;
}

/* HIDE INNER UI WHEN DOCKED */
.chat-box.docked * {
    display: none !important;
}

/* JARVIS CORE ICON */
.chat-box.docked::before {
    content: "◉";
    position: absolute;
    inset: 0;
    display: flex;
    align-items: center;
    justify-content: center;

    font-size: 36px;
    font-weight: bold;
    color: #38bdf8;

    text-shadow:
        0 0 10px #38bdf8,
        0 0 30px #38bdf8,
        0 0 60px rgba(56,189,248,0.8);

    animation: coreRotate 6s linear infinite;
}

/* ================= ANIMATIONS ================= */
@keyframes jarvisPulse {
    0%, 100% {
        transform: scale(1);
        box-shadow:
            0 0 35px rgba(56,189,248,1),
            0 0 80px rgba(56,189,248,0.7);
    }
    50% {
        transform: scale(1.12);
        box-shadow:
            0 0 55px rgba(56,189,248,1),
            0 0 120px rgba(56,189,248,0.95);
    }
}

@keyframes coreRotate {
    from { transform: rotate(0deg); }
    to   { transform: rotate(360deg); }
}

/* ================= UNDOCK TRANSITION ================= */
.chat-box {
    transition:
        width 0.6s ease,
        height 0.6s ease,
        border-radius 0.6s ease,
        box-shadow 0.6s ease,
        background 0.6s ease,
        transform 0.6s ease;
}






.chat-box::after {
    content: "";
    position: absolute;
    inset: 0;
    background: linear-gradient(
        120deg,
        transparent 20%,
        rgba(255,255,255,0.08),
        transparent 80%
    );
    animation: glassSweep 8s infinite linear;
    pointer-events: none;
}

@keyframes glassSweep {
    from { transform: translateX(-100%); }
    to   { transform: translateX(100%); }
}




/* ================= HEADER ================= */
.chat-header {
    display: flex;
    align-items: center;
    gap: 14px;
    padding-bottom: 10px;
    border-bottom: 1px solid rgba(56,189,248,0.35);
}

.chat-logo {
    width: 44px;
    height: 44px;
    border-radius: 10px;
    object-fit: cover;
    box-shadow: 0 0 15px rgba(56,189,248,0.8);
}

.chat-header h2 {
    margin: 0;
    color: #38bdf8;
    letter-spacing: 1px;
    text-shadow: 0 0 10px rgba(56,189,248,0.8);
}

/* ================= QUICK ACTIONS ================= */
.quick-actions {
    margin: 14px 0;
}

.quick-btn {
    margin: 5px;
    background: rgba(2,6,23,0.7);
    color: #e5e7eb;
    border: 1px solid rgba(56,189,248,0.45);
    padding: 7px 14px;
    border-radius: 10px;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 0 12px rgba(56,189,248,0.25);
}

.quick-btn:hover {
    background: rgba(56,189,248,0.15);
    transform: translateY(-2px);
    box-shadow: 0 0 22px rgba(56,189,248,0.8);
}

/* ================= MESSAGES ================= */
.messages {
    flex: 1;                      /* TAKE REMAINING SPACE */
    overflow-y: auto;             /* SCROLL HERE */
    padding: 15px;
    margin-top: 10px;
    scroll-behavior: smooth;
}

/* Scrollbar */
.messages::-webkit-scrollbar {
    width: 6px;
}
.messages::-webkit-scrollbar-thumb {
    background: rgba(56,189,248,0.45);
    border-radius: 10px;
}

.wave i {
    display: inline-block;
    width: 4px;
    height: 16px;
    margin: 0 2px;
    background: #38bdf8;
    animation: wave 1.2s infinite ease-in-out;
}

.wave i:nth-child(2){animation-delay:.1s}
.wave i:nth-child(3){animation-delay:.2s}
.wave i:nth-child(4){animation-delay:.3s}

@keyframes wave {
    0%,100% { height: 8px; }
    50% { height: 22px; }
}


/* USER MESSAGE */
.user {
    text-align: right;
    margin: 12px 0;
}

.user span {
    display: inline-block;
    padding: 10px 16px;
    border-radius: 14px;
   background: rgba(37, 99, 235, 0.35);
    backdrop-filter: blur(10px);
    border: 1px solid rgba(147,197,253,0.4);
    color: #ffffff;
    max-width: 70%;
    box-shadow: 0 0 20px rgba(56,189,248,0.6);
}

/* AI MESSAGE */
.ai {
    text-align: left;
    margin: 14px 0;
}

.ai span {
    display: inline-block;
    padding: 14px 18px;
    border-radius: 14px;
   background: rgba(2, 6, 23, 0.25);
    backdrop-filter: blur(12px);
    border: 1px solid rgba(56,189,248,0.3);
    color: #e5e7eb;
    max-width: 75%;
    line-height: 1.6;
    box-shadow: inset 0 0 20px rgba(56,189,248,0.2);
    animation: holoReveal 0.6s ease;
    
    
}

@keyframes holoReveal {
    from {
        opacity: 0;
        transform: translateY(10px) scale(0.98);
        filter: blur(4px);
    }
    to {
        opacity: 1;
        transform: translateY(0) scale(1);
        filter: blur(0);
    }
}

/* LOADING */
.loading {
    font-style: italic;
    color: #94a3b8;
}

/* ================= INPUT AREA ================= */
.input-area {
    display: flex;
    gap: 10px;
    margin-top: 10px;
}
input {
    background: rgba(255,255,255,0.05);
    backdrop-filter: blur(10px);
    border: 1px solid rgba(56,189,248,0.35);
    color: #fff;
}
.chat-input {
    display: flex;
    gap: 8px;
    margin-top: 12px;
    flex-shrink: 0;              /* NEVER COLLAPSE */
}




#msg {
    flex: 1;
    padding: 14px;
    border-radius: 14px;
    border: 1px solid rgba(56,189,248,0.45);
    background: rgba(2,6,23,0.9);
    color: #e5e7eb;
    outline: none;
    box-shadow: inset 0 0 18px rgba(56,189,248,0.25);
}

#msg:focus {
    box-shadow: 0 0 22px rgba(56,189,248,0.8);
}

button.send {
    padding: 14px 22px;
    border-radius: 14px;
    border: none;
    background: linear-gradient(135deg,#38bdf8,#2563eb);
    color: #fff;
    cursor: pointer;
    font-weight: 600;
    box-shadow: 0 0 20px rgba(56,189,248,0.7);
}

button.send:hover {
    transform: translateY(-2px);
    box-shadow: 0 0 35px rgba(56,189,248,1);
}

/* 🎙️ MIC BUTTON */
.mic-btn {
    position: relative;
    font-size: 18px;
    padding: 10px 14px;
    border-radius: 50%;
    border: 1px solid #38bdf8;
    background: rgba(2,6,23,0.6);
    color: #38bdf8;
    cursor: pointer;
}

/* 🔵 LISTENING PULSE */
.mic-btn.listening::after {
    content: "";
    position: absolute;
    inset: -6px;
    border-radius: 50%;
    border: 2px solid #38bdf8;
    animation: pulseRing 1.2s infinite;
}

@keyframes pulseRing {
    0% {
        transform: scale(1);
        opacity: 0.8;
    }
    100% {
        transform: scale(1.6);
        opacity: 0;
    }
}


.thinking-hud {
    position: relative;
    height: 28px;
    overflow: hidden;
    margin: 10px 0;
    color: #38bdf8;
}

.scan-line {
    position: absolute;
    width: 100%;
    height: 2px;
    background: linear-gradient(to right, transparent, #38bdf8, transparent);
    animation: scanMove 1.4s infinite linear;
}

@keyframes scanMove {
    from { transform: translateX(-100%); }
    to { transform: translateX(100%); }
}

/* ================= AI ACTION BUTTONS ================= */
.ai-actions {
    margin-top: 10px;
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
}

.ai-actions button {
    padding: 8px 14px;
    border-radius: 12px;
    border: 1px solid rgba(56,189,248,0.6);
    background: rgba(2,6,23,0.6);
    color: #38bdf8;
    cursor: pointer;
    font-size: 13px;
    font-weight: 600;
    backdrop-filter: blur(8px);
    transition: all 0.3s ease;
    box-shadow: 0 0 14px rgba(56,189,248,0.35);
}

.ai-actions button:hover {
    background: rgba(56,189,248,0.2);
    transform: translateY(-2px);
    box-shadow: 0 0 25px rgba(56,189,248,0.9);
}






</style>

</head>
<body>

<!-- VIDEO BACKGROUND -->
<video class="bg-video" autoplay muted loop>
    <source src="${pageContext.request.contextPath}/assets/video/Ai-chat-bg.mp4" type="video/mp4">
</video>
<div class="bg-overlay"></div>



<button id="jarvisDockBtn" class="quick-btn">
    🔽 Dock Chat
</button>


<audio id="dockSound" preload="auto">
    <source src="${pageContext.request.contextPath}/assets/sounds/Close-chat-sound.mp3" type="audio/mpeg">
</audio>

<audio id="undockSound" preload="auto">
    <source src="${pageContext.request.contextPath}/assets/sounds/Start-chat-sound1.mp3" type="audio/mpeg">
</audio>




<div class="chat-box">

    <div class="chat-header">
        <img src="${pageContext.request.contextPath}/assets/images/ai-logo.gif" class="chat-logo">
        <h2>ASmitra AI</h2>
    </div>
    
      <div id="thinkingHUD" class="thinking-hud d-none">
    <div class="scan-line"></div>
    <span>Analyzing..</span>
   </div>

    <div class="quick-actions">
        <button class="quick-btn" onclick="sendMessage('Write a birthday wish')">🎂 Birthday</button>
        <button class="quick-btn" onclick="sendMessage('Write an anniversary message')">💍 Anniversary</button>
        <button class="quick-btn" onclick="sendMessage('Explain today’s important events')">📅 Events</button>
        <button class="quick-btn" onclick="sendMessage('Write a professional email')">📧 Email</button>
          <button id="voiceToggleBtn"
        class="quick-btn"
        onclick="toggleVoice()">
        🔊 Voice ON
      </button>
    </div>

    <div class="messages">
    <div class="ai thinking d-none" id="thinking">
   
    </div>
    </div>

    <div class="chat-input">
  
    
    
    <input type="text" id="msg" placeholder="Message ASmitra…" />
    
    <button id="micBtn" class="quick-btn mic-btn" onclick="startListening()">
    🎙️
</button>
    
    <button class="send" onclick="sendMessage()">Send</button>
</div>


</div>


<script>
/* ================= GLOBAL STATE ================= */
let voiceEnabled = localStorage.getItem("voiceEnabled") !== "false";

/* ================= VOICE TOGGLE ================= */
function toggleVoice() {
    voiceEnabled = !voiceEnabled;
    localStorage.setItem("voiceEnabled", voiceEnabled);

    const btn = document.getElementById("voiceToggleBtn");
    if (!btn) return;

    if (voiceEnabled) {
        btn.textContent = "🔊 Voice ON";
        btn.style.boxShadow = "0 0 12px #38bdf8";
    } else {
        btn.textContent = "🔇 Voice OFF";
        btn.style.boxShadow = "none";
        window.speechSynthesis.cancel();
    }
}

/* ================= JARVIS VOICE ================= */
function speakJarvis(text) {
    if (!voiceEnabled) return;
    if (!("speechSynthesis" in window)) return;

    window.speechSynthesis.cancel();

    const utterance = new SpeechSynthesisUtterance(text);
    utterance.rate = 0.9;
    utterance.pitch = 0.85;
    utterance.volume = 0.9;

    const voices = window.speechSynthesis.getVoices();
    const jarvisVoice =
        voices.find(v => v.name.toLowerCase().includes("male")) ||
        voices.find(v => v.lang === "en-US");

    if (jarvisVoice) utterance.voice = jarvisVoice;
    window.speechSynthesis.speak(utterance);
}

/* ================= SEND MESSAGE ================= */
function sendMessage(text = null) {

    const input = $("#msg");
    const message = text ? text : input.val();

    if ($.trim(message) === "") return;

    $(".messages").append(
        "<div class='user'><span>" + message + "</span></div>"
    );

    input.val("");
    $(".messages").scrollTop($(".messages")[0].scrollHeight);

    const loading = $("<div class='loading'>ASmitra is processing...</div>");
    $(".messages").append(loading);

    $.post(
        "${pageContext.request.contextPath}/OpenAI/chat/send",
        { message: message },
        function (data) {

            loading.remove();

            let formatted = $("<textarea/>").html(data).text();

            /* ---------- STRUCTURE EMAIL / TEXT ---------- */

            // Normalize line breaks
            formatted = formatted.replace(/\r\n|\r|\n/g, "\n");

            // Format Subject line
            formatted = formatted.replace(
                /Subject\s*:\s*(.*)/i,
                "<strong>Subject:</strong> $1<br><br>"
            );

            // Add line break after greeting
            formatted = formatted.replace(
                /(Dear\s+[A-Za-z]+)/i,
                "$1,<br><br>"
            );

            // Convert new lines to HTML
            formatted = formatted.replace(/\n/g, "<br>");

            // Clean extra breaks
            formatted = formatted.replace(/(<br>\s*){3,}/gi, "<br><br>");

            /* AI MESSAGE */
            let aiSpan = $("<span></span>");
            let aiDiv = $("<div class='ai'></div>").append(aiSpan);
            $(".messages").append(aiDiv);

            /* TYPE EFFECT */
            aiSpan.html(formatted);
			speakJarvis(formatted.replace(/<[^>]+>/g, ""));

            /* 🔥 ONE-CLICK ACTIONS */
            let actions = generateActions(formatted);

            if (actions.length > 0) {
                let actionBar = $("<div class='ai-actions'></div>");

                actions.forEach(a => {
                    let btn = $("<button></button>").text(a.label);
                    btn.on("click", a.action);
                    actionBar.append(btn);
                });

                aiDiv.append(actionBar);
            }

        }
    );
    $("#thinkingHUD").removeClass("d-none");
    $("#thinkingHUD").addClass("d-none");


}

/* ================= ENTER KEY ================= */
$(document).ready(function () {

    const btn = document.getElementById("voiceToggleBtn");
    if (btn) {
        btn.textContent = voiceEnabled ? "🔊 Voice ON" : "🔇 Voice OFF";
        if (voiceEnabled) btn.style.boxShadow = "0 0 12px #38bdf8";
    }

    $("#msg").on("keydown", function (e) {
        if (e.key === "Enter") {
            e.preventDefault();
            sendMessage();
        }
    });

    const welcome =
        "👋 Welcome to ASmitra AI\n\n" +
        "I assist with reminders, emails, wishes, and smart insights.";

    const welcomeDiv = $("<div class='ai'><span></span></div>");
    welcomeDiv.find("span").text(welcome);
    $(".messages").append(welcomeDiv);
});

/* ================= CINEMATIC TYPING ================= */
function typeText(element, text) {
    let i = 0;
    element.text("");

    // OPTIONAL: soft typing sound (comment out if not needed)
    const typeSound = new Audio(
        "https://assets.mixkit.co/sfx/preview/mixkit-soft-interface-click-1125.mp3"
    );
    typeSound.volume = 0.15;

    function getDelay(char) {
        // Natural pauses (Jarvis-like)
        if (char === "." || char === "!" || char === "?") return 450;
        if (char === ",") return 280;
        if (char === "\n") return 320;

        // Base typing speed
        return i < 30 ? 45 : i < 120 ? 70 : 95;
    }

    function type() {
        const char = text.charAt(i);
        element.text(element.text() + char);
        i++;

        // Glow while typing
        element.css("text-shadow", "0 0 12px #38bdf8");

        // Play typing sound occasionally (not every char)
        if (char.trim() && Math.random() > 0.6) {
            typeSound.currentTime = 0;
            typeSound.play().catch(() => {});
        }

        // Auto-scroll
        $(".messages").scrollTop($(".messages")[0].scrollHeight);

        if (i < text.length) {
            setTimeout(type, getDelay(char));
        } else {
            // Stop glow
            element.css("text-shadow", "none");

            // 🔊 Speak AFTER typing finishes (true Jarvis behavior)
            speakJarvis(text);
        }
    }

    type();
}



/* ================= MIC LISTENING MODE (GLOBAL FIX) ================= */
let recognition;
let isListening = false;

function startListening() {

    if (!("webkitSpeechRecognition" in window)) {
        alert("Speech recognition not supported in this browser.");
        return;
    }

    if (isListening) {
        recognition.stop();
        return;
    }

    recognition = new webkitSpeechRecognition();
    recognition.lang = "en-US";
    recognition.interimResults = false;
    recognition.continuous = false;

    const micBtn = document.getElementById("micBtn");
    micBtn.classList.add("listening");
    isListening = true;

    recognition.start();

    recognition.onresult = function (event) {
        const transcript = event.results[0][0].transcript;
        $("#msg").val(transcript);
        micBtn.classList.remove("listening");
        isListening = false;
        sendMessage();
    };

    recognition.onerror = function () {
        micBtn.classList.remove("listening");
        isListening = false;
    };

    recognition.onend = function () {
        micBtn.classList.remove("listening");
        isListening = false;
    };
}



/* ================= AI ONE-CLICK ACTIONS ================= */
function generateActions(aiText) {

    aiText = aiText.toLowerCase();
    let actions = [];

    if (aiText.includes("event") || aiText.includes("birthday") || aiText.includes("anniversary")) {
        actions.push({
            label: "📅 Create Event",
            action: () => window.location.href = "${pageContext.request.contextPath}/event/add"
        });
    }

    if (aiText.includes("calendar") || aiText.includes("schedule")) {
        actions.push({
            label: "🗓 Open Calendar",
            action: () => window.location.href = "${pageContext.request.contextPath}/calendar"
        });
    }

    if (aiText.includes("email") || aiText.includes("mail")) {
        actions.push({
            label: "📧 Schedule Email",
            action: () => window.location.href = "${pageContext.request.contextPath}/email/schedule"
        });
    }

    return actions;
}




/* ================= SAFE DOCK SYSTEM ================= */

(function () {

    const chatBox = document.querySelector(".chat-box");
    const dockBtn = document.getElementById("jarvisDockBtn");

    const dockSound = document.getElementById("dockSound");
    const undockSound = document.getElementById("undockSound");

    if (!chatBox || !dockBtn) {
        console.error("Chat box or dock button not found");
        return;
    }

    let docked = false;

    dockBtn.addEventListener("click", function () {

        // ===== DOCK CHAT =====
        if (!docked) {
            dockSound.currentTime = 0;
            dockSound.play().catch(() => {});

            chatBox.classList.add("docked");
            dockBtn.textContent = "🔼 Undock Chat";

            if ("speechSynthesis" in window) {
                window.speechSynthesis.cancel();
            }

            docked = true;
        }

        // ===== UNDOCK CHAT =====
        else {
            undockSound.currentTime = 0;
            undockSound.play().catch(() => {});

            chatBox.classList.remove("docked");
            dockBtn.textContent = "🔽 Dock Chat";

            docked = false;
        }
    });

})();
</script>

</body>
</html>