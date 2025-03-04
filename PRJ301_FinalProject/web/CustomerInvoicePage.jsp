<%-- 
    Document   : CustomerInvoicePage
    Created on : Mar 3, 2025, 1:43:00 PM
    Author     : LENOVO
--%>

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
        <h1>CUSTOMER INVOICE PAGE</h1>
        <%
            HashMap<SalesInvoice, String>[] mapSaleInvoice = (HashMap<SalesInvoice, String>[]) request.getAttribute("MAP_SALEINVOICE");
            HashMap<SalesInvoice, String> mapSaleName = mapSaleInvoice[0];
            HashMap<SalesInvoice, String> mapCarName = mapSaleInvoice[1];
            HashMap<SalesInvoice, String> mapCustName = mapSaleInvoice[2];
        %>
        <table>
            <tr>
                <th>Invoice Id</th>
                <th>Invoice Date</th>
                <th>Sale name</th>
                <th>Car model</th>
                <th>Price</th>
                <th>Customer name</th>

            </tr>
            <%                if (mapSaleInvoice != null) {
                    for (SalesInvoice si : mapSaleName.keySet()) {
                        String carModel = mapCarName.get(si);
                        String custName = mapCustName.get(si);
                        String saleName = mapSaleName.get(si);
            %>
            <tr>
                <td><%=si.getInvoiceId()%></td>
                <td><%=si.getInvoiceDate()%></td>
                <td><%=saleName%></td>
                <td><%=carModel%> <a href="CarDetailServlet">Detail</a></td>
                <td><%=NumberFormat.getInstance().format(si.getPrice())%></td>
                <td><%=custName%> <a href="CustDetailServlet">Detail</a></td>
            </tr>
            <%
                    }
                }
            %>
        </table>
    </body>
</html>
