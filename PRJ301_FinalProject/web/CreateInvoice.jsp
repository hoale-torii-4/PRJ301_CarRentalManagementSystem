<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.ArrayList, model.Car, DAO.CarDAO" %>

<%
    String custID = request.getParameter("custID");
    String salesID = (String) session.getAttribute("salesID");

    CarDAO carDAO = new CarDAO();
    ArrayList<Car> carList = carDAO.getAllCars();

    // Kiểm tra danh sách xe có dữ liệu không
    if (carList == null || carList.isEmpty()) {
        out.println("<p style='color:red;'>⚠ Không có xe nào trong hệ thống.</p>");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Create Invoice</title>
    <script>
        function setCurrentDate() {
            let today = new Date().toISOString().split('T')[0]; // Lấy ngày hệ thống
            document.getElementById("invoiceDate").value = today;
        }
    </script>
</head>
<body onload="setCurrentDate()"> <!-- Gọi hàm khi trang tải -->
    <h2>Create Invoice</h2>
    <form action="InvoiceServlet" method="post">
        <input type="hidden" name="salesID" value="<%= salesID %>">
        <input type="hidden" name="custID" value="<%= custID %>">

        <label>Choose Car:</label>
        <select name="carID" required>
            <% if (!carList.isEmpty()) { %>
                <% for (Car car : carList) { %>
                    <option value="<%= car.getCarId() %>">
                        <%= car.getModel() %> - <%= car.getColor() %> - <%= car.getYear() %>
                    </option>
                <% } %>
            <% } else { %>
                <option disabled>Không có xe khả dụng</option>
            <% } %>
        </select>
        <br><br>
        
        <label>Invoice Date:</label>
        <input type="date" id="invoiceDate" name="invoiceDate" required readonly> <!-- Tự động lấy ngày -->
        <br><br>

        <input type="submit" value="Create Invoice">
    </form>
</body>
</html>
