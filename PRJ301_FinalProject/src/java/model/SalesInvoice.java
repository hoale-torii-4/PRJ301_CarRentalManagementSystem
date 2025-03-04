package model;

public class SalesInvoice {
    private int id; 
    private String date;
    private String saleId;
    private String carId;
    private String custId;
    private String price;
    
    public SalesInvoice() {
    }
    
     public SalesInvoice(int id, String date, String saleId, String carId, String custId, String price) {
        this.id = id;
        this.date = date;
        this.saleId = saleId;
        this.carId = carId;
        this.custId = custId;
        this.price = price;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getSaleId() {
        return saleId;
    }

    public void setSaleId(String saleId) {
        this.saleId = saleId;
    }

    public String getCarId() {
        return carId;
    }

    public void setCarId(String carId) {
        this.carId = carId;
    }

    public String getCustId() {
        return custId;
    }

    public void setCustId(String custId) {
        this.custId = custId;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }
     
}
