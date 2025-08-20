<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Error - Pahana Edu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --error-color: #e74c3c;
            --light-color: #f8f9fa;
        }
        body {
            background-color: var(--light-color);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .error-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            text-align: center;
        }
        .error-icon {
            font-size: 5rem;
            color: var(--error-color);
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-icon">
            <i class="fas fa-exclamation-triangle"></i>
        </div>
        <h2>Oops! Something went wrong</h2>
        <div class="alert alert-danger mt-4">
            <p><%= request.getAttribute("error") != null ? request.getAttribute("error") : "An unexpected error occurred" %></p>
        </div>
        <a href="${pageContext.request.contextPath}/CustomerServlet" class="btn btn-primary mt-3">
            <i class="fas fa-arrow-left me-2"></i>Back to Customer List
        </a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>