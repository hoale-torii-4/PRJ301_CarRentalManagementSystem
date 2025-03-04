<%-- 
    Document   : CustomerDashboardPage
    Created on : Feb 24, 2025, 12:59:34 PM
    Author     : HOA LE
--%>

<%@page import="model.Customer"%>
<%@page import="model.Car"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Dashboard</title>
    </head>
    <body>
        
        <%
           Customer kq = (Customer) session.getAttribute("user");
           String token = (String) session.getAttribute("user2");
           
           if (kq == null && token == null) {
               request.setAttribute("LoginFailed", "You must Login");
               request.getRequestDispatcher("LoginCustomerPage.jsp").forward(request, response);
           } else {
        %>

        <h2>Welcome <%= (kq == null) ? token : kq.getCustName() %></h2>
        <%= token %>


</select>
        <form action="CustomerDashboardPage.jsp" method="GET">
            <input type="hidden" name="change" value="true">
            <input type="submit" value="Change Profile">
        </form>

        <%
            if("true".equals(request.getParameter("change"))){
        %>
            <h3>Update Profile</h3>
            <form action="ChangeProfileCustomerServlet" method="POST" accept-charset="UTF-8">
                <input type="hidden" name="cusID" value="<%= (kq != null) ? kq.getCustID() : "" %>">
                <p>New Name: <input type="text" name="newName"></p>
                <p>New Phone: <input type="number" name="newPhone"></p>
                <p>New Sex: 
                    <select name="newSex">
                        <option value="M">Male</option>
                        <option value="F">Female</option>
                    </select>
                </p>
                <p>New Address: <input type="text" name="newAddress"></p>
                <input type="submit" value="Change">
            </form>
         
        
            
        
        <%
            String result = (String)request.getAttribute("RESULT");
            
            if(result != null){
            if("done".equals(result)){
                out.print("Change Customer Information Successful!!!");
            } else out.print("Change Customer Information FAILED!! Try again.");
        }
            }
        %>
        <!-- Logout Form -->
        <form action="LogoutServlet" method="POST">
            <input type="submit" value="LOGOUT">
        </form>

        <h1>DASHBOARD</h1> 
        
        <%
           }
           
        %>
        <a href="ViewServiceTicket?id=<%=kq.getCustID()%>"><button>View My Service Ticket</button></a>
        
    </body>
</html>
