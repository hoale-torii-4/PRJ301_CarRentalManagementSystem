<%@page import="java.util.List"%>
<%@page import="model.CarParts"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Find Car Part</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                color: #333;
                margin: 0;
                padding: 0;
            }

            h1 {
                text-align: center;
                color: #003366;
                font-family: 'Arial', sans-serif;
                margin-top: 20px;
            }

            h3 {
                color: #003366;
            }



            input[type="text"] {
                width: 80%;
                padding: 10px;
                margin: 10px 0;
                border: 1px solid #ddd;
                border-radius: 4px;
                margin-right: 13px;
            }

            button {
                background-color: #003366;
                color: white;
                padding: 10px 15px;
                border: none;
                cursor: pointer;
                border-radius: 4px;
                text-align: center;
                text-decoration: none;
            }

            button:hover {
                background-color: #002244;
            }

            table {
                width: 90%;
                margin: 20px auto;
                border-collapse: collapse;
                background-color: #ffffff;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            }

            table, th, td {
                border: 1px solid #ddd;
            }

            th, td {
                padding: 12px;
                text-align: left;
                font-size: 14px;
            }

            th {
                background-color: #003366;
                color: white;
            }

            tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            tr:hover {
                background-color: #f1f1f1;
            }

            a.backBtn {
                margin-left: 8.6%;
            }

            input[type="submit"] {
                padding: 9px 30px;
                border: none;
                border-radius: 5px;
                background-color: #003366;
                color: #fff;
            }

            .findForm {
                width: 80%;
                margin: 0 auto;
                padding: 20px;
                background-color: #ffffff;
                border-radius: 5px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
            }

            .findForm form{
                display: inline-flex;
                width: 86%;
            }
            .showCreateBtn{
                display: inline-flex;
            }
            .findPartBtn{
                width: 12%;
                height: 36px;
                margin-top: 11px;
                margin-left: 20px;
            }
            .modal {
                display: none;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background-color: white;
                padding: 20px;
                border: 1px solid #ddd;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
                z-index: 1000;
                width: 80%;
                max-width: 500px;
            }

            .overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                z-index: 999;
            }

            .modal button {
                background-color: #003366;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            .modal button:hover {
                background-color: #002244;
            }

            .modal form {
                width: 100%;
            }

            .modal input[type="text"] {
                width: 100%;
                padding: 10px;
                margin: 10px 0;
                border: 1px solid #ddd;
                border-radius: 4px;

            }

            .cancel-btn {
                background-color: #ff3300;
                margin-top: 10px;
            }

            .cancel-btn:hover {
                background-color: #cc2900;
            }

            .back-button {
                display: block;
                width: 150px;
                margin: 20px auto;
                padding: 10px 15px;
                background-color: #003366;
                color: white;
                border: none;
                border-radius: 4px;
                text-align: center;
                text-decoration: none;
            }

            .back-button:hover {
                background-color: #002244;
            }

            .message {
                margin-left: 8.5%;
                color: #003366;
                font-size: 18px;
                font-weight: 600;
            }

            .updateMessage {
                margin-left: 8.5%;
                color: #003366;
            }
        </style>
        <script>
            function fetchSuggestions() {
                let query = document.getElementById("searchInput").value;
                if (query.length < 1)
                    return;

                fetch("FindCarPartServlet?query=" + encodeURIComponent(query))
                        .then(response => response.json())
                        .then(data => {
                            let dataList = document.getElementById("partSuggestions");
                            dataList.innerHTML = "";
                            data.forEach(item => {
                                let option = document.createElement("option");
                                option.value = item;
                                dataList.appendChild(option);
                            });
                        })
                        .catch(error => console.error("Error fetching suggestions:", error));
            }

            function autoSubmit() {
                let inputField = document.getElementById("searchInput");
                let selectedValue = inputField.value;

                let partName = selectedValue.split(" - ")[1].trim();
                inputField.value = partName;
                document.getElementById("findForm").submit();
            }

            function showCreateForm() {
                document.getElementById("createPartForm").style.display = "block";
                document.getElementById("createOverlay").style.display = "block";
            }
            function hideCreateForm() {
                document.getElementById("createPartForm").style.display = "none";
                document.getElementById("createOverlay").style.display = "none";
            }

            function openUpdateModal(partID, name, purchasePrice, retailPrice) {
                document.getElementById("updatePartID").value = partID;
                document.getElementById("updatePartName").value = name;
                document.getElementById("updatePurchasePrice").value = purchasePrice;
                document.getElementById("updateRetailPrice").value = retailPrice;
                document.getElementById("updatePartModal").style.display = "block";
                document.getElementById("updateOverlay").style.display = "block";
            }
            function closeUpdateModal() {
                document.getElementById("updatePartModal").style.display = "none";
                document.getElementById("updateOverlay").style.display = "none";
            }

            function confirmDelete(partID) {
                document.getElementById("deletePartID").value = partID;
                document.getElementById("deleteConfirmModal").style.display = "block";
                document.getElementById("deleteOverlay").style.display = "block";
            }
            function closeDeleteModal() {
                document.getElementById("deleteConfirmModal").style.display = "none";
                document.getElementById("deleteOverlay").style.display = "none";
            }
        </script>
    </head>
    <body>
        <%
                    if (session.getAttribute("salePerson") == null) {
                        response.sendRedirect("LoginCustomerPage.jsp");
                    }
                %>
        <h1>Find Car Part</h1>
        <div class="findForm">
            <form action="FindCarPartServlet" method="POST" accept-charset="UTF-8">
                <input type="text" name="query" id="searchInput" list="partSuggestions" 
                       oninput="fetchSuggestions()" onchange="autoSubmit()" placeholder="Enter part name">
                <datalist id="partSuggestions"></datalist>
                <button type="submit" class="findPartBtn">Find Part</button>
            </form>
            <div class="showCreateBtn" >
                <button onclick="showCreateForm()">Add New Part</button>
            </div>
        </div>

        <a href="SalePersonDashboard.jsp" class="backBtn"> <input type="submit" value="Back" > </a>

        <div id="createPartForm" style="display: none; background: white; padding: 20px; border: 1px solid black; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 1000;">
            <h3>Create New Part</h3>
            <form action="CRUDPartCarServlet?cRUDAction=CREATE" method="POST" accept-charset="UTF-8">
                <label>Part Name:</label>
                <input type="text" name="partName" required><br>
                <label>Purchase Price:</label>
                <input type="text" name="purchasePrice" required><br>
                <label>Retail Price:</label>
                <input type="text" name="retailPrice" required><br>
                <button type="submit">Submit</button>
                <button type="button" onclick="hideCreateForm()">Cancel</button>
            </form>
        </div>

        <div id="createOverlay" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 999;" onclick="hideCreateForm()"></div>

        <% String updateStatus = (String) request.getAttribute("updateMess"); %>
        <% if (updateStatus != null && !updateStatus.isEmpty()) {%>
        <h2 class="updateMessage"><%= updateStatus%></h2>
        <% } %>
        <%
            List<CarParts> partList = (List<CarParts>) request.getAttribute("searchResult");
        %>
        <% if (partList != null && !partList.isEmpty()) { %>
        <table border="1">
            <tr>
                <th>Part ID</th>
                <th>Part Name</th>
                <th>Purchase Price</th>
                <th>Retail Price</th>
                <th>Actions</th>
            </tr>
            <% for (CarParts carP : partList) {%>
            <tr>
                <td><%= carP.getPartID()%></td>
                <td><%= carP.getPartName()%></td>
                <td><%= carP.getPurchasePrice()%></td>
                <td><%= carP.getRetailPrice()%></td>
                <td>
                    <button onclick="openUpdateModal('<%= carP.getPartID()%>', '<%= carP.getPartName()%>', '<%= carP.getPurchasePrice()%>', '<%= carP.getRetailPrice()%>')">Update</button>
                    <button onclick="confirmDelete('<%= carP.getPartID()%>')">Delete</button>
                </td>
            </tr>
            <% } %>
        </table>
        <% } else { %>
        <p class="message">No parts found.</p>
        <% }%>

        <div id="updatePartModal" style="display: none; background: white; padding: 20px; border: 1px solid black; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 1000;">
            <h3>Update Part</h3>
            <form action="CRUDPartCarServlet?cRUDAction=UPDATE" method="POST" accept-charset="UTF-8">
                <input type="hidden" name="partID" id="updatePartID">
                <label>Part Name:</label>
                <input type="text" name="partName" id="updatePartName" required><br>
                <label>Purchase Price:</label>
                <input type="text" name="purchasePrice" id="updatePurchasePrice" required><br>
                <label>Retail Price:</label>
                <input type="text" name="retailPrice" id="updateRetailPrice" required><br>
                <button type="submit">Update</button>
                <button type="button" onclick="closeUpdateModal()">Cancel</button>
            </form>
        </div>
        <div id="updateOverlay" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 999;" onclick="closeUpdateModal()"></div>

        <div id="deleteConfirmModal" style="display: none; background: white; padding: 20px; border: 1px solid black; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 1000;">
            <h3>Are you sure you want to delete this part?</h3>
            <form action="CRUDPartCarServlet?cRUDAction=DELETE" method="POST" accept-charset="UTF-8">
                <input type="hidden" name="partID" id="deletePartID">
                <button type="submit">Yes</button>
                <button type="button" onclick="closeDeleteModal()">No</button>
            </form>
        </div>
        <div id="deleteOverlay" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 999;" onclick="closeDeleteModal()"></div>
    </body>
</html>
