/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Car;
import mylib.DBUtils;

/**
 *
 * @author HOA LE
 */
public class CRUDSearchCarDAO {

    public Car getCarByID(String cartID) {
        Car car = new Car();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT [carID]\n"
                        + ",[serialNumber]\n"
                        + ",[model]\n"
                        + ",[colour]\n"
                        + ",[year]\n"
                        + ",[price]\n"
                        + "FROM [dbo].[Cars]\n"
                        + "WHERE [carID] LIKE ? AND status LIKE 1";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, cartID);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                            String cartId = table.getString("carID");
                            String serialNumber = table.getString("serialNumber");
                            String model = table.getString("model");
                            String colour = table.getString("colour");
                            String price =  table.getString("price");
                            int year = table.getInt("year");
                            car = new Car(cartId, serialNumber, model, colour, year, price);
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
        return car;
    }

    public boolean isUpdateCar(Car car) {
        boolean isUpdated = false;
        Connection cn = null;
        PreparedStatement st = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "UPDATE [dbo].[Cars]\n"
                        + "   SET [serialNumber] = ?"
                        + "      ,[model] = ?"
                        + "      ,[colour] = ?"
                        + "      ,[year] = ?"
                        +"       ,[price] = ?"
                        + " WHERE [carID] LIKE ? AND status LIKE 1";
                st = cn.prepareStatement(sql);
                st.setString(1, car.getSerialNumber());
                st.setString(2, car.getModel());
                st.setString(3, car.getColour());
                st.setInt(4, car.getYear());
                st.setString(5, car.getPrice());
                st.setString(6, car.getCarId());
                int rowsAffected = st.executeUpdate();
                if (rowsAffected > 0) {
                    isUpdated = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (st != null) {
                    st.close();
                }
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return isUpdated;
    }

    public boolean isCreateCar(Car newCar) {
        boolean isCreated = false;
        int newID = 0;
        try {
            Connection cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT TOP 1 [carID]\n"
                        + "FROM [dbo].[Cars]\n"
                        + "ORDER BY [carID] DESC";
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet rs = st.executeQuery();
                if (rs.next()) {
                    newID = rs.getInt("carID") + 1;
                }

                sql = "INSERT [dbo].[Cars] ([carID], [serialNumber], [model], [colour], [year],[price])\n"
                        + "VALUES (?,?,?,?,?,?)";
                st = cn.prepareStatement(sql);
                st.setInt(1,  newID );
                st.setString(2, newCar.getSerialNumber());
                st.setString(3, newCar.getModel());
                st.setString(4, newCar.getColour());
                st.setInt(5, newCar.getYear());
                st.setString(6, newCar.getPrice());
                int row = st.executeUpdate();
                return row > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isCreated;
    }

    public boolean isDeleteCar(String carID) {
        Connection cn = null;
        boolean isDelete = false;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "UPDATE [dbo].[Cars] SET [status] = 0\n"
                        + "WHERE [carID] LIKE ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, "%" + carID + "%");
                int rowsAffected = st.executeUpdate();
                if (rowsAffected > 0) {
                    isDelete = true;
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
        return isDelete;
    }
}
