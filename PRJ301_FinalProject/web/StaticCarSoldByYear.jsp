<%-- 
    Document   : StaticCarSoldByYear
    Created on : Feb 27, 2025, 2:17:54 PM
    Author     : LENOVO
--%>

<%@page import="model.SalesInvoice"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>STATICS OF CARS SOLD BY YEAR</h1>
        <p>Choose year: </p>
        <form action="StaticCarSoldByYearServlet">
            <select name="year-select">
                <%
                    int startYear = 2018;
                    int currentYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
                    for (int year = startYear; year <= currentYear; year++) {
                %>
                <option value="<%= year%>"><%= year%></option>
                <% }%>
            </select>
            <p><input type="submit" value="submit"></p>            
        </form>
        <%String updateStatus = (String) request.getParameter("updateMess");
            if (updateStatus != null && !updateStatus.isEmpty()) {
        %>
        <h2><p><%=updateStatus%></p></h2>
        <%
            }
            ArrayList<SalesInvoice> list = (ArrayList<SalesInvoice>) session.getAttribute("LIST_INVOICE");
            if (list != null && !list.isEmpty()) {
        %>
        <h2>Total: <%=list.size() %></h2>
        <table>
            <tr>
                <th>InvoiceID</th>
                <th>InvoiceDate</th>
                <th>SalesID</th>
                <th>CarID</th>
                <th>CustID</th>
            </tr>
            <%
                int total = 0;
                for (SalesInvoice si : list) {
                
            %>
            <tr>
                <td><%=si.getInvoiceId()%></td>
                <td><%=si.getInvoiceDate()%></td>
                <td><%=si.getSalesId()%></td>
                <td><%=si.getCarId()%></td>
                <td><%=si.getCustId()%></td>
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
