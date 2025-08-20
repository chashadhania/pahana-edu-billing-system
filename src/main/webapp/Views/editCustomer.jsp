<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<html>
<head>
    <title>Edit Customer - Pahana Edu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Same styles as addCustomer.jsp */
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
        
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .btn-primary:hover {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
        }
        
        .btn-danger {
            background-color: var(--accent-color);
            border-color: var(--accent-color);
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
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
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h4 class="mb-0"><i class="fas fa-user-edit me-2"></i>Edit Customer</h4>
                        <a href="${pageContext.request.contextPath}/CustomerServlet" class="btn btn-sm btn-light">
                            <i class="fas fa-arrow-left me-1"></i> Back to List
                        </a>
                    </div>
                    <div class="card-body">
                        <% if (request.getAttribute("message") != null) { %>
                            <div class="message success">
                                <i class="fas fa-check-circle me-2"></i><%= request.getAttribute("message") %>
                            </div>
                        <% } %>
                        <% if (request.getAttribute("error") != null) { %>
                            <div class="message error">
                                <i class="fas fa-exclamation-circle me-2"></i><%= request.getAttribute("error") %>
                            </div>
                        <% } %>
                        
                        <% Customer customer = (Customer) request.getAttribute("customer"); %>
                        <form action="${pageContext.request.contextPath}/CustomerServlet" method="post">
                            <input type="hidden" name="action" value="edit">
                            <input type="hidden" name="accountNumber" value="<%= customer.getAccountNumber() %>">
                            
                            <div class="mb-3">
                                <label class="form-label">
                                    <i class="fas fa-id-card me-1"></i>Account Number
                                </label>
                                <input type="text" class="form-control" value="<%= customer.getAccountNumber() %>" disabled>
                            </div>
                            
                            <div class="mb-3">
                                <label for="name" class="form-label">
                                    <i class="fas fa-user me-1"></i>Customer Name
                                </label>
                                <input type="text" class="form-control" id="name" name="name" 
                                       value="<%= customer.getName() %>" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="address" class="form-label">
                                    <i class="fas fa-map-marker-alt me-1"></i>Address
                                </label>
                                <input type="text" class="form-control" id="address" name="address" 
                                       value="<%= customer.getAddress() %>" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="telephone" class="form-label">
                                    <i class="fas fa-phone me-1"></i>Telephone
                                </label>
                                <input type="text" class="form-control" id="telephone" name="telephone" 
                                       value="<%= customer.getTelephone() %>" required>
                            </div>
                            
                            <div class="mb-4">
                                <label for="unitsConsumed" class="form-label">
                                    <i class="fas fa-bolt me-1"></i>Units Consumed
                                </label>
                                <input type="number" class="form-control" id="unitsConsumed" name="unitsConsumed" 
                                       value="<%= customer.getUnitsConsumed() %>" required>
                            </div>
                            
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-1"></i>Update Customer
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