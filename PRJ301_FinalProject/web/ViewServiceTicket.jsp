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
<html>
    <head>
        <title>SERVICE TICKET</title>
        <style>
            table {
                width: 100%;
                border-collapse: collapse;
            }

            table, th, td {
                border: 1px solid black;
            }

            th, td {
                padding: 8px;
                text-align: left;
            }

            .details-section {
                display: none; /* Ban đầu ẩn phần chi tiết */
                margin-top: 20px;
            }

            .details-btn {
                background-color: blue;
                color: white;
                padding: 5px;
                border: none;
                cursor: pointer;
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

                        inputField.value = name;         // Gán tên vào ô input tên
                        phoneField.value = phone;         // Gán số điện thoại vào ô input phone
                        addressField.value = address;     // Gán địa chỉ vào ô input address
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
                let price = selectedOption.getAttribute("data-price"); // Lấy giá từ data-price
                let row = selectElement.closest("tr"); // Tìm hàng cha của select
                let priceInput = row.querySelector("input[name='partPrice']"); // Chỉ lấy input trong cùng hàng
                priceInput.value = price; // Gán giá vào đúng hàng
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


        </script>
    </head>

    <body>
        <h2 style="text-align: center">SEVICE TICKET</h2>

        <%
            // list ticket for SalePerson
            if (session.getAttribute("salesID") != null) {
        %>
        <button onclick="showCreateForm()">Create new Service Ticket</button>

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
                <table class="create-table">
                    <tr>
                        <td><strong>Customer Name: </strong> <input type="text" name="custName" id="nameInput" list="listCustSuggestion" oninput="fetchCustSuggestions()" onchange="autoCompleteCustInfo()">
                            <datalist id="listCustSuggestion"></datalist></td>
                        <td><strong>Phone: </strong><input type="text" name="custPhone" id="phoneInput"></td>
                        <td><strong>Sex: </strong><input name="custSex" id="sexInput" ></input></td>
                    </tr>
                    <td><strong>Address: </strong><input type="text" name="custAddress" id="addressInput"></td>
                    <tr>

                    </tr>
                    <tr>
                        <td><strong>Car Model: <input type="text" name="carModel" id="modelInput" list="listCarSuggestion" oninput="fetchCarSuggestions()" onchange="autoCompleteCarInfo()"> <datalist id="listCarSuggestion"></datalist></td>
                        <td><strong>Date Received: </strong> <input type="date" name="dateRecived"> </td>
                        <td><strong>Date Returned: </strong> <input type="date" name="dateReturned"> </td>
                    </tr>
                    <tr>
                        <td><strong>Car Color: <label id="colorInput"></label> </strong><input type="hidden" name="carColor"></td>
                        <td><strong>Mechanic Name: </strong><select name="mechanicName">
                                <%for (Mechanic mec : mecList) {
                                %>
                                <option value="<%=mec.getName()%>"><%=mec.getName()%></option>  
                                <%
                                    }
                                %>
                            </select>
                        </td>
                        <td><strong>Comment</strong> <input type="text" name="comment"></td>
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
                            <th>Hours</th>
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
                                <input type="text" readonly name="partPrice">
                            </td>
                            <td><input type="number" name="numOfUsed">
                            </td>
                            <td><input type="number" name="hours">
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
        </div>

        <%
                out.print(request.getAttribute("isCreateServiceTicket"));
            }
            //Detail of service Ticket for customer
            List<ServiceTicketDetails> serDetail = (List<ServiceTicketDetails>) request.getAttribute("serDetail");

            if (serDetail != null) {
                for (ServiceTicketDetails ser : serDetail) {
        %>
        <table class="info-table">
            <tr>
                <td><strong>Ticket ID:</strong> <%= ser.getTicketID()%></td>
                <td><strong>Customer Name:</strong> <%= ser.getCustName()%></td>
                <td><strong>Phone:</strong> <%= ser.getPhone()%></td>
            </tr>
            <tr>
                <td><strong>Car Model:</strong> <%= ser.getCarModel()%></td>
                <td><strong>Date Received:</strong> <%= ser.getDateReceived()%></td>
                <td><strong>Date Returned:</strong> <%= ser.getDateReturned()%></td>
            </tr>
            <tr>
                <td><strong>Car Color:</strong> <%= ser.getCarColour()%></td>
                <td><strong>Mechanic Name:</strong> <%= ser.getMechanicName()%></td>
                <td><strong>Comment:</strong> <%= ser.getCommemt()%></td>
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
                </tr>
            </thead>
            <tbody>
                <%
                    for (ServiceTicketDetails ser : serDetail) {
                %>
                <tr>
                    <td><%= ser.getServiceName()%></td>
                    <td><%= ser.getPartName()%></td>
                    <td><%= NumberFormat.getNumberInstance().format(ser.getPartPrice())%></td>
                    <td><%= ser.getNumberUsed()%></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>

        <%
        } else { %>

        <!-- Danh sách service tickets -->
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
                        <form action="ViewServiceTicket" method="POST">
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
        <%
            if (session != null && session.getAttribute("salePerson") != null) {
        %>
        <a href="SalePersonDashboard.jsp"><button>Back to Dashboard</button></a>
        <% }
            if (session != null && session.getAttribute("customer") != null) {
        %>
        <a href="CustomerDashboardPage.jsp"><button>Back to Dashboard</button></a>
        <% }%>
        <div id="overlay" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%;
             background: rgba(0,0,0,0.5); z-index: 999;" onclick="hideCreateForm();">
        </div>
    </body>
</html>
