package com.pahanaedu.dao;

import com.pahanaedu.model.Customer;
import com.pahanaedu.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {
    public static boolean addCustomer(Customer customer) {
        String sql = "INSERT INTO customers (account_number, name, address, telephone, units_consumed) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, customer.getAccountNumber());
            stmt.setString(2, customer.getName());
            stmt.setString(3, customer.getAddress());
            stmt.setString(4, customer.getTelephone());
            stmt.setInt(5, customer.getUnitsConsumed());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public static List<Integer> getAllCustomerAccounts() {
        List<Integer> accounts = new ArrayList<>();
        String sql = "SELECT DISTINCT account_number FROM customers ORDER BY account_number";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                accounts.add(rs.getInt("account_number"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return accounts;
    }
    public static List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM customers ORDER BY name";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                customers.add(new Customer(
                    rs.getString("account_number"),
                    rs.getString("name"),
                    rs.getString("address"),
                    rs.getString("telephone"),
                    rs.getInt("units_consumed")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }
    public static List<String> getAllCustomerAccountNumbers() {
        List<String> accountNumbers = new ArrayList<>();
        String sql = "SELECT account_number FROM customers ORDER BY account_number";
        
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                accountNumbers.add(rs.getString("account_number"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return accountNumbers;
    }
    public static Customer getCustomerByAccount(String accountNumber) {
        String sql = "SELECT * FROM customers WHERE account_number = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, accountNumber);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Customer(
                        rs.getString("account_number"),
                        rs.getString("name"),
                        rs.getString("address"),
                        rs.getString("telephone"),
                        rs.getInt("units_consumed")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public static boolean updateCustomer(Customer customer) {
        String sql = "UPDATE customers SET name=?, address=?, telephone=?, units_consumed=? WHERE account_number=?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, customer.getName());
            stmt.setString(2, customer.getAddress());
            stmt.setString(3, customer.getTelephone());
            stmt.setInt(4, customer.getUnitsConsumed());
            stmt.setString(5, customer.getAccountNumber());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public static boolean deleteCustomer(String accountNumber) {
        String sql = "DELETE FROM customers WHERE account_number = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, accountNumber);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public static List<Customer> searchCustomers(String searchType, String searchValue) {
        List<Customer> customers = new ArrayList<>();
        String sql;
        
        if ("all".equals(searchType)) {
            sql = "SELECT * FROM customers ORDER BY name";
            try (Connection conn = DBUtil.getConnection();
                 Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(sql)) {
                
                while (rs.next()) {
                    customers.add(new Customer(
                        rs.getString("account_number"),
                        rs.getString("name"),
                        rs.getString("address"),
                        rs.getString("telephone"),
                        rs.getInt("units_consumed")
                    ));
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } else {
            sql = "SELECT * FROM customers WHERE " + searchType + " LIKE ? ORDER BY name";
            try (Connection conn = DBUtil.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {
                
                stmt.setString(1, "%" + searchValue + "%");
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        customers.add(new Customer(
                            rs.getString("account_number"),
                            rs.getString("name"),
                            rs.getString("address"),
                            rs.getString("telephone"),
                            rs.getInt("units_consumed")
                        ));
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return customers;
    }
}