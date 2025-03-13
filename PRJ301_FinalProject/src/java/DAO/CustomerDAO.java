/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Customer;
import mylib.DBUtils;

/**
 *
 * @author user
 */
public class CustomerDAO {

    public Customer checkLogin(String name, String phone) {
        Customer rs = null;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "select custID,custName,phone,sex,cusAddress\n"
                        + "from dbo.Customer\n"
                        + "where custName = ? and phone=?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, name);
                st.setString(2, phone);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int custid = table.getInt("custID");
                        String custname = table.getString("custName");
                        //String phone=""+table.getString("phone");
                        String sex = table.getString("sex");
                        String custadd = table.getString("cusAddress");
                        rs = new Customer(custid, custname, phone, sex, custadd);

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
        return rs;
    }

    public Customer getCustomer(int custID) {
        Customer rs = null;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "select custID,custName,phone,sex,cusAddress\n"
                        + "from dbo.Customer\n"
                        + "where custID LIKE ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, custID);

                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int custid = table.getInt("custID");
                        String custname = table.getString("custName");
                        String phone = "" + table.getString("phone");
                        String sex = table.getString("sex");
                        String custadd = table.getString("cusAddress");
                        rs = new Customer(custid, custname, phone, sex, custadd);

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
        return rs;
    }

    public Customer getCustomerByName(String custName) {
        Customer rs = null;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "select custID,phone,sex,cusAddress\n"
                        + "from dbo.Customer\n"
                        + "where custName LIKE ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, custName);

                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int custid = table.getInt("custID");
                        String phone = "" + table.getString("phone");
                        String sex = table.getString("sex");
                        String custadd = table.getString("cusAddress");
                        rs = new Customer(custid, custName, phone, sex, custadd);

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
        return rs;
    }
    
    public ArrayList<Customer> getCustomers() {
        ArrayList<Customer> list = new ArrayList();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "select custID,custName,phone,sex,cusAddress\n"
                        + "from dbo.Customer\n";
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet table = st.executeQuery();
                if (table != null) {
                    while (table.next()) {
                        int custid = table.getInt("custID");
                        String custname = table.getString("custName");
                        String phone = "" + table.getString("phone");
                        String sex = table.getString("sex");
                        String custadd = table.getString("cusAddress");
                        Customer c = new Customer(custid, custname, phone, sex, custadd);
                        list.add(c);
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
    public boolean isAlreadyCustomer(Customer cust) {
    boolean check = false;
    Connection cn = null;
    try {
        cn = DBUtils.getConnection();
        if (cn != null) {
            String sql = "SELECT custID FROM dbo.Customer WHERE custName = ? AND phone = ? AND cusAddress = ?";
            PreparedStatement st = cn.prepareStatement(sql);
            st.setString(1, cust.getCustName());
            st.setString(2, cust.getPhone());
            st.setString(3, cust.getCustAddress());
            
            ResultSet table = st.executeQuery();
            if (table.next()) { 
                check = true;
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
    return check;
}

    public boolean isUpdateCustomerInformation(int custID, String name, String phone, String sex, String cusAddress) {
        boolean isUpdate = false;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "UPDATE dbo.Customer SET custName = ?, phone = ?, sex = ?, cusAddress = ? WHERE custID = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, name);
                st.setString(2, phone);
                st.setString(3, sex);
                st.setString(4, cusAddress);
                st.setInt(5, custID);

                int rowsAffected = st.executeUpdate();
                if (rowsAffected > 0) {
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

    public List<String> getCustomerSuggestions(String keyword) {
        List<String> suggestions = new ArrayList<>();
        String sql = "SELECT custName, phone, sex, cusAddress FROM Customer WHERE (custName LIKE ?) AND status != 0 ORDER BY custName ASC";

        try (Connection cn = DBUtils.getConnection(); PreparedStatement stmt = cn.prepareStatement(sql)) {

            stmt.setString(1, "%" + keyword + "%");

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String carInfo = rs.getString("custName").trim() + " - 0" + rs.getString("phone") + " - " + rs.getString("sex").trim() + " - " + rs.getString("cusAddress");
                    suggestions.add(carInfo);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return suggestions;
    }
    public Customer searchCustomersByNameByPhone(String name, String phone) {
        Customer cust = new Customer();
        Connection cn = null;
        PreparedStatement st = null;
        ResultSet rs = null;

        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT * FROM Customer WHERE custName LIKE ? AND phone LIKE ?  and status = 1";
                st = cn.prepareStatement(sql);
                st.setString(1, "%" + name + "%");
                st.setString(2, "%" + phone + "%");
                rs = st.executeQuery();
                while (rs != null && rs.next()) {
                    int custID = rs.getInt("custID");
                    String custName = rs.getString("custName");
                    String sex = rs.getString("sex");
                    String address = rs.getString("cusAddress");

                    cust = new Customer(custID, custName, phone, sex, address);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
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
        return cust;
    }


}
