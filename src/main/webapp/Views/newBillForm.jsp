<%@ page import="java.util.List" %>
<%@ page import="com.pahanaedu.dao.CustomerDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Create New Bill - Select Customer</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4; 
        }
        .container { 
            max-width: 600px; 
            margin: 50px auto; 
            background: white; 
            padding: 30px; 
            border-radius: 8px; 
            box-shadow: 0 0 20px rgba(0,0,0,0.1); 
        }
        .header { 
            background: #2c3e50; 
            color: white; 
            padding: 20px; 
            border-radius: 5px; 
            margin-bottom: 30px; 
            text-align: center;
        }
        .form-group { 
            margin-bottom: 25px; 
        }
        label { 
            display: block; 
            margin-bottom: 8px; 
            font-weight: bold;
            color: #2c3e50;
            font-size: 16px;
        }
        select { 
            padding: 12px; 
            width: 100%; 
            border: 2px solid #ddd; 
            border-radius: 6px; 
            font-size: 16px;
            transition: border-color 0.3s ease;
        }
        select:focus {
            border-color: #3498db;
            outline: none;
            box-shadow: 0 0 5px rgba(52, 152, 219, 0.3);
        }
        button { 
            padding: 12px 25px; 
            background: #3498db; 
            color: white; 
            border: none; 
            border-radius: 6px; 
            cursor: pointer; 
            font-size: 16px;
            font-weight: bold;
            transition: background 0.3s ease;
        }
        button:hover { 
            background: #2980b9; 
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }
        .back-link { 
            padding: 12px 25px; 
            background: #95a5a6; 
            color: white; 
            text-decoration: none; 
            border-radius: 6px; 
            margin-left: 15px;
            font-size: 16px;
            transition: background 0.3s ease;
            display: inline-block;
        }
        .back-link:hover { 
            background: #7f8c8d;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }
        .button-group {
            margin-top: 30px;
            text-align: center;
        }
        .message {
            padding: 15px;
            margin: 20px 0;
            border-radius: 6px;
            text-align: center;
        }
        .error { 
            background: #f8d7da; 
            color: #721c24; 
            border: 1px solid #f5c6cb; 
        }
        .success { 
            background: #d4edda; 
            color: #155724; 
            border: 1px solid #c3e6cb; 
        }
        option {
            padding: 10px;
            font-size: 15px;
        }
        option:hover {
            background-color: #3498db;
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Pahana Edu Bookshop</h1>
            <h2>Create New Bill - Select Customer</h2>
        </div>

       
        <form action="BillServlet" method="post">
            <input type="hidden" name="action" value="create">
            
            <div class="form-group">
                <label for="customerAccount">Customer Account Number:</label>
                <select name="customerAccount" id="customerAccount" required>
                    <option value="">-- Select Customer Account --</option>
                    <%
                        try {
                            List<String> accountNumbers = CustomerDAO.getAllCustomerAccountNumbers();
                            if (accountNumbers != null && !accountNumbers.isEmpty()) {
                                for (String account : accountNumbers) {
                    %>
                                    <option value="<%= account %>"><%= account %></option>
                    <%
                                }
                            } else {
                    %>
                                <option value="" disabled>-- No customers available --</option>
                    <%
                            }
                        } catch (Exception e) {
                    %>
                            <option value="" disabled>-- Error loading customers --</option>
                    <%
                        }
                    %>
                </select>
            </div>
            
            <div class="button-group">
                <button type="submit" class="btn-primary">Create New Bill</button>
                <a href="BillServlet" class="back-link">Back to Bills List</a>
            </div>
        </form>
    </div>

    <script>
        // Add some interactivity
        document.addEventListener('DOMContentLoaded', function() {
            const select = document.getElementById('customerAccount');
            
            select.addEventListener('change', function() {
                if (this.value) {
                    this.style.borderColor = '#27ae60';
                } else {
                    this.style.borderColor = '#ddd';
                }
            });
            
            // Focus on the select field when page loads
            select.focus();
        });
    </script>
</body>
</html>