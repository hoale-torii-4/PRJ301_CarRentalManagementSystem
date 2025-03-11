<%@page import="java.util.ArrayList"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="model.SaleInvoiceDetail"%>


<!DOCTYPE html>
<html>
    <head>
        <title>Customer Invoice Page</title>
        <style>
            table {
                width: 100%;
                border-collapse: collapse;
            }
            table, th, td {
                border: 1px solid black;
            }
            th, td {
                padding: 8px;
                text-align: left;
            }
            .details-btn {
                background-color: blue;
                color: white;
                padding: 5px;
                border: none;
                cursor: pointer;
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
                <td><strong>Price:</strong> <%= NumberFormat.getInstance().format(si.getInvoicePrice()) %></td>
                
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

        <% } else { %>
        <!-- Hi?n th? danh sách hóa ??n n?u không có chi ti?t -->
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
        <% }%>

        
        <a href="CustomerDashboardPage.jsp"><button>Back to dashboard</button></a>
    </body>
</html>
