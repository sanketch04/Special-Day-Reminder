<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>ASmitra | Special Day Reminder</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Flatpickr -->
    <link href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css" rel="stylesheet">

<!-- Custom css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/sendEmail.css">

    
</head>

<body>

<div class="card-wrapper">

    <h2>📅 Schedule Email</h2>

    <form action="${pageContext.request.contextPath}/email/schedule" method="post">

        <div class="field">
            <label>Event Info</label>
            <input type="text" name="eventInfo"
                   placeholder="Birthday, Anniversary, Reminder..."
                   required>
            <i class="bi bi-calendar-event"></i>
        </div>

        <div class="field">
            <label>Receiver Email</label>
            <input type="email" name="receiverEmail"
                   placeholder="example@email.com"
                   required>
            <i class="bi bi-envelope"></i>
        </div>

        <div class="field">
            <label>Message</label>
            <textarea name="message" rows="4"
                      placeholder="Write your message here..."
                      required></textarea>
            <i class="bi bi-chat-text"></i>
        </div>

        <div class="row">
            <div class="col-md-6">
                <div class="field">
                    <label>Send Date</label>
                    <input type="text" id="sendDate" name="sendDate" required>
                    <i class="bi bi-calendar3"></i>
                </div>
            </div>

            <div class="col-md-6">
                <div class="field">
                    <label>Send Time</label>
                    <input type="text" id="sendTime" name="sendTime" required>
                    <i class="bi bi-clock"></i>
                </div>
            </div>
        </div>

        <button type="submit" class="btn-submit w-100">
            Schedule Email
        </button>

    </form>

</div>

<!-- SUCCESS MODAL -->
<div class="modal fade" id="successModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <div class="modal-header bg-success text-white">
                <h5 class="modal-title">Success</h5>
                <button class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">
                ✅ Email scheduled successfully!
            </div>

            <div class="modal-footer">
                <button class="btn btn-success" data-bs-dismiss="modal">
                    OK
                </button>
            </div>

        </div>
    </div>
</div>

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

<script>
flatpickr("#sendDate", {
    dateFormat: "Y-m-d",
    minDate: "today",
    allowInput: true
});

flatpickr("#sendTime", {
    enableTime: true,
    noCalendar: true,
    dateFormat: "H:i",   // ✅ 24-hour only
    time_24hr: true      // ✅ backend safe
});
</script>

<script>
(function () {
    const params = new URLSearchParams(window.location.search);
    if (params.get("scheduled") === "true") {
        new bootstrap.Modal(
            document.getElementById("successModal")
        ).show();

        params.delete("scheduled");
        history.replaceState({}, "", window.location.pathname);
    }
})();
</script>

</body>
</html>
