<%-- 
    Document   : BestCarSellingModel
    Created on : Mar 2, 2025, 4:28:21 PM
    Author     : LENOVO
--%>

<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="model.Car"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>STATISTICS OF BEST-SELLING CAR MODEL</h1>

<%
    HashMap<Car, Integer> carMap = (HashMap<Car, Integer>) request.getAttribute("BSCAR_MAP");
    if (carMap != null && !carMap.isEmpty()) {
%>

<table border="1" id="carTable">
    <tr>
        <th>CarID</th>
        <th>SerialNumber</th>
        <th>Model</th>
        <th>Color</th>
        <th>Year</th>
        <th>Price</th>
        <th>Number of cars sold</th>
    </tr>
    <% 
        int index = 0;
        for (Car car : carMap.keySet()) {
            int numberCar = carMap.get(car);
            String rowClass = index < 3 ? "visible" : "hidden";
    %>
    <tr class="<%= rowClass %>">
        <td><%= car.getCarId() %></td>
        <td><%= car.getSerialNumber() %></td>
        <td><%= car.getModel() %></td>
        <td><%= car.getColor() %></td>
        <td><%= car.getYear() %></td>
        <td><%= NumberFormat.getInstance().format(car.getPrice()) %></td>
        <td><%= numberCar %></td>
    </tr>
    <%
            index++;
        }
    %>
</table>

<button id="moreButton" onclick="showMore()">More</button>

<script>
    function showMore() {
        var hiddenRows = document.querySelectorAll('#carTable .hidden');
        hiddenRows.forEach(function(row) {
            row.style.display = 'table-row';
        });
        document.getElementById('moreButton').style.display = 'none';
    }
</script>

<style>
    .hidden {
        display: none;
    }
</style>

<%
    }
%>

    </body>
</html>
