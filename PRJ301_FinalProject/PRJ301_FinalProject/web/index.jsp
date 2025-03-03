<%-- 
    Document   : index
    Created on : Feb 24, 2025, 1:10:31 PM
    Author     : hoang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home Page</title>
</head>
<body>
    <h2>Welcome to the Garage Management System</h2>
    
    <%-- Check if user is logged in --%>
    <%
        String role = (String) session.getAttribute("role");
        if (role != null) {
    %>
        <p>Welcome, <%= session.getAttribute("user") %>!</p>
        <a href="MainServlet?action=dashboard">Go to Dashboard</a>
        <form action="LogoutServlet" method="post">
            <button type="submit">Logout</button>
        </form>
    <%
        } else {
    %>
        <p>Please <a href="MainServlet?action=login">Login</a> to continue.</p>
    <%
        }
    %>
</body>
</html>
