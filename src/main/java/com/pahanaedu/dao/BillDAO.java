package com.pahanaedu.dao;

import com.pahanaedu.model.Bill;
import com.pahanaedu.model.Customer;
import com.pahanaedu.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDAO {
    
    public static int generateNextBillId() {
        String sql = "SELECT MAX(bill_id) FROM bills";
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                int maxId = rs.getInt(1);
                return maxId + 1;
            }
        } catch (SQLException e) {
            handleSQLException(e, "Error generating next bill ID");
        }
        return 1001; // Starting ID
    }
    
    public static boolean addBill(Bill bill) {
        String sql = "INSERT INTO bills (bill_id, customer_account, total_amount, bill_date, status) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, bill.getBillId());
            stmt.setString(2, bill.getCustomerAccount());
            stmt.setDouble(3, bill.getTotalAmount());
            stmt.setTimestamp(4, new Timestamp(bill.getBillDate().getTime()));
            stmt.setString(5, bill.getStatus());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            handleSQLException(e, "Error adding bill: " + bill);
            return false;
        }
    }
    public static List<Bill> searchBills(String searchTerm, String statusFilter) {
        List<Bill> bills = new ArrayList<>();
        
        StringBuilder sql = new StringBuilder("SELECT * FROM bills WHERE 1=1");
        List<Object> params = new ArrayList<>();
        
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            sql.append(" AND (bill_id LIKE ? OR customer_account LIKE ?)");
            String likeTerm = "%" + searchTerm + "%";
            params.add(likeTerm);
            params.add(likeTerm);
        }
        
        if (statusFilter != null && !statusFilter.isEmpty() && !"All".equals(statusFilter)) {
            sql.append(" AND status = ?");
            params.add(statusFilter);
        }
        
        sql.append(" ORDER BY bill_id DESC");
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Bill bill = new Bill();
                    bill.setBillId(rs.getInt("bill_id"));
                    bill.setCustomerAccount(rs.getString("customer_account"));
                    bill.setTotalAmount(rs.getDouble("total_amount"));
                    bill.setStatus(rs.getString("status"));
                    bills.add(bill);
                }
            }
        } catch (SQLException e) {
            System.out.println("DEBUG: SQL Error in searchBills: " + e.getMessage());
            e.printStackTrace();
        }
        
        return bills;
    }
    public static List<Bill> getAllBills() {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT * FROM bills ORDER BY bill_date DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                bills.add(mapRowToBill(rs));
            }
        } catch (SQLException e) {
            handleSQLException(e, "Error retrieving all bills");
        }
        return bills;
    }
   
    
    public static Bill getBillById(int billId) {
        String sql = "SELECT * FROM bills WHERE bill_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, billId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRowToBill(rs);
                }
            }
        } catch (SQLException e) {
            handleSQLException(e, "Error retrieving bill with ID: " + billId);
        }
        return null;
    }
    
    public static List<Bill> getBillsByCustomerAccount(int customerAccount) {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT * FROM bills WHERE customer_account = ? ORDER BY bill_date DESC";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, customerAccount);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    bills.add(mapRowToBill(rs));
                }
            }
        } catch (SQLException e) {
            handleSQLException(e, "Error retrieving bills for customer: " + customerAccount);
        }
        return bills;
    }
    
    public static boolean updateBill(Bill bill) {
        String sql = "UPDATE bills SET total_amount = ?, status = ? WHERE bill_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setDouble(1, bill.getTotalAmount());
            stmt.setString(2, bill.getStatus());
            stmt.setInt(3, bill.getBillId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            handleSQLException(e, "Error updating bill: " + bill);
            return false;
        }
    }
    
    public static boolean updateBillStatus(int billId, String status) {
        String sql = "UPDATE bills SET status = ? WHERE bill_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            stmt.setInt(2, billId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            handleSQLException(e, "Error updating bill status for ID: " + billId);
            return false;
        }
    }
    
    public static boolean deleteBill(int billId) {
        // First delete bill items
        if (!BillItemDAO.deleteBillItemsByBillId(billId)) {
            return false;
        }
        
        // Then delete the bill
        String sql = "DELETE FROM bills WHERE bill_id = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, billId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            handleSQLException(e, "Error deleting bill with ID: " + billId);
            return false;
        }
    }
    
    private static Bill mapRowToBill(ResultSet rs) throws SQLException {
        Bill bill = new Bill();
        bill.setBillId(rs.getInt("bill_id"));
        bill.setCustomerAccount(rs.getString("customer_account"));
        bill.setTotalAmount(rs.getDouble("total_amount"));
        bill.setBillDate(rs.getTimestamp("bill_date"));
        bill.setStatus(rs.getString("status"));
        return bill;
    }
    
    private static void handleSQLException(SQLException e, String context) {
        System.err.println(context);
        e.printStackTrace();
    }
}