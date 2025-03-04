package controller;
import DAO.CRUDPartCarDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.CarParts;

public class CreatePartCarServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Lấy dữ liệu từ form
        String name = request.getParameter("txtname");
        String purchasePriceStr = request.getParameter("txtPurchasePrice");
        String retailPriceStr = request.getParameter("txtRetailPrice");
        String partID = "";

        // Kiểm tra dữ liệu nhập vào có rỗng không
        if (name == null || name.trim().isEmpty() || 
            purchasePriceStr == null || purchasePriceStr.trim().isEmpty() ||
            retailPriceStr == null || retailPriceStr.trim().isEmpty()) {
            
            request.setAttribute("updateMess", "Enter full infomation, PLS!");
            request.getRequestDispatcher("FindCarPart.jsp").forward(request, response);
            return;
        }

        double purchasePrice = 0;
        double retailPrice = 0;

        try {
            purchasePrice = Double.parseDouble(purchasePriceStr.trim());
            retailPrice = Double.parseDouble(retailPriceStr.trim());

            // Kiểm tra nếu giá âm
            if (purchasePrice < 0 || retailPrice < 0) {
                request.setAttribute("updateMess", "Value cannot be negative!");
                request.getRequestDispatcher("FindCarPart.jsp").forward(request, response);
                return;
            }

        } catch (NumberFormatException e) {
            request.setAttribute("updateMess", "Enter right value form pls!");
            request.getRequestDispatcher("FindCarPart.jsp").forward(request, response);
            return;
        }

        // Tạo đối tượng CarParts
        CarParts newParts = new CarParts(partID, name, purchasePrice, retailPrice);
        CRUDPartCarDAO partCarDAO = new CRUDPartCarDAO();

        // Lưu vào database
        if (partCarDAO.CreateCarPart(newParts)) {
            request.setAttribute("updateMess", "Created Part successfully!");
        } else {
            request.setAttribute("updateMess", "Created Part fail!");
        }

        // Chuyển hướng về trang FindCarPart.jsp
        request.getRequestDispatcher("FindCarPart.jsp").forward(request, response);
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
        return "Short description";
    }
}
