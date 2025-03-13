package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Car;
import mylib.DBUtils;

public class CarDAO {


    public List<String> getCarSuggestions1(String keyword) {
        List<String> suggestions = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            String sql = "SELECT carID, price, model,colour , year FROM Cars WHERE (model LIKE ? OR colour LIKE ? OR year LIKE ?) AND status NOT LIKE 0";
            PreparedStatement stmt = cn.prepareStatement(sql);
            stmt.setString(1, "%" + keyword + "%");
            stmt.setString(2, "%" + keyword + "%");
            stmt.setString(3, "%" + keyword + "%");

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {

                String carInfo = rs.getString("CarID") + " - "+rs.getString("price") + " - "+ rs.getString("colour")+ " - " + rs.getString("model") + " (" + rs.getInt("year") + ")";

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

    public List<Car> searchCars(String keyword) {
        List<Car> searchResults = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            String sql = "SELECT carID, serialNumber, model, colour, year, price FROM Cars WHERE (model LIKE ? OR serialNumber LIKE ? OR year LIKE ?) AND status NOT LIKE 0";
            PreparedStatement stmt = cn.prepareStatement(sql);
            stmt.setString(1, "%" + keyword + "%");
            stmt.setString(2, "%" + keyword + "%");
            stmt.setString(3, "%" + keyword + "%");

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String carID = rs.getString("carID");
                String serialNumber = rs.getString("serialNumber");
                String model = rs.getString("model");
                String colour = rs.getString("colour");
                int year = rs.getInt("year");
                double price = rs.getDouble("price");
                searchResults.add(new Car(carID, serialNumber, model, colour, year, price));
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
    public Car searchCarByModelByColor(String model, String color) {
        Car car = new Car();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            String sql = "SELECT carID, serialNumber, model, colour, year, price FROM Cars WHERE (model LIKE ? AND colour LIKE ?) AND status NOT LIKE 0";
            PreparedStatement stmt = cn.prepareStatement(sql);
            stmt.setString(1, "%" + model + "%");
            stmt.setString(2, "%" + color + "%");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String carID = rs.getString("carID");
                String serialNumber = rs.getString("serialNumber");
                int year = rs.getInt("year");
                double price = rs.getDouble("price");
                car = new Car(carID, serialNumber, model, color, year, price);
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
        return car;
    }



    public List<String> getCarSuggestions(String keyword) {
        List<String> suggestions = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            String sql = "SELECT serialNumber, model, colour, year FROM Cars WHERE (model LIKE ? OR serialNumber LIKE ? OR year LIKE ?) AND status NOT LIKE 0";
            PreparedStatement stmt = cn.prepareStatement(sql);
            stmt.setString(1, "%" + keyword + "%");
            stmt.setString(2, "%" + keyword + "%");
            stmt.setString(3, "%" + keyword + "%");

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String carInfo = rs.getString("serialNumber") + " - " + rs.getString("model") + " - " + rs.getString("colour")+" - " + rs.getInt("year") ;
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

    
}

