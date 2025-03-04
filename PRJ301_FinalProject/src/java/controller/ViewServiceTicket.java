package controller;

import DAO.ServiceTicketDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.ServiceTicket;

public class ViewServiceTicket extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            String custID = request.getParameter("id");  

            if (custID != null && !custID.isEmpty()) {
                ServiceTicketDAO serviceTicketDAO = new ServiceTicketDAO();
                List<ServiceTicket> serviceTickets = serviceTicketDAO.getServiceTicketsByCustomerID(custID);

                request.setAttribute("serviceTicket", serviceTickets);
                RequestDispatcher dispatcher = request.getRequestDispatcher("ViewServiceTicket.jsp");
                dispatcher.forward(request, response);
            } else {
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
