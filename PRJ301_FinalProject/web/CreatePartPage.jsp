<%-- 
    Document   : CreatePartPage
    Created on : Feb 26, 2025, 3:11:56 PM
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
        <h1>CREATE NEW PART</h1>
        <form action="CreatePartCarServlet" accept-charset="UTF-8">
            <p>Name<input type="text" name="txtname" required="">*</p>
            <p>Purchase Price<input type="text" name="txtPurchasePrice" required="">*</p>
            <p>Retail Price<input type="text" name="txtRetailPrice" required="">*</p>
            <p><input type="submit" value="submit"></p> 
        </form>
    </body>
</html>
