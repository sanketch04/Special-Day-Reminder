<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Event</title>
</head>
<body>

<h2>Add Event-----</h2>

<form action="save" method="post">
    Title: <input type="text" name="title" required><br><br>
    Date: <input type="date" name="eventDate" required><br><br>

    Category:
    <select name="category">
        <option>Work</option>
        <option>Birthday</option>
        <option>Personal</option>
        <option>Meeting</option>
    </select><br><br>

    Description:<br>
    <textarea name="description"></textarea><br><br>

    Reminder Days Before:
    <input type="number" name="reminderDaysBefore" value="1"><br><br>

    <button type="submit">Save Event</button>
</form>

<a href="../dashboard">Back</a>

</body>
</html>
