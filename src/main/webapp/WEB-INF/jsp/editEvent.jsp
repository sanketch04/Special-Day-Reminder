<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Event</title>
</head>
<body>

<h2>Edit Event</h2>

<form action="../save" method="post">
    <input type="hidden" name="id" value="${event.id}">

    Title: <input type="text" name="title" value="${event.title}" required><br><br>
    Date: <input type="date" name="eventDate" value="${event.eventDate}" required><br><br>

    Category: <input type="text" name="category" value="${event.category}"><br><br>

    Description:<br>
    <textarea name="description">${event.description}</textarea><br><br>

    Reminder Days Before:
    <input type="number" name="reminderDaysBefore" value="${event.reminderDaysBefore}"><br><br>

    <button type="submit">Update</button>
</form>

</body>
</html>
