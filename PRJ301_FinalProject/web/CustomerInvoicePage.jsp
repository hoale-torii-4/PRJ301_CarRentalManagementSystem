<%@page import="java.util.ArrayList"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="model.SaleInvoiceDetail"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Customer Invoice Page</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                color: #333;
                margin: 0;
                padding: 0;
            }
            h1, h2 {
                text-align: center;
                color: #003366;
                font-family: 'Arial', sans-serif;
            }
            table {
                width: 90%;
                margin: 20px auto;
                border-collapse: collapse;
                background-color: #ffffff;
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
            .details-btn {
                background-color: #003366;
                color: white;
                padding: 8px 12px;
                border: none;
                cursor: pointer;
                border-radius: 4px;
                text-align: center;
                text-decoration: none;
            }
            .details-btn:hover {
                background-color: #002244;
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
            .info-table {
                width: 90%; /* Match the width of the list table */
                margin: 20px auto;
                border: 1px solid #ddd;
                background-color: #fff;
                padding: 10px;
            }
            .info-table td {
                padding: 18px;
                font-size: 14px;
            }
        </style>
    </head>
    <body>
        <h1>CUSTOMER INVOICE PAGE</h1>
        <%
            ArrayList<SaleInvoiceDetail> saleInvoices = (ArrayList<SaleInvoiceDetail>) request.getAttribute("LIST_INVOICE");
            ArrayList<SaleInvoiceDetail> detaiInvoices = (ArrayList<SaleInvoiceDetail>) request.getAttribute("LIST_DETAIL");

            boolean isDetailView = (detaiInvoices != null && !detaiInvoices.isEmpty());
        %>
        <% if (isDetailView) { %>
        <h2>Detail</h2>
        <% for (SaleInvoiceDetail si : detaiInvoices) {%>
        <table class="info-table">
            <tr>
                <td><strong>Invoice ID:</strong> <%= si.getInvoiceID()%></td>
                <td><strong>Invoice Date:</strong> <%= si.getInvoiceDate()%></td>
                <td><strong>Sale Name:</strong> <%= si.getSalesName()%></td>
                <td><strong>Price:</strong> <%= NumberFormat.getInstance().format(si.getInvoicePrice())%></td>
            </tr>
            <tr>
                <td><strong>Cust Name:</strong> <%= si.getCustName()%></td>
                <td><strong>Sex:</strong> <%= si.getSex()%></td>
                <td><strong>Cust Address:</strong> <%= si.getCusAddress()%></td>
                <td><strong>Phone:</strong> <%= si.getPhone()%></td>
            </tr>
            <tr>
                <td><strong>Car Serial number:</strong> <%= si.getSerialNumber()%></td>
                <td><strong>Car model:</strong> <%= si.getModel()%></td>
                <td><strong>Car color:</strong> <%= si.getColour()%></td>
                <td><strong>Car year:</strong> <%= si.getYear()%></td>
            </tr>
        </table>
        <% } %>
        <div class="back-container">
            <a href="CustomerInvoiceServlet?id=<%=session.getAttribute("customerID") %>" ><button class="back-button">Back</button></a>
        </div>

        <% } else { %>
        <!-- Display list of invoices if no details available -->
        <h2>List of Invoices</h2>
        <table>
            <tr>
                <th>Invoice Id</th>
                <th>Invoice Date</th>
                <th>Customer Name</th>
                <th>Car Model</th>
                <th>Price</th>
                <th>Action</th>
            </tr>
            <% if (saleInvoices != null && !saleInvoices.isEmpty()) {
                    for (SaleInvoiceDetail si : saleInvoices) {%>
            <tr>
                <td><%= si.getInvoiceID()%></td>
                <td><%= si.getInvoiceDate()%></td>
                <td><%= si.getCustName()%></td>
                <td><%= si.getModel()%></td>
                <td><%= NumberFormat.getInstance().format(si.getInvoicePrice())%></td>
                <td>
                    <form action="CustomerDetailInvoiceServlet" method="POST">
                        <input type="hidden" name="invoiceID" value="<%= si.getInvoiceID()%>">
                        <input type="submit" class="details-btn" value="Detail" />
                    </form>
                </td>
            </tr>
            <% }
            } else { %>
            <tr>
                <td colspan="6" style="text-align: center; color: red;">No invoices available.</td>
            </tr>
            <% } %>
        </table>

        <div class="back-container">
            <a href="CustomerDashboardPage.jsp"><button class="back-button">Back to dashboard</button></a>
        </div>
        <% }%>


    </body>
</html>
