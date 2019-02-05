package POJOs;
// Generated Oct 3, 2017 6:37:39 PM by Hibernate Tools 3.6.0


import java.util.HashSet;
import java.util.Set;

/**
 * Invoice generated by hbm2java
 */
public class Invoice  implements java.io.Serializable {


     private Integer idinvoice;
     private ShipingDetails shipingDetails;
     private SystemDate systemDate;
     private Customer customer;
     private Double total;
     private String invoiceNo;
     private Integer billCount;
     private Double totalAmount;
     private Double shippingCost;
     private String paymentType;
     private Set delivers = new HashSet(0);
     private Set invoiceItemses = new HashSet(0);

    public Invoice() {
    }

	
    public Invoice(ShipingDetails shipingDetails, SystemDate systemDate, Customer customer) {
        this.shipingDetails = shipingDetails;
        this.systemDate = systemDate;
        this.customer = customer;
    }
    public Invoice(ShipingDetails shipingDetails, SystemDate systemDate, Customer customer, Double total, String invoiceNo, Integer billCount, Double totalAmount, Double shippingCost, String paymentType, Set delivers, Set invoiceItemses) {
       this.shipingDetails = shipingDetails;
       this.systemDate = systemDate;
       this.customer = customer;
       this.total = total;
       this.invoiceNo = invoiceNo;
       this.billCount = billCount;
       this.totalAmount = totalAmount;
       this.shippingCost = shippingCost;
       this.paymentType = paymentType;
       this.delivers = delivers;
       this.invoiceItemses = invoiceItemses;
    }
   
    public Integer getIdinvoice() {
        return this.idinvoice;
    }
    
    public void setIdinvoice(Integer idinvoice) {
        this.idinvoice = idinvoice;
    }
    public ShipingDetails getShipingDetails() {
        return this.shipingDetails;
    }
    
    public void setShipingDetails(ShipingDetails shipingDetails) {
        this.shipingDetails = shipingDetails;
    }
    public SystemDate getSystemDate() {
        return this.systemDate;
    }
    
    public void setSystemDate(SystemDate systemDate) {
        this.systemDate = systemDate;
    }
    public Customer getCustomer() {
        return this.customer;
    }
    
    public void setCustomer(Customer customer) {
        this.customer = customer;
    }
    public Double getTotal() {
        return this.total;
    }
    
    public void setTotal(Double total) {
        this.total = total;
    }
    public String getInvoiceNo() {
        return this.invoiceNo;
    }
    
    public void setInvoiceNo(String invoiceNo) {
        this.invoiceNo = invoiceNo;
    }
    public Integer getBillCount() {
        return this.billCount;
    }
    
    public void setBillCount(Integer billCount) {
        this.billCount = billCount;
    }
    public Double getTotalAmount() {
        return this.totalAmount;
    }
    
    public void setTotalAmount(Double totalAmount) {
        this.totalAmount = totalAmount;
    }
    public Double getShippingCost() {
        return this.shippingCost;
    }
    
    public void setShippingCost(Double shippingCost) {
        this.shippingCost = shippingCost;
    }
    public String getPaymentType() {
        return this.paymentType;
    }
    
    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
    }
    public Set getDelivers() {
        return this.delivers;
    }
    
    public void setDelivers(Set delivers) {
        this.delivers = delivers;
    }
    public Set getInvoiceItemses() {
        return this.invoiceItemses;
    }
    
    public void setInvoiceItemses(Set invoiceItemses) {
        this.invoiceItemses = invoiceItemses;
    }




}


