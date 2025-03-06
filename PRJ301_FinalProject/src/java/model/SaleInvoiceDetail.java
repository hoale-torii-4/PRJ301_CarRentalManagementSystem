/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author LENOVO
 */
public class SaleInvoiceDetail {
    private String invoiceID;
    private String invoiceDate;
    private double invoicePrice;
    
    private String serialNumber;
    private String model;
    private String colour;
    private int year;
    
    private String custName;
    private String phone;
    private String sex;
    private String cusAddress;
    
    private String salesName;
    private String salesSex; 

    public SaleInvoiceDetail() {
    }

    public SaleInvoiceDetail(String invoiceID, String invoiceDate, double invoicePrice, String serialNumber, String model, String colour, int year, String custName, String phone, String sex, String cusAddress, String salesName, String salesSex) {
        this.invoiceID = invoiceID;
        this.invoiceDate = invoiceDate;
        this.invoicePrice = invoicePrice;
        this.serialNumber = serialNumber;
        this.model = model;
        this.colour = colour;
        this.year = year;
        this.custName = custName;
        this.phone = phone;
        this.sex = sex;
        this.cusAddress = cusAddress;
        this.salesName = salesName;
        this.salesSex = salesSex;
    }

    public String getInvoiceID() {
        return invoiceID;
    }

    public void setInvoiceID(String invoiceID) {
        this.invoiceID = invoiceID;
    }

    public String getInvoiceDate() {
        return invoiceDate;
    }

    public void setInvoiceDate(String invoiceDate) {
        this.invoiceDate = invoiceDate;
    }

    public double getInvoicePrice() {
        return invoicePrice;
    }

    public void setInvoicePrice(double invoicePrice) {
        this.invoicePrice = invoicePrice;
    }

    public String getSerialNumber() {
        return serialNumber;
    }

    public void setSerialNumber(String serialNumber) {
        this.serialNumber = serialNumber;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getColour() {
        return colour;
    }

    public void setColour(String colour) {
        this.colour = colour;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public String getCustName() {
        return custName;
    }

    public void setCustName(String custName) {
        this.custName = custName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getCusAddress() {
        return cusAddress;
    }

    public void setCusAddress(String cusAddress) {
        this.cusAddress = cusAddress;
    }

    public String getSalesName() {
        return salesName;
    }

    public void setSalesName(String salesName) {
        this.salesName = salesName;
    }

    public String getSalesSex() {
        return salesSex;
    }

    public void setSalesSex(String salesSex) {
        this.salesSex = salesSex;
    }
    
}
