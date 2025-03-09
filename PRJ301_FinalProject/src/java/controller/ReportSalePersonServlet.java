/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.ReportDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Car;
import model.Mechanic;
import model.PartUsed;
import model.SalesInvoice;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "ReportSalePersonServlet", urlPatterns = {"/ReportSalePersonServlet"})
public class ReportSalePersonServlet extends HttpServlet {

    final String SOLD = "SOLD";
    final String BESTMODEL = "BESTMODEL";
    final String BESTPART = "BESTPART";
    final String MECHANIC = "MECHANIC";
    String url = "ReportSalePerson.jsp";

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            ReportDAO reportDAO = new ReportDAO();
            String updateMess = "";
            String year = request.getParameter("year-select");
            String reportType = request.getParameter("reportType");

            switch (reportType) {
                case SOLD:
                    ArrayList<SalesInvoice> list = reportDAO.listInvoice(year);
                    double revenue = list.stream().mapToDouble(SalesInvoice::getPrice).sum();
                    request.setAttribute("LIST_YEAR", list);
                    request.setAttribute("REVENUE", revenue);
                    break;
                case BESTMODEL:
                    HashMap<Car, Integer> cars = reportDAO.bestSellingCarModel();
                    request.setAttribute("BSCAR_MAP", cars);
                    break;
                case BESTPART:
                    ArrayList<PartUsed> PuList = reportDAO.partUsedList();
                    request.setAttribute("LIST_USEDPART", PuList);
             
                    break;
                case MECHANIC:
                    HashMap<Mechanic, Integer> mapMechanic = reportDAO.ThreeMechanicID();
                    request.setAttribute("MAP_MECHANIC", mapMechanic);                    break;
                default:
                    updateMess = "Somethings wrong!";
            }
            request.setAttribute("updateMess", updateMess);
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
