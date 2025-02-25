<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="DAO.CustomerDAO"%>
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
            CustomerDAO customerDAO = new CustomerDAO();
            Customer customer = customerDAO.getCustomerById(custID); // Lấy thông tin khách hàng từ CSDL
        %>

        <!-- Form sửa thông tin khách hàng -->
        <form action="UpdateCustomerServlet" method="post">
            <input type="hidden" name="id" value="<%= customer.getCustID() %>"/>

            <label for="name">Name:</label>
            <input type="text" name="name" value="<%= customer.getCustName() %>" required /><br/>

            <label for="phone">Phone:</label>
            <input type="text" name="phone" value="<%= customer.getPhone() %>" required /><br/>

            <label for="sex">Sex:</label>
            <input type="radio" name="sex" value="M" <%= customer.getSex().equals("M") ? "checked" : "" %> /> Male
            <input type="radio" name="sex" value="F" <%= customer.getSex().equals("F") ? "checked" : "" %> /> Female
            <label for="address">Address:</label>
            <input type="text" name="address" value="<%= customer.getCustAddress() %>" required /><br/> 


            <input type="submit" value="Update"/>
        </form>
    </body>
</html>
