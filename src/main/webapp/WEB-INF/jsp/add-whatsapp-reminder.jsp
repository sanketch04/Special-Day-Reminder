<!-- <%@ page contentType="text/html;charset=UTF-8" %>

<h2>Add Reminder</h2>

<form action="${pageContext.request.contextPath}/whatsapp/save" method="post">

    <label>Event Name</label><br>
    <input type="text" name="eventName" required><br><br>

    <label>Category</label><br>
    <input type="text" name="category" required><br><br>

    <label>Message</label><br>
    <textarea name="message" rows="4" required></textarea><br><br>

    <label>WhatsApp Number</label><br>
    <input type="text" name="whatsappNumber" placeholder="919876543210"><br><br>

    <label>Email</label><br>
    <input type="email" name="email"><br><br>

    <label>Event Date</label><br>
    <input type="date" name="eventDate" required><br><br>

    <label>Event Time</label><br>
    <input type="time" name="eventTime" required><br><br>

    <input type="checkbox" name="sendWhatsApp"> Send WhatsApp<br>
    <input type="checkbox" name="sendEmail"> Send Email<br><br>

    <button type="submit">Save Reminder</button>

</form> -->
