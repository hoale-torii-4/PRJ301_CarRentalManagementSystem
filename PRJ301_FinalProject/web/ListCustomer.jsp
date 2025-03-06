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
            table {
                width: 100%;
                border-collapse: collapse;
            }
            th, td {
                border: 1px solid black;
                padding: 8px;
                text-align: left;
            }
            th {
                background-color: #f2f2f2;
            }
            .modal {
                display: none;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background: white;
                padding: 20px;
                border: 1px solid black;
                z-index: 1000;
            }
            .overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0,0,0,0.5);
                z-index: 999;
            }
        </style>
    </head>
    <body>

        <!-- Form tìm kiếm khách hàng -->
        <form action="ListCustomer.jsp" method="get">
            <label for="search">Enter Customer's Name:</label>
            <input type="text" name="search" id="search" placeholder="Enter name" />
            <input type="submit" value="Search" />
        </form>

        <!-- Button mở pop-up thêm khách hàng -->
        <button type="button" onclick="openAddCustomerModal()">Add Customer</button>

        <!-- Button Xem Danh Sách Khách Hàng -->
        <button><a href="ListCustomer.jsp?list=true" style="text-decoration: none; color: black;">List Customers</a></button>

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
        <button onclick="closeAllModals()">Cancel</button>
        <% } else { %>
        <p>No customers found matching your search.</p>
        <% } %>
        <%
            String success = request.getParameter("success");
            String error = request.getParameter("error");
        %>
        <!-- thong báo delete -->
        <% if ("1".equals(success)) { %>
        <div class="message success"> Customer deleted successfully!</div>
        <% } else if ("1".equals(error)) { %>
        <div class="message error"> Customer deleted failed !</div>
        <% } else if ("invalid_id".equals(error)) { %>
        <div class="message error">️ ID invalid!!!</div>
        <% } %>
        <!-- comment -->
        <% if ("update".equals(success)) { %>
        <div class="message success">Customer updated successfully!</div>
        <% } else if ("update_failed".equals(error)) { %>
        <div class="message error">Customer updated fail!!</div>
        <% } else if ("invalid_id".equals(error)) { %>
        <div class="message error">⚠️ ID Invalid </div>
        <% } %>
        <%
            if ("create_invoice".equals(success)) {
        %>
        <div class="message success">Created Invoice successfully!</div>
        <%
            }
            if ("create_invoice_failed".equals(error)) {
        %>
        <div class="message error">Created Invoice fail!!</div>
        <%
            }%> 
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
                <label>Sex:</label>
                <input type="radio" name="sex" value="M" required /> Male
                <input type="radio" name="sex" value="F" /> Female<br/>
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
                <label>Sex:</label>
                <input type="radio" name="sex" id="updateMale" value="M" /> Male
                <input type="radio" name="sex" id="updateFemale" value="F" /> Female<br/>
                <label>Address:</label>
                <input type="text" name="address" id="updateCustomerAddress" required/><br/>
                <button type="submit">Update</button>
            </form>
                <button type="button" onclick="closeUpdateCustomerModal()">Cancel</button>
        </div>
        <div id="createInvoiceModal" class="modal">
            <h3>Create Invoice</h3>
            <form action="CreateInvoiceServlet" method="post">
                <input type="hidden" name="custId" id="invoiceCustId"/>

                <label for="saleId">SalesID:</label>
                <input type="text" name="saleId" id="saleId" value="<%= session.getAttribute("salesID")%>" readonly><br>

                <label for="date">Date:</label>
                <input type="date" name="date" id="date" required><br>

                <label for="price">Price:</label>
                <input type="text" name="price" id="price" required/><br>

                <input type="hidden" name="carId" id="carId">

                <!-- Tìm kiếm xe -->
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
            function openCreateInvoiceModal(custId) {
                document.getElementById("invoiceCustId").value = custId;
                document.getElementById("createInvoiceModal").style.display = "block";
                document.getElementById("overlay").style.display = "block";
            }

            function closeCreateInvoiceModal() {
                document.getElementById("createInvoiceModal").style.display = "none";
                document.getElementById("overlay").style.display = "none";
            }

            
            function deleteCustomer(customerId) {
                if (confirm("Are you sure you want to delete this customer?")) {
                    window.location.href = "CRUDCustomerServlet?cRUDAction=DELETE&id=" + customerId;
                }
            }

            function createInvoice(customerId) {
                window.location.href = "CreateInvoiceServlet?custId=" + customerId;
            }
            function closeAllModals() {
                document.getElementById("addCustomerModal").style.display = "none";
                document.getElementById("updateCustomerModal").style.display = "none";
                document.getElementById("createInvoiceModal").style.display = "none";
                document.getElementById("overlay").style.display = "none";
                document.getElementById("customerTableResult").style.display = "none";
            }
        </script>
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

    </body>
</html>
