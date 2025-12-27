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

    <label>Category</label><br>
<select name="category" style="width:100%">

    <option value="MEETING"
        ${event.category == 'MEETING' ? 'selected="selected"' : ''}>
        Meeting
    </option>

    <option value="HOLIDAY"
        ${event.category == 'HOLIDAY' ? 'selected="selected"' : ''}>
        Holiday
    </option>

    <option value="REMINDER"
        ${event.category == 'REMINDER' ? 'selected="selected"' : ''}>
        Reminder
    </option>

    <option value="PERSONAL"
        ${event.category == 'PERSONAL' ? 'selected="selected"' : ''}>
        Personal
    </option>

    <option value="BIRTHDAY"
        ${event.category == 'BIRTHDAY' ? 'selected="selected"' : ''}>
        Birthday
    </option>

    <option value="ANNIVERSARY"
        ${event.category == 'ANNIVERSARY' ? 'selected="selected"' : ''}>
        Anniversary
    </option>

    <option value="FESTIVAL"
        ${event.category == 'FESTIVAL' ? 'selected="selected"' : ''}>
        Festival
    </option>

    <option value="APPOINTMENT"
        ${event.category == 'APPOINTMENT' ? 'selected="selected"' : ''}>
        Appointment
    </option>

    <option value="EXAM"
        ${event.category == 'EXAM' ? 'selected="selected"' : ''}>
        Exam
    </option>

    <option value="INTERVIEW"
        ${event.category == 'INTERVIEW' ? 'selected="selected"' : ''}>
        Interview
    </option>

    <option value="WORKSHOP"
        ${event.category == 'WORKSHOP' ? 'selected="selected"' : ''}>
        Workshop
    </option>

    <option value="TRAINING"
        ${event.category == 'TRAINING' ? 'selected="selected"' : ''}>
        Training
    </option>

    <option value="DEADLINE"
        ${event.category == 'DEADLINE' ? 'selected="selected"' : ''}>
        Deadline
    </option>

    <option value="PAYMENT"
        ${event.category == 'PAYMENT' ? 'selected="selected"' : ''}>
        Payment / Bill Due
    </option>

    <option value="TRAVEL"
        ${event.category == 'TRAVEL' ? 'selected="selected"' : ''}>
        Travel
    </option>

    <option value="EVENT"
        ${event.category == 'EVENT' ? 'selected="selected"' : ''}>
        Special Event
    </option>

    <option value="HEALTH"
        ${event.category == 'HEALTH' ? 'selected="selected"' : ''}>
        Health / Medical
    </option>

    <option value="OTHER"
        ${event.category == 'OTHER' ? 'selected="selected"' : ''}>
        Other
    </option>

</select><br><br>


    Description:<br>
    <textarea name="description">${event.description}</textarea><br><br>

    Reminder Days Before:
    <input type="number" name="reminderDaysBefore" value="${event.reminderDaysBefore}"><br><br>

    <button type="submit">Update</button>
</form>

</body>
</html>
