<%-- 
    Document   : StaticBestUsedPart
    Created on : Feb 27, 2025, 6:44:36 PM
    Author     : LENOVO
--%>

<%@page import="model.SalesInvoice"%>
<%@page import="model.PartUsed"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>STATICS OF BEST USED PARTS</h1>
        <%
            
            ArrayList<PartUsed> list = (ArrayList<PartUsed>)session.getAttribute("LIST_USEDPART");
            if (list != null && !list.isEmpty()) {
        %>

        <table>
            <tr>
                <th>serviceTicketID</th>
                <th>partID</th>
                <th>numberUsed</th>
                <th>price</th>
            </tr>
            <%
                for (PartUsed pu : list) {
                
            %>
            <tr>
                <td><%=pu.getServiceTicketID()%></td>
                <td><%=pu.getPartID()%></td>
                <td><%=pu.getNumberUsed()%></td>
                <td><%=pu.getPrice()%></td>
            </tr>
            <%
                }
            %>
        </table>
        <%
            }
        %>
    </body>
</html>
