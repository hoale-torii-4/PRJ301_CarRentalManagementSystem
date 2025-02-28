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
            <input type="submit" value="Report Sale Person">
        </form>
        <form action="StaticBestUsedPartServlet">
            <input type="submit" value="Report Best used part">
        </form>
        <form action="ThreeMechanicServlet">
            <input type="submit" value="Report 3 mechanic most repair">
        </form>
        
    </body>
</html>
