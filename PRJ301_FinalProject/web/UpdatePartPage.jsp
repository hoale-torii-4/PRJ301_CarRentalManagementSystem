<%-- 
    Document   : UpdatePartPage
    Created on : Feb 26, 2025, 12:45:09 PM
    Author     : LENOVO
--%>

<%@page import="model.CarParts"%>
<%@page import="DAO.CRUDPartCarDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>UPDATE CAR PART</h1>
        <%
            String partID = request.getParameter("carPartID");

            if (partID == null || partID.isEmpty()) {
                partID = "";
            }

            String action = request.getParameter("action");
            CRUDPartCarDAO partCarDAO = new CRUDPartCarDAO();
            CarParts carParts = partCarDAO.getCarPartByID(partID);
        %>
        <table>
            <table>
                <tr><th>Part ID</th>
                    <th>Part Name</th>
                    <th>Purchase Price</th>
                    <th>Retail Price</th>
                </tr>
                <tr>
                    <td><%= carParts.getPartID()%></td>
                    <td><%= carParts.getPartName()%></td>
                    <td><%= carParts.getPurchasePrice()%></td>
                    <td><%= carParts.getRetailPrice()%></td>
                </tr>
            </table>
            <form action="UpdatePartServlet">
                <input type="hidden" name="id" value="<%= partID%>">
                <p>Part Name<input type="text" name="txtname" placeholder="Enter new Name"></p>
                <p>Purchase Price<input type="text" name="txtPurchasePrice" placeholder="Enter new Purchase price"></p>
                <p>Retail Price<input type="text" name="txtRetailPrice" placeholder="Enter new Retail price"></p>
                <p><input type="submit" value="Update"></p>
            </form>  
                    
    </body>
</html>
