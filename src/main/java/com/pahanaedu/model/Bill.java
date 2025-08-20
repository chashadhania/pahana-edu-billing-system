package com.pahanaedu.model;

import java.util.Date;
import java.util.List;

public class Bill {
	  private int billId;
	    private String customerAccount; // Changed to String
	    private double totalAmount;
	    
    private Date billDate;
    private String status;
    private List<BillItem> billItems; // For holding bill items
    
    public Bill() {
        this.billDate = new Date();
        this.status = "Pending";
    }
    
    public Bill(int billId, String customerAccount, double totalAmount) {
        this();
        this.billId = billId;
        this.customerAccount = customerAccount;
        this.totalAmount = totalAmount;
    }
    
    // Getters and Setters
    public int getBillId() { return billId; }
    public void setBillId(int billId) { this.billId = billId; }
    
    public String getCustomerAccount() { return customerAccount; }
    public void setCustomerAccount(String customerAccount) { this.customerAccount = customerAccount; }
    
    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
    
    public Date getBillDate() { return billDate; }
    public void setBillDate(Date billDate) { this.billDate = billDate; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public List<BillItem> getBillItems() { return billItems; }
    public void setBillItems(List<BillItem> billItems) { this.billItems = billItems; }
    
    @Override
    public String toString() {
        return "Bill{" +
                "billId=" + billId +
                ", customerAccount=" + customerAccount +
                ", totalAmount=" + totalAmount +
                ", billDate=" + billDate +
                ", status='" + status + '\'' +
                '}';
    }
}