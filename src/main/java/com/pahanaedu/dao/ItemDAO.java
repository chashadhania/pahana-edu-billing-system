package com.pahanaedu.dao;

import com.pahanaedu.model.Item;
import com.pahanaedu.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemDAO {
    
    // Method to generate the next available item ID
    public static String generateNextItemId() {
        String sql = "SELECT MAX(item_id) FROM items";
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                String maxId = rs.getString(1);
                if (maxId == null) {
                    return "ITEM1001"; // Starting ID
                }
                // Extract numeric part and increment
                int num = Integer.parseInt(maxId.replaceAll("\\D+", "")) + 1;
                return "ITEM" + num;
            }
        } catch (SQLException e) {
            handleSQLException(e, "Error generating next item ID");
        }
        return "ITEM1001"; // Fallback
    }

    public static boolean addItem(Item item) {
        // Generate ID if not provided
        if (item.getItemId() == null || item.getItemId().isEmpty()) {
            item.setItemId(generateNextItemId());
        }
        
        String sql = "INSERT INTO items (item_id, name, price, quantity) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, item.getItemId());
            stmt.setString(2, item.getName());
            stmt.setDouble(3, item.getPrice());
            stmt.setInt(4, item.getQuantity());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            handleSQLException(e, "Error adding item: " + item);
            return false;
        }
    }
    
 // In ItemDAO class
    public static List<Item> getAllItems() {
        List<Item> items = new ArrayList<>();
        String query = "SELECT * FROM Items WHERE quantity > 0"; // Only show items with stock
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                Item item = new Item();
                item.setItemId(rs.getString("item_id"));
                item.setName(rs.getString("name"));
                item.setPrice(rs.getDouble("price"));
                item.setQuantity(rs.getInt("quantity"));
                items.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }
    // Update getItemById() to handle String IDs
    public static Item getItemById(String itemId) {
        String sql = "SELECT * FROM items WHERE item_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, itemId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRowToItem(rs);
                }
            }
        } catch (SQLException e) {
            handleSQLException(e, "Error retrieving item with ID: " + itemId);
        }
        return null;
    }
    
    // Update updateItem() to handle String IDs
    public static boolean updateItem(Item item) {
        String sql = "UPDATE items SET name = ?, price = ?, quantity = ? WHERE item_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, item.getName());
            stmt.setDouble(2, item.getPrice());
            stmt.setInt(3, item.getQuantity());
            stmt.setString(4, item.getItemId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            handleSQLException(e, "Error updating item: " + item);
            return false;
        }
    }
    
    // NEW METHOD: Update item stock (deduct quantity)
    public static boolean updateItemStock(String itemId, int quantityToDeduct) {
        String sql = "UPDATE items SET quantity = quantity - ? WHERE item_id = ? AND quantity >= ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, quantityToDeduct);
            stmt.setString(2, itemId);
            stmt.setInt(3, quantityToDeduct);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            handleSQLException(e, "Error updating item stock for ID: " + itemId);
            return false;
        }
    }
    
    // NEW METHOD: Restore item stock (add back quantity)
    public static boolean restoreItemStock(String itemId, int quantityToRestore) {
        String sql = "UPDATE items SET quantity = quantity + ? WHERE item_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, quantityToRestore);
            stmt.setString(2, itemId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            handleSQLException(e, "Error restoring item stock for ID: " + itemId);
            return false;
        }
    }
    
    // NEW METHOD: Check if item has sufficient stock
    public static boolean hasSufficientStock(String itemId, int requiredQuantity) {
        String sql = "SELECT quantity FROM items WHERE item_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, itemId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int currentStock = rs.getInt("quantity");
                    return currentStock >= requiredQuantity;
                }
            }
        } catch (SQLException e) {
            handleSQLException(e, "Error checking stock for item ID: " + itemId);
        }
        return false;
    }
    
    // Update deleteItem() to handle String IDs
    public static boolean deleteItem(String itemId) {
        // First delete from dependent tables
        if (!deleteDependentRecords(itemId)) {
            return false;
        }
        
        // Then delete the item
        String sql = "DELETE FROM items WHERE item_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, itemId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            handleSQLException(e, "Error deleting item with ID: " + itemId);
            return false;
        }
    }
    
    // Helper method to delete dependent records
    private static boolean deleteDependentRecords(String itemId) {
        String[] dependentTables = {"bill_items", "other_related_table"};
        
        try (Connection conn = DBUtil.getConnection()) {
            // Disable foreign key checks temporarily
            try (Statement stmt = conn.createStatement()) {
                stmt.execute("SET FOREIGN_KEY_CHECKS=0");
            }
            
            // Delete from each dependent table
            for (String table : dependentTables) {
                String sql = "DELETE FROM " + table + " WHERE item_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, itemId);
                    stmt.executeUpdate();
                }
            }
            
            // Re-enable foreign key checks
            try (Statement stmt = conn.createStatement()) {
                stmt.execute("SET FOREIGN_KEY_CHECKS=1");
            }
            
            return true;
        } catch (SQLException e) {
            handleSQLException(e, "Error deleting dependent records for item: " + itemId);
            return false;
        }
    }
    
    // Updated mapper for String IDs
    private static Item mapRowToItem(ResultSet rs) throws SQLException {
        Item item = new Item();
        item.setItemId(rs.getString("item_id"));
        item.setName(rs.getString("name"));
        item.setPrice(rs.getDouble("price"));
        item.setQuantity(rs.getInt("quantity"));
        return item;
    }
    
    private static void handleSQLException(SQLException e, String context) {
        System.err.println(context);
        e.printStackTrace();
        // Consider adding logging here
    }
    
    
}