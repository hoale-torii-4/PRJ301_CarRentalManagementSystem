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

            fetch("SearchCarServlet?query=" + query)
                .then(response => response.json())
                .then(data => {
                    let dataList = document.getElementById("carSuggestions");
                    dataList.innerHTML = ""; // Xóa gợi ý cũ

                    data.forEach(item => {
                        let option = document.createElement("option");
                        option.value = item;
                        dataList.appendChild(option);
                    });
                })
                .catch(error => console.error("Error fetching suggestions:", error));
        }

        function autoSubmit() {
            document.getElementById("searchForm").submit();
        }
    </script>
</head>
<body>
    <h2>Search Car by Serial Number, Model, or Year</h2>

    <form id="searchForm" action="SearchCarServlet" method="POST">
        <input type="text" name="query" id="searchInput" list="carSuggestions" 
               oninput="fetchSuggestions()" onchange="autoSubmit()" >

        <datalist id="carSuggestions"></datalist>

        <button type="submit">Search</button>
    </form>

    <h3>Search Results:</h3>
    <ul>
        <% 
            List<String> searchResults = (List<String>) request.getAttribute("searchResults");
            if (searchResults != null && !searchResults.isEmpty()) {
                for (String car : searchResults) {
        %>
                    <li><%= car %></li>
        <% 
                }
            } else { 
        %>
            <li>No results found.</li>
        <% } %>
    </ul>
</body>
</html>
