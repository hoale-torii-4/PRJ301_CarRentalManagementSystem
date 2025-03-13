package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.swing.text.html.HTML;
import model.CarParts;
import model.PartUsed;
import mylib.DBUtils;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author LENOVO
 */
public class CRUDPartCarDAO {

    public CarParts getCarPartByID(String partID) {
        CarParts carParts = new CarParts();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT [partID],[partName],[purchasePrice],[retailPrice]\n"
                        + "FROM [dbo].[Parts]\n"
                        + "WHERE [partID] LIKE ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, partID);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        String partId = table.getString("partID");
                        String pName = table.getString("partName");
                        double purchasePrice = table.getDouble("purchasePrice");
                        double retailPrice = table.getDouble("retailPrice");
                        carParts = new CarParts(partId, pName, purchasePrice, retailPrice);
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
        return carParts;
    }
    
    public CarParts getCarPartByName(String name) {
        CarParts carParts = new CarParts();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT [partID],[partName],[purchasePrice],[retailPrice]\n"
                        + "FROM [dbo].[Parts]\n"
                        + "WHERE [partName] LIKE ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, name);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        String partId = table.getString("partID");
                        String pName = table.getString("partName");
                        double purchasePrice = table.getDouble("purchasePrice");
                        double retailPrice = table.getDouble("retailPrice");
                        carParts = new CarParts(partId, pName, purchasePrice, retailPrice);
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
        return carParts;
    }
    
    public ArrayList<CarParts> getAllCarPart() {
        ArrayList<CarParts> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT [partID],[partName],[purchasePrice],[retailPrice]\n"
                        + "FROM [dbo].[Parts]\n"
                        + "WHERE status = 1";
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        String partId = table.getString("partID");
                        String pName = table.getString("partName");
                        double purchasePrice = table.getDouble("purchasePrice");
                        double retailPrice = table.getDouble("retailPrice");
                        list.add(new CarParts(partId, pName, purchasePrice, retailPrice));
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
        return list;
    }

    public boolean updateCarPart(CarParts carPart) {
        boolean isUpdated = false;
        Connection cn = null;
        PreparedStatement st = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "UPDATE [dbo].[Parts]"
                        + "SET [partName]=?,[purchasePrice]=?,[retailPrice]=?\n"
                        + "WHERE [partID] LIKE ?";
                st = cn.prepareStatement(sql);
                st.setString(1, carPart.getPartName());
                st.setDouble(2, carPart.getPurchasePrice());
                st.setDouble(3, carPart.getRetailPrice());
                st.setString(4, carPart.getPartID());

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

    public boolean CreateCarPart(CarParts newPart) {
        boolean isCreated = false;
        int newID = (int) (System.currentTimeMillis() % Integer.MAX_VALUE);
        try {
                Connection cn = DBUtils.getConnection();
                String sql = "INSERT INTO [dbo].[Parts] ([partID],[partName],[purchasePrice],[retailPrice])\n"
                        + "VALUES (?,?,?,?)";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, newID);
                st.setString(2, newPart.getPartName());
                st.setDouble(3, newPart.getPurchasePrice());
                st.setDouble(4, newPart.getRetailPrice());
                int row = st.executeUpdate();
                return row > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isCreated;
    }
    public boolean CreateCarPartUsed(PartUsed newPartUsed) {
        boolean isCreated = false;
        try {
                Connection cn = DBUtils.getConnection();
                String sql = "INSERT INTO [dbo].[PartsUsed] ([serviceTicketID],[partID],[numberUsed],[price])\n"
                        + "VALUES (?,?,?,?)";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, newPartUsed.getServiceTicketID());
                st.setString(2, newPartUsed.getPartID());
                st.setString(3, newPartUsed.getNumberUsed());
                st.setDouble(4, newPartUsed.getPrice());
                int row = st.executeUpdate();
                isCreated = row > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isCreated;
    }
    public boolean DeleteCarPart(String partID) {
        Connection cn = null;
        boolean isDelete = false;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "UPDATE [dbo].[Parts] SET [status] = 0\n"
                        + "WHERE [partID] LIKE ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1,"%"+ partID+"%");
                int rowsAffected = st.executeUpdate();
                if(rowsAffected > 0) isDelete = true;
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
