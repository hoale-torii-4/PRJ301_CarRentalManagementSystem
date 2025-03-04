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
                if (query.length < 1) return;
                fetch("SearchServiceTicketServlet?query=" + encodeURIComponent(query))
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
            
            function openUpdateModal(ticketID, hours, comment, rate) {
                document.getElementById("updateTicketID").value = ticketID;
                document.getElementById("updateHours").value = hours;
                document.getElementById("updateComment").value = comment;
                document.getElementById("updateRate").value = rate;
                document.getElementById("updateTicketModal").style.display = "block";
                document.getElementById("overlay").style.display = "block";
            }
            
            function closeUpdateModal() {
                document.getElementById("updateTicketModal").style.display = "none";
                document.getElementById("overlay").style.display = "none";
            }
        </script>
    </head>
    <body>
        <h1>Service Ticket Management</h1>
        <%
            String mess = request.getParameter("updateMess");
            if(mess == null || mess.isEmpty())
                mess = "";
        %>
        <h2><%= mess %></h2>
        
        <form id="searchForm" action="SearchServiceTicketServlet" method="POST">
            <input type="text" name="query" id="searchInput" list="serviceSuggestions" oninput="fetchSuggestions()" onchange="autoSubmit()">
            <datalist id="serviceSuggestions"></datalist>
            <button type="submit">Search</button>
        </form>
        
        <table border="1">
            <tr>
                <th>Service Ticket ID</th>
                <th>Service Name</th>
                <th>Mechanic Name</th>
                <th>Hours</th>
                <th>Comment</th>
                <th>Rate</th>
                <th>Actions</th>
            </tr>
            <% 
                HashMap<ServiceMechanic, String> serviceMechanicByMechanicName = (HashMap) session.getAttribute("mapUpdateServiceTicketMechanicName");
                HashMap<ServiceMechanic, String> serviceMechanicByServiceName = (HashMap) session.getAttribute("mapUpdateServiceTicketServiceName");
                if (serviceMechanicByMechanicName != null && !serviceMechanicByMechanicName.isEmpty()) {
                    for (ServiceMechanic sm : serviceMechanicByMechanicName.keySet()) {
                        String mechanicName = serviceMechanicByMechanicName.get(sm);
                        String serviceName = serviceMechanicByServiceName.get(sm); 
            %>
            <tr>
                <td><%= sm.getServiceTicketID() %></td>
                <td><%= serviceName %></td>
                <td><%= mechanicName %></td>
                <td><%= sm.getHour() %></td>
                <td><%= sm.getComment() %></td>
                <td><%= sm.getRate() %></td>
                <td>
                    <button type="button" onclick="openUpdateModal('<%= sm.getServiceTicketID() %>', '<%= sm.getHour() %>', '<%= sm.getComment() %>', '<%= sm.getRate() %>')">Update</button>
                </td>
            </tr>
            <%
                    }
                }
            %>
        </table>
        
        <!-- Update Modal -->
        <div id="updateTicketModal" style="display: none; background: white; padding: 20px; border: 1px solid black; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 1000;">
            <h3>Update Service Ticket</h3>
            <form action="UpdateServiceMechanicServlet" method="POST">
                <input type="hidden" name="ticketID" id="updateTicketID">
                <label>Hours:</label>
                <input type="text" name="hours" id="updateHours" required><br>
                <label>Comment:</label>
                <input type="text" name="comment" id="updateComment" required><br>
                <label>Rate:</label>
                <input type="text" name="rate" id="updateRate" required><br>
                <button type="submit">Update</button>
                <button type="button" onclick="closeUpdateModal()">Cancel</button>
            </form>
        </div>
        
        <div id="overlay" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 999;" onclick="closeUpdateModal()"></div>
    </body>
</html>
