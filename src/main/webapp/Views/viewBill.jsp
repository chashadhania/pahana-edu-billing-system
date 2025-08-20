<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>View Bill - Pahana Edu Bookshop</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background-color: #f4f4f4; }
        .container { max-width: 1000px; margin: 0 auto; background: white; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        .header { background: #2c3e50; color: white; padding: 15px; border-radius: 5px; margin-bottom: 20px; }
        .bill-info { background: #f8f9fa; padding: 15px; border-radius: 5px; margin-bottom: 20px; }
        .info-table { width: 100%; }
        .info-table td { padding: 8px; vertical-align: top; }
        .label { font-weight: bold; width: 150px; }
        .items-table { width: 100%; border-collapse: collapse; margin: 20px 0; }
        .items-table th, .items-table td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        .items-table th { background-color: #f2f2f2; }
        .total-section { text-align: right; margin-top: 20px; font-size: 18px; font-weight: bold; }
        .btn { padding: 10px 15px; text-decoration: none; border-radius: 4px; margin-right: 10px; }
        .btn-primary { background: #3498db; color: white; }
        .btn-primary:hover { background: #2980b9; }
        .btn-success { background: #27ae60; color: white; }
        .btn-success:hover { background: #229954; }
        .status-badge { padding: 4px 8px; border-radius: 3px; font-weight: bold; }
        .status-draft { background: #fff3cd; color: #856404; }
        .status-completed { background: #d4edda; color: #155724; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Bill Details - Pahana Edu Bookshop</h1>
        </div>

        <c:if test="${not empty message}">
            <div style="color: green; padding: 10px; background: #e6ffe6; border: 1px solid green; margin-bottom: 20px;">
                ${message}
            </div>
        </c:if>

        <div class="bill-info">
            <table class="info-table">
                <tr>
                    <td class="label">Bill ID:</td>
                    <td>${bill.billId}</td>
                    <td class="label">Status:</td>
                    <td><span class="status-badge status-${bill.status.toLowerCase()}">${bill.status}</span></td>
                </tr>
                <tr>
                    <td class="label">Customer Account:</td>
                    <td>${bill.customerAccount}</td>
                    <td class="label">Bill Date:</td>
                    <td><fmt:formatDate value="${bill.billDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                </tr>
                <tr>
                    <td class="label">Total Amount:</td>
                    <td>Rs. <fmt:formatNumber value="${bill.totalAmount}" pattern="#,##0.00" /></td>
                    <td class="label">Number of Items:</td>
                    <td>${billItems.size()}</td>
                </tr>
            </table>
        </div>

        <h3>Bill Items</h3>
        <table class="items-table">
            <thead>
                <tr>
                    <th>Item Code</th>
                    <th>Item Name</th>
                    <th>Quantity</th>
                    <th>Unit Price (Rs.)</th>
                    <th>Total (Rs.)</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${billItems}" var="item">
                    <tr>
                        <td>${item.itemId}</td>
                        <td>${item.itemName}</td>
                        <td>${item.quantity}</td>
                        <td><fmt:formatNumber value="${item.unitPrice}" pattern="#,##0.00" /></td>
                        <td><fmt:formatNumber value="${item.totalPrice}" pattern="#,##0.00" /></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div class="total-section">
            Grand Total: Rs. <fmt:formatNumber value="${bill.totalAmount}" pattern="#,##0.00" />
        </div>

        <div style="margin-top: 30px;">
            <a href="BillServlet?action=print&billId=${bill.billId}" class="btn btn-primary">Print Bill</a>
            <c:if test="${bill.status == 'Draft'}">
                <a href="BillServlet?action=new&billId=${bill.billId}" class="btn btn-success">Continue Editing</a>
            </c:if>
            <a href="${pageContext.request.contextPath}/BillServlet" class="btn btn-primary">Back to Bills</a>
        </div>
    </div>
</body>
</html>