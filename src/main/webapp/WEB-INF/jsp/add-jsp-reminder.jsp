<!--  
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Schedule WhatsApp Reminder</title>
</head>
<body>

<h2>Schedule WhatsApp Reminder</h2>

<form action="${pageContext.request.contextPath}/whatsapp/save" method="post">

    <label>Event Name</label><br>
    <input type="text" name="eventName" required><br><br>

    <label>Category</label><br>
    <input type="text" name="category" required><br><br>

    <label>WhatsApp Number</label><br>
    <input type="text" name="whatsappNumber"
           placeholder="91XXXXXXXXXX" required><br><br>

    <label>Message</label><br>
    <textarea name="message" rows="4" cols="40" required></textarea><br><br>

    <label>Date</label><br>
    <input type="date" name="eventDate" required><br><br>

    <label>Time</label><br>
    <input type="time" name="eventTime" required><br><br>

    <button type="submit">Schedule</button>

</form>

</body>
</html>
-->