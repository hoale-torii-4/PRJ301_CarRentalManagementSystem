/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
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
        return new HashMap[]{mapSaleName,mapCarName,mapCusName};
    }
}
