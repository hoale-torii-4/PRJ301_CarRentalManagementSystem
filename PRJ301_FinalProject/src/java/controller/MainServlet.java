package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MainServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // ✅ Check if the request was already forwarded to prevent looping
        if (request.getAttribute("alreadyForwarded") != null) {
            return;
        }
        request.setAttribute("alreadyForwarded", true);

        // ✅ Read action from request parameter
        String action = request.getParameter("action");
        if (action == null) action = "home";

        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");

        String url;
        switch (action) {
            case "home":
                url = "index.jsp";
                break;
            case "login":
                // ✅ Forward login requests to LoginStaffServlet only if not already forwarded
                request.getRequestDispatcher("LoginStaffServlet").forward(request, response);
                return;
            case "dashboard":
                if ("SalePerson".equals(role)) {
                    url = "SalePersonDashboard.jsp";
                } else if ("Mechanic".equals(role)) {
                    url = "MechanicDashboard.jsp";
                } else {
                    url = "LoginStaffPage.jsp";
                }
                break;
            default:
                url = "index.jsp";
                break;
        }

        request.getRequestDispatcher(url).forward(request, response);
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
        return "Main servlet handling navigation";
    }
}
