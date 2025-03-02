package model;

public class SalesInvoice {
    private int id; 
    private String date;
    private String saleId;
    private String carId;
    private String custId;

    public SalesInvoice() {
    }

    public SalesInvoice(int id, String date, String saleId, String carId, String custId) {
        this.id = id;
        this.date = date;
        this.saleId = saleId;
        this.carId = carId;
        this.custId = custId;
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
}
