<%-- 
    Document   : CustomerDashboardPage
    Created on : Feb 24, 2025, 12:59:34 PM
    Author     : HOA LE
--%>

<%@page import="model.Customer"%>
<%@page import="model.Car"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Dashboard</title>
        <script>
            function toggleProfileForm() {
            <%Customer cust = (Customer) session.getAttribute("user");%>
                var form = document.getElementById("profileForm");
                if (form.style.display === "none" || form.style.display === "") {
            <% if (cust != null) {%>
                    document.getElementById("custName").value = "<%=cust.getCustName()%>";
                    document.getElementById("custPhone").value = "<%=cust.getPhone()%>";
                    document.getElementById("custSex").value = "<%=cust.getSex()%>";
                    document.getElementById("custAddress").value = "<%=cust.getCustAddress()%>";
            <%}%>
                    form.style.display = "block";
                    document.getElementById("overlay").style.display = "block";
                } else {
                    form.style.display = "none";
                    document.getElementById("overlay").style.display = "none";
                }
            }

        </script>
    </head>
    <body>

        <%
            Customer kq = (Customer) session.getAttribute("user");
            String token = (String) session.getAttribute("user2");

            if (kq == null && token == null) {
                request.setAttribute("FailedLogin", "You must Login");
                request.getRequestDispatcher("LoginCustomerPage.jsp").forward(request, response);
            } else {
        %>

        <h2>Welcome <%= (kq == null) ? token : kq.getCustName()%></h2>

        <!-- Nút Change Profile -->
        <button onclick="toggleProfileForm()">Change Profile</button>

        <!-- Form Update Profile (Mặc định ẩn) -->
        <div id="profileForm"  style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%);
             background: white; padding: 20px; border: 1px solid black; z-index: 1000;">
            <h3>Update Profile</h3>
            <form action="ChangeProfileCustomerServlet" method="POST" accept-charset="UTF-8">
                <input type="hidden" name="cusID" value="<%= (kq != null) ? kq.getCustID() : ""%>">
                <p>New Name: <input type="text" id="custName" name="newName"></p>
                <p>New Phone: <input type="number" id="custPhone" name="newPhone"></p>
                <p>New Sex: 
                    <select id="custSex" name="newSex">
                        <option value="M">Male</option>
                        <option value="F">Female</option>
                    </select>
                </p>
                <p>New Address: <input type="text" id="custAddress" name="newAddress"></p>
                <input type="submit" value="Change">
                <button type="button" onclick="toggleProfileForm()">Cancel</button>
            </form>
        </div>


        <!-- Logout Form -->
        <form action="LogoutServlet" method="POST">
            <input type="submit" value="LOGOUT">
        </form>

        <%
            String result = (String) request.getAttribute("RESULT");
            if (result != null) {
                if ("done".equals(result)) {
        %> <script>
                    alert("Change Customer Information Successful!!!");
        </script>
        <%
                    } else { %>
        <script>
            alert("Change Customer Information Successful!!!");
        </script> <%
}
}
        %>
        <h1>DASHBOARD</h1> 

        <a href="ViewServiceTicket?id=<%=kq.getCustID()%>"><button>View My Service Ticket</button></a>
        <a href="CustomerInvoiceServlet?id=<%=kq.getCustID()%>"><button>View Invoice</button></a>  

        <%
            }
        %>
        <div id="overlay" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%;
             background: rgba(0,0,0,0.5); z-index: 999;" onclick="toggleProfileForm()">
        </div>
    </body>
</html>
