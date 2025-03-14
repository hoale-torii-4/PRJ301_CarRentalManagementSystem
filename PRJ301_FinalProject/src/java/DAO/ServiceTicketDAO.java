package DAO;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import model.ServiceMechanic;
import model.ServiceTicket;
import model.ServiceTicketDetails;
import mylib.DBUtils;

public class ServiceTicketDAO {

    public List<ServiceTicketDetails> getServiceTicketForCustomer(String custID) {
        List<ServiceTicketDetails> serviceTickets = new ArrayList<>();

        String sql = "SELECT st.serviceTicketID, st.dateReceived, st.dateReturned, "
                + "c.custName, c.phone, "
                + "ca.model , ca.colour , "
                + "s.serviceName, "
                + "m.mechanicName, "
                + "p.partName, pu.price , pu.numberUsed,sm.comment,  sm.hours, sm.rate, "
                + "FROM ServiceTicket st "
                + "JOIN Customer c ON st.custID = c.custID "
                + "JOIN Cars ca ON st.carID = ca.carID "
                + "JOIN ServiceMehanic sm ON st.serviceTicketID = sm.serviceTicketID "
                + "JOIN Mechanic m ON sm.mechanicID = m.mechanicID "
                + "JOIN Service s ON sm.serviceID = s.serviceID "
                + "JOIN PartsUsed pu ON st.serviceTicketID = pu.serviceTicketID "
                + "JOIN Parts p ON pu.partID = p.partID "
                + "WHERE st.custID = ?";

        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, custID);
            ResultSet rs = ps.executeQuery();
            String ticketID;
            String dateReceived;
            String dateReturned;
            String custName;
            String phone;
            String carModel;
            String carColour;
            String serviceName;
            String mechanicName;
            String partName;
            long partPrice, rate;
            int numberUsed;
            String comment;
            String hour;
            while (rs.next()) {
                ticketID = rs.getString("serviceTicketID");
                dateReceived = rs.getString("dateReceived");
                dateReturned = rs.getString("dateReturned");
                custName = rs.getString("custName");
                phone = rs.getString("phone");
                carModel = rs.getString("model");
                carColour = rs.getString("colour");
                serviceName = rs.getString("serviceName");
                mechanicName = rs.getString("mechanicName");
                numberUsed = rs.getInt("numberUsed");
                partName = rs.getString("partName");
                partPrice = rs.getLong("price");
                comment = rs.getString("comment");
                rate = rs.getLong("rate");
                hour = rs.getString("hours");
                serviceTickets.add(new ServiceTicketDetails(ticketID, dateReceived, dateReturned, custName, phone, carModel, carColour, serviceName, mechanicName, partName, partPrice, numberUsed, comment, hour, rate));

            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return serviceTickets;
    }

