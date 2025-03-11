package controller;

import DAO.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Customer;

public class ChangeProfileCustomerServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            
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
    response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");


    try (PrintWriter out = response.getWriter()) {
        // Lấy custID từ request parameter
        String custIDStr = request.getParameter("cusID");
        Customer customer = new Customer();
        CustomerDAO cusDAO  =new CustomerDAO();

        if (custIDStr != null && !custIDStr.isEmpty()) {
            int custID = Integer.parseInt(custIDStr);
            customer = cusDAO.getCustomer(custID);
            String newName = request.getParameter("newName").trim();
            String newPhone = request.getParameter("newPhone").trim();
            String newSex = request.getParameter("newSex").trim();
            String newAddress = request.getParameter("newAddress").trim();
            if(newName.length()==0)
                newName = customer.getCustName();
            if( newPhone.length()==0)
                newPhone = customer.getPhone();
            if( newSex.length()==0)
                newSex = customer.getSex();
            if( newAddress.length()==0)
                newAddress = customer.getCustAddress();
            if(cusDAO.isUpdateCustomerInformation(custID, newName, newPhone, newSex, newAddress)==true)
                request.setAttribute("RESULT", "done");
            else request.setAttribute("RESULT", "failed");
            
        HttpSession s = request.getSession();
        s.removeAttribute("user");
        s.setAttribute("user", cusDAO.getCustomer(custID));
                
                
        } else {
            out.print("Customer ID is missing!");
        }
request.getRequestDispatcher("CustomerDashboardPage.jsp").forward(request, response);
    }
}


    @Override
    public String getServletInfo() {
        return "Handles customer profile changes";
    }
}
