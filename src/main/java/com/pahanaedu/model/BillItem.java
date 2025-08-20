package com.pahanaedu.model;

public class BillItem {
   
    private int billId;
    private String itemId;
    private int quantity;
    private double unitPrice;
    private double totalPrice; // Keep this as totalPrice in Java
    private String itemName;
    
    public BillItem() {}
    
    public BillItem(int billId, String itemId, int quantity, double unitPrice) {
        this.billId = billId;
        this.itemId = itemId;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.totalPrice = quantity * unitPrice;
    }
    
    // Getters and Setters
    
    public int getBillId() { return billId; }
    public void setBillId(int billId) { this.billId = billId; }
    
    public String getItemId() { return itemId; }
    public void setItemId(String itemId) { this.itemId = itemId; }
    
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { 
        this.quantity = quantity;
        this.totalPrice = this.quantity * this.unitPrice; // Recalculate total
    }

    
    public double getUnitPrice() { return unitPrice; }
    public void setUnitPrice(double unitPrice) { 
        this.unitPrice = unitPrice;
        this.totalPrice = this.quantity * this.unitPrice; // Recalculate total
    }
    
    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }
    
    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }
    
    // Helper method to recalculate total price
    public void recalculateTotalPrice() {
        this.totalPrice = this.quantity * this.unitPrice;
    }
    
    @Override
    public String toString() {
        return "BillItem{" +
                
                ", billId=" + billId +
                ", itemId='" + itemId + '\'' +
                ", quantity=" + quantity +
                ", unitPrice=" + unitPrice +
                ", totalPrice=" + totalPrice +
                ", itemName='" + itemName + '\'' +
                '}';
    }
}