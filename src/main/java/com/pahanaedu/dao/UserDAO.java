package com.pahanaedu.dao;

import com.pahanaedu.util.DBUtil;
import java.sql.*;

public class UserDAO {

    // Validate user and return role if credentials are correct
    public static String validateUser(String username, String password) {
        String sql = "SELECT role FROM users WHERE username = ? AND password = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username);
            stmt.setString(2, password); // Hash here if your DB uses hashed passwords
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    String role = rs.getString("role");
                    System.out.println("Login successful for user: " + username + ", role: " + role);
                    return role; // Return role if login successful
                } else {
                    System.out.println("Login failed for user: " + username);
                    return null;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}
