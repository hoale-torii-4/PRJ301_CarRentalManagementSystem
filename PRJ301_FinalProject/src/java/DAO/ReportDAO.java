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
import model.Car;
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
                String sql = "SELECT [invoiceID],[invoiceDate],[salesID],[carID],[custID],[price],[status]\n"
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
                            double price = table.getDouble("price");
                            si = new SalesInvoice(invoiceId, invoiceDate, salesID, carID, custID, price);
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

//    public ArrayList<SalesInvoice> mapInvoice(String year) {
//        ArrayList<SalesInvoice> list = new ArrayList<>();
//        String sql = "SELECT [invoiceID],[invoiceDate],[salesID],[carID],[price],[custID]\n"
//                + "FROM [dbo].[SalesInvoice]\n"
//                + "WHERE YEAR([invoiceDate]) = ? AND [status]=1";
//
//        try (Connection cn = DBUtils.getConnection(); PreparedStatement st = cn.prepareStatement(sql)) {
//
//            st.setInt(1, Integer.parseInt(year));
//            try (ResultSet table = st.executeQuery()) {
//                while (table.next()) {                   
//                        String invoiceId = table.getString("invoiceID");
//                        String invoiceDate = table.getString("invoiceDate");
//                        String salesID = table.getString("salesID");
//                        String carID = table.getString("carID");
//                        String custID = table.getString("custID");
//                        double price = table.getDouble("price");
//                        SalesInvoice si = new SalesInvoice(invoiceId, invoiceDate, salesID, carID, custID,price);
//                        list.add(si);
//                }
//            }
//        } catch (Exception e) {
//            e.printStackTrace(); // Nên log lỗi thay vì in ra console trong môi trường sản xuất.
//        }
//
//        return list;
//    }

    public HashMap<Car, Integer> bestSellingCarModel() {
        HashMap<Car, Integer> map = new HashMap<>();
        String sql = "SELECT Cars.carID,Cars.serialNumber,Cars.model,Cars.colour,Cars.year,Cars.price,COUNT(SalesInvoice.carID) AS NumberOfCarSold\n"
                + "FROM SalesInvoice JOIN Cars ON SalesInvoice.carID = Cars.carID \n"
                + "WHERE SalesInvoice.status = 1\n"
                + "GROUP BY  Cars.carID,Cars.serialNumber,Cars.model,Cars.colour,Cars.year,Cars.price\n"
                + "ORDER BY NumberOfCarSold DESC";

        try (Connection cn = DBUtils.getConnection(); PreparedStatement st = cn.prepareStatement(sql)) {

            try (ResultSet table = st.executeQuery()) {
                while (table.next()) {
                    String carID = table.getString("carID");
                    String serialNumber = table.getString("serialNumber");
                    String model = table.getString("model");
                    String color = table.getString("colour");
                    int year = table.getInt("year");
                    double price = table.getDouble("price");
                    int carNumber = table.getInt("NumberOfCarSold");

                    Car car = new Car(carID, serialNumber, model, color, year, price);
                    map.put(car, carNumber);
                }
            }
        } catch (Exception e) {
            e.printStackTrace(); // Nên log lỗi thay vì in ra console trong môi trường sản xuất.
        }

        return map;
    }
}
