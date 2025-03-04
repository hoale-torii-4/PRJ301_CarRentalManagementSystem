<%@ page import="model.ServiceTicket" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Your Service Tickets</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }

        table, th, td {
            border: 1px solid black;
        }

        th, td {
            padding: 8px;
            text-align: left;
        }
    </style>
</head>
<body>
    <h2>Your Service Tickets</h2>

    <table>
        <thead>
            <tr>
                <th>Ticket ID</th>
                <th>Date Received</th>
                <th>Date Returned</th>
                <th>Car ID</th>
            </tr>
        </thead>
        <tbody>
            <% 
                List<ServiceTicket> serviceTicket = (List<ServiceTicket>) request.getAttribute("serviceTicket");
                if (serviceTicket != null && !serviceTicket.isEmpty()) {
                    for (ServiceTicket ticket : serviceTicket) {
            %>
                <tr>
                    <td><%= ticket.getServiceTicketID() %></td>
                    <td><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(ticket.getDateReceived()) %></td>
                    <td><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(ticket.getDateReturned()) %></td>
                    <td><%= ticket.getCarID() %></td>
                </tr>
            <% 
                    }
                } else {
            %>
                <tr>
                    <td colspan="4">No service tickets found</td>
                </tr>
            <% 
                }
            %>
        </tbody>
    </table>

</body>
</html>
