<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Add New Item - Pahana Edu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
           --primary-color: #3498db;
            --secondary-color: #2980b9;
            --accent-color: #e74c3c;
            --light-color: #ecf0f1;
            --dark-color: #2c3e50;
        }
        
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .card {
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            border: none;
            margin-top: 30px;
        }
        
        .card-header {
            background-color: var(--primary-color);
            color: white;
            border-radius: 10px 10px 0 0 !important;
            padding: 15px 20px;
        }
        
        .btn-success {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .btn-success:hover {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
        }
        
        .btn-danger {
            background-color: var(--accent-color);
            border-color: var(--accent-color);
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(46, 204, 113, 0.25);
        }
        
        .action-btns .btn {
            margin-right: 5px;
        }
        
        .message {
            border-radius: 5px;
            padding: 10px;
            margin-bottom: 20px;
        }
        
        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .input-group-text {
            background-color: var(--light-color);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h4 class="mb-0"><i class="fas fa-box me-2"></i>Add New Item</h4>
                        <a href="${pageContext.request.contextPath}/ItemServlet" class="btn btn-sm btn-light">
                            <i class="fas fa-arrow-left me-1"></i> Back to List
                        </a>
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty message}">
                            <div class="message success">
                                <i class="fas fa-check-circle me-2"></i><c:out value="${message}"/>
                            </div>
                        </c:if>
                        <c:if test="${not empty error}">
                            <div class="message error">
                                <i class="fas fa-exclamation-circle me-2"></i><c:out value="${error}"/>
                            </div>
                        </c:if>
                        
                        <form action="${pageContext.request.contextPath}/ItemServlet" method="post">
                            <input type="hidden" name="action" value="add">
                            
                            <div class="mb-3">
                                <label for="name" class="form-label">
                                    <i class="fas fa-tag me-1"></i>Item Name
                                </label>
                                <input type="text" class="form-control" id="name" name="name" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="price" class="form-label">
                                    <i class=""></i>Price
                                </label>
                                <div class="input-group">
                                    <span class="input-group-text">RS</span>
                                    <input type="number" step="0.01" class="form-control" id="price" name="price" required>
                                </div>
                            </div>
                            
                            <div class="mb-4">
                                <label for="quantity" class="form-label">
                                    <i class="fas fa-cubes me-1"></i>Quantity
                                </label>
                                <input type="number" class="form-control" id="quantity" name="quantity" required>
                            </div>
                            
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-success">
                                    <i class="fas fa-save me-1"></i>Add Item
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>