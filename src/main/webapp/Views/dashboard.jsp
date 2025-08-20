<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String userRole = (String) session.getAttribute("role");
    if (userRole == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pahana EDU Management System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }
        
        body {
            background-color: #f4f4f4;
            color: #333;
            line-height: 1.6;
        }
        
        .container {
            width: 80%;
            margin: 20px auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        
        header {
            background: #3498db;
            color: #ffffff;
            padding: 20px 0;
            text-align: center;
            border-radius: 8px 8px 0 0;
            margin-bottom: 20px;
        }
        
        h1 {
            margin: 0;
            font-size: 24px;
        }
        
        .welcome-message {
            font-size: 18px;
            margin-bottom: 10px;
            color: #35424a;
            text-align: center;
        }
        
        .user-info {
            text-align: center;
            margin-bottom: 20px;
            padding: 10px;
            background-color: #e8f4fc;
            border-radius: 5px;
            font-weight: bold;
        }
        
        .user-role {
            display: inline-block;
            padding: 4px 12px;
            background-color: #2c3e50;
            color: white;
            border-radius: 15px;
            font-size: 14px;
            margin-left: 10px;
        }
        
        .dashboard-menu {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 15px;
            margin: 30px 0;
        }
        
        .menu-card {
            background: #fff;
            border: 1px solid #3498db;
            border-radius: 5px;
            padding: 20px;
            width: 200px;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }
        
        .menu-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .menu-card a {
            text-decoration: none;
            color: #35424a;
            font-weight: bold;
            display: block;
            margin-bottom: 10px;
        }
        
        .menu-card i {
            font-size: 24px;
            margin-bottom: 10px;
            color: #3498db;
        }
        
        .logout {
            text-align: center;
            margin-top: 30px;
        }
        
        .logout a {
            text-decoration: none;
            color: #3498db;
            font-weight: bold;
            padding: 10px 20px;
            border: 1px solid #3498db;
            border-radius: 5px;
            transition: all 0.3s;
        }
        
        .logout a:hover {
            background-color: #3498db;
            color: white;
        }
        
        .section-title {
            color: #35424a;
            border-bottom: 2px solid #3498db;
            padding-bottom: 5px;
            margin-top: 30px;
            text-align: center;
        }
        
        .restricted-section {
            opacity: 0.7;
            position: relative;
        }
        
        .restricted-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(255, 255, 255, 0.8);
            display: flex;
            justify-content: center;
            align-items: center;
            border-radius: 5px;
        }
        
        .restricted-text {
            background-color: #e74c3c;
            color: white;
            padding: 5px 10px;
            border-radius: 3px;
            font-weight: bold;
            font-size: 12px;
        }
        
        @media (max-width: 768px) {
            .container {
                width: 95%;
                padding: 15px;
            }
            
            .menu-card {
                width: 100%;
                max-width: 250px;
            }
        }
    </style>
    <!-- Add Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Pahana EDU Management System</h1>
        </header>
        
        <div class="welcome-message">
            Welcome back, <strong><%= session.getAttribute("username") %></strong>!
        </div>
        
        <div class="user-info">
            Role: <span class="user-role"><%= userRole %></span>
        </div>
        
        <!-- Customer Management - Admin only -->
        <h2 class="section-title">Customer Management</h2>
        <div class="dashboard-menu">
            <div class="menu-card <%= !"admin".equals(userRole) ? "restricted-section" : "" %>">
                <i class="fas fa-users"></i>
                <a href="../CustomerServlet">View Customers</a>
                <p>Manage all customer records</p>
                <% if (!"admin".equals(userRole)) { %>
                <div class="restricted-overlay">
                    <span class="restricted-text">Admin Only</span>
                </div>
                <% } %>
            </div>
            
            <div class="menu-card <%= !"admin".equals(userRole) ? "restricted-section" : "" %>">
                <i class="fas fa-user-plus"></i>
                <a href="addCustomer.jsp">Add New Customer</a>
                <p>Create new customer account</p>
                <% if (!"admin".equals(userRole)) { %>
                <div class="restricted-overlay">
                    <span class="restricted-text">Admin Only</span>
                </div>
                <% } %>
            </div>
            
            <div class="menu-card <%= !"admin".equals(userRole) ? "restricted-section" : "" %>">
                <i class="fas fa-search"></i>
                <a href="searchCustomer.jsp">Search Customers</a>
                <p>Find customer information</p>
                <% if (!"admin".equals(userRole)) { %>
                <div class="restricted-overlay">
                    <span class="restricted-text">Admin Only</span>
                </div>
                <% } %>
            </div>
        </div>
        
        <!-- BookStore Management - Admin, Manager, Cashier -->
        <h2 class="section-title">BookStore Management</h2>
        <div class="dashboard-menu">
            <div class="menu-card">
                <i class="fas fa-boxes"></i>
                <a href="../ItemServlet">View Items</a>
                <p>Browse all inventory items</p>
            </div>
            
            <div class="menu-card">
                <i class="fas fa-plus-circle"></i>
                <a href="addItem.jsp">Add New Item</a>
                <p>Add item to inventory</p>
            </div>
            
            <div class="menu-card">
                <i class="fas fa-chart-bar"></i>
                <a href="Help.jsp">Help Center</a>
                <p>Everything you need to know to use the Pahana Edu Bookshop System</p>
            </div>
        </div>
        
        <!-- Billing Management - Admin, Manager, Cashier -->
        <h2 class="section-title">Billing Management</h2>
        <div class="dashboard-menu">
            <div class="menu-card">
                <i class="fas fa-file-invoice-dollar"></i>
                <a href="../BillServlet?action=new">Create Bill</a>
                <p>Generate new invoices</p>
            </div>
            
            <div class="menu-card">
                <i class="fas fa-list-alt"></i>
                <a href="../BillServlet">View Bills</a>
                <p>Browse all invoices</p>
            </div>
            
            <div class="menu-card">
                <i class="fas fa-print"></i>
                <a href="printBill.jsp">Print Bill</a>
                <p>Print or download invoices</p>
            </div>
        </div>
        
        <div class="logout">
            <a href="../AuthServlet"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </div>

    <script>
        // JavaScript to handle restricted menu items
        document.addEventListener('DOMContentLoaded', function() {
            const restrictedCards = document.querySelectorAll('.restricted-section');
            
            restrictedCards.forEach(card => {
                card.addEventListener('click', function(e) {
                    if (!"<%= userRole %>".includes('admin')) {
                        e.preventDefault();
                        alert('Access denied. This feature requires administrator privileges.');
                    }
                });
                
                // Style the links in restricted cards
                const links = card.querySelectorAll('a');
                links.forEach(link => {
                    if (!"<%= userRole %>".includes('admin')) {
                        link.style.color = '#ccc';
                        link.style.cursor = 'not-allowed';
                    }
                });
            });
        });
    </script>
</body>
</html>