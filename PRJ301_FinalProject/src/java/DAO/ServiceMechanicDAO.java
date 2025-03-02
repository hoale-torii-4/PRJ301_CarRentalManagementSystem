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
                if(table != null){
                    while(table.next()){
                        if(table.getBoolean("status")){
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
}
