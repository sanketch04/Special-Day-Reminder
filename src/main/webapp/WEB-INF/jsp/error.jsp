<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Error | Special Day Reminder</title>

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, Helvetica, sans-serif;
            background: #f4f6f9;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .error-container {
            background: #ffffff;
            width: 420px;
            padding: 30px;
            border-radius: 8px;
            text-align: center;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        .error-code {
            font-size: 48px;
            font-weight: bold;
            color: #e74c3c;
            margin-bottom: 10px;
        }

        .error-title {
            font-size: 22px;
            margin-bottom: 15px;
            color: #333;
        }

        .error-message {
            color: #666;
            font-size: 15px;
            margin-bottom: 25px;
        }

        .error-actions a {
            display: inline-block;
            padding: 10px 18px;
            text-decoration: none;
            border-radius: 4px;
            font-size: 14px;
            margin: 5px;
        }

        .btn-primary {
            background: #3498db;
            color: #fff;
        }

        .btn-secondary {
            background: #95a5a6;
            color: #fff;
        }

        .btn-primary:hover {
            background: #2980b9;
        }

        .btn-secondary:hover {
            background: #7f8c8d;
        }
    </style>
</head>

<body>

<div class="error-container">
    <div class="error-code">Oops!</div>

    <div class="error-title">
        Something went wrong
    </div>

    <div class="error-message">
        ${error}
    </div>

    <div class="error-actions">
        <a href="${pageContext.request.contextPath}/login"
           class="btn-primary">
            Go to Login
        </a>

        <a href="javascript:history.back()"
           class="btn-secondary">
            Go Back
        </a>
    </div>
</div>

</body>
</html>
