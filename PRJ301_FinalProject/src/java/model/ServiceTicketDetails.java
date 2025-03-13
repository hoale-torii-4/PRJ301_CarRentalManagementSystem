package model;


public class ServiceTicketDetails {
    private String ticketID;
    private String dateReceived;
    private String dateReturned;
    private String custName;
    private String phone;
    private String carModel;
    private String carColour;
    private String serviceName;
    private String mechanicName;
    private String partName;
    private long partPrice;
    private int numberUsed;
    private String commemt;

    public ServiceTicketDetails(String serviceName, String partName, long partPrice, int numberUsed) {
        this.serviceName = serviceName;
        this.partName = partName;
        this.partPrice = partPrice;
        this.numberUsed = numberUsed;
    }

    public ServiceTicketDetails() {
    }

    public ServiceTicketDetails(String ticketID, String dateReceived, String dateReturned, String custName, String phone, String carModel, String carColour, String serviceName, String mechanicName, String partName, long partPrice, int numberUsed, String comment) {
        this.ticketID = ticketID;
        this.dateReceived = dateReceived;
        this.dateReturned = dateReturned;
        this.custName = custName;
        this.phone = phone;
        this.carModel = carModel;
        this.carColour = carColour;
        this.serviceName = serviceName;
        this.mechanicName = mechanicName;
        this.partName = partName;
        this.partPrice = partPrice;
        this.numberUsed = numberUsed;
        this.commemt = comment;
    }

    public ServiceTicketDetails(String ticketID, String dateReceived, String dateReturned, String custName, String phone, String carModel, String carColour, String mechanicName) {
        this.ticketID = ticketID;
        this.dateReceived = dateReceived;
        this.dateReturned = dateReturned;
        this.custName = custName;
        this.phone = phone;
        this.carModel = carModel;
        this.carColour = carColour;
        this.mechanicName = mechanicName;
    }

    public ServiceTicketDetails(String ticketID, String dateReceived, String dateReturned, String custName, String phone, String carModel, String carColour) {
        this.ticketID = ticketID;
        this.dateReceived = dateReceived;
        this.dateReturned = dateReturned;
        this.custName = custName;
        this.phone = phone;
        this.carModel = carModel;
        this.carColour = carColour;
    }
    

    // Getters and Setters
    public String getTicketID() {
        return ticketID;
    }

    public void setTicketID(String ticketID) {
        this.ticketID = ticketID;
    }

    public String getDateReceived() {
        return dateReceived;
    }

    public void setDateReceived(String dateReceived) {
        this.dateReceived = dateReceived;
    }

    public String getDateReturned() {
        return dateReturned;
    }

    public void setDateReturned(String dateReturned) {
        this.dateReturned = dateReturned;
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

    public String getCarModel() {
        return carModel;
    }

    public void setCarModel(String carModel) {
        this.carModel = carModel;
    }

    public String getCarColour() {
        return carColour;
    }

    public void setCarColour(String carColour) {
        this.carColour = carColour;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public String getMechanicName() {
        return mechanicName;
    }

    public String getCommemt() {
        return commemt;
    }

    public void setCommemt(String commemt) {
        this.commemt = commemt;
    }

    public void setMechanicName(String mechanicName) {
        this.mechanicName = mechanicName;
    }

    public String getPartName() {
        return partName;
    }

    public void setPartName(String partName) {
        this.partName = partName;
    }

    public long getPartPrice() {
        return partPrice;
    }

    public void setPartPrice(long partPrice) {
        this.partPrice = partPrice;
    }

    public int getNumberUsed() {
        return numberUsed;
    }

    public void setNumberUsed(int numberUsed) {
        this.numberUsed = numberUsed;
    }
}
