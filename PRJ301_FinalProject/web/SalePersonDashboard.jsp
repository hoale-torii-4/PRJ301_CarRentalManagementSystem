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
        <button type="button" onclick="showCreateForm()">Create</button>

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
                    <h5><%=request.getAttribute("isCRUD")%></h5>

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
                    <td><%= car.getPrice() %></td>
                    <td><a href="#">Detail</a></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <%
        } else {
        %>
        <p>No results found.</p>
        <% }%>

</body>
</html>
