<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mechanic Dashboard</title>
</head>
<body>

    <h1>Welcome, ${sessionScope.user}!</h1>
    

    <!-- Button for searching service tickets -->
    <a href="ServiceTicket.jsp">
        <button>Search & View Service Tickets</button>
    </a>

    <!-- Button for updating service tickets -->
    <%
        String mechanicId = (String)session.getAttribute("mechanicID");
    %>
    <a href="UpdateServiceTicketServlet?mechanicID=<%=mechanicId%>&serviceTicket=VIEW">
        <button>Update Service Ticket</button>        
    </a>
        
        <a href="ServicePage.jsp">
        <button>Manage Service</button>        
    </a>

    

</body>
</html>
