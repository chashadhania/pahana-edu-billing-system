package com.pahanaedu.controller;

import com.pahanaedu.dao.CustomerDAO;
import com.pahanaedu.model.Customer;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

@WebServlet("/CustomerServlet")
public class CustomerServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null || action.isEmpty()) {
            request.setAttribute("error", "Action parameter is required");
            request.getRequestDispatcher("/Views/error.jsp").forward(request, response);
            return;
        }
        
        try {
            if ("add".equals(action)) {
                // Validate parameters before creating customer
                String accountNumber = validateParameter(request, "accountNumber", "Account number");
                String name = validateParameter(request, "name", "Name");
                String address = validateParameter(request, "address", "Address");
                String telephone = validateParameter(request, "telephone", "Telephone");
                int unitsConsumed = Integer.parseInt(validateParameter(request, "unitsConsumed", "Units consumed"));
                
                Customer customer = new Customer(accountNumber, name, address, telephone, unitsConsumed);
                
                boolean success = CustomerDAO.addCustomer(customer);
                request.setAttribute(success ? "message" : "error", 
                    success ? "Customer added successfully!" : "Failed to add customer");
                request.getRequestDispatcher("/Views/addCustomer.jsp").forward(request, response);
                
            } else if ("edit".equals(action)) {
                // Validate parameters before updating customer
                String accountNumber = validateParameter(request, "accountNumber", "Account number");
                String name = validateParameter(request, "name", "Name");
                String address = validateParameter(request, "address", "Address");
                String telephone = validateParameter(request, "telephone", "Telephone");
                int unitsConsumed = Integer.parseInt(validateParameter(request, "unitsConsumed", "Units consumed"));
                
                Customer customer = new Customer(accountNumber, name, address, telephone, unitsConsumed);
                
                boolean success = CustomerDAO.updateCustomer(customer);
                if (success) {
                    request.setAttribute("message", "Customer updated successfully!");
                    // After successful update, show the updated list
                    doGet(request, response);
                } else {
                    request.setAttribute("error", "Failed to update customer");
                    request.getRequestDispatcher("/Views/editCustomer.jsp").forward(request, response);
                }
                
            } else if ("delete".equals(action)) {
                String accountNumber = validateParameter(request, "accountNumber", "Account number");
                boolean success = CustomerDAO.deleteCustomer(accountNumber);
                
                request.setAttribute(success ? "message" : "error", 
                    success ? "Customer deleted successfully" : "Failed to delete customer");
                doGet(request, response); // Refresh customer list
            } else {
                throw new IllegalArgumentException("Invalid action: " + action);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid number format: " + e.getMessage());
            request.getRequestDispatcher("/Views/error.jsp").forward(request, response);
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/Views/error.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Unexpected error: " + e.getMessage());
            request.getRequestDispatcher("/Views/error.jsp").forward(request, response);
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            if ("edit".equals(action)) {
                String accountNumber = validateParameter(request, "accountNumber", "Account number");
                Customer customer = CustomerDAO.getCustomerByAccount(accountNumber);
                
                if (customer == null) {
                    throw new IllegalArgumentException("Customer with account number " + accountNumber + " not found");
                }
                
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("/Views/editCustomer.jsp").forward(request, response);
            } else if ("search".equals(action)) {
                String searchType = request.getParameter("searchType");
                String searchValue = request.getParameter("searchValue");
                
                if (searchType == null || searchType.isEmpty()) {
                    searchType = "name"; // default search type
                }
                
                List<Customer> customers = CustomerDAO.searchCustomers(searchType, searchValue);
                request.setAttribute("customers", customers);
                request.setAttribute("searched", true);
                request.getRequestDispatcher("/Views/searchCustomer.jsp").forward(request, response);
            } else {
                List<Customer> customers = CustomerDAO.getAllCustomers();
                request.setAttribute("customers", customers);
                request.getRequestDispatcher("/Views/viewCustomers.jsp").forward(request, response);
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/Views/error.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Unexpected error: " + e.getMessage());
            request.getRequestDispatcher("/Views/error.jsp").forward(request, response);
        }
    }
    
    // Helper method to validate request parameters
    private String validateParameter(HttpServletRequest request, String paramName, String displayName) 
            throws IllegalArgumentException {
        String value = request.getParameter(paramName);
        if (value == null || value.trim().isEmpty()) {
            throw new IllegalArgumentException(displayName + " is required");
        }
        return value.trim();
    }
}