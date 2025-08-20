<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>View Bills - Pahana Edu Bookshop</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background-color: #f4f4f4; }
        .container { max-width: 1400px; margin: 0 auto; background: white; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        .header { background: #2c3e50; color: white; padding: 15px; border-radius: 5px; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background-color: #f2f2f2; position: sticky; top: 0; }
        .btn { padding: 8px 12px; text-decoration: none; border-radius: 4px; margin-right: 5px; }
        .btn-primary { background: #3498db; color: white; }
        .btn-primary:hover { background: #2980b9; }
        .btn-success { background: #27ae60; color: white; }
        .btn-success:hover { background: #229954; }
        .btn-info { background: #17a2b8; color: white; }
        .btn-info:hover { background: #138496; }
        .status-pending { background: #fff3cd; color: #856404; padding: 4px 8px; border-radius: 3px; }
        .status-completed { background: #d4edda; color: #155724; padding: 4px 8px; border-radius: 3px; }
        .search-form { margin-bottom: 20px; }
        .search-form input, .search-form select { padding: 8px; margin-right: 10px; border: 1px solid #ddd; border-radius: 4px; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Pahana Edu Bookshop - Bill Management</h1>
        </div>

        <div style="margin-bottom: 20px;">
    <a href="${pageContext.request.contextPath}/BillServlet?action=new" class="btn btn-success">Create New Bill</a>
    <a href="${pageContext.request.contextPath}/CustomerServlet" class="btn btn-primary">Manage Customers</a>
    <a href="${pageContext.request.contextPath}/ItemServlet" class="btn btn-primary">Manage Items</a>
</div>

        <div class="search-form">
            <form action="BillServlet" method="get">
                <input type="hidden" name="action" value="search">
                <input type="text" name="searchTerm" placeholder="Search by Bill ID or Customer..." value="${param.searchTerm}">
                <select name="statusFilter">
                    <option value="">All Status</option>
                    <option value="Draft" ${param.statusFilter == 'Draft' ? 'selected' : ''}>Draft</option>
                    <option value="Completed" ${param.statusFilter == 'Completed' ? 'selected' : ''}>Completed</option>
                </select>
                <button type="submit" class="btn btn-info">Search</button>
                <a href="BillServlet" class="btn">Clear</a>
            </form>
        </div>

        <c:if test="${not empty error}">
            <div style="color: red; padding: 10px; background: #ffe6e6; border: 1px solid red; margin-bottom: 20px;">
                ${error}
            </div>
        </c:if>

        <c:if test="${not empty message}">
            <div style="color: green; padding: 10px; background: #e6ffe6; border: 1px solid green; margin-bottom: 20px;">
                ${message}
            </div>
        </c:if>

        <table>
            <thead>
                <tr>
                    <th>Bill ID</th>
                    <th>Customer Account</th>
                    <th>Bill Date</th>
                    <th>Total Amount (Rs.)</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${bills}" var="bill">
                    <tr>
                        <td>${bill.billId}</td>
                        <td>${bill.customerAccount}</td>
                        <td>${bill.billDate}</td>
                        <td>${bill.totalAmount}</td>
                        <td>
                            <span class="status-${bill.status.toLowerCase()}">${bill.status}</span>
                        </td>
                        <td>
                            <a href="BillServlet?action=view&billId=${bill.billId}" class="btn btn-info">View</a>
                            <a href="BillServlet?action=print&billId=${bill.billId}" class="btn btn-primary">Print</a>
                            <c:if test="${bill.status == 'Draft'}">
                                <a href="BillServlet?action=new&billId=${bill.billId}" class="btn btn-success">Edit</a>
                                <form action="BillServlet" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="billId" value="${bill.billId}">
                                    <button type="submit" class="btn" style="background: #e74c3c; color: white;" 
                                            onclick="return confirm('Are you sure you want to delete this bill?')">Delete</button>
                                </form>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <c:if test="${empty bills}">
            <p style="text-align: center; padding: 20px; color: #666;">No bills found.</p>
        </c:if>
    </div>
</body>
</html>