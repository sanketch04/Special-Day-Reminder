<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Day Planner</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(120deg, #1d2671, #c33764);
            padding: 30px;
            color: #333;
        }

        .table-container {
            background: #fff;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
            animation: fadeIn 1s ease-in-out;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #1d2671;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: #1d2671;
            color: white;
        }

        th, td {
            padding: 12px;
            text-align: center;
        }

        tbody tr {
            transition: all 0.3s ease;
        }

        tbody tr:hover {
            background: #f0f0ff;
            transform: scale(1.01);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .status {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
        }

        .COMPLETED {
            background: #e6fffa;
            color: #047857;
        }

        .RUNNING {
            background: #fff7ed;
            color: #c2410c;
        }

        .badge {
            padding: 6px 10px;
            border-radius: 6px;
            color: white;
            font-size: 12px;
        }

        .yes {
            background: #16a34a;
        }

        .no {
            background: #dc2626;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>

<body>

<div class="table-container">
    <h2>📅 Day Planner Records</h2>

    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Plan Date</th>
            <th>Start Time</th>
            <th>End Time</th>
            <th>Status</th>
            <th>Plan Date</th>
            <th>Last Status Change</th>
        </tr>
        </thead>

        <tbody>
        <c:forEach var="dp" items="${dayPlan}">
            <tr>
                <td>${dp.id}</td>
                <td>${dp.title}</td>
                <td>${dp.planDate}</td>
                <td>${dp.startTime}</td>
                <td>${dp.endTime}</td>
                <td>
                    <span class="status ${dp.status}">
                        ${dp.status}
                    </span>
                </td>
                <td>
                    <span class="status ${dp.status}">
                        ${dp.planDate}
                    </span>
                </td>
                
                <td>${dp.lastStatusChange}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>
