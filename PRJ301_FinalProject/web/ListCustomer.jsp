<%@page import="java.util.ArrayList"%>
<%@page import="model.Customer"%>
<%@page import="DAO.CustomerDAO"%>
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
        </style>
    </head>
    <body>


        <!-- Form tìm kiếm khách hàng -->
        <form action="ListCustomer.jsp" method="get">
            <label for="search">Enter Customer's Name:</label>
            <input type="text" name="search" id="search" placeholder="Enter name" />
            <input type="submit" value="Search" />
        </form>
        <!-- Hiển thị thông báo cập nhật thành công/thất bại -->
        <%
            String updateMessage = (String) request.getAttribute("updateMessage");
            if (updateMessage != null) {
                if (updateMessage.equals("Customer updated successfully!")) {
        %>
            <div class="success-message"><%= updateMessage %></div>
        <%
                } else {
        %>
            <div class="error-message"><%= updateMessage %></div>
        <%
                }
            }
        %>
        <!-- hien thi danh sach khach hang khi click vào -->
        <h3><a href="ListCustomer.jsp?list=true">List Customers</a></h3>
        
        <%
            // Kiểm tra nếu người dùng nhấn "List Customers"
            String listCustomers = request.getParameter("list");
            String searchQuery = request.getParameter("search");

            // Lấy danh sách khách hàng từ CustomerDAO
            CustomerDAO customerDAO = new CustomerDAO();
            ArrayList<Customer> customers = null;

            // Nếu có tìm kiếm, lọc theo tên
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                customers = customerDAO.searchCustomersByName(searchQuery);
            } else if ("true".equals(listCustomers)) {
                customers = customerDAO.getCustomers(); // Lấy tất cả khách hàng nếu không có tìm kiếm
            }

            if (customers != null && !customers.isEmpty()) {
        %>

        <!-- Bảng khách hàng -->
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Phone</th>
                <th>Sex</th>
                <th>Address</th>
                <th>Actions</th> <!-- Cột cho các hành động (Cập nhật, Xóa) -->
            </tr>
            <%
                for (Customer customer : customers) {
            %>
            <tr>
                <td><%= customer.getCustID()%></td>
                <td><%= customer.getCustName()%></td>
                <td><%= customer.getPhone()%></td>
                <td><%= customer.getSex()%></td>
                <td><%= customer.getCustAddress()%></td>
                <td>
                    <a href="UpdateCustomer.jsp?id=<%= customer.getCustID()%>">Update</a> |
                    <a href="DeleteCustomerServlet?id=<%= customer.getCustID()%>">Delete</a>
                </td>
            </tr>
            <%
                }
            %>
        </table>
        <%
            } else {
                out.println("<p>No customers found matching your search.</p>");
            }
        %>
        <h3><a href="AddCustomer.jsp">Add Customer</a></h3>
    </body>
</html>
