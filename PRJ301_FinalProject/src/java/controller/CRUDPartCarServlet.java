/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.CRUDPartCarDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.CarParts;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "CRUDPartCarServlet", urlPatterns = {"/CRUDPartCarServlet"})
public class CRUDPartCarServlet extends HttpServlet {

    final String CREATE = "CREATE";
    final String UPDATE = "UPDATE";
    final String DELETE = "DELETE";
    final String SEARCH = "SEARCH";
    String url = "PartManagementPage.jsp";

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
            CRUDPartCarDAO partCarDAO = new CRUDPartCarDAO();
            CarParts cp = null;
            String isCRUD = "";
            String partID = "";
            String partName;
            double purchasePrice;
            double retailPrice;
            switch (cRUDAction) {
                case SEARCH:
                    String keyword = request.getParameter("query");
                    CRUDPartCarDAO dao = new CRUDPartCarDAO();
                    List<CarParts> parts = dao.searchCarPart(keyword);
                    request.setAttribute("searchQuery", keyword);
                    request.setAttribute("searchResult", parts);
                    break;
                case CREATE:
                    partName = request.getParameter("partName");
                    purchasePrice = Double.parseDouble(request.getParameter("purchasePrice").trim());
                    retailPrice = Double.parseDouble(request.getParameter("retailPrice").trim());
                    cp = partCarDAO.CreateCarPart(new CarParts(partID, partName, purchasePrice, retailPrice));
                    request.setAttribute("responseMessage", "Added successfully!");
                    request.getRequestDispatcher("CRUDPartCarServlet?cRUDAction=SEARCH&query=" + cp.getPartName()).forward(request, response);
                    return;
                case DELETE:
                    partID = request.getParameter("partID");
                    if (partCarDAO.DeleteCarPart(partID)) {
                        request.setAttribute("responseMessage", "Deleted " + partID + " successfully!");
                    } else {
                        request.setAttribute("responseMessage", "Deleted Fail!");
                    }
                    break;
                case UPDATE:
                    partID = (String) request.getParameter("partID");
                    partName = request.getParameter("partName");
                    purchasePrice = Double.parseDouble(request.getParameter("purchasePrice").trim());
                    retailPrice = Double.parseDouble(request.getParameter("retailPrice").trim());
                    cp = new CarParts(partID, partName, purchasePrice, retailPrice);

                    if (partCarDAO.updateCarPart(cp)) {
                        request.setAttribute("responseMessage", "Updated " + cp.getPartID() + " successfully!");
                        request.getRequestDispatcher("CRUDPartCarServlet?cRUDAction=SEARCH&query=" + cp.getPartName()).forward(request, response);
                    } else {
                        request.setAttribute("responseMessage", "Updated fail!");
                    }
                    break;

            }
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
