/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Car;
import mylib.DBUtils;

/**
 *
 * @author hoang
 */
public class CarDAO {
    public ArrayList<Car> getAllCars() {
        ArrayList<Car> carList = new ArrayList<>();
        String sql = "SELECT carID, serialNumber, model, color, year FROM Cars";

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Car car = new Car(
                    rs.getString("carID"),
                    rs.getString("serialNumber"),
                    rs.getString("model"),
                    rs.getString("color"),
                    rs.getInt("year")
                );
                carList.add(car);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

       
        return carList;
    }

   
    public String getCarID(String model, String color, int year) {
        String carID = null;
        String sql = "SELECT carID FROM Cars WHERE model = ? AND color = ? AND year = ?";

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, model);
            stmt.setString(2, color);
            stmt.setInt(3, year);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                carID = rs.getString("carID");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return carID;
    }
}
