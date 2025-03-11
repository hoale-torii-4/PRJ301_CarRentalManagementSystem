<%@page import="model.SalePerson"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sale Person Dashboard</title>
</head>
<body>
    <%
        SalePerson salePerson = (SalePerson) session.getAttribute("salePerson");
        if (salePerson == null) {
            request.setAttribute("FailedLogin", "You must Login the staff.");
            request.getRequestDispatcher("LoginCustomerPage.jsp").forward(request, response);
            return;
        }
        
        String salesID = (String) session.getAttribute("salesID");
        if (salesID == null) {
            salesID = ""; // Hoặc có thể thay bằng giá trị mặc định hợp lệ
        }
    %>
        <h1>Welcome <%=salePerson.getName()%> </h1>
    <a href="ListCustomer.jsp"><button>Manage Customer</button></a>
    <a href="PartManagementPage.jsp"><button>Manage Part</button></a>
    <a href="ReportSalePerson.jsp"><button>Report</button></a>
    <a href="ViewServiceTicket?salePersonID=<%= salesID %>"><button>Manage Service Ticket</button></a>
    <a href="ManageCarPage.jsp?salePersonID=<%= salesID %>"><button>Manage Car</button></a>
    <a href="LogoutServlet"><button>LOG OUT</button></a>

</body>
</html>
