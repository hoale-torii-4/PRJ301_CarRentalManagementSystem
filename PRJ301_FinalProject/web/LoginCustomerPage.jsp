<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Kiểm tra cookie trước khi in bất kỳ HTML nào
    Cookie[] cookies = request.getCookies();
    String token = null;
    if (cookies != null) {
        for (Cookie c : cookies) {
            if ("token".equals(c.getName())) {
                token = c.getValue();
                break;
            }
        }
    }
    if (token != null) {
        response.sendRedirect("LoginCustomerServlet");
        return; // Dừng xử lý trang hiện tại
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
    </head>
    <body>
        
        <h1>Customer Login</h1>
        <form action="LoginStaffPage.jsp">
            <p style="border: 1px solid black">CUSTOMER   <input type="submit" name="action" value="STAFF"></p>
        </form>
        <!-- Hiển thị form đăng nhập khi không có cookie -->
        <form action="LoginCustomerServlet" method="POST">
            <p>Full name: <input type="text" name="custName" placeholder="Enter your Name" required> *</p>
            <p>Phone: <input type="text" name="custPhone" placeholder="Enter your Phone number" required> *</p>
            <p><input type="checkbox" name="custSave" value="Save"> Save Login</p>
            <input type="submit" value="LOGIN">
        </form>
        <%-- Hiển thị thông báo đăng nhập thất bại nếu có --%>
        <%
            if (request.getAttribute("FailedLogin") != null) {
                out.print("<p style='color:red;'>" + request.getAttribute("FailedLogin") + "</p>");
            }
        %>
    </body>
</html>
