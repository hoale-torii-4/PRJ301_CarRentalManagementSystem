package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import mylib.DBUtils;

public class CarDAO {

    public List<String> getCarSuggestions(String keyword) {
        List<String> suggestions = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            String sql = "SELECT serialNumber, model, year FROM Cars WHERE (model LIKE ? OR serialNumber LIKE ? OR year LIKE ?) AND status NOT LIKE 0";
            PreparedStatement stmt = cn.prepareStatement(sql);
            stmt.setString(1, "%" + keyword + "%");
            stmt.setString(2, "%" + keyword + "%");
            stmt.setString(3, "%" + keyword + "%");

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String carInfo = rs.getString("serialNumber") + " - " + rs.getString("model") + " (" + rs.getInt("year") + ")";
                suggestions.add(carInfo);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) cn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return suggestions;
    }

    public List<String> searchCars(String keyword) {
        List<String> searchResults = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            String sql = "SELECT serialNumber, model, year FROM Cars WHERE (model LIKE ? OR serialNumber LIKE ? OR year LIKE ?) AND status NOT LIKE 0";
            PreparedStatement stmt = cn.prepareStatement(sql);
            stmt.setString(1, "%" + keyword + "%");
            stmt.setString(2, "%" + keyword + "%");
            stmt.setString(3, "%" + keyword + "%");

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String carInfo = rs.getString("serialNumber") + " - " + rs.getString("model") + " (" + rs.getInt("year") + ")";
                searchResults.add(carInfo);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) cn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return searchResults;
    }
}
