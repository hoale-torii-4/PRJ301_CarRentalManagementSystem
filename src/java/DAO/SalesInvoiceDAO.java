package DAO;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import mylib.DBUtils;
import model.SalesInvoice;

public class SalesInvoiceDAO {

    // Tạo ID hóa đơn mới
    public int generateNewInvoiceId() {
        String sql = "SELECT MAX(invoiceID) FROM SalesInvoice";
        int newId = 1; // Mặc định nếu bảng trống
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next() && rs.getObject(1) != null) { // Kiểm tra null trước khi lấy giá trị
                newId = rs.getInt(1) + 1;
            }
            
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return newId;
    }

    // Thêm hóa đơn vào database
    public boolean addInvoice(SalesInvoice invoice) {
        String sql = "INSERT INTO SalesInvoice (invoiceID, invoiceDate, salesID, carID, custID, status) VALUES (?, ?, ?, ?, ?, ?)";
        
        // Sử dụng ID hóa đơn mới
        int newInvoiceId = generateNewInvoiceId();

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            // Set các giá trị vào câu lệnh SQL
            ps.setInt(1, newInvoiceId); // Dùng ID tự tạo
            ps.setString(2, invoice.getDate());
            ps.setString(3, invoice.getSaleId());

            // Chuyển carId và custId sang BigDecimal
            try {
                BigDecimal carId = new BigDecimal(invoice.getCarId());
                ps.setBigDecimal(4, carId);
            } catch (NumberFormatException e) {
                System.out.println("Invalid carId format");
                return false; // Nếu carId không hợp lệ, trả về false
            }

            try {
                BigDecimal custId = new BigDecimal(invoice.getCustId());
                ps.setBigDecimal(5, custId);
            } catch (NumberFormatException e) {
                System.out.println("Invalid custId format");
                return false; // Nếu custId không hợp lệ, trả về false
            }

            // Nếu có cột 'status', có thể cần gán giá trị mặc định
            ps.setBoolean(6, true);  // Ví dụ: gán giá trị 'true' cho status (nếu cần)

            return ps.executeUpdate() > 0; // Trả về true nếu thêm thành công
            
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }
}
