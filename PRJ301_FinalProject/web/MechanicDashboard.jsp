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

        .navbar {
            background: #003366; /* Màu xanh đậm */
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

        /* Căn chỉnh menu bên phải */
        .navbar .menu {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-right: 1%;
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

    <!-- Navbar -->
    <div class="navbar">
        <div class="welcome-text">Welcome, ${sessionScope.user}</div>
        <div class="menu">
            <a href="ViewServiceTicket?action=STAFF">Manage Service Ticket</a>

            <%
                String mechanicId = (String) session.getAttribute("mechanicID");
            %>
            <a href="CRUDServiceServlet?cRUDAction=SEARCH&query=">Manage Service</a>
            <a href="LogoutServlet" class="logout-btn">
                    <span>Log Out</span><img src="images/logout.png" alt="Logout" width="24" height="24">
                </a>
        </div>
    </div>

    <!-- Hero Section -->
    <div class="hero">
        <h1>Welcome to Hoàng Mõm!!!</h1>
        <p>Your journey towards excellence begins here</p>
    </div>

    <!-- Dashboard -->
    
    <!-- Footer -->
    <footer>
        &copy; 2025 Garage Management System
    </footer>

</body>
</html>
