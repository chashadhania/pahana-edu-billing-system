<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<%@ page import="java.util.List" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<html>
<head>
    <title>Customer List - Pahana Edu</title>
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
        
        .table-responsive {
            border-radius: 0 0 10px 10px;
            overflow: hidden;
        }
        
        .table {
            margin-bottom: 0;
        }
        
        .table th {
            background-color: var(--light-color);
            border-top: none;
        }
        
        .table-hover tbody tr:hover {
            background-color: rgba(52, 152, 219, 0.1);
        }
        
        .btn-sm {
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
        }
        
        .action-btns .btn {
            margin-right: 5px;
        }
        
        .add-btn {
            margin-bottom: 20px;
        }
        
        .no-data {
            text-align: center;
            padding: 20px;
            color: #6c757d;
        }
        .swal2-popup {
    border-radius: 10px !important;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15) !important;
}

.swal2-title {
    color: var(--dark-color) !important;
    font-size: 1.5rem !important;
}

.swal2-html-container {
    font-size: 1.1rem !important;
    color: #495057 !important;
}

.swal2-confirm {
    background-color: var(--accent-color) !important;
    border: none !important;
    padding: 8px 20px !important;
}

.swal2-cancel {
    background-color: var(--light-color) !important;
    color: var(--dark-color) !important;
    border: none !important;
    padding: 8px 20px !important;
}
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h4 class="mb-0"><i class="fas fa-users me-2"></i>Customer Management</h4>
                        <a href="${pageContext.request.contextPath}/Views/addCustomer.jsp" class="btn btn-light btn-sm">
                            <i class="fas fa-plus me-1"></i> Add New
                        </a>
                    </div>
                    
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Account No.</th>
                                    <th>Name</th>
                                    <th>Address</th>
                                    <th>Telephone</th>
                                    <th>Units</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% List<Customer> customers = (List<Customer>) request.getAttribute("customers"); %>
                                <% if (customers != null && !customers.isEmpty()) { %>
                                    <% int counter = 1; %>
                                    <% for (Customer customer : customers) { %>
                                        <tr>
                                            <td><%= counter++ %></td>
                                            <td><%= customer.getAccountNumber() %></td>
                                            <td><%= customer.getName() %></td>
                                            <td><%= customer.getAddress() %></td>
                                            <td><%= customer.getTelephone() %></td>
                                            <td><%= customer.getUnitsConsumed() %></td>
                                            <td class="action-btns">
                                                <a href="${pageContext.request.contextPath}/CustomerServlet?action=edit&accountNumber=<%= customer.getAccountNumber() %>" 
                                                   class="btn btn-primary btn-sm">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                               <form action="${pageContext.request.contextPath}/CustomerServlet" method="post" style="display:inline;" 
   											   id="deleteForm_<%= customer.getAccountNumber() %>" class="delete-form">
   												 <input type="hidden" name="action" value="delete">
   												 <input type="hidden" name="accountNumber" value="<%= customer.getAccountNumber() %>">
   												 <button type="button" class="btn btn-danger btn-sm delete-btn">
     											   <i class="fas fa-trash-alt"></i>
 												   </button>
												</form>
                                            </td>
                                        </tr>
                                    <% } %>
                                <% } else { %>
                                    <tr>
                                        <td colspan="7" class="no-data">
                                            <i class="fas fa-info-circle fa-2x mb-3"></i>
                                            <h5>No customers found</h5>
                                            <p>Click "Add New" to create your first customer</p>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
document.addEventListener('DOMContentLoaded', function() {
    // Handle all delete buttons
    document.querySelectorAll('.delete-btn').forEach(button => {
        button.addEventListener('click', function(e) {
            const form = this.closest('.delete-form');
            const accountNumber = form.querySelector('input[name="accountNumber"]').value;
            
            Swal.fire({
                title: 'Delete Customer',
                html: `<p>Are you sure you want to delete customer <strong>${accountNumber}</strong>?</p>
                       <p class="text-danger">This action cannot be undone!</p>`,
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#d33',
                cancelButtonColor: '#6c757d',
                confirmButtonText: 'Yes, delete it!',
                cancelButtonText: 'Cancel',
             
                customClass: {
                    popup: 'border-radius-10',
                    confirmButton: 'btn btn-danger',
                    cancelButton: 'btn btn-secondary'
                }
            }).then((result) => {
                if (result.isConfirmed) {
                    form.submit();
                }
            });
        });
    });
});
</script>

</body>
</html>