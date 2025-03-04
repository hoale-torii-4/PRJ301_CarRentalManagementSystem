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

        int newInvoiceId = generateNewInvoiceId();

        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, newInvoiceId);

            ps.setString(2, invoice.getInvoiceDate());
            ps.setString(3, invoice.getInvoiceId());
            ps.setDouble(5, invoice.getPrice());

            try {
                BigDecimal carId = new BigDecimal(invoice.getCarId());
                ps.setBigDecimal(4, carId);
            } catch (NumberFormatException e) {
                System.out.println("Invalid carId format");
                return false;
            }

            try {
                BigDecimal custId = new BigDecimal(invoice.getCustId());
                ps.setBigDecimal(6, custId);
            } catch (NumberFormatException e) {
                System.out.println("Invalid custId format");
                return false;
            }

            return ps.executeUpdate() > 0;

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }
}
