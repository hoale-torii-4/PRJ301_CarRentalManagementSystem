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
        <title>Report </title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                color: #333;
                margin: 0;
                padding: 0;
            }

            h1 {
                text-align: center;
                color: #003366;
                font-family: 'Arial', sans-serif;
                margin-top: 20px;
            }

            h2 {
                color: #003366;
                font-size: 18px;
                margin: 10px 0;
            }

            h3 {
                color: #003366;
            }

            button {
                background-color: #003366;
                color: white;
                padding: 10px 15px;
                border: none;
                cursor: pointer;
                border-radius: 4px;
                text-align: center;
                text-decoration: none;
                margin: 10px 5px;
            }

            button:hover {
                background-color: #002244;
            }

            #findForm {
                width: 80%;
                margin: 0 auto;
                padding: 20px;
                background-color: #ffffff;
                border-radius: 5px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            #findForm select {
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }

            #findForm input[type="submit"] {
                background-color: #003366;
                color: white;
                padding: 10px 15px;
                border: none;
                cursor: pointer;
                border-radius: 4px;
                margin-left: 10px;
            }

            #findForm input[type="submit"]:hover {
                background-color: #002244;
            }

            table {
                width: 90%;
                margin: 20px auto;
                border-collapse: collapse;
                background-color: #ffffff;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            }

            table, th, td {
                border: 1px solid #ddd;
            }

            th, td {
                padding: 12px;
                text-align: left;
                font-size: 14px;
            }

            th {
                background-color: #003366;
                color: white;
            }

            tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            tr:hover {
                background-color: #f1f1f1;
            }

            .modal {
                display: none;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background-color: white;
                padding: 20px;
                border: 1px solid #ddd;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
                z-index: 1000;
                width: 80%;
                max-width: 500px;
            }

            .overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                z-index: 999;
            }

            .modal button {
                background-color: #003366;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            .modal button:hover {
                background-color: #002244;
            }

            .modal form {
                width: 100%;
            }

            .modal input[type="text"] {
                width: 100%;
                padding: 10px;
                margin: 10px 0;
                border: 1px solid #ddd;
                border-radius: 4px;
            }

            .cancel-btn {
                background-color: #ff3300;
                margin-top: 10px;
            }

            .cancel-btn:hover {
                background-color: #cc2900;
            }

            .back-button {
                display: block;
                width: 150px;
                margin: 20px auto;
                padding: 10px 15px;
                background-color: #003366;
                color: white;
                border: none;
                border-radius: 4px;
                text-align: center;
                text-decoration: none;
            }

            .back-button:hover {
                background-color: #002244;
            }

            .hidden {
                display: none;
            }

            .searchCarSoldByyear {
                margin-left: 8%;
            }

            .searchCarSoldByyear select, input {
                height: 36px;
                width: 71.5px;
            }

            .searchCarSoldByyear input {
                background-color:#003366;
                color: #fff;
                border-style: none;
                border-radius: 3px;

            }
            .searchCarSoldByyear button {
                height: 29px;
                margin-left: 0;
                width: 71.5px;
                height: 36px;
                padding: 0px;
            }

            .PriceCarSoldByYear {
                margin-left: 8%;
            }
            .moreCancelBtn {
                margin-left: 5%;
            }

            .moreCancelBtn button,#moreButton{
                width: 71.5px;
                margin: 10px 5px;
            }

            .BackBtn input{
                background-color: #003366;
                color: #fff;
                border-style: none;
                border-radius: 4px;
            }
            .BackBtn input:hover {
                background-color: #002244;
            }

            #ThreeMechanic button{
                margin-left: 5%;
            }

            #moreButton {
                margin: 20px;
                background-color: #003366;
                color: white;
                padding: 10px 15px;
                border: none;
                cursor: pointer;
                border-radius: 4px;
            }

/*            #moreButton:hover {
                background-color: #002244;
            }*/
            
        .navbar {
            background-color: #003366; /* Màu sắc phù hợp với giao diện hiện tại */
            padding: 10px;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
            text-align: center;
            width: 100%;
        }
        .navbar a {
            color: white;
            text-decoration: none;
            padding: 10px 15px;
        }
/*        .navbar a:hover {
            background-color: #002050;
            border-radius: 5px;
        }*/
        

        </style>
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
        <%
                    if (session.getAttribute("salePerson") == null) {
                        response.sendRedirect("LoginCustomerPage.jsp");
                    }
                %>
        <div class="navbar">
            <div>
                <a href="#"><button onclick="showCarSoldByYear()">Car sold by year</button></a>
                <a href="ReportSalePersonServlet?reportType=BESTMODEL" ><button onclick="showBestModel()">Best selling model</button></a>
                <a href="ReportSalePersonServlet?reportType=BESTPART" ><button onclick="showBestPart()">Best used part</button></a>
                <a href="ReportSalePersonServlet?reportType=MECHANIC" ><button onclick="showMechanic()">Three mechanic most repair</button></a>
                <a href="SalePersonDashboard.jsp" class="BackBtn"> <input type="submit" value="Back" /> </a> 
            </div>
        </div>
        

<!--        <button onclick="showCarSoldByYear()">Car sold by year</button>
        <a href="ReportSalePersonServlet?reportType=BESTMODEL" ><button onclick="showBestModel()">Best selling model</button></a>
        <a href="ReportSalePersonServlet?reportType=BESTPART" ><button onclick="showBestPart()">Best used part</button></a>
        <a href="ReportSalePersonServlet?reportType=MECHANIC" ><button onclick="showMechanic()">Three mechanic most repair</button></a>
        <a href="SalePersonDashboard.jsp" class="BackBtn"> <input type="submit" value="Back" /> </a>-->

        <!-- Car sold by year -->
        <div id="CarSoldByYear" style="display: none;">
            <h1>STATICS OF CARS SOLD BY YEAR</h1>
            <div class="searchCarSoldByyear">
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
            </div>
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
            <div class="PriceCarSoldByYear">
                <h2>Total: <%=list.size()%></h2>
                <h2>Total Price: <%= NumberFormat.getInstance().format(totalPrice)%></h2>
            </div>


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
            <div class="moreCancelBtn">
                <button onclick="hiddenBestModel()">Cancel</button>
                <button id="moreButton" onclick="showMore()">More</button>
            </div>
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

            <div class="moreCancelBtn">
                <button onclick="hiddenBestPart()">Cancel</button>
                <button id="moreButton" onclick="showMore()">More</button>
            </div>

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
