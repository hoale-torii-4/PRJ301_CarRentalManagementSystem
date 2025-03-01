package controller;

import DAO.InvoiceDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.SalesInvoice;

public class CreateInvoiceServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String salesID = request.getParameter("salesID");
        String custID = request.getParameter("custID");
        String carID = request.getParameter("carID");
        String invoiceDate = request.getParameter("invoiceDate");
        
        SalesInvoice invoice = new SalesInvoice(null, invoiceDate, salesID, carID, custID);
        InvoiceDAO dao = new InvoiceDAO();
        
        boolean isSuccess = dao.createInvoice(invoice);

        if (isSuccess) {
            response.sendRedirect("ListInvoice.jsp?success=1");
        } else {
            response.sendRedirect("CreateInvoice.jsp?custID=" + custID + "&error=1");
        }
    
}
    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Create Invoice Servlet";
    }
}
