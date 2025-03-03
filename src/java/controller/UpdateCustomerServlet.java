/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.CRUDCustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Customer;

/**
 *
 * @author hoang
 */
public class UpdateCustomerServlet extends HttpServlet {

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
            try {
            int id = Integer.parseInt(request.getParameter("id"));
            CRUDCustomerDAO customerDAO = new CRUDCustomerDAO();
            Customer oldCustomer = customerDAO.getCustomerById(id); // Lấy thông tin cũ từ database

            if (oldCustomer == null) {
                response.sendRedirect("ListCustomer.jsp?error=customer_not_found");
                return;
            }

            // Nhận dữ liệu mới từ form
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String sex = request.getParameter("sex");
            String address = request.getParameter("address");

            // Nếu một trường trống, giữ nguyên giá trị cũ
            if (name == null || name.trim().isEmpty()) name = oldCustomer.getCustName();
            if (phone == null || phone.trim().isEmpty()) phone = oldCustomer.getPhone();
            if (sex == null || sex.trim().isEmpty()) sex = oldCustomer.getSex();
            if (address == null || address.trim().isEmpty()) address = oldCustomer.getCustAddress();

            
            // Tạo đối tượng khách hàng mới
            Customer updatedCustomer = new Customer(id, name, phone, sex, address);
            boolean isUpdated = customerDAO.updateCustomer(updatedCustomer);

            if (isUpdated) {
                response.sendRedirect("ListCustomer.jsp?success=update");
            } else {
                response.sendRedirect("ListCustomer.jsp?error=update_failed");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("ListCustomer.jsp?error=invalid_id");
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
