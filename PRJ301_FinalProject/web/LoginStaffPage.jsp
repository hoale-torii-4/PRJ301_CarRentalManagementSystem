<%-- 
    Document   : LoginStaffPage
    Created on : Feb 24, 2025, 11:49:23 AM
    Author     : hoang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Staff Login</title>
</head>
<body>
    <h2>Staff Login</h2>
    <form action="MainServlet" accept-charset="UTF-8">
        <input type="hidden" name="action" value="login">

        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required><br>
        
        <label for="role">Role:</label>
        <select id="role" name="role" required>
            <option value="SalePerson">Sale Person</option>
            <option value="Mechanic">Mechanic</option>
        </select><br>
        
        <input type="submit" value="Login">
    </form>
    
    <% if (request.getAttribute("errorMessage") != null) { %>
        <p style="color: red; font-weight: bold;"><%= request.getAttribute("errorMessage") %></p>
    <% } %>
</body>
</html>
