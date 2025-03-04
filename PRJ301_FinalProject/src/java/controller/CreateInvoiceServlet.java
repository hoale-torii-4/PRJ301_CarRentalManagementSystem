package controller;

import DAO.CRUDCustomerDAO;
import DAO.SalesInvoiceDAO;
import model.SalesInvoice;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Customer;

public class CreateInvoiceServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // 1. Lấy thông tin khách hàng từ request
        String custIdParam = request.getParameter("custId");
        Integer custId = null;

        if (custIdParam == null || custIdParam.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Không tìm thấy ID khách hàng!");
            request.getRequestDispatcher("CreateInvoice.jsp").forward(request, response);
            return;
        }

        try {
            custId = Integer.parseInt(custIdParam);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "ID khách hàng không hợp lệ!");
            request.getRequestDispatcher("CreateInvoice.jsp").forward(request, response);
            return;
        }

        // ✅ Lấy thông tin khách hàng từ database
        CRUDCustomerDAO customerDAO = new CRUDCustomerDAO();
        Customer customer = customerDAO.getCustomerById(custId);

        if (customer == null) {
            request.setAttribute("errorMessage", "Không tìm thấy khách hàng!");
            request.getRequestDispatcher("CreateInvoice.jsp").forward(request, response);
            return;
        }

        // 2. Lấy ID nhân viên từ session
        HttpSession session = request.getSession();
        session.setAttribute("custId", customer.getCustID());  
        String saleId = (String) request.getSession().getAttribute("salesID");

        // Nếu không có salesID trong session, chuyển hướng về trang đăng nhập
        if (saleId == null || saleId.trim().isEmpty()) {
            // Chuyển hướng đến trang login và hiển thị thông báo lỗi
            response.sendRedirect("login.jsp?error=not_logged_in");
            return;
        }
        if (saleId == null) {
            request.setAttribute("errorMessage", "Lỗi: Không tìm thấy ID nhân viên!");
            request.getRequestDispatcher("CreateInvoice.jsp").forward(request, response);
            return;
        }

        // 3. Lấy các dữ liệu cần thiết từ form
        String date = request.getParameter("date");
        String carId = request.getParameter("carId"); // ID của xe
        if (carId == null || carId.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Không tìm thấy ID xe!");
            request.getRequestDispatcher("CreateInvoice.jsp").forward(request, response);
            return;
        }

        // ✅ Tạo đối tượng SalesInvoice
        SalesInvoice invoice = new SalesInvoice();
        invoice.setSaleId(saleId);
        invoice.setCustId(String.valueOf(customer.getCustID())); // Lưu lại dưới dạng String
        invoice.setCarId(carId);  
        invoice.setDate(date);
        
        // 4. Gọi DAO để lưu hóa đơn vào cơ sở dữ liệu
        SalesInvoiceDAO invoiceDAO = new SalesInvoiceDAO();
        boolean success = invoiceDAO.addInvoice(invoice);

        if (success) {
            // Nếu tạo hóa đơn thành công, chuyển hướng về ListCustomer.jsp và hiển thị thông báo thành công
            response.sendRedirect("ListCustomer.jsp?success=create_invoice");
        } else {
            // Nếu thất bại, chuyển hướng về ListCustomer.jsp và hiển thị thông báo lỗi
            response.sendRedirect("ListCustomer.jsp?error=create_invoice_failed");
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
        return "Servlet xử lý tạo hóa đơn";
    }
}
