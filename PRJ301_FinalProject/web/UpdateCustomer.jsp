<%@page import="DAO.CRUDCustomerDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="model.Customer"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Customer</title>
    </head>
    <body>
        <h1>Update Customer</h1>

        <%
            // Lấy id khách hàng cần cập nhật từ URL
            int custID = Integer.parseInt(request.getParameter("id"));
            CRUDCustomerDAO customerDAO = new CRUDCustomerDAO();
            Customer customer = customerDAO.getCustomerById(custID); // Lấy thông tin khách hàng từ CSDL
        %>

        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Phone</th>
                <th>Sex</th>
                <th>Address</th>
            </tr>
            <tr>
                <td><%= customer.getCustID()%></td>
                <td><%= customer.getCustName()%></td>
                <td><%= customer.getPhone()%></td>
                <td>
                    <%= (customer.getSex() != null && customer.getSex().trim().equalsIgnoreCase("M")) ? "Male" : "Female"%>
                </td>
                <td><%= customer.getCustAddress()%></td>
            </tr>
        </table>


        <!-- Form sửa thông tin khách hàng -->
        <form action="UpdateCustomerServlet" method="post">
            <input type="hidden" name="id" value="<%= customer.getCustID()%>"/>

            <label for="name">Name:</label>
            <input type="text" name="name"   /><br/>

            <label for="phone">Phone:</label>
            <input type="text" name="phone"  /><br/>

            <label for="sex">Sex:</label>
            <input type="radio" name="sex" value="M" <%= customer.getSex().equals("M") ? "checked" : ""%> /> Male
            <input type="radio" name="sex" value="F" <%= customer.getSex().equals("F") ? "checked" : ""%> /> Female<br/>
            <label for="address">Address:</label>
            <input type="text" name="address"  /><br/> 


            <input type="submit" value="Update"/>
        </form>
    </body>
</html>
