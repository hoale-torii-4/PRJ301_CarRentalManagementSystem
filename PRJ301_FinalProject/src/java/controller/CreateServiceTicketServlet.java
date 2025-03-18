/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.CRUDPartCarDAO;
import DAO.CRUDServiceDAO;
import DAO.CarDAO;
import DAO.CustomerDAO;
import DAO.MechanicDAO;
import DAO.ServiceMechanicDAO;
import DAO.ServiceTicketDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Car;
import model.Customer;
import model.Mechanic;
import model.PartUsed;
import model.Service;
import model.ServiceMechanic;
import model.ServiceTicket;

/**
 *
 * @author HOA LE
 */
@WebServlet(name = "CreateServiceTicketServlet", urlPatterns = {"/CreateServiceTicketServlet"})
public class CreateServiceTicketServlet extends HttpServlet {

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
            throws ServletException, IOException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            CRUDPartCarDAO partDAO = new CRUDPartCarDAO();
            ServiceMechanicDAO serMecDAO = new ServiceMechanicDAO();
            CustomerDAO custDAO = new CustomerDAO();
            CustomerDAO cRUDCustDAO = new CustomerDAO();
            ServiceTicketDAO serTicketDAO = new ServiceTicketDAO();
            CRUDServiceDAO serviceDAO = new CRUDServiceDAO();
            CarDAO carDAO = new CarDAO();
            MechanicDAO mecDAO = new MechanicDAO();
            Customer customer = new Customer();
            Car car = new Car();
            Service service = new Service();
            Mechanic mechanic = new Mechanic();
            String customerName = request.getParameter("custName");
            String phone = request.getParameter("custPhone");
            String sex = request.getParameter("custSex");
            String address = request.getParameter("custAddress");
            String carModel = request.getParameter("carModel");
            String carColor = request.getParameter("carColor");
            String dateReceivedStr = request.getParameter("dateReceived");
            String dateReturnedStr = request.getParameter("dateReturned");
            Date dateReceived = (dateReceivedStr != null && !dateReceivedStr.isEmpty()) ? Date.valueOf(dateReceivedStr) : null;
            Date dateReturned = (dateReturnedStr != null && !dateReturnedStr.isEmpty()) ? Date.valueOf(dateReturnedStr) : null;
            //create new customer if not found
            int cusID;
            if (!custDAO.isAlreadyCustomer(new Customer(0, customerName, phone, sex, address))) {
                cusID = cRUDCustDAO.addCustomer(new Customer(0, customerName, phone, sex, address));
            } else {
                cusID = custDAO.getCustomerByName(customerName).getCustID();
            }
            car = carDAO.searchCarByModelByColor(carModel, carColor);
            //create new  service ticket and get service ticket id
            int serTicketID = serTicketDAO.createServiceTicketForSalePerson(new ServiceTicket("", dateReceived, dateReturned, "" + cusID, car.getCarId()));
            // Nhận thông tin chi tiết dịch vụ
            String[] serviceNames = request.getParameterValues("serviceName");
            String[] partNames = request.getParameterValues("partName");
            String[] partPrices = request.getParameterValues("partPrice");
            String[] numOfUsed = request.getParameterValues("numOfUsed");
            String[] hours = request.getParameterValues("hours");
            String[] commentSTR = request.getParameterValues("comment");
            String[] mechanicNameSTR = request.getParameterValues("mechanicName");
            String mechanicName;
            String comment;
            String serviceName;
            String partName;
            String partPrice;
            String numUsed;
            String hour;
            int numberOfRow = Integer.parseInt(request.getParameter("count"));
            if (serviceNames != null && partNames != null && partPrices != null && numOfUsed != null && hours != null && commentSTR != null && mechanicNameSTR != null) {
                for (int i = 0; i < numberOfRow; i++) {
                    serviceName = serviceNames[i];
                    partName = partNames[i];
                    partPrice = partPrices[i];
                    numUsed = numOfUsed[i];
                    hour = hours[i];
                    comment = commentSTR[i];
                    mechanicName = mechanicNameSTR[i];
                    //check null after create
                    if (serviceName.isEmpty() || partName.isEmpty() || partPrice.isEmpty() || numUsed.isEmpty() || hour.isEmpty() || comment.isEmpty() || mechanicName.isEmpty()) {
                        continue; // Bỏ qua dòng nếu thiếu dữ liệu
                    }
                    try {
                        double price = Double.parseDouble(partPrice);
                        int workHours = Integer.parseInt(hour);
                        service = serviceDAO.getOneServiceByName(serviceName);
                        mechanic = mecDAO.checkLogin(mechanicName);
                        //create service machanic
                        serMecDAO.CreateServiceMechanic(new ServiceMechanic(String.valueOf(serTicketID), service.getServiceID(), mechanic.getId(), workHours, comment, service.getHourlyRate()));
                        //create part used
                        partDAO.CreateCarPartUsed(new PartUsed(String.valueOf(serTicketID), partDAO.getCarPartByName(partName).getPartID(), numUsed, price, service.getServiceID()));
                    } catch (NumberFormatException e) {
                        System.err.println("Numberic ERROR: " + e.getMessage());
                    }
                }
                request.setAttribute("responseMessage", "Create new service ticket successful");
            } else {
                request.setAttribute("responseMessage", "Create new service ticket failed! Try Again!!");
            }
            request.getRequestDispatcher("ViewServiceTicket?action=DETAIL&ticketID="+ serTicketID).forward(request, response);
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
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CreateServiceTicketServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CreateServiceTicketServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
