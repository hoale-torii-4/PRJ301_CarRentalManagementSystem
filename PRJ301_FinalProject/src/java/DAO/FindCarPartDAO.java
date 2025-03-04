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
import model.CarParts;
import mylib.DBUtils;

/**
 *
 * @author LENOVO
 */
public class FindCarPartDAO {

    public ArrayList<CarParts> getPartCar(String partName) {
        ArrayList<CarParts> partCarList = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT [partID],[partName],[purchasePrice],[retailPrice],[status]\n"
                        + "FROM [dbo].[Parts]\n"
                        + "WHERE [partName] LIKE ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, "%" + partName + "%");
                ResultSet table = st.executeQuery();
                CarParts c = new CarParts();
                if (table != null) {
                    while (table.next()) {
                        if (table.getBoolean("status")) {
                            String partId = table.getString("partID");
                            String pName = table.getString("partName");
                            double purchasePrice = table.getDouble("purchasePrice");
                            double retailPrice = table.getDouble("retailPrice");
                            c = new CarParts(partId, pName, purchasePrice, retailPrice);
                            partCarList.add(c);
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return partCarList;
    }

    public CarParts getPartCarById(String partID) {
        CarParts partCar = null;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT [partID],[partName],[purchasePrice],[retailPrice]\n"
                        + "FROM [dbo].[Parts]\n"
                        + "WHERE [partID]";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, "%" + partID + "%");
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        String partId = table.getString("partID");
                        String pName = table.getString("partName");
                        double purchasePrice = table.getDouble("purchasePrice");
                        double retailPrice = table.getDouble("retailPrice");
                        partCar = new CarParts(partId, pName, purchasePrice, retailPrice);

                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return partCar;
    }
}
