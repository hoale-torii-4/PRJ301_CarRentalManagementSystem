<%-- 
    Document   : SalePersonDashBoard
    Created on : Feb 24, 2025, 12:14:48 PM
    Author     : hoang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body> 
    
    <h1>Welcome, <%= session.getAttribute("user") %>!</h1>
    <nav>
        <ul>
            <li><a href="ListCustomer.jsp">Manage Customers</a></li>
            <li><a href="CreateInvoice.jsp">Create Invoice</a></li>
            <li><a href="viewReports.jsp">View Reports</a></li>
        </ul>
    </nav>
    
    
    <body/>
</html>
