<%@page import="DAO.CRUDCustomerDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List of Customers</title>

        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f7fc; /* Nền màu trắng sáng */
                color: #333; /* Văn bản màu tối */
                margin: 0;
                padding: 20px;
                width: auto;
            }

            h3 {
                color:#003366; /* Tiêu đề màu xanh da trời */
            }

            /* Nút chính */
            button {
                background-color: #003366; /* Nút có nền màu xanh da trời */
                color: white;
                padding: 10px 20px;
                margin: 10px;
                border: none;
                cursor: pointer;
                border-radius: 5px;
                transition: background-color 0.3s;
            }

            button:hover {
                background-color: #1565C0; /* Màu xanh đậm khi hover */
            }

            /* Style cho Bảng */
            table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px 0;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            th, td {
                padding: 12px;
                text-align: left;
                border: 1px solid #ddd;
            }

            th {
                background-color: #003366; /* Nền màu xanh da trời cho th */
                color: white;
            }

            tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            tr:hover {
                background-color: #e3f2fd; /* Màu xanh nhạt khi hover */
            }

            /* Style cho Form tìm kiếm */
            form {
                margin-bottom: 20px;
                padding: 10px;
                background-color: #fff; /* Nền sáng */
                border-radius: 5px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);

            }

            input[type="text"], input[type="tel"], input[type="date"] {
                padding: 8px;
                margin: 8px 0;
                width: 100%;
                box-sizing: border-box;
                background-color: #f4f7fc; /* Nền ô nhập liệu sáng */
                color: #333;
                border: 1px solid #ddd;
            }

            input[type="submit"] {
                background-color: #003366; /* Nút submit màu xanh da trời */
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
            }

            input[type="submit"]:hover {
                background-color: #1565C0;
            }

            /* Modal */
            .modal {
                display: none;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background: #fff; /* Nền modal trắng */
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                z-index: 1000;
                width: 50%;
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

            /* Success/Error Messages */
            .message {
                padding: 10px;
                margin: 10px 0;
                border-radius: 5px;
            }

            .message.success {
                background-color: #003366; /* Màu xanh da trời cho thông báo thành công */
                color: white;
            }

            .message.error {
                background-color: #f44336; /* Màu đỏ cho thông báo lỗi */
                color: white;
            }

            /* Nút "Back to Dashboard" */
            a button {
                background-color: #003366;
                color: white;
                padding: 10px 20px;
                border: none;
                cursor: pointer;
                border-radius: 5px;
                text-decoration: none;
            }

            a button:hover {
                background-color: #1565C0;
            }

            /* Cấu hình cho radio button */
            .radio {
                display: flex;
                justify-content: space-around;
                align-items: center;
                margin-top: 10px;
            }

            /* Định dạng radio button */
            .radio input[type="radio"] {
                accent-color: #003366; /* Màu xanh da trời cho radio button */
                width: 20px;
                height: 20px;
                margin-right: 8px;
                cursor: pointer;
            }

            /* Style cho các nhãn (label) tương ứng với radio button */
            .radio label {
                color: #333;
                font-size: 16px;
                margin-left: 10px;
                cursor: pointer;
            }

            /* Thêm hiệu ứng hover cho các radio button */
            .radio input[type="radio"]:hover {
                transform: scale(1.1);
            }

            /* Khi radio button được chọn, làm nổi bật label */
            .radio input[type="radio"]:checked + label {
                color: #003366;
                font-weight: bold;
            }

            /* Thêm khoảng cách giữa các lựa chọn radio button */
            .radio input[type="radio"]:not(:last-child) {
                margin-right: 20px;
            }

            form label {
                width: 20%;
                text-align: center;
            }

            input#search {
                width: 65%;
            }

            input[type="submit"] {
                width: 10%;
            }
    
            #searchform {
                width: 90%;
                margin-left: 5%;
            }

        </style>
    </head>
    <body>

        <!-- Form tìm kiếm khách hàng -->
        <form  action="ListCustomer.jsp" method="get" id="searchform">
                <label for="search">Enter Customer's Name:</label>
                <input type="text" name="search" id="search" placeholder="Enter name" />
                <input type="submit" value="Search" />
            </form>
     

        <!-- Button mở pop-up thêm khách hàng -->
        <button type="button" onclick="openAddCustomerModal()">Add Customer</button>

        <!-- Button Xem Danh Sách Khách Hàng -->
        <button><a href="ListCustomer.jsp?list=true" style="text-decoration: none; color:white;">List Customers</a></button>
        <button onclick="closeAllModals()">Cancel</button>
        <%-- Xử lý lấy danh sách khách hàng --%>
        <%
            String listCustomers = request.getParameter("list");
            String searchQuery = request.getParameter("search");

            CRUDCustomerDAO customerDAO = new CRUDCustomerDAO();
            ArrayList<Customer> customers = null;
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                customers = customerDAO.searchCustomersByName(searchQuery);
            } else if ("true".equals(listCustomers)) {
                customers = customerDAO.getCustomers();
            }

            if (customers != null && !customers.isEmpty()) {
        %>

        <!-- Bảng khách hàng -->
        <table id="customerTableResult">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Phone</th>
                <th>Sex</th>
                <th>Address</th>
                <th>Actions</th>
            </tr>
            <% for (Customer customer : customers) {%>
            <tr>
                <td><%= customer.getCustID()%></td>
                <td><%= customer.getCustName()%></td>
                <td><%= customer.getPhone()%></td>
                <td><%= customer.getSex()%></td>
                <td><%= customer.getCustAddress()%></td>
                <td>
                    <button type="button" onclick="openUpdateCustomerModal('<%= customer.getCustID()%>',
                                    '<%= customer.getCustName()%>', '<%= customer.getPhone()%>',
                                    '<%= customer.getSex()%>', '<%= customer.getCustAddress()%>')">
                        Update
                    </button>
                    <button type="button" onclick="deleteCustomer('<%= customer.getCustID()%>')">Delete</button>
                    <button type="button" onclick="openCreateInvoiceModal('<%= customer.getCustID()%>')">
                        Create Invoice
                    </button>
                </td>
            </tr>
            <% } %>
        </table>
        
        <% } else { %>
        <p>No customers found matching your search.</p>
        <% } %>
        <%
            String success = request.getParameter("success");
            String error = request.getParameter("error");
            String custId = request.getParameter("custId");
        %>

        <!-- Success or error messages for customer actions -->

        <!-- Customer deleted -->
        <% if ("1".equals(success)) { %>
        <div class="message success">Customer deleted successfully!</div>
        <% } else if ("1".equals(error)) { %>
        <div class="message error">Customer deletion failed!</div>
        <% } else if ("invalid_id".equals(error)) { %>
        <div class="message error">ID is invalid!</div>
        <% } %>

        <!-- Customer updated -->
        <% if ("update".equals(success)) { %>
        <div class="message success">Customer updated successfully!</div>
        <% } else if ("update_failed".equals(error)) { %>
        <div class="message error">Customer update failed!</div>
        <% } else if ("invalid_id".equals(error)) { %>
        <div class="message error">ID is invalid!</div>
        <% } %>

        <!-- Customer added -->
        <% if ("customer_added".equals(success)) { %>
        <div class="message success">Customer added successfully! </div>
        <% } %>

        <% if ("add_failed".equals(error)) { %>
        <div class="message error">Failed to add customer. Please try again.</div>
        <% } %>

        <!-- Invoice creation -->
        <% if ("create_invoice".equals(success)) {%>
        <div class="message success">Created Invoice successfully !</div>
        <% } %>

        <!-- Show error message for creating an invoice -->
        <% if ("create_invoice_failed".equals(error)) { %>
        <div class="message error">Failed to create invoice! Please try again.</div>
        <% } %>

        <!-- Additional action success messages -->
        <% if ("delete_failed".equals(error)) { %>
        <div class="message error">Failed to delete the customer. Please try again.</div>
        <% } %>

        <% if ("update_failed".equals(error)) { %>
        <div class="message error">Failed to update customer details. Please try again.</div>
        <% }%>

        <!-- Overlay để che nền -->
        <div id="overlay" class="overlay" onclick="closeAllModals(); hideCreateForm();"></div>

        <!-- Pop-up Thêm Khách Hàng -->
        <div id="addCustomerModal" class="modal">
            <h3>Add Customer</h3>
            <form action="CRUDCustomerServlet" method="post">
                <input type="hidden" name="cRUDAction" value="CREATE"/>
                <label>Name:</label>
                <input type="text" name="name" required /><br/>
                <label>Phone:</label>
                <input type="tel" name="phone" required pattern="[0-9+ -]{10,15}" title="Enter a valid phone number"/><br/>
                <div class="radio">
                    <input type="radio" name="sex" id="updateMale" value="M" /> Male
                    <input type="radio" name="sex" id="updateFemale" value="F" /> Female<br/>
                </div>
                <label>Address:</label>
                <input type="text" name="address" required/><br/>
                <button type="submit">Add</button>
                <button type="button" onclick="closeAddCustomerModal()">Cancel</button>
            </form>
        </div>

        <!-- Pop-up Cập Nhật Khách Hàng -->
        <div id="updateCustomerModal" class="modal">
            <h3>Update Customer</h3>
            <form action="CRUDCustomerServlet" method="post">
                <input type="hidden" name="cRUDAction" value="UPDATE"/>
                <input type="hidden" name="id" id="updateCustomerId"/>
                <label>Name:</label>
                <input type="text" name="name" id="updateCustomerName" required /><br/>
                <label>Phone:</label>
                <input type="tel" name="phone" id="updateCustomerPhone" required/><br/>
                <div class="radio">
                    <input type="radio" name="sex" id="updateMale" value="M" /> Male
                    <input type="radio" name="sex" id="updateFemale" value="F" /> Female<br/>
                </div>
                <label>Address:</label>
                <input type="text" name="address" id="updateCustomerAddress" required/><br/>
                <button type="submit">Update</button>
            </form>
            <button type="button" onclick="closeUpdateCustomerModal()">Cancel</button>
        </div>
        <div id="createInvoiceModal" class="modal">
            <h3>Create Invoice</h3>
            <form action="CreateInvoiceServlet" method="post">
                <!-- Hidden customer ID -->
                <input type="hidden" name="custId" id="invoiceCustId"/>

                <label for="saleId">SalesID:</label>
                <!-- Fix single quotes to double quotes -->
                <input type="text" name="saleId" id="saleId" value="<%= session.getAttribute("salesID")%>" readonly><br>

                <label for="date">Date:</label>
                <input type="date" name="date" id="date" required><br>

                <label for="price">Price:</label>
                <input type="text" name="price" id="price" required/><br>

                <input type="hidden" name="carId" id="carId">

                <!-- Search Car -->
                <label for="searchInput">Search Car:</label>
                <input type="text" name="query" id="searchInput" list="carSuggestions1" oninput="fetchSuggestions()" onchange="autoSubmit()">
                <datalist id="carSuggestions1"></datalist><br>

                <button type="submit">Create Invoice</button>
            </form>
            <button type="button" onclick="closeCreateInvoiceModal()">Cancel</button>
        </div>

        <!-- JavaScript -->
        <script>
            function openAddCustomerModal() {
                document.getElementById("addCustomerModal").style.display = "block";
                document.getElementById("overlay").style.display = "block";
            }

            function closeAddCustomerModal() {
                document.getElementById("addCustomerModal").style.display = "none";
                document.getElementById("overlay").style.display = "none";
            }

            function openUpdateCustomerModal(id, name, phone, sex, address) {
                document.getElementById("updateCustomerId").value = id;
                document.getElementById("updateCustomerName").value = name;
                document.getElementById("updateCustomerPhone").value = phone;
                document.getElementById("updateCustomerAddress").value = address;
                document.getElementById(sex === "M" ? "updateMale" : "updateFemale").checked = true;
                document.getElementById("updateCustomerModal").style.display = "block";
                document.getElementById("overlay").style.display = "block";
            }

            function closeUpdateCustomerModal() {
                document.getElementById("updateCustomerModal").style.display = "none";
                document.getElementById("overlay").style.display = "none";
            }

            function closeAllModals() {
                closeAddCustomerModal();
                closeUpdateCustomerModal();
            }
        </script>
        <script>
            function openCreateInvoiceModal(custID) {
                document.getElementById("invoiceCustId").value = custID;
                document.getElementById("createInvoiceModal").style.display = "block";
                document.getElementById("overlay").style.display = "block";
            }

            // Close the Create Invoice Modal
            function closeCreateInvoiceModal() {
                document.getElementById("createInvoiceModal").style.display = "none";
                document.getElementById("overlay").style.display = "none";
            }


            function deleteCustomer(customerId) {
                if (confirm("Are you sure you want to delete this customer?")) {
                    window.location.href = "CRUDCustomerServlet?cRUDAction=DELETE&id=" + customerId;
                }
            }

            function closeAllModals() {
                document.getElementById("addCustomerModal").style.display = "none";
                document.getElementById("updateCustomerModal").style.display = "none";
                document.getElementById("createInvoiceModal").style.display = "none";
                document.getElementById("overlay").style.display = "none";
                document.getElementById("customerTableResult").style.display = "none";
            }
        </script>



        <!-- Overlay and Modals -->
        <div id="overlay" class="overlay" onclick="closeAllModals();"></div>
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

                if (selectedValue.includes(" - ")) {
                    let carID = selectedValue.split(" - ")[0].trim();
                    document.getElementById("carId").value = carID;
                    inputField.value = carID;
                }
            }

            document.addEventListener("DOMContentLoaded", function () {
                let today = new Date();
                let yyyy = today.getFullYear();
                let mm = String(today.getMonth() + 1).padStart(2, '0');
                let dd = String(today.getDate()).padStart(2, '0');

                let formattedDate = yyyy + "-" + mm + "-" + dd;
                document.getElementById("date").value = formattedDate;
            });
        </script>
        <a href="SalePersonDashboard.jsp"><button>Back to Dashboard</button></a>
    </body>
</html>
