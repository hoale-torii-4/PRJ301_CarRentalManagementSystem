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
        request.setCharacterEncoding(StandardCharsets.UTF_8.name());
        response.setContentType("text/html;charset=UTF-8");

        String name = request.getParameter("name");
        String selectedRole = request.getParameter("role");
        if (name != null) {
            HttpSession session = request.getSession(true);
            
            if ("SalePerson".equals(selectedRole)) {
                SalePersonDAO salePersonDAO = new SalePersonDAO();
                SalePerson salePerson = salePersonDAO.checkLogin(name);
                
                if (salePerson != null) {
                    session.setAttribute("user", salePerson.getName());
                    session.setAttribute("salesID", salePerson.getId()); 
                    session.setAttribute("salePerson", salePerson); 
                    session.setAttribute("role", "SalePerson");
                    response.sendRedirect("SalePersonDashboard.jsp");
                    return;
                }
            }
            
            if ("Mechanic".equals(selectedRole)) {
                MechanicDAO mechanicDAO = new MechanicDAO();
                Mechanic mechanic = mechanicDAO.checkLogin(name);
                
                if (mechanic != null) {
                    session.setAttribute("mechanic", mechanic);
                    session.setAttribute("user", mechanic.getName());
                    session.setAttribute("mechanicID", mechanic.getId());
                    session.setAttribute("role", "Mechanic");
                    response.sendRedirect("MechanicDashboard.jsp");
                    return;
                }
            }
            
            request.setAttribute("errorMessage", "Login failed: Invalid credentials or role selection!!!");
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
