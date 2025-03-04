<%@page import="model.Service"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="model.ServiceMechanic"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Service Ticket Management</title>
        <script>
            function fetchSuggestions() {
                let query = document.getElementById("searchInput").value;
                if (query.length < 1)
                    return;
                fetch("SearchServiceByNameServlet?query=" + encodeURIComponent(query))
                        .then(response => response.json())
                        .then(data => {
                            let dataList = document.getElementById("serviceSuggestions");
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
                document.getElementById("searchForm").submit();
            }

            function openUpdateModal(serviceID, name, hourlyRate) {
                document.getElementById("updateServiceID").value = serviceID;
                document.getElementById("updateName").value = name;
                document.getElementById("updateHourlyRate").value = hourlyRate;
                document.getElementById("updateTicketModal").style.display = "block";
                document.getElementById("overlay").style.display = "block";
            }

            function closeUpdateModal() {
                document.getElementById("updateTicketModal").style.display = "none";
                document.getElementById("overlay").style.display = "none";
            }

            function confirmDelete(serviceID) {
                document.getElementById("deleteServiceID").value = serviceID;
                document.getElementById("deleteConfirmModal").style.display = "block";
                document.getElementById("deleteOverlay").style.display = "block";
            }

            function closeDeleteModal() {
                document.getElementById("deleteConfirmModal").style.display = "none";
                document.getElementById("deleteOverlay").style.display = "none";
            }
            function openCreateModal() {
                document.getElementById("createServiceModal").style.display = "block";
                document.getElementById("createOverlay").style.display = "block";
            }

            function closeCreateModal() {
                document.getElementById("createServiceModal").style.display = "none";
                document.getElementById("createOverlay").style.display = "none";
            }
        </script>
    </head>
    <body>
        <h1>SERVICE PAGE</h1>

        <form id="searchForm" action="SearchServiceByNameServlet" method="POST">
            <input type="text" name="query" id="searchInput" list="serviceSuggestions" oninput="fetchSuggestions()" onchange="autoSubmit()">
            <datalist id="serviceSuggestions"></datalist>
            <button type="submit">Search</button>
        </form>
        <button type="button" onclick="openCreateModal()">Create Service</button>
        <%
            String updateMess = (String) request.getAttribute("updateMess");
            if (updateMess != null && !updateMess.isEmpty()) {
        %>
        <h2><%= updateMess%></h2>
        <%
            }
        %>


        <table border="1">
            <tr>
                <th>Service ID</th>
                <th>Service Name</th>
                <th>Hourly rate</th>
                <th>Action</th>

            </tr>
            <%
                ArrayList<Service> serviceList = (ArrayList<Service>) request.getAttribute("LIST_SERVICE");
                if (serviceList != null && !serviceList.isEmpty()) {
                    for (Service s : serviceList) {
            %>
            <tr>
                <td><%= s.getServiceID()%></td>
                <td><%= s.getName()%></td>
                <td><%= s.getHourlyRate()%></td>
                <td>
                    <button type="button" onclick="openUpdateModal('<%= s.getServiceID()%>', '<%= s.getName()%>', '<%= s.getHourlyRate()%>')">Update</button>
                    <button type="button" onclick="confirmDelete('<%= s.getServiceID()%>')">Delete</button>
                </td>
            </tr>
            <%
                    }
                }
            %>
            <!-- Create Modal -->
        </table>
        <div id="createServiceModal" style="display: none; background: white; padding: 20px; border: 1px solid black; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 1000;">
            <h3>Create New Service</h3>
            <form action="CreateServiceServlet" method="POST">
                <label>Name:</label>
                <input type="text" name="serviceName" id="createName" required><br>
                <label>Hourly Rate:</label>
                <input type="text" name="hourlyRate" id="createHourlyRate" required><br>
                <button type="submit">Create</button>
                <button type="button" onclick="closeCreateModal()">Cancel</button>
            </form>
        </div>
        <!-- Update Modal -->
        <div id="updateTicketModal" style="display: none; background: white; padding: 20px; border: 1px solid black; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 1000;">
            <h3>Update Service Ticket</h3>
            <form action="UpdatServiceServlet" method="POST">
                <input type="hidden" name="serviceID" id="updateServiceID">
                <label>Name:</label>
                <input type="text" name="serviceName" id="updateName" required><br>
                <label>Hourly Rate:</label>
                <input type="text" name="hourlyRate" id="updateHourlyRate" required><br>
                <button type="submit">Update</button>
                <button type="button" onclick="closeUpdateModal()">Cancel</button>
            </form>
        </div>

        <!-- Delete Modal -->
        <div id="deleteConfirmModal" style="display: none; background: white; padding: 20px; border: 1px solid black; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 1000;">
            <h3>Are you sure you want to delete this service?</h3>
            <form action="DeleteServiceServlet" method="POST">
                <input type="hidden" name="serviceID" id="deleteServiceID">
                <button type="submit">Yes</button>
                <button type="button" onclick="closeDeleteModal()">No</button>
            </form>
        </div>

        <div id="overlay" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 999;" onclick="closeUpdateModal()"></div>
        <div id="deleteOverlay" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 999;" onclick="closeDeleteModal()"></div>
        <div id="createOverlay" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 999;" onclick="closeCreateModal()"></div>
    </body>
</html>
