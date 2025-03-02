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
        if (query.length < 1) return; // Không gọi nếu chưa nhập gì

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
                </tr>
            </thead>
            <tbody>
                <% for (Car car : searchResults) { %>
                <tr>
                    <td><%= car.getCarId()%></td>
                    <td><%= car.getSerialNumber() %></td>
                    <td><%= car.getModel() %></td>
                    <td><%= car.getColour()%></td>
                    <td><%= car.getYear() %></td>

                </tr>
                <% } %>
            </tbody>
        </table>
    <% 
        } else { 
    %>
        <p>No results found.</p>
    <% } %>
    </ul>
</body>
</html>
