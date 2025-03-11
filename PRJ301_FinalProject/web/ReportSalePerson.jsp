<%-- 
    Document   : ReportSalePerson
    Created on : Feb 28, 2025, 1:59:30 PM
    Author     : LENOVO
--%>

<%@page import="java.util.Map"%>
<%@page import="model.Mechanic"%>
<%@page import="model.PartUsed"%>
<%@page import="java.util.HashMap"%>
<%@page import="model.Car"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.SalesInvoice"%>
<%@page import="java.text.NumberFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript">
            window.onload = function () {
                let carSold = <%= (request.getAttribute("LIST_YEAR") != null) ? "true" : "false"%>;
                let bestModel = <%= (request.getAttribute("BSCAR_MAP") != null) ? "true" : "false"%>;
                let bestPart = <%= (request.getAttribute("LIST_USEDPART") != null) ? "true" : "false"%>;
                let ThreeMechanic = <%= (request.getAttribute("MAP_MECHANIC") != null) ? "true" : "false"%>;
                if (carSold) {
                    document.getElementById("CarSoldByYear").style.display = "block";
                } else if (bestModel) {
                    document.getElementById("BestSellingCar").style.display = "block";
                } else if (bestPart) {
                    document.getElementById("BestSellingPart").style.display = "block";
                } else if (ThreeMechanic) {
                    document.getElementById("ThreeMechanic").style.display = "block";
                }
            };
            //hide all
            function hideAllSections() {
                document.getElementById("CarSoldByYear").style.display = "none";
                document.getElementById("BestSellingCar").style.display = "none";
                document.getElementById("BestSellingPart").style.display = "none";
                document.getElementById("ThreeMechanic").style.display = "none";
            }
            //report Car sold By Year
            function showCarSoldByYear() {
                hideAllSections();
                document.getElementById("CarSoldByYear").style.display = "block";
            }
            function hiddenCarSoldByYear() {
                document.getElementById("CarSoldByYear").style.display = "none";
            }
            function showBestModel() {
                hideAllSections();
                document.getElementById("BestSellingCar").style.display = "block";
            }
            function hiddenBestModel() {
                document.getElementById("BestSellingCar").style.display = "none";
            }
            function showBestPart() {
                hideAllSections();
                document.getElementById("BestSellingPart").style.display = "block";
            }
            function hiddenBestPart() {
                document.getElementById("BestSellingPart").style.display = "none";
            }
            function showMechanic() {
                hideAllSections();
                document.getElementById("ThreeMechanic").style.display = "block";
            }
            function hiddenMechanic() {
                document.getElementById("ThreeMechanic").style.display = "none";
            }
        </script>

    </head>
    <body>

        <button onclick="showCarSoldByYear()">Car sold by year</button>
        <a href="ReportSalePersonServlet?reportType=BESTMODEL" ><button onclick="showBestModel()">Best selling model</button></a>
        <a href="ReportSalePersonServlet?reportType=BESTPART" ><button onclick="showBestPart()">Best used part</button></a>
        <a href="ReportSalePersonServlet?reportType=MECHANIC" ><button onclick="showMechanic()">Three mechanic most repair</button></a>
        <a href="SalePersonDashboard.jsp"> <input type="submit" value="Back" /> </a>

        <!-- Car sold by year -->
        <div id="CarSoldByYear" style="display: none;">
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
            <button onclick="hiddenCarSoldByYear()">Cancel</button>
            <%String updateStatus = (String) request.getAttribute("updateMess");
                if (updateStatus != null && !updateStatus.isEmpty()) {
            %>
            <h2><p><%=updateStatus%></p></h2>
            <%
                }
                ArrayList<SalesInvoice> list = (ArrayList<SalesInvoice>) request.getAttribute("LIST_YEAR");

                if (list != null && !list.isEmpty()) {

                    double totalPrice = (Double) request.getAttribute("REVENUE");
            %>
            <h2>Total: <%=list.size()%></h2>
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
        </div>
        <!-- Best selling model -->
        <div id="BestSellingCar" style="display: none;">
            <h1>STATISTICS OF BEST-SELLING CAR MODEL</h1>
            <button onclick="hiddenBestModel()">Cancel</button>
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
                <tr class="<%= rowClass%>">
                    <td><%= car.getCarId()%></td>
                    <td><%= car.getSerialNumber()%></td>
                    <td><%= car.getModel()%></td>
                    <td><%= car.getColor()%></td>
                    <td><%= car.getYear()%></td>
                    <td><%= NumberFormat.getInstance().format(car.getPrice())%></td>
                    <td><%= numberCar%></td>
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
                    hiddenRows.forEach(function (row) {
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
        </div>
        <!-- Best used part -->
        <div id="BestSellingPart" style="display: none">
            <h1>STATICS OF BEST USED PARTS</h1>
            <button onclick="hiddenBestPart()">Cancel</button>
            <%
                ArrayList<PartUsed> listPart = (ArrayList<PartUsed>) request.getAttribute("LIST_USEDPART");
                if (listPart != null && !listPart.isEmpty()) {

            %>

            <table border="1" id="partTable">
                <tr>
                    <th>serviceTicketID</th>
                    <th>partID</th>
                    <th>numberUsed</th>
                    <th>price</th>
                </tr>
                <%                    int index = 0;
                    for (PartUsed pu : listPart) {
                        String rowClass = index < 3 ? "visible" : "hidden";
                %>
                <tr class="<%= rowClass%>">
                    <td><%=pu.getServiceTicketID()%></td>
                    <td><%=pu.getPartID()%></td>
                    <td><%=pu.getNumberUsed()%></td>
                    <td><%=pu.getPrice()%></td>
                </tr>
                <%
                        index++;
                    }
                %>
            </table>
            <button id="moreButton" onclick="showMore()">More</button>

            <script>
                function showMore() {
                    var hiddenRows = document.querySelectorAll('#partTable .hidden');
                    hiddenRows.forEach(function (row) {
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
        </div>
        <!-- Three most mechanic -->
        <div id="ThreeMechanic" style="display: none">
            <h1>THREE MOST MECHANIC</h1>
            <button onclick="hiddenMechanic()">Cancel</button>
            <%
                HashMap<Mechanic, Integer> map = (HashMap<Mechanic, Integer>) request.getAttribute("MAP_MECHANIC");
            %>
            <table border="1">
                <tr>
                    <th>Mechanic ID</th>
                    <th>Mechanic Name</th>
                    <th>Total</th>
                </tr>
                <%                if (map != null && !map.isEmpty()) {
                        for (Map.Entry<Mechanic, Integer> mechicMap : map.entrySet()) {
                            Mechanic mechanic = mechicMap.getKey();
                            int total = mechicMap.getValue();

                %>
                <tr>
                    <td><%=mechanic.getId()%></td>
                    <td><%=mechanic.getName()%></td>
                    <td><%=total%></td>
                </tr>
                <%
                        }
                    }
                %>
            </table>
        </div>



    </body>
</html>
