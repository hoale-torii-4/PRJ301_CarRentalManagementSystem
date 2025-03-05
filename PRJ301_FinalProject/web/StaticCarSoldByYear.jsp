<%-- 
    Document   : StaticCarSoldByYear
    Created on : Feb 27, 2025, 2:17:54 PM
    Author     : LENOVO
--%>

<%@page import="java.text.NumberFormat"%>
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
        <form action="ReportSalePersonServlet">
            <select name="year-select">
                <%
                    int startYear = 2018;
                    int currentYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
                    for (int year = startYear; year <= currentYear; year++) {
                %>
                <option value="<%= year%>"><%= year%></option>
                <% }%>
            </select>
            <input type="hidden" name="reportType" value="SOLD">
            <input type="submit" value="search">           
        </form>
        <%String updateStatus = (String)request.getAttribute("updateMess");
            if (updateStatus != null && !updateStatus.isEmpty()) {
        %>
        <h2><p><%=updateStatus%></p></h2>
        <%
            }
            ArrayList<SalesInvoice> list = (ArrayList<SalesInvoice>) request.getAttribute("LIST_YEAR");

            if (list != null && !list.isEmpty()) {
        
            double totalPrice = (Double) request.getAttribute("REVENUE");
        %>
        <h2>Total: <%=list.size() %></h2>
        <h2>Total Price: <%= NumberFormat.getInstance().format(totalPrice)%></h2>

        <table>
            <tr>
                <th>InvoiceID</th>
                <th>InvoiceDate</th>
                <th>SalesID</th>
                <th>CarID</th>
                <th>CustID</th>
                <th>Price</th>
            </tr>
            <%
                for (SalesInvoice si : list) {
                
            %>
            <tr>
                <td><%=si.getInvoiceId()%></td>
                <td><%=si.getInvoiceDate()%></td>
                <td><%=si.getSalesId()%></td>
                <td><%=si.getCarId()%></td>
                <td><%=si.getCustId()%></td>
                <td><%= NumberFormat.getInstance().format(si.getPrice())%></td>
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
