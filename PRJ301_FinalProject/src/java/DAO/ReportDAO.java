/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import model.Mechanic;
import model.PartUsed;
import model.SalesInvoice;
import mylib.DBUtils;

/**
 *
 * @author LENOVO
 */
public class ReportDAO {

    public ArrayList<SalesInvoice> listInvoice(String year) {
        ArrayList<SalesInvoice> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT [invoiceID],[invoiceDate],[salesID],[carID],[custID],[status]\n"
                        + "FROM [dbo].[SalesInvoice]\n"
                        + "WHERE YEAR(invoiceDate) like ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, "%" + year + "%");
                ResultSet table = st.executeQuery();
                SalesInvoice si = new SalesInvoice();
                if (table != null) {
                    while (table.next()) {
                        if (table.getBoolean("status")) {
                            String invoiceId = table.getString("invoiceID");
                            String invoiceDate = table.getString("invoiceDate");
                            String salesID = table.getString("salesID");
                            String carID = table.getString("carID");
                            String custID = table.getString("custID");
                            si = new SalesInvoice(invoiceId, invoiceDate, salesID, carID, custID, custID);
                            list.add(si);
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

    public ArrayList<PartUsed> partUsedList() {
        Connection cn = null;
        ArrayList<PartUsed> partUList = new ArrayList<>();
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT [serviceTicketID],[partID],[numberUsed],[price],[status]\n"
                        + "FROM [dbo].[PartsUsed]\n"
                        + "ORDER BY numberUsed DESC";
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet table = st.executeQuery();
                PartUsed pu = new PartUsed();
                if (table != null) {
                    while (table.next()) {
                        if (table.getBoolean("status")) {
                            String serviceTicketID = table.getString("serviceTicketID");
                            String partID = table.getString("partID");
                            String numberUsed = table.getString("numberUsed");
                            double price = table.getDouble("price");
                            pu = new PartUsed(serviceTicketID, partID, numberUsed, price);
                            partUList.add(pu);
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
        return partUList;
    }

    public HashMap<Mechanic, Integer> ThreeMechanicID() {
//        ArrayList<Mechanic> listMechanic = new ArrayList<>();
        HashMap<Mechanic, Integer> mapMechanic = new HashMap<>();
        Connection cn = null;
//        Mechanic mechanic = new Mechanic();
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT TOP 3\n"
                        + "    ServiceMehanic.mechanicID, \n"
                        + "    Mechanic.mechanicName, \n"
                        + "    COUNT(ServiceMehanic.mechanicID) AS TOTAL,Mechanic.status\n"
                        + "FROM [dbo].[ServiceMehanic] \n"
                        + "JOIN [dbo].[Mechanic] ON ServiceMehanic.mechanicID = Mechanic.mechanicID\n"
                        + "GROUP BY ServiceMehanic.mechanicID, Mechanic.mechanicName, Mechanic.status\n"
                        + "ORDER BY TOTAL DESC;";
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        if (table.getBoolean("status")) {
                            String mechanicId = table.getString("mechanicID");
                            String name = table.getString("mechanicName");
                            int total = table.getInt("TOTAL");
                            mapMechanic.put(new Mechanic(mechanicId, name), total);
//                            listMechanic.add(mechanic);
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
        return mapMechanic;
    }
}
