package controller;

import DAO.MechanicDAO;
import DAO.SalePersonDAO;
import model.Mechanic;
import model.SalePerson;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.Normalizer;

public class LoginStaffServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding(StandardCharsets.UTF_8.name()); // ✅ Ensure UTF-8
        response.setContentType("text/html;charset=UTF-8");

        String name = request.getParameter("name");
        String selectedRole = request.getParameter("role");
        if (name != null) {
            SalePersonDAO salePersonDAO = new SalePersonDAO();
            SalePerson salePerson = salePersonDAO.checkLogin(name);
            
            if (salePerson != null) {
                if (!"SalePerson".equals(selectedRole)) {
                    request.setAttribute("errorMessage", "Login failed: Incorrect role selected");
                    request.getRequestDispatcher("LoginStaffPage.jsp").forward(request, response);
                    return;
                }
                HttpSession session = request.getSession(true);
                session.setAttribute("user", salePerson.getName());
                session.setAttribute("role", "SalePerson");
                response.sendRedirect("MainServlet?action=home");
                return;
            }
            
            MechanicDAO mechanicDAO = new MechanicDAO();
            Mechanic mechanic = mechanicDAO.checkLogin(name);
            
            if (mechanic != null) {
                if (!"Mechanic".equals(selectedRole)) {
                    request.setAttribute("errorMessage", "Login failed: Incorrect role selected");
                    request.getRequestDispatcher("LoginStaffPage.jsp").forward(request, response);
                    return;
                }
                HttpSession session = request.getSession(true);
                session.setAttribute("user", mechanic.getName());
                session.setAttribute("role", "Mechanic");
                response.sendRedirect("MainServlet?action=home");
                return;
            }
            
            System.out.println("❌ Login failed: No matching user found");
            request.setAttribute("errorMessage", "Login failed: Invalid Name");
            request.getRequestDispatcher("LoginStaffPage.jsp").forward(request, response);
        }
    }

    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet handling staff login and forwarding to MainServlet";
    }
}
