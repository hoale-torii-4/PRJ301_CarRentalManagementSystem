package controller;

import DAO.ServiceTicketDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.ServiceTicket;
import model.ServiceTicketDetails;

public class ViewServiceTicket extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");

    try {
        HttpSession s = request.getSession();
        String ticketID = request.getParameter("ticketID"); // Lấy ticketID từ URL
        String custID = request.getParameter("id");
//        String salePersonID = request.getParameter("salePersonID");

        String salePersonID = (String) s.getAttribute("salesID");


        ServiceTicketDAO serviceTicketDAO = new ServiceTicketDAO();

        if (ticketID != null && !ticketID.isEmpty()) {
            // Lấy chi tiết của Service Ticket theo ticketID
            List<ServiceTicketDetails> serDetail = serviceTicketDAO.getServiceTicketForCustomerTiketID(ticketID);
            request.setAttribute("serDetail", serDetail);
            request.setAttribute("RESULT", ticketID); // Lưu ticketID vào request để hiển thị trong JSP
            request.getRequestDispatcher("ViewServiceTicket.jsp").forward(request, response);
        } else if (custID != null && !custID.isEmpty()) {
            // Lấy danh sách service tickets của khách hàng theo custID
            List<ServiceTicketDetails> serviceTickets = serviceTicketDAO.getServiceTicketForCustomer(custID);
            request.setAttribute("serviceTicket", serviceTickets);
            request.getRequestDispatcher("ViewServiceTicket.jsp").forward(request, response);
        } if (salePersonID != null && !salePersonID.isEmpty()) {
            List<ServiceTicketDetails> serviceTickets = serviceTicketDAO.getAllServiceTicketForSalePerson();
            request.setAttribute("serviceTicket", serviceTickets);
            request.setAttribute("salePersonID", salePersonID);
            request.getRequestDispatcher("ViewServiceTicket.jsp").forward(request, response);
        
        } else  {
            response.sendRedirect("LoginCustomerPage.jsp");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("LoginCustomerPage.jsp");
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
        return "Short description";
    }
}
