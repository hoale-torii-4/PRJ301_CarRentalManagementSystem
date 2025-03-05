<%@page import="model.CarParts"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Find Car Part</title>
    <script>
        function fetchSuggestions() {
            let query = document.getElementById("searchInput").value;
            if (query.length < 1) return;
            
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
    <h1>Find Car Part</h1>
    <form action="FindCarPartServlet" method="post">
        <input type="text" name="txtname" id="searchInput" list="partSuggestions" oninput="fetchSuggestions()" placeholder="Enter part name">
        <datalist id="partSuggestions"></datalist>
        <button type="submit">Find Part</button>
    </form>
    
    <button onclick="showCreateForm()">Add New Part</button>
    
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
    <% if (updateStatus != null && !updateStatus.isEmpty()) { %>
        <h2><%= updateStatus %></h2>
    <% } %>
    
    <% ArrayList<CarParts> list = (ArrayList<CarParts>) request.getAttribute("LIST_PART"); %>
    <% if (list != null && !list.isEmpty()) { %>
        <table border="1">
            <tr>
                <th>Part ID</th>
                <th>Part Name</th>
                <th>Purchase Price</th>
                <th>Retail Price</th>
                <th>Actions</th>
            </tr>
            <% for (CarParts carP : list) { %>
            <tr>
                <td><%= carP.getPartID() %></td>
                <td><%= carP.getPartName() %></td>
                <td><%= carP.getPurchasePrice() %></td>
                <td><%= carP.getRetailPrice() %></td>
                <td>
                    <button onclick="openUpdateModal('<%= carP.getPartID() %>', '<%= carP.getPartName() %>', '<%= carP.getPurchasePrice() %>', '<%= carP.getRetailPrice() %>')">Update</button>
                    <button onclick="confirmDelete('<%= carP.getPartID() %>')">Delete</button>
                </td>
            </tr>
            <% } %>
        </table>
    <% } else { %>
        <p>No parts found.</p>
    <% } %>
    
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
