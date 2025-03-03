/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author hoang
 */
public class ServiceTicket {
    private String serviceTicketID;
    private Date dateReceived;
    private Date dateReturned;
    private String custID;
    private String carID;

    public ServiceTicket(String serviceTicketID, Date dateReceived, Date dateReturned, String custID, String carID) {
        this.serviceTicketID = serviceTicketID;
        this.dateReceived = dateReceived;
        this.dateReturned = dateReturned;
        this.custID = custID;
        this.carID = carID;
    }

    public ServiceTicket() {
    }

    public String getServiceTicketID() {
        return serviceTicketID;
    }

    public void setServiceTicketID(String serviceTicketID) {
        this.serviceTicketID = serviceTicketID;
    }

    public Date getDateReceived() {
        return dateReceived;
    }

    public void setDateReceived(Date dateReceived) {
        this.dateReceived = dateReceived;
    }

    public Date getDateReturned() {
        return dateReturned;
    }

    public void setDateReturned(Date dateReturned) {
        this.dateReturned = dateReturned;
    }

    public String getCustID() {
        return custID;
    }

    public void setCustID(String custID) {
        this.custID = custID;
    }

    public String getCarID() {
        return carID;
    }

    public void setCarID(String carID) {
        this.carID = carID;
    }
}
