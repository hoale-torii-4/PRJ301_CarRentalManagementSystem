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

        String custIdParam = request.getParameter("custId");
        Integer custId = null;

        // Kiểm tra custId có tồn tại không
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

        // Lấy thông tin khách hàng từ Database
        CRUDCustomerDAO customerDAO = new CRUDCustomerDAO();
        Customer customer = customerDAO.getCustomerById(custId);

        if (customer == null) {
            request.setAttribute("errorMessage", "Không tìm thấy khách hàng trong hệ thống!");
            request.getRequestDispatcher("CreateInvoice.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("custId", customer.getCustID());  
        String saleId = (String) session.getAttribute("salesID");

        // Kiểm tra saleId hợp lệ
        if (saleId == null || saleId.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Không tìm thấy ID nhân viên!");
            request.getRequestDispatcher("CreateInvoice.jsp").forward(request, response);
            return;
        }

        // Lấy thông tin khác từ request
        String date = request.getParameter("date");
        String carId = request.getParameter("carId");
        String priceParam = request.getParameter("price");

        if (date == null || date.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Ngày không được để trống!");
            request.getRequestDispatcher("CreateInvoice.jsp").forward(request, response);
            return;
        }

        if (carId == null || carId.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Không tìm thấy ID xe!");
            request.getRequestDispatcher("CreateInvoice.jsp").forward(request, response);
            return;
        }

        double price;
        try {
            price = Double.parseDouble(priceParam.trim());
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Giá không hợp lệ!");
            request.getRequestDispatcher("CreateInvoice.jsp").forward(request, response);
            return;
        }

        // Tạo hóa đơn mới
        SalesInvoice invoice = new SalesInvoice();
        invoice.setSalesId(saleId);
        invoice.setCustId(String.valueOf(customer.getCustID()));
        invoice.setPrice(price);
        invoice.setCarId(carId);
        invoice.setInvoiceDate(date);

        // Lưu hóa đơn vào Database
        SalesInvoiceDAO invoiceDAO = new SalesInvoiceDAO();
        boolean success = invoiceDAO.addInvoice(invoice);

        if (success) {
            System.out.println("✅ Hóa đơn đã được tạo thành công!");
            response.sendRedirect("ListCustomer.jsp?success=create_invoice");
        } else {
            System.out.println("❌ Lỗi khi tạo hóa đơn!");
            request.setAttribute("errorMessage", "Lỗi khi tạo hóa đơn. Vui lòng thử lại.");
            request.getRequestDispatcher("CreateInvoice.jsp").forward(request, response);
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
