package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.SalesInvoice;
import mylib.DBUtils;

public class InvoiceDAO {

    // Lấy tất cả hóa đơn từ bảng SalesInvoice
    public ArrayList<SalesInvoice> getAllInvoices() {
        ArrayList<SalesInvoice> invoices = new ArrayList<>();
        String sql = "SELECT invoiceID, invoiceDate, salesID, carID, custID FROM SalesInvoice";

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                SalesInvoice invoice = new SalesInvoice(
                        rs.getString("invoiceID"),
                        rs.getString("invoiceDate"),
                        rs.getString("salesID"),
                        rs.getString("carID"),
                        rs.getString("custID")
                );
                invoices.add(invoice);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return invoices;
    }

    // Tạo hóa đơn mới
    public boolean createInvoice(SalesInvoice invoice) {
        String sql = "INSERT INTO SalesInvoice (invoiceDate, salesID, carID, custID) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, invoice.getDate());
            stmt.setString(2, invoice.getSaleId());
            stmt.setString(3, invoice.getCarId());
            stmt.setString(4, invoice.getCustId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }
}
