<%-- 
    Document   : ServiceTicketPage
    Created on : Feb 28, 2025, 4:17:46 PM
    Author     : LENOVO
--%>

<%@page import="java.util.Map"%>
<%@page import="model.ServiceMechanic"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Service Ticket Page</h1>
        <%
            HashMap<ServiceMechanic, String> serviceMechanicByMechanicName = (HashMap) session.getAttribute("mapUpdateServiceTicketMechanicName");
            HashMap<ServiceMechanic, String> serviceMechanicByServiceName = (HashMap) session.getAttribute("mapUpdateServiceTicketServiceName");
        %>
        <table>
            <tr>
                <th>Service Ticket ID</th>
                <th>Service Name</th>
                <th>Mechanic Name</th>
                <th>Hours</th>
                <th>Comment</th>
                <th>Rate</th>
            </tr>
            <%                if (serviceMechanicByMechanicName != null && !serviceMechanicByMechanicName.isEmpty()) {
                    for (ServiceMechanic sm : serviceMechanicByMechanicName.keySet()) {
                        String mechanicName = serviceMechanicByMechanicName.get(sm);
                        String serviceName = serviceMechanicByServiceName.get(sm); 
//                        if (serviceName == null) {
//                            serviceName = "Unknown Service";
//                        }
            %>
            <tr>
                <td><%= sm.getServiceTicketID()%></td>
                <td><%= serviceName%></td>
                <td><%= mechanicName%></td>
                <td><%= sm.getHour()%></td>
                <td><%= sm.getComment()%></td>
                <td><%= sm.getRate()%></td>
            </tr>
            <%
                    }
                }
            %>
        </table>    
    </body>
</html>
