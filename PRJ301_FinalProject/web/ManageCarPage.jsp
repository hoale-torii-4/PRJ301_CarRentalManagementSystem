<%-- 
    Document   : ManageCarPage
    Created on : Mar 8, 2025, 8:31:41 AM
    Author     : HOA LE
--%>

<%@page import="java.text.NumberFormat"%>
<%@page import="model.SalePerson"%>
<%@page import="java.util.List"%>
<%@page import="model.Car"%>
<%@page import="model.Car"%>
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Car</title>
        <script>
            function fetchSuggestions() {
                let query = document.getElementById("searchInput").value;
                if (query.length < 1)
                    return;

                fetch("SearchCarServlet?query=" + encodeURIComponent(query))
                        .then(response => response.json())
                        .then(data => {
                            let dataList = document.getElementById("carSuggestions");
                            dataList.innerHTML = ""; // Xóa gợi ý cũ

                            data.forEach(item => {
                                let option = document.createElement("option");
                                option.value = item; // Gán toàn bộ giá trị gợi ý
                                dataList.appendChild(option);
                            });
                        })
                        .catch(error => console.error("Error fetching suggestions:", error));
            }
            function showCreateForm() {
                document.getElementById("createCarForm").style.display = "block";
                document.getElementById("overlay").style.display = "block";
            }

            function hideCreateForm() {
                document.getElementById("createCarForm").style.display = "none";
                document.getElementById("overlay").style.display = "none";
            }
            function showSearchDiv() {
                document.getElementById("searchDiv").style.display = "block";
            }

            function hideSearchDiv() {
                document.getElementById("searchDiv").style.display = "none";
            }

            function autoSubmit() {
                let inputField = document.getElementById("searchInput");
                let selectedValue = inputField.value;

                // Tách chuỗi: lấy phần trước dấu '-'
                let serialNumber = selectedValue.split(" - ")[0].trim();
                inputField.value = serialNumber; // Cập nhật lại giá trị input

                document.getElementById("searchForm").submit(); // Gửi form
            }
            function openUpdateModal(carID, serialNumber, model, colour, year, price) {
                document.getElementById("updateCarID").value = carID;
                document.getElementById("updateSerialNumber").value = serialNumber;
                document.getElementById("updateModel").value = model;
                document.getElementById("updateColour").value = colour;
                document.getElementById("updateYear").value = year;
                document.getElementById("updatePrice").value = price;
                document.getElementById("updateCarModal").style.display = "block";
                document.getElementById("overlay").style.display = "block";
            }

            function closeUpdateModal() {
                document.getElementById("updateCarModal").style.display = "none";
                document.getElementById("overlay").style.display = "none";
            }
            function confirmDelete(carID) {
                document.getElementById("deleteCarID").value = carID; // Gán ID xe vào form xóa
                document.getElementById("deleteConfirmModal").style.display = "block";
                document.getElementById("overlay").style.display = "block";
            }

            function closeDeleteModal() {
                document.getElementById("deleteConfirmModal").style.display = "none";
                document.getElementById("overlay").style.display = "none";
            }
            document.addEventListener("DOMContentLoaded", function () {
        var message = "<%= request.getAttribute("responseMessage") %>";
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
        <style>

            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                color: #333;
                margin: 0;
                padding: 0;
            }

            h1, h3 {
                text-align: center;
                color: #003366;
            }

            input, select, button {
                padding: 10px;
                border-radius: 4px;
                font-size: 14px;
            }

            input[type="text"], select {
                width: 92%;
                border: 1px solid #003366;
                margin-bottom: 12px;
            }

            button {
                background-color: #003366;
                color: white;
                border: none;
                cursor: pointer;
            }

            button:hover {
                background-color: #002244;
            }

            table {
                width: 90%;
                margin: 20px auto;
                border-collapse: collapse;
                background: white;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            th, td {
                padding: 12px;
                border: 1px solid #ddd;
            }

            th {
                background-color: #003366;
                color: white;
            }
            label {
                color: #003366;
                font-weight: 600 ;
            }

            tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            tr:hover {
                background-color: #f1f1f1;
            }

            .findForm {
                width: 80%;
                margin: 20px auto;
                background: white;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .modal {
                display: none;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background: white;
                padding: 20px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
                z-index: 1000;
                max-width: 500px;
                width: 90%;
            }

            .modal form input {
                width: 100%;
            }

            .overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                z-index: 999;
            }

            .cancel-btn {
                background-color: #ff3300;
            }

            .cancel-btn:hover {
                background-color: #cc2900;
            }

            .back-button {
                display: block;
                width: 150px;
                margin: 20px auto;
                text-align: center;
                background: #003366;
                color: white;
                text-decoration: none;
            }

            .back-button:hover {
                background: #002244;
            }
            
            .twoBtn {
                margin-left: 6%;
            }
            
            .message {
                margin-left: 6%;
                color: #003366;
                font-size: 18px;
                font-weight: 600;
            }

            #searchDiv {
                width: 100%;
                display: flex;
                margin-bottom: 20px;
            }



            #searchForm {
                width: 90%;
                display: inline-flex;
                margin: 12px 0;
                justify-content: center;
            }

            #searchForm input {
                width:  70%;
                margin: 0 20px;
            }

            button.createBtn {
                width: 10%;
                height: 36.4px;
                margin: 12px;
                margin-left: -100px;
                margin-right: 75px;
            }

            button.submitBtn {
                width: 8%;
                height: 36.4px;
            }
            
            h4 {
                text-align: center;
                font-size: 18px;
                color: #003366;
            }

        </style>

    </head>
    <body>

        <h4>Search Car by Serial Number, Model, or Year</h4>

        <div id="searchDiv">
            <form id="searchForm"  action="SearchCarServlet" method="POST">
                <input type="text" name="query" id="searchInput" list="carSuggestions" 
                       oninput="fetchSuggestions()" onchange="autoSubmit()">

                <datalist id="carSuggestions"></datalist>

                <button type="submit" class="submitBtn">Search</button>
            </form>
            <button type="button" onclick="showCreateForm()" class="createBtn">Add new Car</button><br>
        </div>
        <div class="twoBtn">
            <button type="submit" onclick="autoSubmit()">View List ALL CAR</button>
            <a href="SalePersonDashboard.jsp"><button>Back to DashBoard</button></a>
        </div>

        <h3>Search Results:</h3>

        <%
            //format price
            DecimalFormat df = new DecimalFormat("#,###");
            List<Car> searchResults = (List<Car>) request.getAttribute("searchResults");
            if (searchResults != null && !searchResults.isEmpty()) {
        %>
        <table border="1">
            <thead>
                <tr>
                    <th>Car ID</th>
                    <th>Serial Number</th>
                    <th>Model</th>
                    <th>Color</th>
                    <th>Year</th>
                    <th>Price</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% for (Car car : searchResults) {%>
                <tr>
                    <td><%= car.getCarId()%></td>
                    <td><%= car.getSerialNumber()%></td>
                    <td><%= car.getModel()%></td>
                    <td><%= car.getColor()%></td>
                    <td><%= car.getYear()%></td>
                    <td><%= df.format(car.getPrice())%></td>
                    <td>
                        <button type="button" onclick="openUpdateModal('<%= car.getCarId()%>', '<%= car.getSerialNumber()%>',
                                        '<%= car.getModel()%>', '<%= car.getColor()%>', '<%= car.getYear()%>', '<%=car.getPrice()%>')">
                            Update
                        </button>
                        <button type="button" onclick="confirmDelete('<%= car.getCarId()%>')">
                            Delete
                        </button> 
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <%
        } else {
        %>
        <p class="message">No results found.</p>
        <% }%>



        <!-- In thông báo sau khi thực hiện CRUD -->
        <%
            if (request.getAttribute("isCRUD") != null) {
        %>
        <h4><%= request.getAttribute("isCRUD")%></h4>
        <%
            }
        %>
        <div id="createCarForm" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%);
             background: white; padding: 20px; border: 1px solid black; z-index: 1000;">
            <h3>Create New Car</h3>
            <form id="newCarForm" action="CRUDCarServlet?cRUDAction=CREATE" method="POST">
                <label>Serial Number:</label>
                <input type="text" name="carSerialNumber" required><br>

                <label>Model:</label>
                <input type="text" name="carModel" required><br>

                <label>Color:</label>
                <input type="text" name="carColour" required><br>
                <label>Price:</label>
                <input type="text" name="carPrice" required> <br>
                <label>Year:</label>
                <select name="carYear">
                    <%
                        int startYear = 2010;
                        int currentYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
                        for (int year = startYear; year <= currentYear; year++) {
                    %>
                    <option value="<%= year%>"><%= year%></option>
                    <% }%>
                </select> <br>

                <button type="submit">Submit</button>
                <button type="button" onclick="hideCreateForm()">Cancel</button>
            </form>
        </div>

        <!-- Modal cập nhật xe (ẩn mặc định) -->
        <div id="updateCarModal" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%);
             background: white; padding: 20px; border: 1px solid black; z-index: 1000;">
            <h3>Update Car Information</h3>
            <form id="updateCarForm" action="CRUDCarServlet?cRUDAction=UPDATE" method="POST">
                <input type="hidden" name="carID" id="updateCarID"> <!-- Ẩn ID xe -->

                <label>Serial Number:</label>
                <input type="text" name="carSerialNumber" id="updateSerialNumber" required><br>

                <label>Model:</label>
                <input type="text" name="carModel" id="updateModel" required><br>

                <label>Color:</label>
                <input type="text" name="carColour" id="updateColour" required><br>

                <label>Price:</label>
                <input type="text" name="carPrice" id="updatePrice" required><br>

                <label>Year:</label>
                <select name="carYear" id="updateYear">
                    <option value="0">No Update</option>
                    <%
                        startYear = 2010;
                        currentYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
                        for (int year = startYear; year <= currentYear; year++) {
                    %>
                    <option value="<%= year%>"><%= year%></option>
                    <% }%>
                </select><br>

                <button type="submit">Update</button>
                <button type="button" onclick="closeUpdateModal()">Cancel</button>
            </form>
        </div>

        <!-- Overlay để che nền -->
        <div id="overlay" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%;
             background: rgba(0,0,0,0.5); z-index: 999;" onclick="hideCreateForm(); closeUpdateModal();closeDeleteModal();">
        </div>


        <!-- Modal xác nhận xóa -->
        <div id="deleteConfirmModal" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%);
             background: white; padding: 20px; border: 1px solid black; z-index: 1000;">
            <h3>Are you sure you want to delete this car?</h3>
            <form id="deleteCarForm" action="CRUDCarServlet?cRUDAction=DELETE" method="POST">
                <input type="hidden" name="carID" id="deleteCarID"> <!-- ID xe cần xóa -->
                <button type="submit">Yes</button>
                <button type="button" onclick="closeDeleteModal()">No</button>
            </form>
        </div>

    </body>
</html>
