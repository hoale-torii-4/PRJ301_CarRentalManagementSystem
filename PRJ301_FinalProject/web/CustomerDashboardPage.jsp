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

    </head>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: url("images/xe2.jpg") no-repeat center center fixed;
            background-size: cover;
            text-align: center;
            color: white;
        }

        /* Navbar */
        .navbar {
            background: #003366;
            padding: 10px 20px;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        /* Chào mừng người dùng */
        .navbar .welcome-text {
            font-size: 18px;
            font-weight: bold;
            color: white;
        }

        .navbar .menu {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-right: 3%;
        }

        /* Các nút trong menu */
        .navbar a,
        .navbar button {
            color: white;
            text-decoration: none;
            padding: 10px 15px;
            display: flex;
            align-items: center;
            border: none;
            background: none;
            cursor: pointer;
            font-weight: bold;
            transition: background 0.3s ease-in-out, transform 0.2s ease-in-out;
        }
        .navbar button {
            font-size: 16px;
        }

        /* Hover cho các nút */
        .navbar a:hover,
        .navbar button:hover {
            background: rgba(255, 255, 255, 0.2);
            border-radius: 5px;
            transform: scale(1.05);            
            color: #FFD700;
        }

        /* Logout button */
        .logout-btn {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .logout-btn img {
            width: 24px;
            height: 24px;
            transition: transform 0.2s ease-in-out;
        }

        .logout-btn:hover img {
            transform: scale(1.2);
        }


        /* Nội dung chính */
        .content {
            padding-top: 80px; /* Để tránh header che nội dung */
        }


        /* Overlay nền mờ */
        #overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1000;
        }

        /* Footer */
        footer {
            background: rgba(0, 0, 0, 0.8);
            color: white;
            text-align: center;
            padding: 10px;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
        /* Form cập nhật */
        #profileForm {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 25px;
            width: 350px;
            border-radius: 10px;
            border: 2px solid #003366;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
            z-index: 1000;
            text-align: left;
        }

        /* Tiêu đề */
        #profileForm h3 {
            color: #003366;
            text-align: center;
            margin-bottom: 20px;
        }

        /* Nhãn và input */
        #profileForm p {
            margin: 10px 0;
            font-weight: bold;
            color: #003366;
        }

        #profileForm input,
        #profileForm select {
            width: 95%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #003366;
            border-radius: 5px;
            font-size: 14px;
        }
        select#custSex {
            width: 100%;
        }
        /* Các nút */
        #profileForm input[type="submit"],
        #profileForm button {
            width: 49%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            margin-top: 10px;
        }

        /* Nút Đổi thông tin */
        #profileForm input[type="submit"] {
            background: #003366;
            color: white;
            transition: 0.3s;
        }

        #profileForm input[type="submit"]:hover {
            background: #002244;
        }

        /* Nút Hủy */
        #profileForm button {
            background: #ccc;
            color: black;
            transition: 0.3s;
        }

        #profileForm button:hover {
            background: #999;
        }
        /* Hero Section */
        .hero {
            
            background-size: cover;
            background-position: center;
            color: white;
            padding: 100px 0;
            text-align: center;
            flex-grow: 1;  /* Ensures this section grows to fill remaining space */
        }

        .hero h1 {
            font-size: 3rem;
            font-weight: bold;
            transition: transform 0.3s ease, color 0.3s ease;
        }

        .hero h1:hover {
            transform: translateY(-10px);
            color: #FFD700;
        }

        .hero p {
            font-size: 1.5rem;
            transition: transform 0.3s ease, color 0.3s ease;
        }

        .hero p:hover {
            transform: translateY(-5px);
            color: #FFD700;
        }

        /* Responsive */
        @media screen and (max-width: 768px) {
            .navbar {
                flex-direction: column;
                text-align: center;
                padding: 15px 0;
            }

            .navbar .menu {
                flex-direction: column;
                gap: 10px;
                margin-top: 10px;
            }
        }


    </style>
    <body>

        <%
            Customer kq = null;
            if (session.getAttribute("customer") != null) {
                kq = (Customer) session.getAttribute("customer");
            }

            if (kq == null) {
                request.setAttribute("FailedLogin", "You must Login");
                request.getRequestDispatcher("LoginCustomerPage.jsp").forward(request, response);
            } else {
        %>



        <!-- Navbar  -->
        <div class="navbar">
            <div class="welcome-text">Welcome <%= kq.getCustName()%></div>
            <div class="menu">
                <a href="ViewServiceTicket?&action=CUSTOMER">View My Service Ticket</a>
                <a href="CustomerInvoiceServlet?id=<%=kq.getCustID()%>">View Invoice</a>
                <button onclick="toggleProfileForm('<%=kq.getCustName()%>', '<%=kq.getPhone()%>', '<%=kq.getSex()%>', '<%=kq.getCustAddress()%>')">
                    Change Profile
                </button>
                <a href="LogoutServlet" class="logout-btn">
                    <span>Log Out</span><img src="images/logout.png" alt="Logout" width="24" height="24">
                </a>
            </div>
        </div>

        <!-- Form Update Profile (Mặc định ẩn) -->
        <div id="profileForm"  style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%);
             background: white; padding: 20px; border: 1px solid black; z-index: 1000;">
            <h3>Update Profile</h3>
            <form action="ChangeProfileCustomerServlet" method="POST" accept-charset="UTF-8">
                <input type="hidden" name="cusID" value="<%= (kq != null) ? kq.getCustID() : ""%>">
                <p>New Name: <input type="text" id="custName" name="newName" required=""></p>
                <p>New Phone: <input type="number" id="custPhone" name="newPhone" required=""></p>
                <p>New Sex: 
                    <select id="custSex" name="newSex" required="">
                        <option value="M">Male</option>
                        <option value="F">Female</option>
                    </select>
                </p>
                <p>New Address: <input type="text" id="custAddress" name="newAddress" required=""></p>
                <input type="submit" value="Change">
                <button type="button" onclick="toggleProfileForm()">Cancel</button>
            </form>
        </div>


        <!-- Logout Form -->

        <%
            }
        %>
        <div class="hero">
        <h1>Welcome to King of cars Garage!!!</h1>
        <p>Your journey towards excellence begins here</p>
    </div>
        <div id="overlay" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%;
             background: rgba(0,0,0,0.5); z-index: 999;" onclick="toggleProfileForm()">
        </div>
        
        <!-- Footer -->
        <footer>
            <p>&copy; 2025 King of cars Garage. All rights reserved.</p>
        </footer>
    </body>
    <script>
        function toggleProfileForm(custName, phone, sex, address) {
            var form = document.getElementById("profileForm");
            var overlay = document.getElementById("overlay");

            if (form.style.display === "none" || form.style.display === "") {
                // Gán giá trị vào input
                document.getElementById("custName").value = custName || "";
                document.getElementById("custPhone").value = phone || "";
                document.getElementById("custAddress").value = address || "";

                // Gán giá trị mặc định cho select giới tính
                var sexDropdown = document.getElementById("custSex");
                if (sexDropdown) {
                    sexDropdown.value = sex || "M"; // Nếu sex không có giá trị, chọn mặc định là "M"
                }

                form.style.display = "block";
                overlay.style.display = "block";
            } else {
                form.style.display = "none";
                overlay.style.display = "none";
            }
        }
        document.addEventListener("DOMContentLoaded", function () {
            var message = "<%= request.getAttribute("responseMessage")%>";
            if (message && message !== "null") {
                var popup = document.createElement("div");
                popup.textContent = message;
                popup.style.position = "fixed";
                popup.style.top = "20px";
                popup.style.right = "20px";
                popup.style.padding = "15px";
                popup.style.backgroundColor = "#4CAF50";
                popup.style.color = "white";
                popup.style.borderRadius = "5px";
                popup.style.boxShadow = "0px 0px 10px rgba(0, 0, 0, 0.1)";
                document.body.appendChild(popup);

                setTimeout(function () {
                    popup.style.opacity = "0";
                    setTimeout(() => popup.remove(), 500);
                }, 5000);
            }
        });
    </script>
</html>
