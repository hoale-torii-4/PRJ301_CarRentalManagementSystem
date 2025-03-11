/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import DAO.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Customer;

/**
 *
 * @author Hoa le
 */
public class LoginCustomerServlet extends HttpServlet {

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
           out.print(request.getAttribute("LoginFailed"));
           request.setCharacterEncoding("utf-8");
           String name=request.getParameter("custName");
           String phone=request.getParameter("custPhone");
           if(name!=null && phone!=null){
               //check token trong requst cua client truoc
               Cookie[] cookies=request.getCookies();
               boolean found=false;
               String token="";
               if(cookies!=null){
                   for (Cookie c : cookies) {
                       if(c.getName().equals("token")){
                          found=true;
                          token=c.getValue();
                     }
                   }
               }
               if(found){
                   HttpSession s=request.getSession(true);
                   s.setAttribute("user2",token);                   
                   response.sendRedirect("CustomerDashboardPage.jsp");
               }
               else{
               //neu ko co token thi moi check trong DB
                   CustomerDAO d = new CustomerDAO();
                   Customer kq = d.checkLogin(name, phone);
                   if (kq == null) {
                       //response.sendRedirect("error.html");
                       request.setAttribute("FailedLogin", "Login Failed!!! Try again!");
                       request.getRequestDispatcher("LoginCustomerPage.jsp").forward(request, response);
                   } else {
                       HttpSession s = request.getSession(true);
                       s.setAttribute("user", kq);
                       String save=request.getParameter("custSave");
                       if (save!=null && save.equalsIgnoreCase("Save")) {
                           Cookie cookie = new Cookie("token",  URLEncoder.encode(kq.getCustName(), "UTF-8"));
                           cookie.setMaxAge(3000); 
                           response.addCookie(cookie);
                       }
                       response.sendRedirect("CustomerDashboardPage.jsp");
                       
                   }
               }
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
