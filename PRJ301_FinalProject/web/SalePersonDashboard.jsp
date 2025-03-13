<%@page import="model.SalePerson"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mercedes-Benz Dashboard</title>
    <!-- Liên kết Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Ensure the entire page takes up 100% height */
        html, body {
            height: 100%;  /* Make sure the page takes 100% of the viewport height */
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;  /* Align the elements vertically */
        }

        /* Ensure body uses Arial font */
        body {
            font-family: 'Arial', sans-serif;
            background-color: white;
        }

        /* Navbar Styling */
        .navbar {
            background-color: #003366;
            color: white;
        }

        .navbar a {
            color: white !important;
            transition: transform 0.3s ease, color 0.3s ease;
        }

        .navbar a:hover {
            transform: translateY(-5px); /* Nổi lên */
            color: #FFD700; /* Change text color on hover */
        }

        .navbar .navbar-brand {
            font-size: 28px;
            font-weight: bold;
        }

        /* Hero Section */
        .hero {
            background-image: url('images/showcar.jpeg');
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

        /* Custom button */
        .btn-custom {
            background-color: #000;
            color: white;
            padding: 12px 30px;
            border-radius: 5px;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .btn-custom:hover {
            background-color: #3e3e3e;
        }

        /* Footer Styling */
        footer {
            background-color: #2c3e50;
            color: white;
            padding: 20px 0;
            text-align: center;
            margin-top: auto;  /* Ensures footer is at the bottom */
        }

        .button-container {
            margin-top: 40px;
        }

        .button-container a {
            margin: 10px;
        }

    </style>
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <a class="navbar-brand" href="#">Welcome, 
            <%= session.getAttribute("user") != null ? session.getAttribute("user") : "User" %>
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Xử lý salesID -->
        <%
            String salesID = (String) session.getAttribute("salesID");
            if (salesID == null) {
                salesID = ""; // Default value if salesID is not found in the session
            }
        %>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="ListCustomer.jsp">Manage Customer</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="PartManagementPage.jsp">Manage Part</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="ViewServiceTicket?salePersonID=<%= !salesID.isEmpty() ? salesID : "" %>">Manage Service Ticket</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="ManageCarPage.jsp?salePersonID=<%= !salesID.isEmpty() ? salesID : "" %>">Manage Car</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="ReportSalePerson.jsp">Report</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="LogoutServlet">LOG OUT</a>
                </li>
            </ul>
        </div>
    </nav>

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
</html>
