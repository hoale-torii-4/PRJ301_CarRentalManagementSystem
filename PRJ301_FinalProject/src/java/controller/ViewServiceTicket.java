package controller;

import DAO.CRUDServiceDAO;
import DAO.ServiceMechanicDAO;
import DAO.ServiceTicketDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.ServiceTicketDetails;

public class ViewServiceTicket extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        try {
            HttpSession s = request.getSession();
            String action = request.getParameter("action");
            List<ServiceTicketDetails> serviceTickets;
            ServiceTicketDAO serviceTicketDAO = new ServiceTicketDAO();
            ServiceMechanicDAO serMecDAO = new ServiceMechanicDAO();
            CRUDServiceDAO serviceDAO = new CRUDServiceDAO();
            if (action == null) {
                response.sendRedirect("LoginCustomerPage.jsp");
                return;
            }
            switch (action) {
                case "SEARCH":
                    String carIDSearch = request.getParameter("carID");
                    String custIDSearch = request.getParameter("custID");
                    String dateSearch = (String) request.getParameter("dateReceived");
                    carIDSearch = (carIDSearch == null || carIDSearch.isEmpty()) ? null : carIDSearch;
                    custIDSearch = (custIDSearch == null || custIDSearch.isEmpty()) ? null : custIDSearch;
                    dateSearch = (dateSearch == null || dateSearch.isEmpty()) ? null : dateSearch;
                    serviceTickets = serviceTicketDAO.getServiceTicketByTicketIDByCarIDByDate(custIDSearch, dateSearch, carIDSearch);
                    request.setAttribute("serviceTicket", serviceTickets);
                    request.getRequestDispatcher("ViewServiceTicket.jsp").forward(request, response);
                    return;

                case "UPDATE":
                    String serviceTicketID = request.getParameter("serviceTicketID");
                    String comment = request.getParameter("comment");
                    String serviceName = request.getParameter("serviceName");
                    HttpSession session = request.getSession();
                    String mechanicID = (String) session.getAttribute("mechanicID");
                    int hour = 0;
                    double rate = 0;
                    String serviceID = serviceDAO.getOneServiceByName(serviceName).getServiceID();
                    try {
                        hour = Integer.parseInt(request.getParameter("hours"));
                        rate = Double.parseDouble(request.getParameter("rate"));
                    } catch (NumberFormatException e) {
                        request.setAttribute("errorMess", "Wrong format number!");
                        request.getRequestDispatcher("ErrorPage.jsp").forward(request, response);
                    }
                    boolean isUpdate = serMecDAO.UpdateServiceMechanic(serviceTicketID, serviceID, mechanicID, hour, comment, rate);
                    if (isUpdate) {
                        request.setAttribute("responseMessage", "Update service Ticket ID: " + serviceTicketID + " successful!");
                    } else {
                        request.setAttribute("responseMessage", "Update service Ticket ID: " + serviceTicketID + " Failed!!");
                    }
                    request.getRequestDispatcher("ViewServiceTicket?action=DETAIL&ticketID=" + serviceTicketID).forward(request, response);
                    return;

                case "STAFF":
                    serviceTickets = serviceTicketDAO.getAllServiceTicketForSalePerson();
                    request.setAttribute("serviceTicket", serviceTickets);
                    break;
                case "CUSTOMER":
                    String custID = String.valueOf(s.getAttribute("customerID"));
                    serviceTickets = serviceTicketDAO.getServiceTicketForCustomer(custID);
                    request.setAttribute("serviceTicket", serviceTickets);
                    break;
                case "DETAIL":
                    String ticketID = request.getParameter("ticketID");
                    List<ServiceTicketDetails> serDetail = serviceTicketDAO.getServiceTicketForCustomerTiketID(ticketID);
                    request.setAttribute("serDetail", serDetail);
                    request.setAttribute("RESULT", ticketID);
                    break;

            }

            request.getRequestDispatcher("ViewServiceTicket.jsp").forward(request, response);
            return;
        } catch (Exception e) {
            log("Error in ViewServiceTicket: " + e.getMessage());
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
