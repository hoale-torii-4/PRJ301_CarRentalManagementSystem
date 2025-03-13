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
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Customer Login</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            /* Global styles */
            body {
                font-family: 'Arial', sans-serif;
                background-color: #f4f4f4;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
                color: #333;
            }

            /* Form container */
            .login-container {
                background-color: #fff;
                padding: 40px;
                border-radius: 10px;
                box-shadow: 0 6px 10px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 420px;
                text-align: center;
                box-sizing: border-box;
            }

            /* Heading style */
            .login-container h1 {
                color: #003366;  /* Red color for the heading */
                font-size: 2.5rem;
                margin-bottom: 20px;
            }

            /* Form input fields */
            .login-container input[type="text"],
            .login-container input[type="submit"],
            .login-container input[type="password"]
            {
                width: 100%;
                padding: 12px;
                margin: 10px 0;
                border-radius: 5px;
                border: 1px solid #ddd;
                font-size: 1rem;
                transition: 0.3s ease;
            }

            /* Focus effect on inputs */
            .login-container input[type="text"]:focus,
            .login-container input[type="password"]:focus {
                border-color: #003366;
                outline: none;
            }

            /* Submit button */
            
            .login-container input[type="submit"] {
                background-color: #003366; /* Red color */
                color: white;
                border: none;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .login-container input[type="submit"]:hover {
                background-color: #B71C1C; /* Darker red on hover */
            }

            /* Checkbox styling */
            .login-container input[type="checkbox"] {
                margin-right: 10px;
            }
            div#checkboxlogin {
                text-align: left;
            }
            /* Error message styling */
            .message {
                padding: 10px;
                margin-top: 20px;
                font-size: 16px;
                border-radius: 5px;
                color: white;
                text-align: center;
            }

            .error {
                background-color: #f44336;
            }

            .success {
                background-color: #4CAF50;
            }

            .form-group {
                margin-bottom: 15px;
            }

            .form-group input[type="text"], .form-group input[type="tel"], .form-group input[type="date"] {
                width: 100%;
                padding: 10px;
                border-radius: 5px;
                border: 1px solid #ddd;
            }

            .form-group input[type="radio"] {
                margin-right: 10px;
            }

            .modal button, .overlay {
                margin-top: 10px;
            }

            /* Responsive design */
            @media screen and (max-width: 768px) {
                .login-container {
                    width: 90%;
                    padding: 20px;
                }
            }

        </style>
    </head>
    <body>

        <div class="login-container">
            <h1>Customer Login</h1>

            <!-- Form to redirect to Staff login -->
            <form action="LoginStaffPage.jsp">

            </form>

            <!-- Customer login form -->
            <form action="LoginCustomerServlet" method="POST" onsubmit="return validateForm()">
                <p><input type="text" name="custName" id="custName" placeholder="Enter your Name" required></p>
                <p><input type="text" name="custPhone" id="custPhone" placeholder="Enter your Phone number" required></p>
                <div id="checkboxlogin"><p><input type="checkbox" name="custSave" value="Save"> Save Login</p></div>
                <input type="submit" value="LOGIN">
            </form>

            <!-- Display failed login message -->
            <div id="error-message" class="message error" style="display: none;">You must Login</div>

            <p>Already a staff member? <a href="LoginStaffPage.jsp">Login as Staff</a></p>
        </div>

        <script>
            // JavaScript form validation
            function validateForm() {
                var name = document.getElementById("custName").value;
                var phone = document.getElementById("custPhone").value;

                if (name === "" || phone === "") {
                    // Show the error message if fields are empty
                    document.getElementById("error-message").style.display = "block";
                    return false; // Prevent form submission
                }
                return true; // Allow form submission
            }
        </script>

    </body>
</html>
