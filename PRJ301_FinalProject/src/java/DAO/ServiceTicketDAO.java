package DAO;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.ServiceTicket;
import mylib.DBUtils;

public class ServiceTicketDAO {

    public List<ServiceTicket> getServiceTicketsByCustomerID(String custID) {
        List<ServiceTicket> tickets = new ArrayList<>();

        String query = "SELECT serviceTicketID, dateReceived, dateReturned, custID, carID FROM ServiceTicket WHERE custID = ?";

        try (Connection connection = DBUtils.getConnection(); PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, custID);
            ResultSet rs = stmt.executeQuery();

           
            while (rs.next()) {
                String serviceTicketID = rs.getString("serviceTicketID");
                Date dateReceived = rs.getDate("dateReceived");
                Date dateReturned = rs.getDate("dateReturned");
                String carID = rs.getString("carID");

                ServiceTicket ticket = new ServiceTicket(serviceTicketID, dateReceived, dateReturned, custID, carID);
                tickets.add(ticket);
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return tickets;
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
