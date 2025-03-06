/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import model.Car;
import model.SaleInvoiceDetail;
import model.SalesInvoice;
import model.ServiceMechanic;
import mylib.DBUtils;

/**
 *
 * @author LENOVO
 */
public class CustomerInvoiceDAO {

    public HashMap<SalesInvoice, String>[] customerInvoice(String customerId) {
        Connection cn = null;
        HashMap<SalesInvoice, String> mapSaleName = new HashMap<>();
        HashMap<SalesInvoice, String> mapCarName = new HashMap<>();
        HashMap<SalesInvoice, String> mapCusName = new HashMap<>();

        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT SL.invoiceID,SL.invoiceDate,SL.salesID,SL.carID,SL.price,SL.custID,CA.model,CU.custName,SP.salesName\n"
                        + "FROM [dbo].[SalesInvoice] SL JOIN [dbo].[Cars] CA ON SL.carID = CA.carID \n"
                        + "     JOIN [dbo].[Customer] CU ON SL.custID = CU.custID JOIN [dbo].[SalesPerson] SP\n"
                        + "     ON SL.salesID = SP.salesID\n"
                        + "WHERE CU.custID LIKE ? AND SL.status = 1";

                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, customerId);
                ResultSet rs = st.executeQuery();

                while (rs.next()) {

                    SalesInvoice si = new SalesInvoice(
                            rs.getString("invoiceID"),
                            rs.getString("invoiceDate"),
                            rs.getString("salesID"),
                            rs.getString("carID"),
                            rs.getString("custID"),
                            rs.getDouble("price")
                    );

                    String saleName = rs.getString("salesName");
                    String custName = rs.getString("custName");
                    String model = rs.getString("model");

                    mapCarName.put(si, model);
                    mapCusName.put(si, custName);
                    mapSaleName.put(si, saleName);
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
        return new HashMap[]{mapSaleName, mapCarName, mapCusName};
    }

    public ArrayList<Car> getCarByCustId(String customerID) {
        Connection cn = null;
        ArrayList<Car> carList = new ArrayList<>();
        try {
            cn = DBUtils.getConnection();
            Car car = null;
            if (cn != null) {
                String sql = "SELECT ca.carID,ca.colour,ca.model,ca.price,ca.serialNumber,ca.year\n"
                        + "FROM[dbo].[Cars] ca join [dbo].[SalesInvoice] si on ca.carID = si.carID\n"
                        + "WHERE si.customerID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, customerID);
                ResultSet table = st.executeQuery();
                while (table.next()) {
                    String carId = table.getString("carID");
                    String serialNumber = table.getString("serialNumber");
                    String model = table.getString("model");
                    String color = table.getString("colour");
                    int year = table.getInt("year");
                    double price = table.getDouble("price");
                    car = new Car(carId, serialNumber, model, color, year, price);
                    carList.add(car);
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
        return carList;
    }

    public ArrayList<SaleInvoiceDetail> getInvoiceDetail(String customerId) {
        ArrayList<SaleInvoiceDetail> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT \n"
                        + "    si.invoiceID, \n"
                        + "    si.invoiceDate, \n"
                        + "    si.price AS invoicePrice, \n"
                        + "    ca.carID, \n"
                        + "    ca.serialNumber, \n"
                        + "    ca.model, \n"
                        + "    ca.colour, \n"
                        + "    ca.year, \n"
                        + "    cu.custName, \n"
                        + "    cu.phone, \n"
                        + "    cu.sex, \n"
                        + "    cu.cusAddress, \n"
                        + "    sp.salesName, \n"
                        + "    sp.sex AS salesSex\n"
                        + "FROM SalesInvoice si\n"
                        + "JOIN Cars ca ON si.carID = ca.carID\n"
                        + "JOIN Customer cu ON si.custID = cu.custID\n"
                        + "JOIN SalesPerson sp ON si.salesID = sp.salesID\n"
                        + "WHERE si.custID = ? and si.status = 1";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, customerId);
                ResultSet table = st.executeQuery();
                while (table.next()) {
                    String invoiceID = table.getString("invoiceID");
                    String invoiceDate = table.getString("invoiceDate");
                    double invoicePrice = table.getDouble("invoicePrice");

                    String serialNumber = table.getString("serialNumber");
                    String model = table.getString("model");
                    String colour = table.getString("colour");
                    int year = table.getInt("year");

                    String custName = table.getString("custName");
                    String phone = table.getString("phone");
                    String sex =table.getString("sex");
                    String cusAddress = table.getString("cusAddress");

                    String salesName = table.getString("salesName");
                    String salesSex =table.getString("salesSex");
                    SaleInvoiceDetail sidetail = new SaleInvoiceDetail(invoiceID, invoiceDate, invoicePrice, serialNumber, model, colour, year, custName, phone, sex, cusAddress, salesName, salesSex);
                    list.add(sidetail);
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
    
    public ArrayList<SaleInvoiceDetail> invoiceDetailByInvoiceID(String invoiceID) {
        ArrayList<SaleInvoiceDetail> list = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT \n"
                        + "    si.invoiceID, \n"
                        + "    si.invoiceDate, \n"
                        + "    si.price AS invoicePrice, \n"
                        + "    ca.carID, \n"
                        + "    ca.serialNumber, \n"
                        + "    ca.model, \n"
                        + "    ca.colour, \n"
                        + "    ca.year, \n"
                        + "    cu.custName, \n"
                        + "    cu.phone, \n"
                        + "    cu.sex, \n"
                        + "    cu.cusAddress, \n"
                        + "    sp.salesName, \n"
                        + "    sp.sex AS salesSex\n"
                        + "FROM SalesInvoice si\n"
                        + "JOIN Cars ca ON si.carID = ca.carID\n"
                        + "JOIN Customer cu ON si.custID = cu.custID\n"
                        + "JOIN SalesPerson sp ON si.salesID = sp.salesID\n"
                        + "WHERE si.invoiceID = ? and si.status = 1";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, invoiceID);
                ResultSet table = st.executeQuery();
                while (table.next()) {
                    String ID = table.getString("invoiceID");
                    String invoiceDate = table.getString("invoiceDate");
                    double invoicePrice = table.getDouble("invoicePrice");

                    String serialNumber = table.getString("serialNumber");
                    String model = table.getString("model");
                    String colour = table.getString("colour");
                    int year = table.getInt("year");

                    String custName = table.getString("custName");
                    String phone = table.getString("phone");
                    String sex =table.getString("sex");
                    String cusAddress = table.getString("cusAddress");

                    String salesName = table.getString("salesName");
                    String salesSex =table.getString("salesSex");
                    SaleInvoiceDetail sidetail = new SaleInvoiceDetail(ID, invoiceDate, invoicePrice, serialNumber, model, colour, year, custName, phone, sex, cusAddress, salesName, salesSex);
                    list.add(sidetail);
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
