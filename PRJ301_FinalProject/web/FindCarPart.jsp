<%-- 
    Document   : FindCarPart
    Created on : Feb 24, 2025, 3:09:04 PM
    Author     : LENOVO
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="model.CarParts"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>FIND CAR PART</h1>
        <form action="FindCarPartServlet" method="post">
            <p><input type="text" name="txtname" placeholder="Enter name"></p>
            <p><input type="submit" value="findpart"></p>
        </form>
        <%String updateStatus = (String)request.getAttribute("updateMess");
        if(updateStatus==null || updateStatus.isEmpty()) updateStatus = "";%>
        <h2><p><%=updateStatus%></p></h2>
        <%
            ArrayList<CarParts> list = (ArrayList) session.getAttribute("LIST_PART");
//            CarParts carParts = (CarParts) session.getAttribute("PART_CAR");
            if (list != null && !list.isEmpty()) {
        %>
        <table>
            <tr><th>Part ID</th>
                <th>Part Name</th>
                <th>Purchase Price</th>
                <th>Retail Price</th>
            </tr>
            <%        
                for (CarParts carP : list) {
            %>
            <tr>
                <td><%= carP.getPartID()%></td>
                <td><%= carP.getPartName()%></td>
                <td><%= carP.getPurchasePrice()%></td>
                <td><%= carP.getRetailPrice()%></td>
                <td><a href="UpdatePartPage.jsp?carPartID=<%= carP.getPartID()%>&action=UPDATE">Update</a></td>
                <td><a href="DeleteCarPartServlet?carPartID=<%= carP.getPartID()%>&action=DELETE">Delete</a></td>
                

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
