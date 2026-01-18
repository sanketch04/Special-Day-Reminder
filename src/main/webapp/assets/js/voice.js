const voiceBtn = document.getElementById("voiceBtn");

const SpeechRecognition =
    window.SpeechRecognition || window.webkitSpeechRecognition;

if (!SpeechRecognition) {
    alert("Speech Recognition not supported. Use Chrome.");
}

const recognition = new SpeechRecognition();
recognition.lang = "en-IN";
recognition.continuous = false;

// Start listening
voiceBtn.addEventListener("click", () => {
    recognition.start();
    voiceBtn.classList.add("listening");
});

// Get voice input
recognition.onresult = (event) => {
    const command = event.results[0][0].transcript.toLowerCase().trim();
    console.log("Voice Command:", command);
    handleVoiceCommand(command);
};

// Stop animation
recognition.onend = () => {
    voiceBtn.classList.remove("listening");
};

// ================= VOICE COMMAND HANDLER =================

function handleVoiceCommand(command) {

    // Dashboard
    if (command.includes("dashboard")) {
        speak("Opening dashboard");
        window.location.href = "/SDR/dashboard";
    }

    // Calendar
    else if (command.includes("calendar")) {
        speak("Opening calendar");
        window.location.href = "/SDR/calendar";
    }
	
	else if (command.includes("schedule email")) {
	       speak("Opening Email");
	       window.location.href = "/SDR/email/schedule";
	   }

    // ✅ ADD EVENT (YOUR REQUIREMENT)
    else if (command.includes("add event") || command.includes("add new event")) {
        speak("Opening add event page");
        window.location.href = "/SDR/event/add";
    }

    else {
        speak("Sorry, I did not understand");
    }
}

// ================= TEXT TO SPEECH =================

function speak(text) {
    const speech = new SpeechSynthesisUtterance(text);
    speech.lang = "en-IN";
    speech.rate = 1;
    window.speechSynthesis.speak(speech);
}