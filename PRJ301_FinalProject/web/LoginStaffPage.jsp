<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Staff Login</title>
          <style>
            /* General Styling */
            body {
                font-family: 'Arial', sans-serif;
                background-color: #ffffff; 
                color: #003366; 
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            /* Container Styling */
            .login-container {
                background-color: #f4f4f4; /* Nền sáng cho container */
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
                width: 100%;
                max-width: 500px;
                text-align: center;
            }

            /* Title Styling */
            h2 {
                color: #003366; /* Chữ màu xanh da trời */
                margin-bottom: 25px;
                font-size: 32px;
                letter-spacing: 1px;
            }

            /* Label and Input Styling */
            label {
                font-size: 14px;
                margin-bottom: 5px;
                color: #003366; /* Chữ màu xanh da trời */
                width: 20%;
                text-align: left;
            }

            /* Flexbox styling to align the input fields side by side */
            .form-group {
                display: flex;
                justify-content: space-between;
                margin-bottom: 20px;
                align-items: center;
                width: 100%;
            }

            /* Input Fields Styling */
            input[type="text"], select {
                padding: 12px;
                border: 1px solid #444;
                border-radius: 8px;
                font-size: 16px;
                background-color: #e8e8e8;
                color: #333;
                width: 80%; /* Adjust to make them side by side with space between */
            }

            input[type="text"]:invalid {
                border-color: #FF3B3B; /* Red border for invalid input */
            }

            /* Submit Button Styling */
            input[type="submit"] {
                padding: 12px;
                background-color: #003366; /* Màu xanh da trời */
                color: white;
                font-size: 16px;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                width: 20%;
                transition: background-color 0.3s ease;
            }

            input[type="submit"]:hover {
                background-color: #1565C0; /* Màu xanh đậm khi hover */
            }

            /* Error message Styling */
            p {
                color: #FF3B3B; /* Màu đỏ cho thông báo lỗi */
                font-weight: bold;
                text-align: center;
                font-size: 16px;
            }
            select#role {
                width: 85%;
            }
            /* Responsive Design for smaller screens */
            @media (max-width: 600px) {
                .login-container {
                    padding: 30px;
                }
                h2 {
                    font-size: 28px;
                }
                .form-group {
                    flex-direction: column;
                    align-items: flex-start;
                }
                input[type="text"], select {
                    width: 100%; /* Stacked vertically on smaller screens */
                }
            }
        </style>
    </head>
    <body>

        <!-- Login Form Container -->
        <div class="login-container">
            <h2>Staff Login</h2>

            <!-- Form for login -->
            <form action="LoginStaffServlet" method="POST" novalidate>
                <input type="hidden" name="action" value="login">

                <!-- Name Input Field -->
                <div class="form-group">
                    <label for="name">Full Name:</label>
                    <input type="text" id="name" name="name" required placeholder="Enter your Name" pattern=".{3,}" title="Name should have at least 3 characters"><br>
                </div>

                <!-- Role Selection Dropdown -->
                <div class="form-group">
                    <label for="role">Role:</label>
                    <select id="role" name="role" required>
                        <option value="SalePerson">Sale Person</option>
                        <option value="Mechanic">Mechanic</option>
                    </select><br>
                </div>

                <!-- Submit Button -->
                <input type="submit" value="Login">
            </form>

            <!-- Error Message Display -->
            <% if (request.getAttribute("errorMessage") != null) {%>
            <p><%= request.getAttribute("errorMessage")%></p>
            <% }%>
        </div>

    </body>
</html>
