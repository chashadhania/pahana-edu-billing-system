<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Bill Receipt</title>
    <style>
        @media print {
            .no-print { display: none !important; }
            body { font-family: Arial, sans-serif; margin: 0; }
            .container { width: 100%; margin: 0; padding: 0; }
        }
        @media screen {
            body { font-family: Arial, sans-serif; margin: 20px; background-color: #f4f4f4; }
            .container { max-width: 800px; margin: 0 auto; background: white; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        }
        .header { text-align: center; margin-bottom: 30px; border-bottom: 2px solid #333; padding-bottom: 20px; }
        .company-name { font-size: 24px; font-weight: bold; color: #2c3e50; }
        .company-address { font-size: 14px; color: #666; }
        .bill-title { font-size: 20px; margin: 10px 0; }
        .bill-info { margin: 20px 0; }
        .bill-info table { width: 100%; }
        .bill-info td { padding: 5px; vertical-align: top; }
        .bill-info .label { font-weight: bold; width: 120px; }
        .items-table { width: 100%; border-collapse: collapse; margin: 20px 0; }
        .items-table th, .items-table td { padding: 10px; border: 1px solid #ddd; text-align: left; }
        .items-table th { background-color: #f2f2f2; }
        .total-section { text-align: right; margin-top: 20px; font-size: 16px; }
        .grand-total { font-size: 18px; font-weight: bold; border-top: 2px solid #333; padding-top: 10px; }
        .thank-you { text-align: center; margin-top: 40px; font-style: italic; color: #666; }
        .no-print { margin-top: 30px; text-align: center; }
        .btn { padding: 10px 20px; background: #3498db; color: white; text-decoration: none; border-radius: 4px; margin: 0 10px; }
        .btn:hover { background: #2980b9; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="company-name">PAHANA EDU BOOKSHOP</div>
            <div class="company-address">123 Colombo City, Sri Lanka | Tel: +94 11 234 5678</div>
            <div class="bill-title">BILL RECEIPT</div>
        </div>

        <div class="bill-info">
            <table>
                <tr>
                    <td class="label">Bill ID:</td>
                    <td>${bill.billId}</td>
                    <td class="label">Date:</td>
                    <td><fmt:formatDate value="${bill.billDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                </tr>
                <tr>
                    <td class="label">Customer Account:</td>
                    <td>${bill.customerAccount}</td>
                    <td class="label">Status:</td>
                    <td>${bill.status}</td>
                </tr>
            </table>
        </div>

        <table class="items-table">
            <thead>
                <tr>
                    <th>Item Code</th>
                    <th>Description</th>
                    <th>Qty</th>
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
            <div class="grand-total">
                Grand Total: Rs. <fmt:formatNumber value="${bill.totalAmount}" pattern="#,##0.00" />
            </div>
        </div>

        <div class="thank-you">
            <p>Thank you for your business!</p>
            <p>Visit us again at Pahana Edu Bookshop</p>
        </div>

        <div class="no-print">
            <button onclick="window.print()" class="btn">Print Bill</button>
            <a href="${pageContext.request.contextPath}/BillServlet" class="btn">Back to Bills</a>
        </div>
    </div>
</body>
</html>