<%-- 
    Document   : StaticCarRevenueByYear
    Created on : Mar 2, 2025, 12:50:14 PM
    Author     : LENOVO
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="model.SalesInvoice"%>
<%@page import="java.util.HashMap"%>
<%@ page import="java.text.NumberFormat" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>STATICS OF CAR SALES REVENUE BY YEAR</h1>
        <p>Choose year: </p>
        <form action="StaticCarRevenueByYearServlet">
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
            ArrayList<SalesInvoice> invoicelist = (ArrayList<SalesInvoice>) request.getAttribute("LIST_INVOICE");
            if (invoicelist != null && !invoicelist.isEmpty()) {
        %>

        <table>
            <tr>
                <th>InvoiceID</th>
                <th>InvoiceDate</th>
                <th>SalesID</th>
                <th>CarID</th>
                <th>CustID</th>
                <th>Price</th>

            </tr>
            <%                for (SalesInvoice si : invoicelist) {
                    
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
            double totalPrice = (Double) request.getAttribute("TOTAL_PRICE");
        %>
        <h2>Total Price: <%= NumberFormat.getInstance().format(totalPrice)%></h2>
        <%
            }
        %>    




    </body>
</html>
