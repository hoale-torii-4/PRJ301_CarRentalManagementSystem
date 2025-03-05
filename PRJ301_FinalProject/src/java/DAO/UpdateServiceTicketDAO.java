/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import model.ServiceMechanic;
import mylib.DBUtils;

/**
 *
 * @author LENOVO
 */
public class UpdateServiceTicketDAO {

    public HashMap<ServiceMechanic, String> mapServiceMeGetServiceName() {
        Connection cn = null;
        HashMap<ServiceMechanic, String> map = new HashMap<>();
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT ServiceMehanic.serviceTicketID,ServiceMehanic.serviceID,ServiceMehanic.mechanicID,ServiceMehanic.hours,ServiceMehanic.comment,ServiceMehanic.rate,Service.serviceName,ServiceMehanic.status\n"
                        + "FROM [dbo].[ServiceMehanic] join [dbo].[Service] ON ServiceMehanic.serviceID = Service.serviceID";
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        if (table.getBoolean("status")) {
                            String serviceTicketID = table.getString("serviceTicketID");
                            String serviceID = table.getString("serviceID");
                            String mechanicID = table.getString("mechanicID");
                            int hour = table.getInt("hours");
                            String comment = table.getString("comment");
                            double rate = table.getDouble("rate");
                            String serviceName = table.getString("serviceName");
                            map.put(new ServiceMechanic(serviceTicketID, serviceID, mechanicID, hour, comment, rate), serviceName);
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
        return map;
    }

    public HashMap<ServiceMechanic, String> mapServiceMeGetMechanicName() {
        Connection cn = null;
        HashMap<ServiceMechanic, String> map = new HashMap<>();
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT ServiceMehanic.serviceTicketID,ServiceMehanic.serviceID,ServiceMehanic.mechanicID,ServiceMehanic.hours,ServiceMehanic.comment,ServiceMehanic.rate,Mechanic.mechanicName,ServiceMehanic.status\n"
                        + "FROM [dbo].[ServiceMehanic] join [dbo].[Mechanic] ON ServiceMehanic.mechanicID = Mechanic.mechanicID";
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        if (table.getBoolean("status")) {
                            String serviceTicketID = table.getString("serviceTicketID");
                            String serviceID = table.getString("serviceID");
                            String mechanicID = table.getString("mechanicID");
                            int hour = table.getInt("hours");
                            String comment = table.getString("comment");
                            double rate = table.getDouble("rate");
                            String mechanicName = table.getString("mechanicName");
                            map.put(new ServiceMechanic(serviceTicketID, serviceID, mechanicID, hour, comment, rate), mechanicName);
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
        return map;
    }
    
    public HashMap<ServiceMechanic, String>[] getServiceMechanicDetails(String mechanicID) {
    Connection cn = null;
    HashMap<ServiceMechanic, String> mapServiceName = new HashMap<>();
    HashMap<ServiceMechanic, String> mapMechanicName = new HashMap<>();

    try {
        cn = DBUtils.getConnection();
        if (cn != null) {
            String sql = "SELECT sm.serviceTicketID, sm.serviceID, sm.mechanicID, sm.hours, "
                       + "sm.comment, sm.rate, s.serviceName, m.mechanicName, sm.status "
                       + "FROM ServiceMehanic sm "
                       + "JOIN Service s ON sm.serviceID = s.serviceID "
                       + "JOIN Mechanic m ON sm.mechanicID = m.mechanicID "
                       + "WHERE sm.mechanicID LIKE ?";

            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, "%"+mechanicID+"%");
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                if (rs.getBoolean("status")) {
                    ServiceMechanic sm = new ServiceMechanic(
                        rs.getString("serviceTicketID"),
                        rs.getString("serviceID"),
                        rs.getString("mechanicID"),
                        rs.getInt("hours"),
                        rs.getString("comment"),
                        rs.getDouble("rate")
                    );

                    String serviceName = rs.getString("serviceName");
                    String mechanicName = rs.getString("mechanicName");

                    mapServiceName.put(sm, serviceName);
                    mapMechanicName.put(sm, mechanicName);
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

    return new HashMap[]{mapServiceName, mapMechanicName};
}

}
