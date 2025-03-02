/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.CRUDSearchCarDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Car;

/**
 *
 * @author HOA LE
 */
public class CRUDCarServlet extends HttpServlet {

    final String CREATE = "CREATE";
    final String UPDATE = "UPDATE";
    final String DELETE = "DELETE";
    String url = "SalePersonDashboard.jsp";

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
            String cRUDAction = request.getParameter("cRUDAction");
            HttpSession session = request.getSession(true);
            CRUDSearchCarDAO cRUDDAO = new CRUDSearchCarDAO();
            Car car = new Car();
            String isCRUD = "Failed to ";
            String carID = "";
            String serialNumber;
            String model;
            String colour;
            int year;
            String price;
            switch (cRUDAction) {
                case CREATE:
                    serialNumber = request.getParameter("carSerialNumber").trim();
                    model = request.getParameter("carModel").trim();
                    colour = request.getParameter("carColour").trim();
                    year = Integer.parseInt(request.getParameter("carYear").trim());
                    price = request.getParameter("carPrice");
                    
                    car = new Car(carID, serialNumber, model, colour, year, price);
                    if (cRUDDAO.isCreateCar(car)) {
                        isCRUD = "Create new car Successful!!";
                    } else {
                        isCRUD = "Create new Car is Failed!! TRY AGAIN!";
                    }
                    break;
                case UPDATE:
                    carID = request.getParameter("carID").trim();
                    car = cRUDDAO.getCarByID(carID);
                    serialNumber = request.getParameter("carSerialNumber").trim();
                    model = request.getParameter("carModel").trim();
                    colour = request.getParameter("carColour").trim();
                    year = Integer.parseInt(request.getParameter("carYear").trim());
                    price = request.getParameter("carPrice").trim();
                    if(serialNumber == null || serialNumber.trim().isEmpty())
                        serialNumber = car.getSerialNumber();
                    if(model == null || model.trim().isEmpty())
                        model = car.getModel();
                    if(colour == null || colour.trim().isEmpty())
                        colour = car.getColour();
                    if(year == 0)
                       year = car.getYear();
                    if(price == null || price.trim().isEmpty())
                        price = car.getPrice();
                    car = new Car(carID, serialNumber, model, colour, year, price);
                    if(cRUDDAO.isUpdateCar(car))
                        isCRUD = "Update car Successful!!";
                    else isCRUD = "Update car Failed!! TRY AGAIN.";
                    break;
                case DELETE:
                    carID = request.getParameter("carID").trim();
                    if(cRUDDAO.isDeleteCar(carID))
                        isCRUD = "Delete car ID " + carID + " Successful!!";
                    else isCRUD = "Delete car ID" + carID + " Failed!! TRY AGAIN.";
                    break;

            }
            request.setAttribute("isCRUD", isCRUD);
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
