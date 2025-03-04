<%-- 
    Document   : LoginCustomerPage
    Created on : Feb 23, 2025, 3:00:58 PM
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
        <h1>Hello World!</h1>
        
        <form action="LoginStaffPage.jsp">
            <p style="border: 1px solid black">CUSTOMER   <input type="submit" name="action" value="STAFF"></p>
        </form>
        <form action="LoginCustomerServlet" accept-charset="UTF-8" method="POST">
            
            <p>Full name : <input type="text" name="custName" placeholder="Enter your Name">* </p>
            <p>Phone: <input type="text" name="custPhone" placeholder="Enter your Phone number">* </p>
            <p> <input type="checkbox" id="save" name="custSave" value="Save"> Save Login</p> 
            <input type="submit" name="action" value="LOGIN">
        </form>
        <%
            if(request.getAttribute("FailedLogin")!=null)
            out.print(request.getAttribute("FailedLogin"));
        %>
        
    </body>
</html>
