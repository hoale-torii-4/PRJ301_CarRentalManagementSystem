<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mechanic Dashboard</title>
    <style>
        /* Reset mặc định */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Cấu trúc chính */
        html, body {
            height: 100%;
            font-family: 'Arial', sans-serif;
            display: flex;
            flex-direction: column;
            background-color: #f4f4f4;
        }

        /* Navbar */
        .navbar {
            background-color: #003366;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 30px;
        }

        .navbar .welcome-text {
            font-size: 20px;
            font-weight: bold;
        }

        .navbar .menu {
            display: flex;
            gap: 20px;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            font-size: 16px;
            font-weight: bold;
            transition: color 0.3s ease;
        }

        .navbar a:hover {
            color: #FFD700;
        }

        /* Hero Section */
        .hero {
            background-image: url('images/garacar.jpg');
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


        
        /* Footer */
        footer {
            background-color: #2c3e50;
            color: white;
            padding: 15px 0;
            text-align: center;
            margin-top: auto;
        }

    </style>
</head>
<body>

    <!-- Navbar -->
    <div class="navbar">
        <div class="welcome-text">Welcome, ${sessionScope.user}!</div>
        <div class="menu">
            <a href="ServiceTicket.jsp">Search & View Service Tickets</a>

            <%
                String mechanicId = (String) session.getAttribute("mechanicID");
            %>
            <a href="UpdateServiceTicketServlet?mechanicID=<%=mechanicId%>&serviceTicket=VIEW">Update Service Ticket</a>

            <a href="ServicePage.jsp">Manage Service</a>
            <a href="LogoutServlet">LOG OUT</a>
        </div>
    </div>

    <!-- Hero Section -->
    <div class="hero">
        <h1>Welcome to Hòa Nghèo!!!</h1>
        <p>Your journey towards excellence begins here</p>
    </div>

    <!-- Dashboard -->
    
    <!-- Footer -->
    <footer>
        &copy; 2025 Garage Management System
    </footer>

</body>
</html>
