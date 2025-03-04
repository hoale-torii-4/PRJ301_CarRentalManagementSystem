/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author LENOVO
 */
public class ServiceMechanic {
    private String serviceTicketID;
    private String serviceID;
    private String mechanicID;
    private int hour;
    private String comment;
    private double rate;

    public ServiceMechanic() {
    }

    public ServiceMechanic(String serviceTicketID, String serviceID, String mechanicID, int hour, String comment, double rate) {
        this.serviceTicketID = serviceTicketID;
        this.serviceID = serviceID;
        this.mechanicID = mechanicID;
        this.hour = hour;
        this.comment = comment;
        this.rate = rate;
    }

    public String getServiceTicketID() {
        return serviceTicketID;
    }

    public void setServiceTicketID(String serviceTicktID) {
        this.serviceTicketID = serviceTicktID;
    }

    public String getServiceID() {
        return serviceID;
    }

    public void setServiceID(String serviceID) {
        this.serviceID = serviceID;
    }

    public String getMechanicID() {
        return mechanicID;
    }

    public void setMechanicID(String mechanicID) {
        this.mechanicID = mechanicID;
    }

    public int getHour() {
        return hour;
    }

    public void setHour(int hour) {
        this.hour = hour;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public double getRate() {
        return rate;
    }

    public void setRate(double rate) {
        this.rate = rate;
    }

    
    
    
}
