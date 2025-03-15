/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.ServiceMechanic;
import mylib.DBUtils;

/**
 *
 * @author LENOVO
 */
public class ServiceMechanicDAO {

    public ArrayList<ServiceMechanic> listServiceMechanic() {
        Connection cn = null;
        ArrayList<ServiceMechanic> list = new ArrayList<>();
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT [serviceTicketID],[serviceID],[mechanicID],[hours],[comment],[rate],[status]\n"
                        + "FROM[dbo].[ServiceMehanic]";
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet table = st.executeQuery();
                ServiceMechanic sm = null;
                if (table != null) {
                    while (table.next()) {
                        if (table.getBoolean("status")) {
                            String serviceTicketID = table.getString("serviceTicketID");
                            String serviceID = table.getString("serviceID");
                            String mechanicID = table.getString("mechanicID");
                            int hours = table.getInt("hours");
                            String comment = table.getString("comment");
                            double rate = table.getDouble("rate");
                            sm = new ServiceMechanic(serviceTicketID, serviceID, mechanicID, hours, comment, rate);
                            list.add(sm);
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
        return list;
    }

    public boolean CreateServiceMechanic(ServiceMechanic newSerMec) {
        boolean isCreated = false;
        try {
            Connection cn = DBUtils.getConnection();
            String sql = "INSERT INTO [dbo].[ServiceMehanic]"
                    + "           ([serviceTicketID]"
                    + "           ,[serviceID]"
                    + "           ,[mechanicID]"
                    + "           ,[hours]"
                    + "           ,[comment]"
                    + "           ,[rate])"
                    + "     VALUES"
                    + "           (?,?,?,?,?,?)\n";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, newSerMec.getServiceTicketID());
            st.setString(2, newSerMec.getServiceID());
            st.setString(3, newSerMec.getMechanicID());
            st.setInt(4, newSerMec.getHour());
            st.setString(5, newSerMec.getComment());
            st.setDouble(6, newSerMec.getRate());
            int row = st.executeUpdate();
            if(row>0)
                isCreated = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return isCreated;
    }

    public boolean UpdateServiceMechanic(String serviceTicketID, String serviceID , int hour, String comment, double rate) {
        boolean isUpdate = false;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "UPDATE [dbo].[ServiceMehanic]\n"
                        + "SET [hours]=?,[comment]=?,[rate]=?\n"
                        + "WHERE [serviceTicketID] LIKE ? AND serviceID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, hour);
                st.setString(2, comment);
                st.setDouble(3, rate);
                st.setString(4, serviceTicketID);
                st.setString(5, serviceID);
                int row = st.executeUpdate();
                if (row > 0) {
                    isUpdate = true;
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

        return isUpdate;
    }
}
