<title>Special Day Reminder</title>
<h2>Schedule Email</h2>

<form action="${pageContext.request.contextPath}/email/schedule" method="post">

    <label>Event Info</label><br>
    <input type="text" name="eventInfo" required><br><br>

    <label>Receiver Email</label><br>
    <input type="email" name="receiverEmail" required><br><br>

    <label>Message</label><br>
    <textarea name="message" required></textarea><br><br>

    <label>Send Date</label><br>
    <input type="date" name="sendDate" required><br><br>

    <label>Send Time</label><br>
    <input type="date" name="sendDate" required><br><br>

    <button type="submit">Schedule Email</button>

</form>

<script>
document.addEventListener("wheel", function (event) {
    if (document.activeElement.type === "date") {
        document.activeElement.blur();
    }
}, { passive: true });
</script>
