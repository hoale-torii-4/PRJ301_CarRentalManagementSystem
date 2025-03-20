<%@page import="model.Customer"%>
<%@page import="model.CarParts"%>
<%@page import="DAO.CRUDPartCarDAO"%>
<%@page import="model.Mechanic"%>
<%@page import="model.Service"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.MechanicDAO"%>
<%@page import="DAO.CRUDServiceDAO"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.HashSet"%>
<%@page import="DAO.ServiceTicketDAO"%>
<%@page import="model.ServiceTicketDetails"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title>SERVICE TICKET</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #ffffff;
                color: #003366;
                margin: 20px;
            }

            h2, h3 {
                text-align: center;
                color: #003366;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background: white;
                box-shadow: 0 0 10px rgba(0, 51, 102, 0.2);
                border-radius: 5px;
                overflow: hidden;
            }

            th, td {
                border: 1px solid #003366;
                padding: 10px;
                text-align: left;
            }

            th {
                background-color: #003366;
                color: white;
                border: 1px solid #fff;
            }

            tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            tr:hover {
                background-color: #ddd;
            }

            button {
                background-color: #003366;
                color: white;
                border: none;
                padding: 10px 15px;
                cursor: pointer;
                border-radius: 5px;
                margin-bottom: 10px;
            }

            button:hover {
                background-color: #002244;
            }

            .details-btn {
                background-color: #003366;
                color: white;
                padding: 5px 10px;
                border: none;
                cursor: pointer;
                border-radius: 3px;
            }

            .details-btn:hover {
                background-color: #002244;
            }
            #search-form{
                width: 70%;
                margin: auto;
            }
            #srsubmit{
                margin-left: 40%;
                width: 20%;
            }
            .createBtn {
                margin: 12px 0;
            }
            #createForm {
                background: white;
                border-radius: 8px;
                box-shadow: 0 0 15px rgba(0, 51, 102, 0.3);
                width: 90%;
            }

            input, select {
                padding: 8px;
                border: 1px solid #003366;
                border-radius: 4px;
                width: 100%;
                box-sizing: border-box;
                margin: 1%;
            }

            input:focus, select:focus {
                outline: none;
                border-color: #002244;
                box-shadow: 0 0 5px rgba(0, 51, 102, 0.5);
            }

            label {
                font-weight: bold;
            }


        </style>
        <script>
            function fetchCustSuggestions() {
                let query = document.getElementById("nameInput").value;
                if (query.length < 1)
                    return;

                fetch("SearchCustomerServlet?custName=" + encodeURIComponent(query))
                        .then(response => response.json())
                        .then(data => {
                            let dataList = document.getElementById("listCustSuggestion");
                            dataList.innerHTML = ""; // Xóa gợi ý cũ

                            data.forEach(item => {
                                let option = document.createElement("option");
                                option.value = item; // Gán toàn bộ giá trị gợi ý
                                dataList.appendChild(option);
                            });
                        })
                        .catch(error => console.error("Error fetching suggestions:", error));
            }
            function fetchCarSuggestions() {
                let query = document.getElementById("modelInput").value;
                if (query.length < 1)
                    return;

                fetch("SearchCarServlet?query=" + encodeURIComponent(query))
                        .then(response => response.json())
                        .then(data => {
                            let dataList = document.getElementById("listCarSuggestion");
                            dataList.innerHTML = ""; // Xóa gợi ý cũ

                            data.forEach(item => {
                                let option = document.createElement("option");
                                option.value = item; // Gán toàn bộ giá trị gợi ý
                                dataList.appendChild(option);
                            });
                        })
                        .catch(error => console.error("Error fetching suggestions:", error));
            }
            function autoCompleteCustInfo() {
                let inputField = document.getElementById("nameInput");
                let phoneField = document.getElementById("phoneInput");
                let sexField = document.getElementById("sexInput");
                let addressField = document.getElementById("addressInput");
                let selectedValue = inputField.value;

                // Nếu chuỗi chứa " - " và có ít nhất 4 phần
                if (selectedValue.includes(" - ")) {
                    let parts = selectedValue.split(" - ");
                    if (parts.length >= 4) {
                        let name = parts[0].trim();
                        let phone = parts[1].trim();
                        let sex = parts[2].trim();
                        let address = parts[3].trim();

                        inputField.value = name;
                        phoneField.value = phone;
                        addressField.value = address;
                        // Kiểm tra giới tính
                        if (sex.toUpperCase() === "F") {
                            sexField.value = "Female";
                        } else if (sex.toUpperCase() === "M") {
                            sexField.value = "Male";
                        } else {
                            sexField.value = sex;
                        }
                    }
                }
            }
            function autoCompleteCarInfo() {
                let inputField = document.getElementById("modelInput");
                let colorField = document.getElementById("colorInput");

                let selectedValue = inputField.value;

                // Nếu chuỗi chứa " - " và có ít nhất 4 phần
                if (selectedValue.includes(" - ")) {
                    let parts = selectedValue.split(" - ");
                    if (parts.length >= 4) {
                        let model = parts[1].trim();
                        let color = parts[2].trim();

                        inputField.value = model;
                        colorField.innerHTML = color;
                        document.getElementById("carColor").value = color; // Gán giá trị hidden

                    }
                }
            }
            function autoCompletePartPrice(selectElement) {
                let selectedOption = selectElement.options[selectElement.selectedIndex];
                let price = selectedOption.getAttribute("data-price");
                let row = selectElement.closest("tr");
                let priceInput = row.querySelector("input[name='partPrice']");
                priceInput.value = price;
            }

            function addRow() {
                // Lấy tbody của bảng detail
                var tableBody = document.getElementById("detailTable").getElementsByTagName("tbody")[0];
                // Lấy hàng đầu tiên để clone
                var firstRow = tableBody.getElementsByTagName("tr")[0];
                // Clone hàng đầu tiên (deep clone)
                var newRow = firstRow.cloneNode(true);

                // Xóa giá trị của các input, nếu có (ví dụ input type="number")
                var inputs = newRow.getElementsByTagName("input");
                for (var i = 0; i < inputs.length; i++) {
                    inputs[i].value = "";
                }
                // (Nếu cần, bạn có thể reset select về giá trị mặc định)
                var selects = newRow.getElementsByTagName("select");
                for (var i = 0; i < selects.length; i++) {
                    selects[i].selectedIndex = 0;
                }
                tableBody.appendChild(newRow);

                let countInput = document.getElementById("count");
                countInput.value = parseInt(countInput.value) + 1;
                document.getElementById("in").innerHTML = countInput.value;

            }

            function removeRow(button) {
                // Xác định hàng chứa nút được bấm
                var row = button.parentNode.parentNode;
                var tableBody = document.getElementById("detailTable").getElementsByTagName("tbody")[0];
                // Nếu có hơn 1 hàng, cho phép xóa; nếu chỉ còn 1 hàng thì cảnh báo
                if (tableBody.rows.length > 1) {
                    tableBody.removeChild(row);
                    let countInput = document.getElementById("count");
                    countInput.value = parseInt(countInput.value) - 1;
                    document.getElementById("in").innerHTML = countInput.value;
                } else {
                    alert("Phải có ít nhất 1 hàng detail.");
                }

            }
            function showCreateForm() {
                document.getElementById("createForm").style.display = "block";
                document.getElementById("overlay").style.display = "block";
            }

            function hideCreateForm() {
                document.getElementById("createForm").style.display = "none";
                document.getElementById("overlay").style.display = "none";
            }

            function openUpdateModal(ticketID, hours, comment, rate, serviceName) {
                document.getElementById("updateTicketID").value = ticketID;
                document.getElementById("updateHours").value = hours;
                document.getElementById("updateComment").value = comment;
                document.getElementById("updateRate").value = rate;
                document.getElementById("serviceName").value = serviceName;
                document.getElementById("updateTicketModal").style.display = "block";
                document.getElementById("overlay").style.display = "block";
            }

            function closeUpdateModal() {
                document.getElementById("updateTicketModal").style.display = "none";
                document.getElementById("overlay").style.display = "none";
            }
            document.addEventListener("DOMContentLoaded", function () {
                var message = "<%= request.getAttribute("responseMessage")%>";
                if (message && message !== "null") {
                    var popup = document.createElement("div");
                    popup.textContent = message;
                    popup.style.position = "fixed";
                    popup.style.top = "20px";
                    popup.style.right = "20px";
                    popup.style.padding = "15px";
                    popup.style.backgroundColor = "#4CAF50";
                    popup.style.color = "white";
                    popup.style.borderRadius = "5px";
                    popup.style.boxShadow = "0px 0px 10px rgba(0, 0, 0, 0.1)";
                    document.body.appendChild(popup);

                    setTimeout(function () {
                        popup.style.opacity = "0";
                        setTimeout(() => popup.remove(), 500);
                    }, 5000);
                }
            });
        </script>
    </head>

    <body>
        <h2 style="text-align: center">SERVICE TICKET</h2>


        <%
            // list ticket for staff
            String mechanicID = (String) session.getAttribute("mechanicID");
            String saleID = (String) session.getAttribute("salesID");
            Customer customer = (Customer) session.getAttribute("customer");
            String urlToBack = "CustomerDashboardPage.jsp";
            String urlToBackInDetail = "ViewServiceTicket?action=CUSTOMER";
            if (saleID == null && mechanicID == null && customer == null) {
                request.setAttribute("FailedLogin", "You must Login");
                request.getRequestDispatcher("LoginCustomerPage.jsp").forward(request, response);
            }
            if (saleID != null || mechanicID != null) {
                urlToBackInDetail = "ViewServiceTicket?action=STAFF";
                //role sale person
                if (saleID != null) {
                    urlToBack = "SalePersonDashboard.jsp";
        %>



        <div id="createForm" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%);
             background: white; padding: 20px; border: 1px solid black; z-index: 1000;">
            <%
                CRUDServiceDAO serDAO = new CRUDServiceDAO();
                MechanicDAO mecDAO = new MechanicDAO();
                CRUDPartCarDAO partDAO = new CRUDPartCarDAO();
                ArrayList<Service> serList = new ArrayList<>();
                ArrayList<Mechanic> mecList = new ArrayList<>();
                ArrayList<CarParts> partList = new ArrayList<>();
                serList = serDAO.getAllService();
                mecList = mecDAO.getListAllMechanic();
                partList = partDAO.getAllCarPart();
            %>
            <form action="CreateServiceTicketServlet" method="GET" accept-charset="UTF-8">
                <h2>CREATE SERVICE TICKET</h2>
                <table class="create-table">
                    <tr>
                        <td><strong>Customer Name: </strong> <input type="text" name="custName" id="nameInput" list="listCustSuggestion" oninput="fetchCustSuggestions()" onchange="autoCompleteCustInfo()" required>
                            <datalist id="listCustSuggestion"></datalist></td>
                        <td><strong>Phone: </strong><input type="number" name="custPhone" id="phoneInput" required></td>
                        <td><strong>Sex: </strong><input name="custSex" id="sexInput" required ></input></td>

                    </tr>
                    <tr>
                        <td><strong>Car Model:</strong> <input type="text" name="carModel" id="modelInput" list="listCarSuggestion" oninput="fetchCarSuggestions()" onchange="autoCompleteCarInfo()" required> 
                            <datalist id="listCarSuggestion"></datalist>
                        </td>
                        <td><strong>Date Received: </strong> <input type="date" name="dateReceived" required> </td>
                        <td><strong>Date Returned: </strong> <input type="date" name="dateReturned" required> </td>
                    </tr>
                    <tr>
                        <td><strong>Car Color: <label id="colorInput"></label> </strong><input type="hidden" name="carColor"></td>

                        <td><strong>Address: </strong><input type="text" name="custAddress" id="addressInput" required></td>

                    </tr>
                </table>
                <h2 style="text-align: center;">DETAIL</h2>
                <table id="detailTable">
                    <thead>
                        <tr>
                            <th>Service Name</th>
                            <th>Part</th>
                            <th>Price</th>
                            <th>Number Of Used</th>
                            <th>Mechanic</th>
                            <th>Hours</th>
                            <th>Comment</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><select name="serviceName" id="serviceInput" >
                                    <%for (Service ser : serList) {
                                    %>
                                    <option value="<%=ser.getName()%>"><%=ser.getName()%></option>  
                                    <%
                                        }
                                    %> </select></td>

                            <td>
                                <select name="partName" onchange="autoCompletePartPrice(this)">
                                    <%for (CarParts part : partList) {%>
                                    <option value="<%=part.getPartName()%>" data-price="<%=part.getRetailPrice()%>">
                                        <%=part.getPartName()%>
                                    </option>  
                                    <% } %>
                                </select>
                            </td>
                            <td>
                                <input type="text" readonly name="partPrice" required="">
                            </td>
                            <td><input type="number" name="numOfUsed" required>
                            </td>
                            <td><select name="mechanicName" required>
                                    <%for (Mechanic mec : mecList) {
                                    %>
                                    <option value="<%=mec.getName()%>"><%=mec.getName()%></option>  
                                    <%
                                        }
                                    %>
                                </select>
                            </td>
                            <td><input type="number" name="hours" required>
                            </td>
                            <td><input type="text" name="comment" required>
                            </td>

                            <td>
                                <button type="button" onclick="removeRow(this)">X</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <input type="hidden" name="count" id="count" value="1">
                <label id="in"></label>
                <button type="submit">Submit</button>
                <button type="button" onclick="addRow()">+</button>
            </form>
            <button onclick="hideCreateForm()">Cancel</button>
        </div> <!--end create FORM-->
        <%
            }
            // update service ticket for mechanic form 
            if (mechanicID != null) {
                urlToBack = "MechanicDashboard.jsp";
        %>                        
        <div id="updateTicketModal" style="display: none; background: white; padding: 20px; border: 1px solid black; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 1000;">
            <h3>Update Service Ticket</h3>
            <form action="ViewServiceTicket?action=UPDATE" method="POST" accept-charset="UTF-8">
                <label>Service Ticket ID:</label>
                <input type="text" name="serviceTicketID" id="updateTicketID" readonly="">
                <label>Service:</label>
                <input type="text" name="serviceName" id="serviceName" readonly="">
                <label>Hours:</label>
                <input type="number" name="hours" id="updateHours" required><br>
                <label>Comment:</label>
                <input type="text" name="comment" id="updateComment" required><br>
                <label>Rate:</label>
                <input type="number" name="rate" id="updateRate" required><br>
                <button type="submit">Update</button>
                <button type="button" onclick="closeUpdateModal()">Cancel</button>
            </form>
        </div>
        <%}%>
        <!--Search form-->
        <form   id = search-form method="get" action="ViewServiceTicket">
            <label for="custID">Customer ID:</label>
            <input type="text" id="custID" name="custID" /><br/>

            <label for="carID">Car ID:</label>
            <input type="text" id="carID" name="carID" /><br/>

            <label for="dateReceived">Date Received:</label>
            <input type="date" id="dateReceived" name="dateReceived" /><br/>
            <input type="hidden"  name="action" value="SEARCH">
            <button id="srsubmit" type="submit">Search</button><br/><br/>
        </form>
        <!--end search form-->

        <%
            }

            //Detail of service Ticket 
            List<ServiceTicketDetails> serDetail = (List<ServiceTicketDetails>) request.getAttribute("serDetail");

            if (serDetail != null) {%>
        <a href="<%= urlToBackInDetail%>" ><button>Back to List Service Ticket </button></a>

        <% for (ServiceTicketDetails ser : serDetail) {
        %>
        <table class="info-table">
            <tr>
                <td><strong>Ticket ID:</strong> <%= ser.getTicketID()%></td>
                <td><strong>Customer Name:</strong> <%= ser.getCustName()%></td>
                <td><strong>Phone:</strong> <%= ser.getPhone()%></td>
            </tr>
            <tr>
                <td><strong>Date Received:</strong> <%= ser.getDateReceived()%></td>
                <td><strong>Date Returned:</strong> <%= ser.getDateReturned()%></td>
            </tr>
            <tr>
                <td><strong>Car Model:</strong> <%= ser.getCarModel()%></td>
                <td><strong>Car Color:</strong> <%= ser.getCarColour()%></td>
            </tr>
        </table>

        <%
                break;
            }
        %>  

        <h3 style="text-align: center">DETAIL</h3>
        <table>
            <thead>
                <tr>
                    <th>Service Name</th>
                    <th>Part Name</th>
                    <th>Price</th>
                    <th>Number of Used</th>
                    <th>Mechanic</th>
                    <th>Hours</th>
                    <th>Rate</th>
                    <th>Comment</th>
                        <c:if test="${mechanicID != null }">
                        <th id="updateButton">Action</th>
                        </c:if>

                </tr>
            </thead>
            <tbody>
                <%
                    MechanicDAO mecDAO = new MechanicDAO();
                    Mechanic mec;
                    for (ServiceTicketDetails ser : serDetail) {
                        mec = mecDAO.checkLogin(ser.getMechanicName());
                %>
                <tr>
                    <td><%= ser.getServiceName()%></td>
                    <td><%= ser.getPartName()%></td>
                    <td><%= NumberFormat.getNumberInstance().format(ser.getPartPrice())%></td>
                    <td><%= ser.getNumberUsed()%></td>
                    <td><%= ser.getMechanicName()%></td>
                    <td><%= ser.getHour()%></td>
                    <td><%= ser.getRate()%></td>
                    <td><%= ser.getCommemt()%></td> 
                    <% if (mec.getId().equals(mechanicID)) {%>
                    <td><button type="button" id="updateButton" onclick="openUpdateModal('<%= ser.getTicketID()%>', '<%= ser.getHour()%>', '<%= ser.getCommemt()%>', '<%=ser.getRate()%>', '<%=ser.getServiceName()%>')">Update</button></td>
                    <%}%>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        <% // end Detail service ticket
        } else {%>
        <div>
            <a href="<%= urlToBack%>" ><button>Back to Dashboard </button></a>
           <%if(saleID!=null) {%>
            <button onclick="showCreateForm()" class="createBtn">Create new Service Ticket</button>
            <%}%>
        </div>

        <!-- List service tickets -->
        <table id="ticketList">
            <thead>
                <tr>
                    <th>Ticket ID</th>
                    <th>Date Received</th>
                    <th>Date Returned</th>
                    <th>Customer Name</th>
                    <th>Phone</th>
                    <th>Car Model</th>
                    <th>Car Color</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<ServiceTicketDetails> serviceTickets = (List<ServiceTicketDetails>) request.getAttribute("serviceTicket");

                    HashSet<String> displayedTicketIDs = new HashSet<>();

                    if (serviceTickets != null && !serviceTickets.isEmpty()) {
                        for (ServiceTicketDetails ticket : serviceTickets) {
                            if (ticket.getTicketID() != null && displayedTicketIDs.contains(ticket.getTicketID())) {
                                continue;
                            }
                            if (ticket.getTicketID() != null) {
                                displayedTicketIDs.add(ticket.getTicketID());
                            }

                %>
                <tr>
                    <td><%= ticket.getTicketID()%></td>
                    <td><%= ticket.getDateReceived()%></td>
                    <td><%= ticket.getDateReturned()%></td>
                    <td><%= ticket.getCustName()%></td>
                    <td><%= ticket.getPhone()%></td>
                    <td><%= ticket.getCarModel()%></td>
                    <td><%= ticket.getCarColour()%></td>
                    <td>
                        <form action="ViewServiceTicket?action=DETAIL" method="POST">
                            <input type="hidden" name="ticketID" value="<%= ticket.getTicketID()%>">
                            <input type="submit" class="details-btn" value="Detail" />
                        </form>

                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="8">No service tickets found</td>
                </tr>
                <%
                    }
                %>
            </tbody>

        </table>
        <%}%>
        <div id="overlay" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%;
             background: rgba(0,0,0,0.5); z-index: 999;" onclick="hideCreateForm();">
        </div>
    </body>
</html>
