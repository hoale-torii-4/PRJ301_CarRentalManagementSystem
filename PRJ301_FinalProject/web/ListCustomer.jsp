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
        </style>
    </head>
    <body>

        <!-- Form tìm kiếm khách hàng -->
        <form action="ListCustomer.jsp" method="get">
            <label for="search">Enter Customer's Name:</label>
            <input type="text" name="search" id="search" placeholder="Enter name" />
            <input type="submit" value="Search" />
        </form>

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
        <!-- add thành công -->
        <% if ("add".equals(success)) { %>
        <div class="message success">Customer add successfully!</div>
        <% } else if ("add_failed".equals(error)) { %>
        <div class="message error">❌ Customer add failed !</div>
        <% } else if ("invalid_data".equals(error)) { %>
        <div class="message error">Invalid Data!!!</div>
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
        <!-- hien thi danh sach khach hang khi click vào -->
        <button><a href="ListCustomer.jsp?list=true">List Customers</a></button>

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
                    <a href="DeleteCustomerServlet?id=<%= customer.getCustID()%>">Delete</a>|
                    <a href="CreateInvoiceServlet?custId=<%= customer.getCustID()%>">Create Invoice</a>
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
