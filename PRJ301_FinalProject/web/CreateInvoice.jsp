
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%-- 
    Document   : SearchCar
    Created on : Mar 2, 2025, 1:51:20 PM
    Author     : hoang
--%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h2>Create Invoice</h2>

        <form action="CreateInvoiceServlet" >
            <label for="saleId">SalesID:</label>
            <input type="text" name="saleId" id="saleId" value="<%= session.getAttribute("salesID")%>" readonly><br>

            <label for="custId">CustID:</label>
            <input type="text" name="custId" id="custId" value="<%= session.getAttribute("custId")%>" readonly><br>

            <label for="date">Date:</label>
            <input type="date" name="date" id="date" required><br>
            <label for="price">Price:</label>
            <input type="text" name="price" id="price" required=""/><br>
            <!-- Trường để chứa ID của xe đã chọn -->
            <input type="hidden" name="carId" id="carId">

            <!-- Tìm kiếm xe -->
            <input type="text" name="query" id="searchInput" list="carSuggestions1" oninput="fetchSuggestions()" onchange="autoSubmit()">
            <datalist id="carSuggestions1"></datalist><br>

            <input type="submit" value="Tạo Hóa Đơn">
        </form>
        <%
            String success = request.getParameter("success");
            String error = request.getParameter("error");
            if ("customer_added".equals(success)) {
        %>
        <div class="message success">
            Customer added successfully! You can now create an invoice.
        </div>
        <%
            }
            if ("add_failed".equals(error)) {
        %>
        <div class="message error">
            Failed to add customer. Please try again.
        </div>
        <%
        } else if ("invalid_data".equals(error)) {
        %>
        <div class="message error">
            Invalid data provided. Please check your input.
        </div>
        <%
            }
        %>

        <%
            String custID = request.getParameter("custID");
        %>
        <script>
            function fetchSuggestions() {
                let query = document.getElementById("searchInput").value;
                if (query.length < 1)
                    return;

                fetch("SearchCarInvoiceServlet?query=" + encodeURIComponent(query))
                        .then(response => response.json())
                        .then(data => {
                            let dataList = document.getElementById("carSuggestions1");
                            dataList.innerHTML = "";
                            data.forEach(item => {
                                let option = document.createElement("option");
                                option.value = item;
                                dataList.appendChild(option);
                            });
                        })
                        .catch(error => console.error("Error fetching suggestions:", error));
            }

            function autoSubmit() {
                let inputField = document.getElementById("searchInput");
                let selectedValue = inputField.value;

                let carID = selectedValue.split(" - ")[0].trim();
                inputField.value = carID;
                document.getElementById("carId").value = carID;


                document.getElementById("searchForm").submit();
            }
        </script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                let today = new Date();
                let yyyy = today.getFullYear();
                let mm = String(today.getMonth() + 1).padStart(2, '0');
                let dd = String(today.getDate()).padStart(2, '0');

                let formattedDate = yyyy + "-" + mm + "-" + dd;
                document.getElementById("date").value = formattedDate;
            });
        </script>



    </body>
</html>
