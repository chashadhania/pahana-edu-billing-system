package com.pahanaedu.controller;

import com.pahanaedu.dao.ItemDAO;
import com.pahanaedu.model.Item;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet("/ItemServlet")
public class ItemServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null || action.isEmpty()) {
            forwardWithError(request, response, "Action parameter is required");
            return;
        }
        
        try {
            switch (action) {
                case "add":
                    handleAddItem(request, response);
                    break;
                case "edit":
                    handleEditItem(request, response);
                    break;
                case "delete":
                    handleDeleteItem(request, response);
                    break;
                default:
                    throw new IllegalArgumentException("Invalid action: " + action);
            }
        } catch (NumberFormatException e) {
            forwardWithError(request, response, "Invalid number format: " + e.getMessage());
        } catch (IllegalArgumentException e) {
            forwardWithError(request, response, e.getMessage());
        } catch (Exception e) {
            forwardWithError(request, response, "Unexpected error: " + e.getMessage());
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            if ("edit".equals(action)) {
                String itemId = validateParameter(request, "itemId", "Item ID");
                Item item = ItemDAO.getItemById(itemId);
                
                if (item == null) {
                    throw new IllegalArgumentException("Item with ID " + itemId + " not found");
                }
                
                request.setAttribute("item", item);
                forwardToView(request, response, "/Views/editItem.jsp");
            } else if ("add".equals(action)) {
                forwardToView(request, response, "/Views/addItem.jsp");
            } else {
                List<Item> items = ItemDAO.getAllItems();
                request.setAttribute("items", items);
                forwardToView(request, response, "/Views/viewItems.jsp");
            }
        } catch (Exception e) {
            forwardWithError(request, response, "Error: " + e.getMessage());
        }
    }
    
    private void handleAddItem(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            Item item = new Item();
            item.setName(validateParameter(request, "name", "Name"));
            item.setPrice(Double.parseDouble(validateParameter(request, "price", "Price")));
            item.setQuantity(Integer.parseInt(validateParameter(request, "quantity", "Quantity")));
            
            // Set timestamps (handled automatically in Item constructor)
            // Additional validation
            if (item.getPrice() <= 0) {
                throw new IllegalArgumentException("Price must be positive");
            }
            if (item.getQuantity() < 0) {
                throw new IllegalArgumentException("Quantity cannot be negative");
            }
            
            System.out.println("Attempting to add item: " + item);
            
            boolean success = ItemDAO.addItem(item);
            
            if (success) {
                request.setAttribute("message", "Item added successfully! ID: " + item.getItemId());
                System.out.println("Item added successfully with ID: " + item.getItemId());
            } else {
                request.setAttribute("error", "Failed to add item. Please check server logs.");
            }
        } catch (NumberFormatException e) {
            String errorMsg = "Invalid number format: " + e.getMessage();
            request.setAttribute("error", errorMsg);
            System.err.println(errorMsg);
        } catch (IllegalArgumentException e) {
            String errorMsg = "Validation error: " + e.getMessage();
            request.setAttribute("error", errorMsg);
            System.err.println(errorMsg);
        } catch (Exception e) {
            String errorMsg = "Unexpected error: " + e.getMessage();
            request.setAttribute("error", errorMsg);
            System.err.println(errorMsg);
            e.printStackTrace();
        }
        
        forwardToView(request, response, "/Views/addItem.jsp");
    }
    
    private void handleEditItem(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            Item item = new Item();
            item.setItemId(validateParameter(request, "itemId", "Item ID"));
            item.setName(validateParameter(request, "name", "Name"));
            item.setPrice(Double.parseDouble(validateParameter(request, "price", "Price")));
            item.setQuantity(Integer.parseInt(validateParameter(request, "quantity", "Quantity")));
            item.setUpdatedAt(LocalDateTime.now());
            
            // Additional validation
            if (item.getPrice() <= 0) {
                throw new IllegalArgumentException("Price must be positive");
            }
            if (item.getQuantity() < 0) {
                throw new IllegalArgumentException("Quantity cannot be negative");
            }
            
            boolean success = ItemDAO.updateItem(item);
            
            if (success) {
                request.setAttribute("message", "Item updated successfully!");
            } else {
                request.setAttribute("error", "Failed to update item");
            }
            doGet(request, response);
        } catch (NumberFormatException e) {
            forwardWithError(request, response, "Invalid number format: " + e.getMessage());
        } catch (IllegalArgumentException e) {
            forwardWithError(request, response, e.getMessage());
        }
    }
    
    private void handleDeleteItem(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String itemId = validateParameter(request, "itemId", "Item ID");
            System.out.println("Attempting to delete item with ID: " + itemId);
            
            boolean success = ItemDAO.deleteItem(itemId);
            System.out.println("Delete operation result: " + success);
            
            HttpSession session = request.getSession();
            if (success) {
                session.setAttribute("message", "Item deleted successfully");
            } else {
                session.setAttribute("error", "Failed to delete item. It may be referenced by other records.");
            }
            
            response.sendRedirect(request.getContextPath() + "/ItemServlet");
            
        } catch (IllegalArgumentException e) {
            HttpSession session = request.getSession();
            session.setAttribute("error", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/ItemServlet");
        } catch (Exception e) {
            HttpSession session = request.getSession();
            session.setAttribute("error", "Unexpected error during deletion: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/ItemServlet");
        }
    }
    
    private String validateParameter(HttpServletRequest request, String paramName, String displayName) {
        String value = request.getParameter(paramName);
        if (value == null || value.trim().isEmpty()) {
            throw new IllegalArgumentException(displayName + " is required");
        }
        return value.trim();
    }
    
    private void forwardToView(HttpServletRequest request, HttpServletResponse response, String view) 
            throws ServletException, IOException {
        request.getRequestDispatcher(view).forward(request, response);
    }
    
    private void forwardWithError(HttpServletRequest request, HttpServletResponse response, String error) 
            throws ServletException, IOException {
        request.setAttribute("error", error);
        forwardToView(request, response, "/Views/error.jsp");
    }
}