    public List<ServiceTicketDetails> getAllServiceTicketForSalePerson() {
        List<ServiceTicketDetails> serviceTickets = new ArrayList<>();

        String sql = "SELECT st.dateReceived, st.dateReturned, "
                + "c.custName, c.phone, "
                + "ca.model , ca.colour , "
                + "s.serviceName, "
                + "m.mechanicName,  sm.hours, sm.rate, "
                + "p.partName, pu.price , pu.numberUsed,sm.comment, st.serviceTicketID "
                + "FROM ServiceTicket st "
                + "JOIN Customer c ON st.custID = c.custID "
                + "JOIN Cars ca ON st.carID = ca.carID "
                + "JOIN ServiceMehanic sm ON st.serviceTicketID = sm.serviceTicketID "
                + "JOIN Mechanic m ON sm.mechanicID = m.mechanicID "
                + "JOIN Service s ON sm.serviceID = s.serviceID "
                + "JOIN PartsUsed pu ON st.serviceTicketID = pu.serviceTicketID "
                + "JOIN Parts p ON pu.partID = p.partID ";

        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            String serviceTicketID;
            String dateReceived;
            String dateReturned;
            String custName;
            String phone;
            String carModel;
            String carColour;
            String serviceName;
            String mechanicName;
            String partName;
            long partPrice, rate;
            int numberUsed;
            String comment;
            String hour;
            while (rs.next()) {
                serviceTicketID = rs.getString("serviceTicketID");
                dateReceived = rs.getString("dateReceived");
                dateReturned = rs.getString("dateReturned");
                custName = rs.getString("custName");
                phone = rs.getString("phone");
                carModel = rs.getString("model");
                carColour = rs.getString("colour");
                serviceName = rs.getString("serviceName");
                mechanicName = rs.getString("mechanicName");
                numberUsed = rs.getInt("numberUsed");
                partName = rs.getString("partName");
                partPrice = rs.getLong("price");
                comment = rs.getString("comment");
                rate = rs.getLong("rate");
                hour = rs.getString("hours");
                serviceTickets.add(new ServiceTicketDetails(serviceTicketID, dateReceived, dateReturned, custName, phone, carModel, carColour, serviceName, mechanicName, partName, partPrice, numberUsed, comment, hour, rate));

            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return serviceTickets;
    }

    public List<ServiceTicketDetails> getServiceTicketByTicketIDByCarIDByDate(String custID, String date, String carID) {
        List<ServiceTicketDetails> serviceTickets = new ArrayList<>();

        String sql = "SELECT st.dateReceived, st.dateReturned, "
                + "c.custName, c.phone, "
                + "ca.model , ca.colour , "
                + "s.serviceName, "
                + "m.mechanicName,  sm.hours, sm.rate, "
                + "p.partName, pu.price , pu.numberUsed,sm.comment, st.serviceTicketID "
                + "FROM ServiceTicket st "
                + "JOIN Customer c ON st.custID = c.custID "
                + "JOIN Cars ca ON st.carID = ca.carID "
                + "JOIN ServiceMehanic sm ON st.serviceTicketID = sm.serviceTicketID "
                + "JOIN Mechanic m ON sm.mechanicID = m.mechanicID "
                + "JOIN Service s ON sm.serviceID = s.serviceID "
                + "JOIN PartsUsed pu ON st.serviceTicketID = pu.serviceTicketID "
                + "JOIN Parts p ON pu.partID = p.partID "
                + "WHERE (st.custID = ? OR st.carID = ? OR st.dateReceived = ?) AND st.status = 1";

        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, custID);
            ps.setString(2, carID);
            ps.setString(3, date);
            ResultSet rs = ps.executeQuery();
            String serviceTicketID;
            String dateReceived;
            String dateReturned;
            String custName;
            String phone;
            String carModel;
            String carColour;
            String serviceName;
            String mechanicName;
            String partName;
            long partPrice, rate;
            int numberUsed;
            String comment;
            String hour;
            while (rs.next()) {
                serviceTicketID = rs.getString("serviceTicketID");
                dateReceived = rs.getString("dateReceived");
                dateReturned = rs.getString("dateReturned");
                custName = rs.getString("custName");
                phone = rs.getString("phone");
                carModel = rs.getString("model");
                carColour = rs.getString("colour");
                serviceName = rs.getString("serviceName");
                mechanicName = rs.getString("mechanicName");
                numberUsed = rs.getInt("numberUsed");
                partName = rs.getString("partName");
                partPrice = rs.getLong("price");
                comment = rs.getString("comment");
                rate = rs.getLong("rate");
                hour = rs.getString("hours");
                serviceTickets.add(new ServiceTicketDetails(serviceTicketID, dateReceived, dateReturned, custName, phone, carModel, carColour, serviceName, mechanicName, partName, partPrice, numberUsed, comment, hour, rate));

            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return serviceTickets;
    }

    public List<ServiceTicketDetails> getServiceTicketForCustomerTiketID    (String ticketID) {
        List<ServiceTicketDetails> serviceTickets = new ArrayList<>();

        String sql = "SELECT st.dateReceived, st.dateReturned, "
                + "c.custName, c.phone, "
                + "ca.model , ca.colour , "
                + "s.serviceName, "
                + "m.mechanicName, "
                + "p.partName, pu.price , pu.numberUsed,sm.comment,  sm.hours, sm.rate "
                + "FROM ServiceTicket st "
                + "JOIN Customer c ON st.custID = c.custID "
                + "JOIN Cars ca ON st.carID = ca.carID "
                + "JOIN ServiceMehanic sm ON st.serviceTicketID = sm.serviceTicketID "
                + "JOIN Mechanic m ON sm.mechanicID = m.mechanicID "
                + "JOIN Service s ON sm.serviceID = s.serviceID "
                + "JOIN PartsUsed pu ON st.serviceTicketID = pu.serviceTicketID "
                + "JOIN Parts p ON pu.partID = p.partID "
                + "WHERE st.serviceTicketID = ?";

        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, ticketID);
            ResultSet rs = ps.executeQuery();
            String dateReceived;
            String dateReturned;
            String custName;
            String phone;
            String carModel;
            String carColour;
            String serviceName;
            String mechanicName;
            String partName;
            long partPrice, rate;
            int numberUsed;
            String comment;
            String hour;
            while (rs.next()) {
                dateReceived = rs.getString("dateReceived");
                dateReturned = rs.getString("dateReturned");
                custName = rs.getString("custName");
                phone = rs.getString("phone");
                carModel = rs.getString("model");
                carColour = rs.getString("colour");
                serviceName = rs.getString("serviceName");
                mechanicName = rs.getString("mechanicName");
                numberUsed = rs.getInt("numberUsed");
                partName = rs.getString("partName");
                partPrice = rs.getLong("price");
                comment = rs.getString("comment");
                rate = rs.getLong("rate");
                hour = rs.getString("hours");
                serviceTickets.add(new ServiceTicketDetails(ticketID, dateReceived, dateReturned, custName, phone, carModel, carColour, serviceName, mechanicName, partName, partPrice, numberUsed, comment, hour, rate));

            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return serviceTickets;
    }

    public List<ServiceTicket> getServiceTickets(String custID, String carID, String dateReceived) {
        List<ServiceTicket> tickets = new ArrayList<>();

        String query = "SELECT serviceTicketID, dateReceived, dateReturned, custID, CarID FROM ServiceTicket WHERE 1=1";

        if (custID != null && !custID.isEmpty()) {
            query += " AND custID = ?";
        }
        if (carID != null && !carID.isEmpty()) {
            query += " AND carID = ?";
        }
        if (dateReceived != null && !dateReceived.isEmpty()) {
            query += " AND dateReceived = ?";
        }

        try (Connection connection = DBUtils.getConnection(); PreparedStatement stmt = connection.prepareStatement(query)) {

            int index = 1;

            if (custID != null && !custID.isEmpty()) {
                stmt.setString(index++, custID);
            }
            if (carID != null && !carID.isEmpty()) {
                stmt.setString(index++, carID);
            }
            if (dateReceived != null && !dateReceived.isEmpty()) {
                stmt.setString(index++, dateReceived);
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String serviceTicketID = rs.getString("serviceTicketID");
                Date dateReceivedDB = rs.getDate("dateReceived");
                Date dateReturnedDB = rs.getDate("dateReturned");
                String custIDDB = rs.getString("custID");
                String carIDDB = rs.getString("carID");

                ServiceTicket ticket = new ServiceTicket(serviceTicketID, dateReceivedDB, dateReturnedDB, custIDDB, carIDDB);
                tickets.add(ticket);
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return tickets;
    }

    public int createServiceTicketForSalePerson(ServiceTicket serviceTicket) {
        int id = 0;
        Connection cn = null;
        try {
            cn = DBUtils.getConnection();
            if (cn != null) {
                id = Math.abs((int) (System.currentTimeMillis() % Integer.MAX_VALUE));
                String sql = "INSERT INTO [dbo].[ServiceTicket] "
                        + "([serviceTicketID], [dateReceived], [dateReturned], [custID], [carID]) "
                        + "VALUES (?, ?, ?, ?, ?)";

                PreparedStatement st = cn.prepareStatement(sql);
                st.setInt(1, id);
                st.setDate(2, serviceTicket.getDateReceived());
                st.setDate(3, serviceTicket.getDateReturned());
                st.setString(4, serviceTicket.getCustID());
                st.setString(5, serviceTicket.getCarID());

                int rowsAffected = st.executeUpdate();
                if (rowsAffected <= 0) {
                    id = 0;
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
        return id;
    }

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
                st.setString(1, "%" + mechanicID + "%");
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
