package com.pahanaedu.dao;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class RoleAuthFilter implements Filter {
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());
        
        // Allow access to login page, authentication servlet, and public resources
        if (path.startsWith("/Views/login.jsp") || 
            path.equals("/AuthServlet") ||
            path.startsWith("/css/") || 
            path.startsWith("/js/") ||
            path.startsWith("/images/") ||
            path.startsWith("/assets/")) {
            chain.doFilter(request, response);
            return;
        }
        
        // Check if user is logged in
        if (session == null || session.getAttribute("username") == null) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/Views/login.jsp");
            return;
        }
        
        String userRole = (String) session.getAttribute("role");
        
        // If role is not set in session, redirect to login
        if (userRole == null) {
            if (session != null) {
                session.invalidate();
            }
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/Views/login.jsp");
            return;
        }
        
        // Role-based access control rules
        
        // Customer Management - Admin only
        if (path.startsWith("/CustomerServlet") || 
            path.contains("addCustomer.jsp") || 
            path.contains("editCustomer.jsp") || 
            path.contains("searchCustomer.jsp") ||
            path.contains("viewCustomers.jsp")) {
            if (!"admin".equals(userRole)) {
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, 
                    "Access denied. Customer management requires admin privileges.");
                return;
            }
        }
        
        // Billing Management - Admin, Manager, and Cashier
        if (path.startsWith("/BillServlet") || 
            path.contains("printBill.jsp") || 
            path.contains("billing")) {
            if (!"admin".equals(userRole) && !"manager".equals(userRole) && !"cashier".equals(userRole)) {
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, 
                    "Access denied. Billing requires admin, manager, or cashier privileges.");
                return;
            }
        }
        
        // Inventory Management - Admin, Manager, and Cashier
        if (path.startsWith("/ItemServlet") || 
            path.contains("addItem.jsp") || 
            path.contains("inventory")) {
            if (!"admin".equals(userRole) && !"manager".equals(userRole) && !"cashier".equals(userRole)) {
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, 
                    "Access denied. Inventory management requires admin, manager, or cashier privileges.");
                return;
            }
        }
        
        // Dashboard access - All authenticated users
        if (path.contains("dashboard.jsp")) {
            // All roles can access dashboard
            chain.doFilter(request, response);
            return;
        }
        
        // Help page - All authenticated users
        if (path.contains("Help.jsp")) {
            // All roles can access help
            chain.doFilter(request, response);
            return;
        }
        
        chain.doFilter(request, response);
    }
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
        System.out.println("RoleAuthFilter initialized");
    }
    
    @Override
    public void destroy() {
        // Cleanup code if needed
        System.out.println("RoleAuthFilter destroyed");
    }
}