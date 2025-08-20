<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Create New Bill</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background-color: #f4f4f4; }
        .container { max-width: 1200px; margin: 0 auto; background: white; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        .header { background: #2c3e50; color: white; padding: 15px; border-radius: 5px; margin-bottom: 20px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input, select { padding: 8px; width: 300px; border: 1px solid #ddd; border-radius: 4px; }
        button { padding: 10px 15px; background: #3498db; color: white; border: none; border-radius: 4px; cursor: pointer; }
        button:hover { background: #2980b9; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background-color: #f2f2f2; }
        .action-btn { padding: 5px 10px; text-decoration: none; border-radius: 3px; margin-right: 5px; }
        .btn-danger { background: #e74c3c; color: white; }
        .btn-danger:hover { background: #c0392b; }
        .btn-primary { background: #3498db; color: white; }
        .btn-primary:hover { background: #2980b9; }
        .btn-success { background: #27ae60; color: white; }
        .btn-success:hover { background: #229954; }
        .message { padding: 10px; margin: 10px 0; border-radius: 4px; }
        .success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .error { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .bill-info { background: #f8f9fa; padding: 15px; border-radius: 5px; margin-bottom: 20px; }
        .total-section { text-align: right; margin-top: 20px; font-size: 18px; font-weight: bold; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Pahana Edu Bookshop - Create New Bill</h1>
        </div>

        <c:if test="${not empty error}">
            <div class="message error">${error}</div>
        </c:if>
        <c:if test="${not empty message}">
            <div class="message success">${message}</div>
        </c:if>

        <div class="bill-info">
            <h3>Bill ID: ${billId}</h3>
        </div>

        <h3>Add Item to Bill</h3>
        <form action="BillServlet" method="post">
            <input type="hidden" name="action" value="addItem">
            <input type="hidden" name="billId" value="${billId}">
            
            <div class="form-group">
                <label>Select Item:</label>
                <select name="itemId" required>
                    <option value="">-- Select Item --</option>
                    <c:if test="${not empty items}">
                        <c:forEach items="${items}" var="item">
                            <option value="${item.itemId}">
                                ${item.itemId} - ${item.name} - Rs. ${item.price} (Stock: ${item.quantity})
                            </option>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty items}">
                        <option value="" disabled>No items available in database</option>
                    </c:if>
                </select>
            </div>
            
            <div class="form-group">
                <label>Quantity:</label>
                <input type="number" name="quantity" min="1" value="1" required>
            </div>
            
            <button type="submit" class="btn-primary">Add Item to Bill</button>
        </form>

        <h3>Bill Items</h3>
        <c:if test="${not empty billItems}">
            <table>
                <thead>
                    <tr>
                        <th>Item ID</th>
                        <th>Item Name</th>
                        <th>Quantity</th>
                        <th>Unit Price (Rs.)</th>
                        <th>Total (Rs.)</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${billItems}" var="item">
                        <tr>
                            <td>${item.itemId}</td>
                            <td>${item.itemName}</td>
                            <td>${item.quantity}</td>
                            <td>${item.unitPrice}</td>
                            <td>${item.totalPrice}</td>
                            <td>
                             <form action="BillServlet" method="post" style="display: inline;">
    <input type="hidden" name="action" value="deleteItem">
    <input type="hidden" name="billId" value="${billId}">
    <input type="hidden" name="itemId" value="${item.itemId}">
    <button type="submit" class="btn-danger" onclick="return confirm('Are you sure you want to remove this item?')">Remove</button>
</form>
                            </td>
                            
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <div class="total-section">
                <c:set var="grandTotal" value="0" />
                <c:forEach items="${billItems}" var="item">
                    <c:set var="grandTotal" value="${grandTotal + item.totalPrice}" />
                </c:forEach>
                <p>Grand Total: Rs. ${grandTotal}</p>
            </div>

            <div style="margin-top: 20px;">
                <form action="BillServlet" method="post">
                    <input type="hidden" name="action" value="finalize">
                    <input type="hidden" name="billId" value="${billId}">
                    <button type="submit" class="btn-success">Finalize Bill</button>
                </form>
                
            
               
            </div>
        </c:if>

        <c:if test="${empty billItems}">
            <p>No items added to this bill yet.</p>
        </c:if>
    </div>
</body>
</html>