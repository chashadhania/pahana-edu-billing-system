<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Inventory Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <style>
        .card-hover:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }
        .action-btns .btn {
            margin: 0 3px;
        }
        .table-responsive {
            overflow-x: auto;
        }
        .alert {
            margin-bottom: 1rem;
        }
    </style>
</head>
<body class="bg-light">
    <div class="container py-5">
        <div class="card shadow">
            <div class="card-header bg-primary text-white">
                <div class="d-flex justify-content-between align-items-center">
                    <h3 class="mb-0">
                        <i class="fas fa-boxes me-2"></i>Bookstore Management
                    </h3>
                    <a href="ItemServlet?action=add" class="btn btn-light">
                        <i class="fas fa-plus me-1"></i> Add New Item
                    </a>
                </div>
            </div>
            
            <div class="card-body">
                <%-- Display session messages --%>
                <c:if test="${not empty sessionScope.message}">
                    <div class="alert alert-success alert-dismissible fade show">
                        <i class="fas fa-check-circle me-2"></i>${sessionScope.message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        <c:remove var="message" scope="session"/>
                    </div>
                </c:if>
                <c:if test="${not empty sessionScope.error}">
                    <div class="alert alert-danger alert-dismissible fade show">
                        <i class="fas fa-exclamation-circle me-2"></i>${sessionScope.error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        <c:remove var="error" scope="session"/>
                    </div>
                </c:if>
                
                <%-- Display request messages (for non-redirect cases) --%>
                <c:if test="${not empty requestScope.message}">
                    <div class="alert alert-success alert-dismissible fade show">
                        <i class="fas fa-check-circle me-2"></i>${requestScope.message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                <c:if test="${not empty requestScope.error}">
                    <div class="alert alert-danger alert-dismissible fade show">
                        <i class="fas fa-exclamation-circle me-2"></i>${requestScope.error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Total Value</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${items}" var="item">
                                <tr>
                                    <td>${item.itemId}</td>
                                    <td>${item.name}</td>
                                    <td><fmt:formatNumber value="${item.price}" type="currency" currencySymbol="Rs."/></td>
                                    <td>${item.quantity}</td>
                                    <td><fmt:formatNumber value="${item.price * item.quantity}" type="currency" currencySymbol="Rs. "/></td>
                                    <td class="action-btns">
                                        <a href="ItemServlet?action=edit&itemId=${item.itemId}" 
                                           class="btn btn-sm btn-primary">
                                            <i class="fas fa-edit"></i> Edit
                                        </a>
                                        <button class="btn btn-sm btn-danger delete-btn" 
                                                data-itemid="${item.itemId}"
                                                data-itemname="${item.name}">
                                            <i class="fas fa-trash"></i> Delete
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty items}">
                                <tr>
                                    <td colspan="6" class="text-center">No items found</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <div class="card-footer text-center">
                <a href="Views/dashboard.jsp" class="btn btn-secondary">
                    <i class="fas fa-arrow-left me-1"></i> Back to Dashboard
                </a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
    // Enhanced delete confirmation with SweetAlert
   // Enhanced delete confirmation with SweetAlert
document.querySelectorAll('.delete-btn').forEach(btn => {
    btn.addEventListener('click', function() {
        const itemId = this.getAttribute('data-itemid');
        const itemName = this.getAttribute('data-itemname');
        
        Swal.fire({
            title: 'Delete Item?',
            html: `Are you sure you want to delete <strong>${itemName}</strong> (ID: ${itemId})?`,
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
            confirmButtonText: 'Yes, delete it!',
            cancelButtonText: 'Cancel',
            reverseButtons: true
        }).then((result) => {
            if (result.isConfirmed) {
                // Create a form and submit via POST
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'ItemServlet';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'delete';
                form.appendChild(actionInput);
                
                const itemIdInput = document.createElement('input');
                itemIdInput.type = 'hidden';
                itemIdInput.name = 'itemId';
                itemIdInput.value = itemId;
                form.appendChild(itemIdInput);
                
                document.body.appendChild(form);
                form.submit();
            }
        });
    });
});
    
    // Auto-close alerts after 5 seconds
    setTimeout(() => {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => {
            const bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        });
    }, 5000);
    </script>
</body>
</html>