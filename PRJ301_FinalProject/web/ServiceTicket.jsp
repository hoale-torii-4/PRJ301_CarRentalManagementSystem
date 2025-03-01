<%@page import="java.util.List"%>
<%@page import="model.ServiceTicket"%>
<%@page import="model.ServiceTicket"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Search Service Tickets</title>
</head>
<body>

<h2>Search Service Tickets</h2>

<!-- Search Form -->
<form method="get" action="ServiceTickets">
    <label for="custID">Customer ID:</label>
    <input type="text" id="custID" name="custID" /><br/>

    <label for="carID">Car ID:</label>
    <input type="text" id="carID" name="carID" /><br/>

    <label for="dateReceived">Date Received (YYYY-MM-DD):</label>
    <input type="text" id="dateReceived" name="dateReceived" /><br/>

    <input type="submit" value="Search" />
</form>

<!-- Display Service Tickets -->
<h3>Service Tickets</h3>
<table border="1">
    <thead>
        <tr>
            <th>Ticket ID</th>
            <th>Customer ID</th>
            <th>Car ID</th>
            <th>Date Received</th>
            <th>Date Returned</th>
        </tr>
    </thead>
    <tbody>
        <% 
            // Get the list of service tickets from the request attribute
            List<ServiceTicket> tickets = (List<ServiceTicket>) request.getAttribute("serviceTickets");
            
            // Loop through the list and display each ticket
            if (tickets != null) {
                for (ServiceTicket ticket : tickets) {
        %>
            <tr>
                <td><%= ticket.getServiceTicketID() %></td>
                <td><%= ticket.getCustID() %></td>
                <td><%= ticket.getCarID() %></td>
                <td><%= ticket.getDateReceived() %></td>
                <td><%= ticket.getDateReturned() %></td>
            </tr>
        <% 
                }
            }
        %>
    </tbody>
</table>

</body>
</html>
