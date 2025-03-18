<%@page import="model.SalePerson"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sale person Dashboard</title>
        <!-- Liên kết Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>

            html, body {
                height: 100%;
                margin: 0;
                padding: 0;
                display: flex;
                flex-direction: column;
                font-family: 'Arial', sans-serif;
                background-color: white;
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

            /* Căn chỉnh menu */
            .navbar .menu {
                display: flex;
                align-items: center;
                gap: 20px;
                margin-right: 1%;
            }

            /* Các nút */
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

            /* Hover */
            .navbar a:hover,
            .navbar button:hover {
                background: rgba(255, 255, 255, 0.2);
                border-radius: 5px;
                transform: scale(1.05);
                color: #FFD700;
            }
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

            /* Hero Section */
            .hero {
                background-image: url('images/showcar.jpeg');
                background-size: cover;
                background-position: center;
                color: white;
                padding: 100px 0;
                text-align: center;
                flex-grow: 1;
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





            @media (max-width: 480px) {
                .hero {
                    padding: 60px 10px;
                }

                .hero h1 {
                    font-size: 1.8rem;
                }

                .hero p {
                    font-size: 0.9rem;
                }

                .navbar .menu {
                    flex-direction: column;
                    gap: 5px;
                }
            }
            @media (max-width: 768px) {
                .navbar {
                    flex-direction: column;
                    align-items: center;
                    padding: 15px;
                }

                .navbar .menu {
                    display: flex;
                    flex-direction: column;
                    gap: 10px;
                    text-align: center;
                    width: 100%;
                }

                .navbar a,
                .navbar button {
                    width: 100%;
                    padding: 10px;
                }
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


        </style>
    </head>
    <body>

        <div class="navbar">
            <div class="welcome-text">
                <%
                    if (session.getAttribute("user") == null) {
                        response.sendRedirect("LoginCustomerPage.jsp");
                    }
                %>
                Welcome, <%= session.getAttribute("user")%>

            </div>
            <div class="menu">
                <!-- Xử lý salesID -->
                <%
                    String salesID = (String) session.getAttribute("salesID");
                    if (salesID == null) {
                        salesID = ""; // Default value if salesID is not found in the session
                    }
                %>
                <a href="CRUDCustomerServlet?cRUDAction=SEARCH&name=""">Manage Customer</a>
                <a href="PartManagementPage.jsp">Manage Part</a>
                <a href="ViewServiceTicket?action=STAFF">Manage Service Ticket</a>
                <a href="CRUDCarServlet?cRUDAction=SEARCH">Manage Car</a>
                <a href="ReportSalePersonServlet?reportType=MECHANIC">Report</a>
                <a href="LogoutServlet" class="logout-btn">
                    <span>Log Out</span><img src="images/logout.png" alt="Logout" width="24" height="24">
                </a>
            </div>
        </div>



        <!-- Hero Section -->
        <div class="hero">
            <h1>Welcome to Hòa Nghẹo!!!</h1>
            <p>Your journey towards excellence begins here</p>
        </div>

        <!-- Footer -->
        <footer>
            <p>&copy; 2025 Hòa Nghẹo!!!. All Rights Reserved.</p>
        </footer>

        <!-- Bootstrap JS and Popper.js -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    </body>

