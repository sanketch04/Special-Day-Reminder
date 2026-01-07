<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<title>Special Day Reminder</title>
<h2>Edit Scheduled Email</h2>

<form action="${pageContext.request.contextPath}/email/update" method="post">

    <input type="hidden" name="id" value="${email.id}" />

    <label>Event Info</label><br>
    <input type="text" name="eventInfo"
           value="${email.eventInfo}" required><br><br>

    <label>Receiver Email</label><br>
    <input type="email" name="receiverEmail"
           value="${email.receiverEmail}" required><br><br>

    <label>Message</label><br>
    <textarea name="message" required>${email.message}</textarea><br><br>

    <label>Send Date</label><br>
    <input type="date" name="sendDate"
           value="${email.sendDate}" required><br><br>

    <label>Send Time</label><br>
    <input type="time" name="sendTime"
           value="${email.sendTime}" required><br><br>

    <button type="submit">Update Email</button>
    <a href="${pageContext.request.contextPath}/email/list">Cancel</a>

</form>
