/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.CRUDCustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Customer;

/**
 *
 * @author hoang
 */
@WebServlet(name = "CRUDCustomerServlet", urlPatterns = {"/CRUDCustomerServlet"})
public class CRUDCustomerServlet extends HttpServlet {

    final String CREATE = "CREATE";
    final String UPDATE = "UPDATE";
    final String DELETE = "DELETE";
    String url = "ListCustomer.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String cRUDAction = request.getParameter("cRUDAction");
            CRUDCustomerDAO customerDAO = new CRUDCustomerDAO();
            String isCRUD = "Failed to ";
            String customerID = "";

            switch (cRUDAction) {
                case CREATE:
                    String name = request.getParameter("name");
                    String phone = request.getParameter("phone");
                    String sex = request.getParameter("sex");
                    String address = request.getParameter("address");

                    // Create new customer object
                    Customer newCustomer = new Customer(0, name, phone, sex, address);
                    int custID = customerDAO.addCustomer(newCustomer);

                    if (custID > 0) {
                        isCRUD = "Create new customer Successful!";
                        request.getSession().setAttribute("custId", custID);
                        // Redirect to ListCustomer.jsp with the customer ID and success message
                        response.sendRedirect("ListCustomer.jsp?success=customer_added&custId=" + custID);
                    } else {
                        isCRUD = "Create new customer failed! TRY AGAIN.";
                        response.sendRedirect("ListCustomer.jsp?error=add_failed");
                    }
                    break;

                case UPDATE:
                    try {
                        int id = Integer.parseInt(request.getParameter("id"));
                        Customer oldCustomer = customerDAO.getCustomerById(id);

                        if (oldCustomer == null) {
                            response.sendRedirect("ListCustomer.jsp?error=customer_not_found");
                            return;
                        }

                        name = request.getParameter("name");
                        phone = request.getParameter("phone");
                        sex = request.getParameter("sex");
                        address = request.getParameter("address");

                        if (name == null || name.trim().isEmpty()) {
                            name = oldCustomer.getCustName();
                        }
                        if (phone == null || phone.trim().isEmpty()) {
                            phone = oldCustomer.getPhone();
                        }
                        if (sex == null || sex.trim().isEmpty()) {
                            sex = oldCustomer.getSex();
                        }
                        if (address == null || address.trim().isEmpty()) {
                            address = oldCustomer.getCustAddress();
                        }

                        Customer updatedCustomer = new Customer(id, name, phone, sex, address);
                        boolean isUpdated = customerDAO.updateCustomer(updatedCustomer);

                        if (isUpdated) {
                            isCRUD = "Update customer Successful!";
                            response.sendRedirect("ListCustomer.jsp?success=update");
                            url = "UpdateCustomer.jsp";
                        } else {
                            isCRUD = "Update customer failed! TRY AGAIN.";
                            response.sendRedirect("ListCustomer.jsp?error=update_failed");
                        }
                    } catch (NumberFormatException e) {
                        e.printStackTrace();
                        response.sendRedirect("ListCustomer.jsp?error=invalid_id");
                    }
                    break;

                case DELETE:
                    try {
                        int id = Integer.parseInt(request.getParameter("id"));
                        boolean isDeleted = customerDAO.deleteCustomer(id);

                        if (isDeleted) {
                            isCRUD = "Delete customer ID " + id + " Successful!";
                            response.sendRedirect("ListCustomer.jsp?success=1");
                        } else {
                            isCRUD = "Delete customer ID " + id + " failed! TRY AGAIN.";
                            response.sendRedirect("ListCustomer.jsp?error=1");
                        }
                    } catch (NumberFormatException e) {
                        e.printStackTrace();
                        response.sendRedirect("ListCustomer.jsp?error=invalid_id");
                    }
                    break;

                default:
                    response.sendRedirect("ListCustomer.jsp?error=invalid_action");
                    break;
            }

            // Set the CRUD message
            request.setAttribute("isCRUD", isCRUD);
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
