/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Customer;
import mylib.DBUtils;

/**
 *
 * @author hoang
 */
public class CRUDCustomerDAO {

    public ArrayList<Customer> getCustomers() {
        ArrayList<Customer> list = new ArrayList();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "select custID,custName,phone,sex,cusAddress\n"
                        + "from dbo.Customer\n"
                        + "where status = 1";
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
    //

    public int addCustomer(Customer customer) {
        int custID = 0;

        try (Connection cn = DBUtils.getConnection()) {
            if (cn != null) {
                long newID = System.currentTimeMillis() % Integer.MAX_VALUE;
                String sql = "INSERT INTO dbo.Customer (custID, custName, phone, sex, cusAddress) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setLong(1, newID);  // Đặt newID là custID
                st.setString(2, customer.getCustName());
                st.setString(3, customer.getPhone());
                st.setString(4, customer.getSex());
                st.setString(5, customer.getCustAddress());

                int row = st.executeUpdate();
                if (row > 0) {
                    custID = (int) newID;
                }

                st.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return custID;
    }

    public boolean deleteCustomer(int custID) {
        Connection cn = null;
        PreparedStatement st = null;
        boolean isUpdated = false;

        try {
            cn = DBUtils.getConnection();
            if (cn != null) {

                String sql = "UPDATE Customer SET status = 0 WHERE custID = ?";
                st = cn.prepareStatement(sql);
                st.setInt(1, custID);

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

    public Customer getCustomerById(int custID) {
        Connection cn = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        Customer customer = null;

        try {
            cn = DBUtils.getConnection();
            if (cn != null) {

                String sql = "SELECT * FROM Customer WHERE custID = ? and status = 1";
                st = cn.prepareStatement(sql);
                st.setInt(1, custID);

                rs = st.executeQuery();

                if (rs != null && rs.next()) {
                    String name = rs.getString("custName");
                    String phone = rs.getString("phone");
                    String sex = rs.getString("sex");
                    String address = rs.getString("cusAddress");

                    customer = new Customer(custID, name, phone, sex, address);
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
        return customer;
    }

    public ArrayList<Customer> searchCustomersByName(String name) {
        ArrayList<Customer> list = new ArrayList<>();
        Connection cn = null;
        PreparedStatement st = null;
        ResultSet rs = null;

        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT * FROM Customer WHERE custName LIKE ? and status = 1";
                st = cn.prepareStatement(sql);
                st.setString(1, "%" + name + "%");

                rs = st.executeQuery();
                while (rs != null && rs.next()) {
                    int custID = rs.getInt("custID");
                    String custName = rs.getString("custName");
                    String phone = rs.getString("phone");
                    String sex = rs.getString("sex");
                    String address = rs.getString("cusAddress");

                    Customer customer = new Customer(custID, custName, phone, sex, address);
                    list.add(customer);
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
        return list;
    }

    public boolean updateCustomer(Customer customer) {
        boolean isUpdated = false;
        Connection cn = null;
        PreparedStatement st = null;

        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "UPDATE Customer SET custName = ?, phone = ?, sex = ?, cusAddress = ? WHERE custID = ? AND status = 1";
                st = cn.prepareStatement(sql);
                st.setString(1, customer.getCustName());
                st.setString(2, customer.getPhone());
                st.setString(3, customer.getSex());
                st.setString(4, customer.getCustAddress());
                st.setInt(5, customer.getCustID());

                int rowsAffected = st.executeUpdate();
                System.out.println("🔄 Rows affected: " + rowsAffected);
                if (rowsAffected > 0) {
                    isUpdated = true;
                } else {
                    System.out.println("⚠️ No rows updated. Check custID and status.");
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

}
