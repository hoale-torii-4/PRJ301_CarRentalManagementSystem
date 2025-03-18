/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author LENOVO
 */
public class PartUsed {
    private String serviceTicketID;
    private String partID;
    private String numberUsed;
    private Double price;
    private String serviceID;
    private int total;
    
    public PartUsed() {
    }

    public PartUsed(String partID,int total,Double price) {
        this.partID = partID;
        this.total = total;
        this.price = price;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }
    
    
    public PartUsed(String serviceTicketID, String partID, String numberUsed, Double price) {
        this.serviceTicketID = serviceTicketID;
        this.partID = partID;
        this.numberUsed = numberUsed;
        this.price = price;
    }
    public PartUsed(String serviceTicketID, String partID, String numberUsed, Double price, String serviceID) {
        this.serviceTicketID = serviceTicketID;
        this.partID = partID;
        this.numberUsed = numberUsed;
        this.price = price;
        this.serviceID = serviceID;
    }

    public String getServiceTicketID() {
        return serviceTicketID;
    }

    public void setServiceTicketID(String serviceTicketID) {
        this.serviceTicketID = serviceTicketID;
    }

    public String getPartID() {
        return partID;
    }

    public void setPartID(String partID) {
        this.partID = partID;
    }

    public String getNumberUsed() {
        return numberUsed;
    }

    public void setNumberUsed(String numberUsed) {
        this.numberUsed = numberUsed;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getServiceID() {
        return serviceID;
    }

    public void setServiceID(String serviceID) {
        this.serviceID = serviceID;
    }
    
    
}
