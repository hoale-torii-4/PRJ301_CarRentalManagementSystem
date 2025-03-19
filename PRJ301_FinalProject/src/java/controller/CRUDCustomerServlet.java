/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
    final String SEARCH = "SEARCH";
    String url = "ListCustomer.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String cRUDAction = request.getParameter("cRUDAction");
            CustomerDAO customerDAO = new CustomerDAO();
            String isCRUD = "Failed to ";
            String customerID = "";

            switch (cRUDAction) {
                case CREATE:
                    String name = request.getParameter("name");
                    String phone = request.getParameter("phone");
                    String sex = request.getParameter("sex");
                    String address = request.getParameter("address");
                    Customer newCustomer = new Customer(0, name, phone, sex, address);
                    int custID = customerDAO.addCustomer(newCustomer);

                    if (custID > 0) {
                        isCRUD = "Create new customer successful!";
                        request.getSession().setAttribute("custId", custID);
                    } else {
                        isCRUD = "Create new customer failed! TRY AGAIN.";
                    }

                    request.setAttribute("isCRUD", isCRUD);
                    ArrayList<Customer> customerList = customerDAO.getCustomers();
                    request.setAttribute("customer", customerList);
                    request.getRequestDispatcher("ListCustomer.jsp").forward(request, response);
                    break;

                case UPDATE:
                    try {
                        int id = Integer.parseInt(request.getParameter("id"));
                        Customer Customer = customerDAO.getCustomerById(id);

                        if (Customer == null) {
                            response.sendRedirect("ListCustomer.jsp?error=customer_not_found");
                            return;
                        }

                        name = request.getParameter("name");
                        phone = request.getParameter("phone");
                        sex = request.getParameter("sex");
                        address = request.getParameter("address");

                        if (name == null || name.trim().isEmpty()) {
                            name = Customer.getCustName();
                        }
                        if (phone == null || phone.trim().isEmpty()) {
                            phone = Customer.getPhone();
                        }
                        if (sex == null || sex.trim().isEmpty()) {
                            sex = Customer.getSex();
                        }
                        if (address == null || address.trim().isEmpty()) {
                            address = Customer.getCustAddress();
                        }

                        Customer updatedCustomer = new Customer(id, name, phone, sex, address);
                        boolean isUpdated = customerDAO.updateCustomer(updatedCustomer);

                        if (isUpdated) {
                            isCRUD = "Update customer Successful!";
                            request.setAttribute("isCRUD", isCRUD);
                            request.getRequestDispatcher("CRUDCustomerServlet?cRUDAction=SEARCH&name=" + name).forward(request, response);
                        } else {
                            isCRUD = "Update customer failed! TRY AGAIN.";
                            request.setAttribute("isCRUD", isCRUD);
                            response.sendRedirect("ListCustomer.jsp?error=update_failed");
                        }
                    } catch (NumberFormatException e) {
                        e.printStackTrace();
                        request.setAttribute("errorMess", "Wrong id format!");
                        request.getRequestDispatcher("ErrorPage.jsp").forward(request, response);
                    }
                    break;

                case DELETE:
                    try {
                        int id = Integer.parseInt(request.getParameter("CustId"));
                        boolean isDeleted = customerDAO.deleteCustomer(id);

                        if (isDeleted) {
                            isCRUD = "Delete customer successful!";
                        } else {
                            isCRUD = "Delete customer ID " + id + " failed! TRY AGAIN.";
                        }

                        request.setAttribute("isCRUD", isCRUD);

                        ArrayList<Customer> newList = customerDAO.getCustomers();
                        request.setAttribute("customer", newList);
                        request.getRequestDispatcher("ListCustomer.jsp").forward(request, response);

                    } catch (NumberFormatException e) {
                        e.printStackTrace();
                        request.setAttribute("isCRUD", "Invalid customer ID!");
                        request.setAttribute("errorMess", "Somethings wrong!");
                        request.getRequestDispatcher("ErrorPage.jsp").forward(request, response);
                    }
                    break;
                case SEARCH:
                    try {
                        name = request.getParameter("name");
                        CustomerDAO Fincust = new CustomerDAO();
                        ArrayList<Customer> customer = Fincust.searchCustomersByName(name);
                        request.setAttribute("customer", customer);

                        request.getRequestDispatcher("ListCustomer.jsp").forward(request, response);

                    } catch (Exception e) {
                        e.printStackTrace();
                        request.setAttribute("errorMess", "Somethings wrong!");
                        request.getRequestDispatcher("ErrorPage.jsp").forward(request, response);;
                    }
                    break;

                default:
                    response.sendRedirect("ListCustomer.jsp?error=invalid_action");
                    break;
            }

        } catch (Exception e) {
            request.setAttribute("errorMess", "Somethings wrong!");
            request.getRequestDispatcher("ErrorPage.jsp").forward(request, response);
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
