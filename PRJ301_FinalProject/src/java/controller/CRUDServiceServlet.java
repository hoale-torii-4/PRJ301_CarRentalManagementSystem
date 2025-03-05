/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.CRUDServiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Service;

/**
 *
 * @author LENOVO
 */
public class CRUDServiceServlet extends HttpServlet {

    final String CREATE = "CREATE";
    final String UPDATE = "UPDATE";
    final String DELETE = "DELETE";
    String url = "ServicePage.jsp";

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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String cRUDAction = request.getParameter("cRUDAction");
            CRUDServiceDAO serviceDAO = new CRUDServiceDAO();
            String isCRUD = "Failed to";
            Service s = new Service();
            String serviceName = "";
            double hourlyRate = 0;
            String serviceID = "";
            switch (cRUDAction) {
                case CREATE:
                    serviceName = request.getParameter("serviceName");
                    hourlyRate = 0;
                    try {
                        hourlyRate = Double.parseDouble(request.getParameter("hourlyRate"));
                        if (serviceDAO.isCreated(serviceName, hourlyRate)) {
                            isCRUD = "Created new service successfully!";
                        } else {
                            isCRUD = "Created new service fail!";
                        }
                    } catch (NumberFormatException e) {
                    }
                    break;
                case DELETE:
                    serviceID = request.getParameter("serviceID");
                    if (serviceDAO.DeleteServlet(serviceID)) {
                        isCRUD = "Deleted service successfully!";
                    } else {
                        isCRUD = "Deleted service fail!";
                    }
                    break;
                case UPDATE:
                    serviceID = request.getParameter("serviceID");
                    serviceName = request.getParameter("serviceName");
                    hourlyRate = 0;
                    try {
                        hourlyRate = Double.parseDouble(request.getParameter("hourlyRate").trim());
                    } catch (NumberFormatException e) {
                        request.setAttribute("updateMess", "Wrong format number!");
                    }
                    if (serviceDAO.UpdateService(serviceID, serviceName, hourlyRate)) {
                        isCRUD = "Updated service successfully!";
                    } else {
                        isCRUD = "Updated service fail!";
                    }
                    break;
            }
            request.setAttribute("updateMess", isCRUD);
            request.getRequestDispatcher(url).forward(request, response);
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
