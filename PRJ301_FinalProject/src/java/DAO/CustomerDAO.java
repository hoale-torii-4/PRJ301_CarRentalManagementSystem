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
public class CustomerDAO {

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
    //

    public boolean addCustomer(Customer customer) {
        Connection cn = null;
        PreparedStatement st = null;
        boolean isAdded = false;

        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                // Câu lệnh SQL để chèn dữ liệu vào bảng Customer
                String sql = "INSERT INTO dbo.Customer (custID, custName, phone, sex, cusAddress) VALUES (?, ?, ?, ?, ?)";
                st = cn.prepareStatement(sql);

                // Thiết lập các tham số cho câu lệnh SQL
                st.setInt(1, customer.getCustID()); // ID khách hàng
                st.setString(2, customer.getCustName()); // Tên khách hàng
                st.setString(3, customer.getPhone()); // Số điện thoại
                st.setString(4, customer.getSex()); // Giới tính
                st.setString(5, customer.getCustAddress()); // Địa chỉ

                // Thực thi câu lệnh
                int rowsAffected = st.executeUpdate();

                // Kiểm tra nếu số dòng bị ảnh hưởng > 0 thì thêm thành công
                if (rowsAffected > 0) {
                    isAdded = true;
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
        return isAdded; // Trả về true nếu thêm thành công, ngược lại trả về false
    }
    //

    public boolean deleteCustomer(int custID) {
        Connection cn = null;
        PreparedStatement st = null;
        boolean isDeleted = false;

        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "DELETE FROM Customer WHERE custID = ?";
                st = cn.prepareStatement(sql);
                st.setInt(1, custID);

                int rowsAffected = st.executeUpdate();
                if (rowsAffected > 0) {
                    isDeleted = true;
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
        return isDeleted;
    }

    public Customer getCustomerById(int custID) {
        Connection cn = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        Customer customer = null;

        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                // Câu lệnh SQL để lấy thông tin khách hàng theo custID
                String sql = "SELECT * FROM Customer WHERE custID = ?";
                st = cn.prepareStatement(sql);
                st.setInt(1, custID); // Đặt giá trị cho tham số ? (custID)

                rs = st.executeQuery();

                if (rs != null && rs.next()) {
                    // Nếu có kết quả, khởi tạo đối tượng Customer từ kết quả truy vấn
                    String name = rs.getString("custName");
                    String phone = rs.getString("phone");
                    String sex = rs.getString("sex");
                    String address = rs.getString("cusAddress");

                    customer = new Customer(custID, name, phone, sex, address); // Tạo đối tượng Customer
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
        return customer; // Trả về đối tượng Customer hoặc null nếu không tìm thấy
    }

    public ArrayList<Customer> searchCustomersByName(String name) {
        ArrayList<Customer> list = new ArrayList<>();
        Connection cn = null;
        PreparedStatement st = null;
        ResultSet rs = null;

        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                // Câu lệnh SQL tìm kiếm theo tên khách hàng
                String sql = "SELECT * FROM Customer WHERE custName LIKE ?";
                st = cn.prepareStatement(sql);
                st.setString(1, "%" + name + "%"); // Tìm theo tên (custName)

                rs = st.executeQuery();

                // Duyệt qua kết quả và thêm vào danh sách
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
        Connection cn = null;
        PreparedStatement st = null;
        boolean isUpdated = false;

        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "UPDATE Customer SET custName = ?, phone = ?, sex = ?, cusAddress = ? WHERE custID = ?";
                st = cn.prepareStatement(sql);
                st.setString(1, customer.getCustName());
                st.setString(2, customer.getPhone());
                st.setString(3, customer.getSex());
                st.setString(4, customer.getCustAddress());
                st.setInt(5, customer.getCustID());

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

}
