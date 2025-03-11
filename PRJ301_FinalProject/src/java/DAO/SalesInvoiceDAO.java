package DAO;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import mylib.DBUtils;
import model.SalesInvoice;

public class SalesInvoiceDAO {

    public int generateNewInvoiceId() {
        long newId = System.currentTimeMillis(); 
        return (int) (newId % Integer.MAX_VALUE); 
    }

    public boolean addInvoice(SalesInvoice invoice) {
        String sql = "INSERT INTO SalesInvoice (invoiceID, invoiceDate, salesID, carID, price, custID) VALUES (?, ?, ?, ?, ?, ?)";

        // Generate a new invoice ID
        int newInvoiceId = generateNewInvoiceId();

        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            
            ps.setInt(1, newInvoiceId); 
            ps.setString(2, invoice.getInvoiceDate()); 
            ps.setString(3, invoice.getSalesId()); 
            
            try {
                ps.setString(4, invoice.getCarId());
                ps.setDouble(5, invoice.getPrice()); 
                ps.setString(6, invoice.getCustId()); 

            } catch (NumberFormatException e) {
                System.out.println("Invalid carId or custId format");
                return false;
            }

            return ps.executeUpdate() > 0;

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }
}
