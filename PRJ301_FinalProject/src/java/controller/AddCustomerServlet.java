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
@WebServlet(name = "AddCustomerServlet", urlPatterns = {"/AddCustomer"})
public class AddCustomerServlet extends HttpServlet {

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
            try {
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String sex = request.getParameter("sex");
            String address = request.getParameter("address");

            CRUDCustomerDAO customerDAO = new CRUDCustomerDAO();
            Customer newCustomer = new Customer(0, name, phone, sex, address);
            
            int custID = customerDAO.addCustomer(newCustomer);

           if (custID > 0) {
                    // Lưu custID vào session
                    request.getSession().setAttribute("custId", custID);
                    // Chuyển hướng về CreateInvoice.jsp và truyền thông báo thành công
                    response.sendRedirect("CreateInvoice.jsp?success=customer_added");
                } else {
                    // Chuyển hướng về ListCustomer.jsp với thông báo lỗi
                    response.sendRedirect("ListCustomer.jsp?error=add_failed");
                }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ListCustomer.jsp?error=invalid_data");
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
