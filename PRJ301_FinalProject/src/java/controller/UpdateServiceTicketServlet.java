/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.ServiceMechanicDAO;
import DAO.UpdateServiceTicketDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.ServiceMechanic;

/**
 *
 * @author LENOVO
 */
public class UpdateServiceTicketServlet extends HttpServlet {

    final String VIEW = "VIEW";
    final String UPDATE = "UPDATE";
    String url = "ServiceTicketPage.jsp";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            UpdateServiceTicketDAO updateServiceTicketDAO = new UpdateServiceTicketDAO();
            ServiceMechanicDAO mechanicDAO = new ServiceMechanicDAO();
            String serviceTicket = request.getParameter("serviceTicket");
            String mechanicID = request.getParameter("mechanicID");

            switch (serviceTicket) {
                case VIEW:
                    HashMap<ServiceMechanic, String>[] maps = updateServiceTicketDAO.getServiceMechanicDetails(mechanicID);
                    request.setAttribute("mapUpdateServiceTicketServiceName", maps[0]);
                    request.setAttribute("mapUpdateServiceTicketMechanicName", maps[1]);
                    request.setAttribute("mechanicID", mechanicID);
                    request.getRequestDispatcher(url).forward(request, response);
                    break;
                case UPDATE:
                    String id = request.getParameter("ticketID");
                    String comment = request.getParameter("comment");
                    int hour = 0;
                    double rate = 0;
                    try {
                        hour = Integer.parseInt(request.getParameter("hours").trim());
                        rate = Double.parseDouble(request.getParameter("rate").trim());
                    } catch (NumberFormatException e) {
                        request.getSession().setAttribute("updateMess", "wrong number format");
                    }
                    if (mechanicDAO.UpdateServiceMechanic(id, hour, comment, rate)) {
                        request.getSession().setAttribute("updateMess", "Updated successfully!");
                    } else {
                        request.setAttribute("updateMess", "Updated fail!");
                    }
                    response.sendRedirect("UpdateServiceTicketServlet?serviceTicket=VIEW&mechanicID=" + mechanicID);
                    break;
            }

        }
    }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
