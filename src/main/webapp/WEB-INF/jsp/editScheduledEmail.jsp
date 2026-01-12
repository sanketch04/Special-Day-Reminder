<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>ASmitra | Special Day Reminder</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<!-- Custom Css -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/editScheduleEmail.css">

    
</head>

<body>

<div class="page-wrapper">
    <div class="editor-shell">

        <!-- Header -->
        <div class="mb-4">
            <div class="d-flex align-items-center gap-2 mb-1">
                <i class="bi bi-envelope-paper fs-4 text-primary"></i>
                <div class="page-title">Edit Scheduled Email</div>
            </div>
            <div class="page-subtitle">
                Modify email content, delivery date, or recipient details.
            </div>
        </div>

        <div class="divider"></div>

        <form action="${pageContext.request.contextPath}/email/update" method="post">

            <input type="hidden" name="id" value="${email.id}" />

            <!-- Event -->
            <div class="mb-4">
                <label class="form-label">Event Information</label>
                <input type="text"
                       class="form-control"
                       name="eventInfo"
                       value="${email.eventInfo}"
                       required>
                <div class="hint">Example: Birthday reminder for John</div>
            </div>

            <!-- Email -->
            <div class="mb-4">
                <label class="form-label">Recipient Email</label>
                <input type="email"
                       class="form-control"
                       name="receiverEmail"
                       value="${email.receiverEmail}"
                       required>
            </div>

            <!-- Message -->
            <div class="mb-3">
                <label class="form-label">Email Message</label>
                <textarea class="form-control"
                          name="message"
                          id="message"
                          rows="4"
                          required>${email.message}</textarea>
                <div class="d-flex justify-content-between mt-1">
                    <div class="hint">This message will be sent automatically</div>
                    <div class="char-count"><span id="charCount">0</span> chars</div>
                </div>
            </div>

            <!-- Schedule -->
            <div class="row mt-4">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Send Date</label>
                    <input type="date"
                           class="form-control"
                           name="sendDate"
                           value="${email.sendDate}"
                           required>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Send Time</label>
                    <input type="time"
                           class="form-control"
                           name="sendTime"
                           value="${email.sendTime}"
                           required>
                </div>
            </div>

            <!-- Actions -->
            <div class="action-bar">
                <a href="${pageContext.request.contextPath}/email/list"
                   class="btn btn-outline-secondary">
                    Cancel
                </a>

                <button type="submit" class="btn btn-primary">
                    Save Changes
                </button>
            </div>

        </form>

    </div>
</div>

<script>
    function updateCount() {
        $("#charCount").text($("#message").val().length);
    }
    updateCount();
    $("#message").on("input", updateCount);
</script>

</body>
</html>
