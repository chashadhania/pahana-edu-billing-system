<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Bill Receipt</title>
    <style>
        @media print {
            .no-print { display: none; }
            body { font-family: Arial, sans-serif; }
        }
        .bill-container { max-width: 800px; margin: 0 auto; padding: 20px; border: 1px solid #eee; }
        .bill-header { text-align: center; margin-bottom: 20px; }
        .bill-info { margin-bottom: 20px; }
        .bill-items { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        .bill-items th, .bill-items td { padding: 8px; border: 1px solid #ddd; }
        .thank-you { text-align: center; margin-top: 30px; font-style: italic; }
        .no-print { margin-top: 20px; }
        .no-print button { padding: 8px 15px; background: #2196F3; color: white; border: none; cursor: pointer; }
        .no-print button:hover { background: #0b7dda; }
        .no-print a { margin-left: 10px; }
    </style>
</head>
<body>
    <div class="bill-container">
        <div class="bill-header">
            <h1>Pahana Edu Bookshop</h1>
            <h2>Bill Receipt</h2>
        </div>
        
        <div class="bill-info">
            <p><strong>Bill ID:</strong> ${bill.billId}</p>
            <p><strong>Date:</strong> ${bill.billDate}</p>
            <p><strong>Customer Account:</strong> ${bill.customerAccount}</p>
            <p><strong>Status:</strong> ${bill.status}</p>
        </div>
        
        <table class="bill-items">
            <thead>
                <tr>
                    <th>Item</th>
                    <th>Quantity</th>
                    <th>Unit Price (Rs.)</th>
                    <th>Total (Rs.)</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${billItems}" var="item">
                    <tr>
                        <td>${item.itemName}</td>
                        <td>${item.quantity}</td>
                        <td>${item.unitPrice}</td>
                        <td>${item.totalPrice}</td>
                    </tr>
                </c:forEach>
                <tr>
                    <td colspan="3" align="right"><strong>Total Amount:</strong></td>
                    <td><strong>Rs. ${totalAmount}</strong></td>
                </tr>
            </tbody>
        </table>
        
        <div class="thank-you">
            <p>Thank you for your purchase!</p>
            <p>Visit us again at Pahana Edu Bookshop, Colombo City</p>
        </div>
        
        <div class="no-print">
            <button onclick="window.print()">Print Bill</button>
            <a href="customer?action=list">Back to Customers</a>
        </div>
    </div>
</body>
</html>