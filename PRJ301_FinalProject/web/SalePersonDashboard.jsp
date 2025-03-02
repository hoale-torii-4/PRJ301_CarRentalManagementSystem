<%@page import="model.Car"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Car</title>
        <script>
            function fetchSuggestions() {
                let query = document.getElementById("searchInput").value;
                if (query.length < 1)
                    return; // Không gọi nếu chưa nhập gì

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
            }

            function hideCreateForm() {
                document.getElementById("createCarForm").style.display = "none";
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
                document.getElementById("deleteOverlay").style.display = "block";
            }

            function closeDeleteModal() {
                document.getElementById("deleteConfirmModal").style.display = "none";
                document.getElementById("deleteOverlay").style.display = "none";
            }


        </script>

    </head>
    <body>
        <h2>Search Car by Serial Number, Model, or Year</h2>

        <form id="searchForm" action="SearchCarServlet" method="POST">
            <input type="text" name="query" id="searchInput" list="carSuggestions" 
                   oninput="fetchSuggestions()" onchange="autoSubmit()">

            <datalist id="carSuggestions"></datalist>

            <button type="submit">Search</button>
        </form>

        <button type="submit" onclick="autoSubmit()">View List ALL CAR</button>
        <button type="button" onclick="showCreateForm()">Add new Car</button>

        <!-- Form nhập thông tin xe (Ẩn mặc định) -->
        <div id="createCarForm" style="display: none; border: 1px solid #ccc; padding: 10px; margin-top: 10px;">
            <h3>Create New Car</h3>
            <form id="newCarForm" action="CRUDCarServlet?cRUDAction=CREATE" method="POST">
                <label>Serial Number:</label>
                <input type="text" name="carSerialNumber" required><br>

                <label>Model:</label>
                <input type="text" name="carModel" required><br>

                <label>Colour:</label>
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
                
                
 <!-- In thông báo sau khi thực hiện CRUD -->
<% 
    if (request.getAttribute("isCRUD") != null) { 
%>
    <h4><%= request.getAttribute("isCRUD") %></h4>
<% 
    } 
%>

        <h3>Search Results:</h3>

        <%
            List<Car> searchResults = (List<Car>) request.getAttribute("searchResults");
            if (searchResults != null && !searchResults.isEmpty()) {
        %>
        <table border="1">
            <thead>
                <tr>
                    <th>Car ID</th>
                    <th>Serial Number</th>
                    <th>Model</th>
                    <th>Colour</th>
                    <th>Year</th>
                    <th>Price</th>
                </tr>
            </thead>
            <tbody>
                <% for (Car car : searchResults) {%>
                <tr>
                    <td><%= car.getCarId()%></td>
                    <td><%= car.getSerialNumber()%></td>
                    <td><%= car.getModel()%></td>
                    <td><%= car.getColour()%></td>
                    <td><%= car.getYear()%></td>
                    <td><%= car.getPrice()%></td>
                    <td>
                        <button type="button" onclick="openUpdateModal('<%= car.getCarId()%>', '<%= car.getSerialNumber()%>',
                                        '<%= car.getModel()%>', '<%= car.getColour()%>', '<%= car.getYear()%>', '<%= car.getPrice()%>')">
                            Update
                        </button>
                    </td>
                    <td>
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
        <p>No results found.</p>
        <% }%>
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

                <label>Colour:</label>
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
             background: rgba(0,0,0,0.5); z-index: 999;" onclick="closeUpdateModal()"></div>
             
             
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

        <!-- Overlay để che nền -->
        <div id="deleteOverlay" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%;
             background: rgba(0,0,0,0.5); z-index: 999;" onclick="closeDeleteModal()"></div>



    </body>
</html>
