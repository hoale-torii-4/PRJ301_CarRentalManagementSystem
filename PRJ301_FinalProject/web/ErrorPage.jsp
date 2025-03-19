<%-- 
    Document   : ErrorPage
    Created on : Feb 24, 2025, 1:41:51 PM
    Author     : HOA LE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error Page</title>

    </head>
    <body>
        <style>
            body {
                background: url('images/errorPage.jpg');
                background-size: cover;
            }
            body {
                background: url('images/errorPage.jpg') no-repeat center center fixed;
                background-size: cover;
                font-family: Arial, sans-serif;
                text-align: center;
                color: white;
                margin: 0;
                padding: 0;
            }

            h1 {
                font-size: 50px;
                font-weight: bold;
                margin-top: 20%;
                text-shadow: 2px 2px 5px red;
            }

            a {
                display: inline-block;
                margin-top: 20px;
                padding: 10px 20px;
                font-size: 18px;
                font-weight: bold;
                color: white;
                background-color: blue;
                text-decoration: none;
                border-radius: 5px;
                box-shadow: 2px 2px 5px black;
                transition: background 0.3s, transform 0.2s;
            }

            a:hover {
                background-color: darkred;
                transform: scale(1.1);
            }

        </style>
        <% %>
            <h1>ERROR !!!!!!!!!!!!</h1>
            <h1><%=request.getAttribute("errorMess") %></h1>
        <a href="LoginCustomerPage.jsp" > Back to Login</a>
    </body>
</html>
