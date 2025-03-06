<%@page import="java.util.HashSet"%>
<%@page import="DAO.ServiceTicketDAO"%>
<%@page import="model.ServiceTicketDetails"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>SERVICE TICKET</title>
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

            .details-section {
                display: none; /* Ban đầu ẩn phần chi tiết */
                margin-top: 20px;
            }

            .details-btn {
                background-color: blue;
                color: white;
                padding: 5px;
                border: none;
                cursor: pointer;
            }
        </style>
    </head>

    <body>
        <h2 style="text-align: center">SEVICE TICKET</h2>

        <%
            List<ServiceTicketDetails> serDetail = (List<ServiceTicketDetails>) request.getAttribute("serDetail");

            if (serDetail != null) {
            for (ServiceTicketDetails ser : serDetail){
            %>
            <table class="info-table">
            <tr>
                <td><strong>Ticket ID:</strong> <%= ser.getTicketID() %></td>
                <td><strong>Customer Name:</strong> <%= ser.getCustName() %></td>
                <td><strong>Phone:</strong> <%= ser.getPhone() %></td>
            </tr>
            <tr>
                <td><strong>Car Colour:</strong> <%= ser.getCarColour() %></td>
                <td><strong>Date Received:</strong> <%= ser.getDateReceived() %></td>
                <td><strong>Date Returned:</strong> <%= ser.getDateReturned() %></td>
            </tr>
            <tr>
                <td><strong>Car Model:</strong> <%= ser.getCarModel() %></td>
                <td><strong>Mechanic Name:</strong> <%= ser.getMechanicName() %></td>
                <td><strong>Service Name:</strong> <%= ser.getServiceName() %></td>
            </tr>
        </table>
        <%
            break;
            }
        %>  
        <h3 style="text-align: center">DETAIL</h3>
        <table>
            <thead>
                <tr>
                    <th>Service Name</th>
                    <th>Part Name</th>
                    <th>Price</th>
                    <th>Number of Used</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (ServiceTicketDetails ser : serDetail) {
                %>
                    <tr>
                        <td><%= ser.getServiceName() %></td>
                        <td><%= ser.getPartName() %></td>
                        <td><%= ser.getPartPrice() %></td>
                        <td><%= ser.getNumberUsed() %></td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>
            
        <% } else { %>

        <!-- Danh sách service tickets -->
        <table id="ticketList">
            <thead>
                <tr>
                    <th>Ticket ID</th>
                    <th>Date Received</th>
                    <th>Date Returned</th>
                    <th>Customer Name</th>
                    <th>Phone</th>
                    <th>Car Model</th>
                    <th>Car Color</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<ServiceTicketDetails> serviceTickets = (List<ServiceTicketDetails>) request.getAttribute("serviceTicket");
                    HashSet<String> displayedTicketIDs = new HashSet<>();

                    if (serviceTickets != null && !serviceTickets.isEmpty()) {
                        for (ServiceTicketDetails ticket : serviceTickets) {
                            if (displayedTicketIDs.contains(ticket.getTicketID())) {
                                continue;
                            }
                            displayedTicketIDs.add(ticket.getTicketID());
                %>
                            <tr>
                                <td><%= ticket.getTicketID() %></td>
                                <td><%= ticket.getDateReceived() %></td>
                                <td><%= ticket.getDateReturned() %></td>
                                <td><%= ticket.getCustName() %></td>
                                <td><%= ticket.getPhone() %></td>
                                <td><%= ticket.getCarModel() %></td>
                                <td><%= ticket.getCarColour() %></td>
                                <td>
                                    <form action="ViewServiceTicket" method="POST">
                                        <input type="hidden" name="ticketID" value="<%= ticket.getTicketID() %>">
                                        <input type="submit" class="details-btn" value="Detail" />
                                    </form>
                                </td>
                            </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="8">No service tickets found</td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>

        <a href="CustomerDashboardPage.jsp"><button>Back</button></a>
        <% } %>
    </body>
</html>
