<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Event</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <!-- Custom Css -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/editEvent.css">
    
</head>

<body>

<div class="edit-card">

    <h2>✏️ Edit Event</h2>

    <form action="../save" method="post">

        <input type="hidden" name="id" value="${event.id}">

        <div class="field">
            <label>Title</label>
            <input type="text" name="title" value="${event.title}" required>
        </div>

        <div class="field">
            <label>Date</label>
            <input type="date" name="eventDate" value="${event.eventDate}" required>
        </div>

        <div class="field">
            <label>Category</label>
            <select name="category">
                <option value="MEETING" ${event.category == 'MEETING' ? 'selected' : ''}>Meeting</option>
                <option value="HOLIDAY" ${event.category == 'HOLIDAY' ? 'selected' : ''}>Holiday</option>
                <option value="REMINDER" ${event.category == 'REMINDER' ? 'selected' : ''}>Reminder</option>
                <option value="PERSONAL" ${event.category == 'PERSONAL' ? 'selected' : ''}>Personal</option>
                <option value="BIRTHDAY" ${event.category == 'BIRTHDAY' ? 'selected' : ''}>Birthday</option>
                <option value="ANNIVERSARY" ${event.category == 'ANNIVERSARY' ? 'selected' : ''}>Anniversary</option>
                <option value="FESTIVAL" ${event.category == 'FESTIVAL' ? 'selected' : ''}>Festival</option>
                <option value="APPOINTMENT" ${event.category == 'APPOINTMENT' ? 'selected' : ''}>Appointment</option>
                <option value="EXAM" ${event.category == 'EXAM' ? 'selected' : ''}>Exam</option>
                <option value="INTERVIEW" ${event.category == 'INTERVIEW' ? 'selected' : ''}>Interview</option>
                <option value="WORKSHOP" ${event.category == 'WORKSHOP' ? 'selected' : ''}>Workshop</option>
                <option value="TRAINING" ${event.category == 'TRAINING' ? 'selected' : ''}>Training</option>
                <option value="DEADLINE" ${event.category == 'DEADLINE' ? 'selected' : ''}>Deadline</option>
                <option value="PAYMENT" ${event.category == 'PAYMENT' ? 'selected' : ''}>Payment / Bill Due</option>
                <option value="TRAVEL" ${event.category == 'TRAVEL' ? 'selected' : ''}>Travel</option>
                <option value="EVENT" ${event.category == 'EVENT' ? 'selected' : ''}>Special Event</option>
                <option value="HEALTH" ${event.category == 'HEALTH' ? 'selected' : ''}>Health / Medical</option>
                <option value="OTHER" ${event.category == 'OTHER' ? 'selected' : ''}>Other</option>
            </select>
        </div>

        <div class="field">
            <label>Description</label>
            <textarea name="description" rows="4">${event.description}</textarea>
        </div>

        <div class="field">
            <label>Reminder Days Before</label>
            <input type="number" name="reminderDaysBefore" value="${event.reminderDaysBefore}">
        </div>

        <div class="row g-3 mt-3">
            <div class="col-12 col-md-6">
                <button type="submit" class="btn-update w-100">
                    Update Event
                </button>
            </div>
            <div class="col-12 col-md-6">
                <a href="javascript:history.back()" class="btn btn-cancel w-100">
                    Cancel
                </a>
            </div>
        </div>

    </form>

</div>

</body>
</html>
