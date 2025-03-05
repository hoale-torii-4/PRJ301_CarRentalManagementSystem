package DAO;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.ServiceTicket;
import model.ServiceTicketDetails;
import mylib.DBUtils;

public class ServiceTicketDAO {
    
    public List<ServiceTicketDetails>getServiceTicketDetails (String ticketID) {
        List<ServiceTicketDetails> serviceTickets = new ArrayList<>();

        String sql = "SELECT s.serviceName, "
                + "p.partName, pu.price , pu.numberUsed "
                + "FROM ServiceTicket st "
                + "JOIN Customer c ON st.custID = c.custID "
                + "JOIN Cars ca ON st.carID = ca.carID "
                + "JOIN ServiceMehanic sm ON st.serviceTicketID = sm.serviceTicketID "
                + "JOIN Mechanic m ON sm.mechanicID = m.mechanicID "
                + "JOIN Service s ON sm.serviceID = s.serviceID "
                + "JOIN PartsUsed pu ON st.serviceTicketID = pu.serviceTicketID "
                + "JOIN Parts p ON pu.partID = p.partID "
                + "WHERE st.serviceTicketID LIKE ?";

        try (Connection conn = DBUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, ticketID);
            ResultSet rs = ps.executeQuery();
    
            String serviceName;
            String partName;
            String partPrice;
            int numberUsed;
            while (rs.next()) {
                serviceName = rs.getString("serviceName");
                numberUsed = rs.getInt("numberUsed");
                partName = rs.getString("partName");
                partPrice = rs.getString("price");
                serviceTickets.add(new ServiceTicketDetails(serviceName, partName, partPrice, numberUsed));

            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return serviceTickets;
    }
    public List<ServiceTicketDetails> getServiceTicketForCustomer(String custID) {
        List<ServiceTicketDetails> serviceTickets = new ArrayList<>();

        String sql = "SELECT st.serviceTicketID, st.dateReceived, st.dateReturned, "
                + "c.custName, c.phone, "
                + "ca.model , ca.colour , "
                + "s.serviceName, "
                + "m.mechanicName, "
                + "p.partName, pu.price , pu.numberUsed "
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
            String partPrice;
            int numberUsed;
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
                partPrice = rs.getString("price");
                serviceTickets.add(new ServiceTicketDetails(ticketID, dateReceived, dateReturned, custName, phone, carModel, carColour, serviceName, mechanicName, partName, partPrice, numberUsed));

            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return serviceTickets;
    }
      public List<ServiceTicketDetails> getServiceTicketForCustomerTiketID(String ticketID) {
        List<ServiceTicketDetails> serviceTickets = new ArrayList<>();

        String sql = "SELECT st.dateReceived, st.dateReturned, "
                + "c.custName, c.phone, "
                + "ca.model , ca.colour , "
                + "s.serviceName, "
                + "m.mechanicName, "
                + "p.partName, pu.price , pu.numberUsed "
                + "FROM ServiceTicket st "
                + "JOIN Customer c ON st.custID = c.custID "
                + "JOIN Cars ca ON st.carID = ca.carID "
                + "JOIN ServiceMehanic sm ON st.serviceTicketID = sm.serviceTicketID "
                + "JOIN Mechanic m ON sm.mechanicID = m.mechanicID "
                + "JOIN Service s ON sm.serviceID = s.serviceID "
                + "JOIN PartsUsed pu ON st.serviceTicketID = pu.serviceTicketID "
                + "JOIN Parts p ON pu.partID = p.partID "
                + "WHERE st.serviceTicketID LIKE ?";

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
            String partPrice;
            int numberUsed;
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
                partPrice = rs.getString("price");
                serviceTickets.add(new ServiceTicketDetails(ticketID, dateReceived, dateReturned, custName, phone, carModel, carColour, serviceName, mechanicName, partName, partPrice, numberUsed));

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
}
