<%-- 
    Document   : ReportSalePerson
    Created on : Feb 28, 2025, 1:59:30 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>REPORT FOR SALE PERSON</h1>
        <form action="StaticCarSoldByYear.jsp">
            <input type="submit" value="Report of cars sold by year">
        </form>
        <form action="ReportSalePersonServlet">
            <input type="hidden" name="reportType" value="BESTMODEL">
            <input type="submit" value="Report of car best-selling car models">
        </form>
        <form action="ReportSalePersonServlet">
            <input type="hidden" name="reportType" value="BESTPART">
            <input type="submit" value="Report Best used part">
        </form>
        <form action="ReportSalePersonServlet">
            <input type="hidden" name="reportType" value="MECHANIC">
            <input type="submit" value="Report 3 mechanic most repair">
        </form>
        
    </body>
</html>
