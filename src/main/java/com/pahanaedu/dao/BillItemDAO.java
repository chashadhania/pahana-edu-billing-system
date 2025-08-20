package com.pahanaedu.dao;

import com.pahanaedu.model.BillItem;
import com.pahanaedu.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillItemDAO {
    
	public static BillItem getBillItem(int billId, String itemId) {
	    String sql = "SELECT bi.bill_id, bi.item_id, bi.quantity, bi.unit_price, i.name as item_name " +
	                 "FROM bill_items bi " +
	                 "JOIN items i ON bi.item_id = i.item_id " +
	                 "WHERE bi.bill_id = ? AND bi.item_id = ?";
	    
	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {
	        
	        stmt.setInt(1, billId);
	        stmt.setString(2, itemId);
	        
	        try (ResultSet rs = stmt.executeQuery()) {
	            if (rs.next()) {
	                BillItem billItem = new BillItem();
	                billItem.setBillId(rs.getInt("bill_id"));
	                billItem.setItemId(rs.getString("item_id"));
	                billItem.setQuantity(rs.getInt("quantity"));
	                billItem.setUnitPrice(rs.getDouble("unit_price"));
	                
	                // Calculate total price
	                double totalPrice = billItem.getQuantity() * billItem.getUnitPrice();
	                billItem.setTotalPrice(totalPrice);
	                
	                billItem.setItemName(rs.getString("item_name"));
	                return billItem;
	            }
	        }
	    } catch (SQLException e) {
	        handleSQLException(e, "Error getting bill item for billId: " + billId + ", itemId: " + itemId);
	    }
	    return null;
	}
	public static boolean addBillItem(BillItem billItem) {
	    String sql = "INSERT INTO bill_items (bill_id, item_id, quantity, unit_price) VALUES (?, ?, ?, ?)";
	    
	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {
	        
	        stmt.setInt(1, billItem.getBillId());
	        stmt.setString(2, billItem.getItemId());
	        stmt.setInt(3, billItem.getQuantity());
	        stmt.setDouble(4, billItem.getUnitPrice());
	        
	        boolean result = stmt.executeUpdate() > 0;
	        System.out.println("DEBUG: Database insert result: " + result);
	        return result;
	        
	    } catch (SQLException e) {
	        System.out.println("DEBUG: SQL Exception in addBillItem: " + e.getMessage());
	        e.printStackTrace();
	        return false;
	    }
	}
    public static List<BillItem> getBillItemsByBillId(int billId) {
        System.out.println("DEBUG: BillItemDAO.getBillItemsByBillId(" + billId + ") called");
        List<BillItem> billItems = new ArrayList<>();
        String query = "SELECT bi.bill_id, bi.item_id, bi.quantity, bi.unit_price, i.name as item_name " +
                       "FROM bill_items bi " +
                       "JOIN items i ON bi.item_id = i.item_id " +
                       "WHERE bi.bill_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, billId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                BillItem billItem = new BillItem();
                billItem.setBillId(rs.getInt("bill_id"));
                billItem.setItemId(rs.getString("item_id"));
                billItem.setQuantity(rs.getInt("quantity"));
                billItem.setUnitPrice(rs.getDouble("unit_price"));
                
                // Calculate total price since there's no total_amount column
                double totalPrice = billItem.getQuantity() * billItem.getUnitPrice();
                billItem.setTotalPrice(totalPrice);
                
                billItem.setItemName(rs.getString("item_name"));
                
                billItems.add(billItem);
                System.out.println("DEBUG: Added bill item - ID: " + billItem.getItemId() + 
                                  ", Name: " + billItem.getItemName() +
                                  ", Total: " + billItem.getTotalPrice());
            }
            
            System.out.println("DEBUG: Total bill items retrieved: " + billItems.size());
            
        } catch (SQLException e) {
            System.out.println("DEBUG: SQLException in getBillItemsByBillId: " + e.getMessage());
            e.printStackTrace();
        }
        
        return billItems;
    }
    
    public static boolean updateBillItem(BillItem billItem) {
        // Use bill_id and item_id as composite key since there's no bill_item_id
        String sql = "UPDATE bill_items SET quantity = ?, unit_price = ? WHERE bill_id = ? AND item_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, billItem.getQuantity());
            stmt.setDouble(2, billItem.getUnitPrice());
            stmt.setInt(3, billItem.getBillId());
            stmt.setString(4, billItem.getItemId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            handleSQLException(e, "Error updating bill item: " + billItem);
            return false;
        }
    }
    
    public static boolean deleteBillItem(int billId, String itemId) {
        String sql = "DELETE FROM bill_items WHERE bill_id = ? AND item_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, billId);
            stmt.setString(2, itemId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            handleSQLException(e, "Error deleting bill item with BillID: " + billId + ", ItemID: " + itemId);
            return false;
        }
    }
    
    public static boolean deleteBillItemsByBillId(int billId) {
        String sql = "DELETE FROM bill_items WHERE bill_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, billId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            handleSQLException(e, "Error deleting bill items for bill ID: " + billId);
            return false;
        }
    }
    
    public static double getBillTotalAmount(int billId) {
        String sql = "SELECT SUM(quantity * unit_price) as total_amount FROM bill_items WHERE bill_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, billId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("total_amount");
                }
            }
        } catch (SQLException e) {
            handleSQLException(e, "Error calculating total amount for bill ID: " + billId);
        }
        return 0.0;
    }
    
    public static void checkTableStructure() {
        String sql = "DESCRIBE bill_items";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            System.out.println("DEBUG: bill_items table structure:");
            while (rs.next()) {
                System.out.println("Column: " + rs.getString("Field") + 
                                 ", Type: " + rs.getString("Type"));
            }
        } catch (SQLException e) {
            System.out.println("DEBUG: Error checking table structure: " + e.getMessage());
        }
    }
    
    private static void handleSQLException(SQLException e, String context) {
        System.err.println(context);
        e.printStackTrace();
    }
}