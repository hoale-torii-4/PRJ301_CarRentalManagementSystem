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

public class ServiceTicketServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Fetch search parameters from the request
        String custID = request.getParameter("custID").trim();
        String carID = request.getParameter("carID").trim();
        String dateReceived = request.getParameter("dateReceived").trim();

        
        ServiceTicketDAO dao = new ServiceTicketDAO();
        List<ServiceTicket> tickets = dao.getServiceTickets(custID, carID, dateReceived);

        
        request.setAttribute("serviceTickets", tickets);

        
        RequestDispatcher dispatcher = request.getRequestDispatcher("ServiceTicket.jsp");
        dispatcher.forward(request, response);
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
}
