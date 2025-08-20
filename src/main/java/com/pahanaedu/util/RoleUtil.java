package com.pahanaedu.util;

import javax.servlet.http.HttpSession;

public class RoleUtil {
    public static final String ROLE_ADMIN = "admin";
    public static final String ROLE_MANAGER = "manager";
    public static final String ROLE_CASHIER = "cashier";
    
    public static boolean hasRole(HttpSession session, String requiredRole) {
        if (session == null) return false;
        
        String userRole = (String) session.getAttribute("role");
        if (userRole == null) return false;
        
        // Admin has access to everything
        if (ROLE_ADMIN.equals(userRole)) return true;
        
        // Check if user's role matches required role
        return userRole.equals(requiredRole);
    }
    
    public static boolean hasAccessToCustomerManagement(HttpSession session) {
        return hasRole(session, ROLE_ADMIN);
    }
    
    public static boolean hasAccessToBilling(HttpSession session) {
        String userRole = (String) session.getAttribute("role");
        return userRole != null && 
               (ROLE_ADMIN.equals(userRole) || 
                ROLE_MANAGER.equals(userRole) || 
                ROLE_CASHIER.equals(userRole));
    }
    
    public static boolean hasAccessToInventory(HttpSession session) {
        String userRole = (String) session.getAttribute("role");
        return userRole != null && 
               (ROLE_ADMIN.equals(userRole) || 
                ROLE_MANAGER.equals(userRole) || 
                ROLE_CASHIER.equals(userRole));
    }
}