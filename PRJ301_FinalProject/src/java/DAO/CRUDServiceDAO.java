/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Service;
import mylib.DBUtils;

/**
 *
 * @author LENOVO
 */
public class CRUDServiceDAO {

    public ArrayList<Service> getServiceByName(String name) {
        ArrayList<Service> services = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT [serviceID],[serviceName],[hourlyRate],[status]\n"
                        + "FROM [dbo].[Service]\n"
                        + "WHERE [serviceName] LIKE ? AND [status] = 1";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, "%" + name + "%");
                ResultSet table = st.executeQuery();
                while (table.next()) {
                    String serviceID = table.getString("serviceID");
                    String serviceName = table.getString("serviceName");
                    double hourlyRate = table.getDouble("hourlyRate");
                    Service s = new Service(serviceID, serviceName, hourlyRate);
                    services.add(s);
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
        return services;
    }
    public Service getOneServiceByName(String name) {
        Service service = new Service();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT [serviceID],[serviceName],[hourlyRate],[status]\n"
                        + "FROM [dbo].[Service]\n"
                        + "WHERE [serviceName] LIKE ? AND [status] = 1";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, "%" + name + "%");
                ResultSet table = st.executeQuery();
                while (table.next()) {
                    String serviceID = table.getString("serviceID");
                    String serviceName = table.getString("serviceName");
                    double hourlyRate = table.getDouble("hourlyRate");
                    service  = new Service(serviceID, serviceName, hourlyRate);
                  
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
        return service;
    }
    public ArrayList<Service> getAllService() {
        ArrayList<Service> services = new ArrayList<>();
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "SELECT [serviceID],[serviceName],[hourlyRate],[status]\n"
                        + "FROM [dbo].[Service]\n"
                        + "WHERE [status] = 1";
                PreparedStatement st = cn.prepareStatement(sql);
                ResultSet table = st.executeQuery();
                while (table.next()) {
                    String serviceID = table.getString("serviceID");
                    String serviceName = table.getString("serviceName");
                    double hourlyRate = table.getDouble("hourlyRate");
                    Service s = new Service(serviceID, serviceName, hourlyRate);
                    services.add(s);
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
        return services;
    }

    public boolean UpdateService(String id, String name, double hourlyRate) {
        boolean isUpdate = false;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "UPDATE [dbo].[Service]\n"
                        + "SET [serviceName] = ?,[hourlyRate] = ?\n"
                        + "WHERE [serviceID] LIKE ? AND [status] = 1";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, name);
                st.setDouble(2, hourlyRate);
                st.setString(3, id);
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

    public boolean DeleteServlet(String id) {
        boolean isDelete = false;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                String sql = "UPDATE [dbo].[Service]\n"
                        + "SET [status] = 0\n"
                        + "WHERE [serviceID] = ?";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setString(1, id);
                int row = st.executeUpdate();
                if (row > 0) {
                    isDelete = true;
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

        return isDelete;
    }

    public boolean isCreated(String name, double hourlyRate) {
        boolean isCreated = false;
        Connection cn = null;
        int newID = (int) (System.currentTimeMillis() % Integer.MAX_VALUE);
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
               String sql = "INSERT INTO Service (serviceID, serviceName, hourlyRate) VALUES (?, ?, ?)";
                PreparedStatement st = cn.prepareStatement(sql);
                st.setLong(1, newID);
                st.setString(2, name);
                st.setDouble(3, hourlyRate);
                int row = st.executeUpdate();
                isCreated = row > 0;
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

        return isCreated;
    }
}
