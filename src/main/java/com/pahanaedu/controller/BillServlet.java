package com.pahanaedu.controller;

import com.pahanaedu.dao.BillDAO;
import com.pahanaedu.dao.BillItemDAO;
import com.pahanaedu.dao.ItemDAO;
import com.pahanaedu.model.Bill;
import com.pahanaedu.model.BillItem;
import com.pahanaedu.model.Item;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

@WebServlet("/BillServlet")
public class BillServlet extends HttpServlet {
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
	        throws ServletException, IOException {
	    
	    String action = request.getParameter("action");
	    
	    if (action == null || action.isEmpty()) {
	        forwardWithError(request, response, "Action parameter is required");
	        return;
	    }
	    
	    try {
	        switch (action) {
	            case "create":
	                handleCreateBill(request, response);
	                break;
	            case "addItem":
	                handleAddBillItem(request, response);
	                break;
	            case "updateItem":
	                handleUpdateBillItem(request, response);
	                break;
	            case "deleteItem": // Add this missing case
	                handleDeleteBillItem(request, response);
	                break;
	            case "finalize":
	                handleFinalizeBill(request, response);
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
	        if ("view".equals(action)) {
	            handleViewBill(request, response);
	        } else if ("print".equals(action)) {
	            handlePrintBill(request, response);
	        } else if ("new".equals(action)) {
	            handleNewBill(request, response);
	        } else if ("search".equals(action)) {
	            handleSearchBills(request, response);
	        } else {
	            List<Bill> bills = BillDAO.getAllBills();
	            request.setAttribute("bills", bills);
	            forwardToView(request, response, "/Views/viewBills.jsp");
	        }
	    } catch (Exception e) {
	        forwardWithError(request, response, "Error: " + e.getMessage());
	    }
	}
	private void handleSearchBills(HttpServletRequest request, HttpServletResponse response) 
	        throws ServletException, IOException {
	    try {
	        String searchTerm = request.getParameter("searchTerm");
	        String statusFilter = request.getParameter("statusFilter");
	        
	        System.out.println("DEBUG: Search - Term: '" + searchTerm + "', Status: '" + statusFilter + "'");
	        
	        List<Bill> bills;
	        
	        if ((searchTerm == null || searchTerm.trim().isEmpty()) && 
	            (statusFilter == null || statusFilter.isEmpty() || "All".equals(statusFilter))) {
	            // No filters applied, get all bills
	            bills = BillDAO.getAllBills();
	        } else {
	            // Apply filters
	            bills = BillDAO.searchBills(searchTerm, statusFilter);
	        }
	        
	        request.setAttribute("bills", bills);
	        request.setAttribute("searchTerm", searchTerm);
	        request.setAttribute("statusFilter", statusFilter);
	        
	        forwardToView(request, response, "/Views/viewBills.jsp");
	        
	    } catch (Exception e) {
	        System.out.println("DEBUG: Error in search: " + e.getMessage());
	        e.printStackTrace();
	        forwardWithError(request, response, "Search error: " + e.getMessage());
	    }
	}
    private void handleCreateBill(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String customerAccount = validateParameter(request, "customerAccount", "Customer Account");
            
            Bill bill = new Bill();
            bill.setBillId(BillDAO.generateNextBillId());
            bill.setCustomerAccount(customerAccount); // This should accept String
            bill.setTotalAmount(0.0);
            bill.setStatus("Draft");
            
            boolean success = BillDAO.addBill(bill);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/BillServlet?action=new&billId=" + bill.getBillId());
            } else {
                forwardWithError(request, response, "Failed to create bill");
            }
        } catch (Exception e) {
            forwardWithError(request, response, "Error creating bill: " + e.getMessage());
        }
    }
    
    private void handleAddBillItem(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int billId = Integer.parseInt(validateParameter(request, "billId", "Bill ID"));
            String itemId = validateParameter(request, "itemId", "Item ID");
            int quantity = Integer.parseInt(validateParameter(request, "quantity", "Quantity"));
            
            System.out.println("DEBUG: Adding item to bill - BillID: " + billId + ", ItemID: " + itemId + ", Qty: " + quantity);
            
            Item item = ItemDAO.getItemById(itemId);
            if (item == null) {
                throw new IllegalArgumentException("Item not found with ID: " + itemId);
            }
            
            if (quantity <= 0) {
                throw new IllegalArgumentException("Quantity must be positive");
            }
            
            if (quantity > item.getQuantity()) {
                throw new IllegalArgumentException("Insufficient stock. Available: " + item.getQuantity());
            }
            
            // Create BillItem using setter methods instead of constructor
            BillItem billItem = new BillItem();
            billItem.setBillId(billId);
            billItem.setItemId(itemId);
            billItem.setQuantity(quantity);
            billItem.setUnitPrice(item.getPrice());
            
            boolean success = BillItemDAO.addBillItem(billItem);
            
            if (success) {
                // Update item stock
                ItemDAO.updateItemStock(itemId, quantity);
                
                // Update bill total
                double totalAmount = BillItemDAO.getBillTotalAmount(billId);
                Bill bill = BillDAO.getBillById(billId);
                if (bill != null) {
                    bill.setTotalAmount(totalAmount);
                    BillDAO.updateBill(bill);
                }
                
                // Set success message and reload the bill data
                request.setAttribute("message", "Item added successfully!");
                
                // Reload the data
                List<Item> items = ItemDAO.getAllItems();
                List<BillItem> billItems = BillItemDAO.getBillItemsByBillId(billId);
                
                request.setAttribute("billId", billId);
                request.setAttribute("items", items);
                request.setAttribute("billItems", billItems);
                
                System.out.println("DEBUG: Item added successfully, reloading page with bill items: " + billItems.size());
                
                // Forward to the same page instead of redirecting
                forwardToView(request, response, "/Views/createBill.jsp");
                
            } else {
                forwardWithError(request, response, "Failed to add item to bill");
            }
        } catch (NumberFormatException e) {
            forwardWithError(request, response, "Invalid number format");
        }
    }
    
    private void handleUpdateBillItem(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int billId = Integer.parseInt(validateParameter(request, "billId", "Bill ID"));
            String itemId = validateParameter(request, "itemId", "Item ID");
            int quantity = Integer.parseInt(validateParameter(request, "quantity", "Quantity"));
            
            if (quantity <= 0) {
                throw new IllegalArgumentException("Quantity must be positive");
            }
            
            // Get the item to check stock
            Item item = ItemDAO.getItemById(itemId);
            if (item == null) {
                throw new IllegalArgumentException("Item not found with ID: " + itemId);
            }
            
            if (quantity > item.getQuantity()) {
                throw new IllegalArgumentException("Insufficient stock. Available: " + item.getQuantity());
            }
            
            // Create BillItem
            BillItem billItem = new BillItem();
            billItem.setBillId(billId);
            billItem.setItemId(itemId);
            billItem.setQuantity(quantity);
            billItem.setUnitPrice(item.getPrice());
            
            boolean success = BillItemDAO.updateBillItem(billItem);
            
            if (success) {
                // Update bill total
                double totalAmount = BillItemDAO.getBillTotalAmount(billId);
                Bill bill = BillDAO.getBillById(billId);
                if (bill != null) {
                    bill.setTotalAmount(totalAmount);
                    BillDAO.updateBill(bill);
                }
                
                request.setAttribute("message", "Item updated successfully!");
                response.sendRedirect(request.getContextPath() + "/BillServlet?action=new&billId=" + billId);
            } else {
                forwardWithError(request, response, "Failed to update item");
            }
            
        } catch (NumberFormatException e) {
            forwardWithError(request, response, "Invalid number format");
        }
    }
    
    private void handleDeleteBillItem(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int billId = Integer.parseInt(validateParameter(request, "billId", "Bill ID"));
            String itemId = validateParameter(request, "itemId", "Item ID");
            
            // Get the current quantity before deleting
            BillItem billItem = BillItemDAO.getBillItem(billId, itemId);
            
            if (billItem == null) {
                forwardWithError(request, response, "Item not found in bill");
                return;
            }
            
            boolean success = BillItemDAO.deleteBillItem(billId, itemId);
            
            if (success) {
                // Restore item stock
                ItemDAO.restoreItemStock(itemId, billItem.getQuantity());
                
                // Update bill total
                double totalAmount = BillItemDAO.getBillTotalAmount(billId);
                Bill bill = BillDAO.getBillById(billId);
                if (bill != null) {
                    bill.setTotalAmount(totalAmount);
                    BillDAO.updateBill(bill);
                }
                
                response.sendRedirect(request.getContextPath() + "/BillServlet?action=new&billId=" + billId);
            } else {
                forwardWithError(request, response, "Failed to delete item from bill");
            }
        } catch (NumberFormatException e) {
            forwardWithError(request, response, "Invalid number format");
        }
    }
   
    
    private void handleFinalizeBill(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int billId = Integer.parseInt(validateParameter(request, "billId", "Bill ID"));
            
            boolean success = BillDAO.updateBillStatus(billId, "Completed");
            
            if (success) {
                request.setAttribute("message", "Bill finalized successfully!");
                handleViewBill(request, response);
            } else {
                forwardWithError(request, response, "Failed to finalize bill");
            }
        } catch (NumberFormatException e) {
            forwardWithError(request, response, "Invalid bill ID");
        }
    }
    
    private void handleViewBill(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int billId = Integer.parseInt(validateParameter(request, "billId", "Bill ID"));
            
            Bill bill = BillDAO.getBillById(billId);
            if (bill == null) {
                throw new IllegalArgumentException("Bill not found with ID: " + billId);
            }
            
            List<BillItem> billItems = BillItemDAO.getBillItemsByBillId(billId);
            bill.setBillItems(billItems);
            
            request.setAttribute("bill", bill);
            request.setAttribute("billItems", billItems);
            
            forwardToView(request, response, "/Views/viewBill.jsp");
        } catch (NumberFormatException e) {
            forwardWithError(request, response, "Invalid bill ID");
        }
    }
    
    private void handlePrintBill(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int billId = Integer.parseInt(validateParameter(request, "billId", "Bill ID"));
            
            Bill bill = BillDAO.getBillById(billId);
            if (bill == null) {
                throw new IllegalArgumentException("Bill not found with ID: " + billId);
            }
            
            List<BillItem> billItems = BillItemDAO.getBillItemsByBillId(billId);
            
            request.setAttribute("bill", bill);
            request.setAttribute("billItems", billItems);
            
            forwardToView(request, response, "/Views/printBill.jsp");
        } catch (NumberFormatException e) {
            forwardWithError(request, response, "Invalid bill ID");
        }
    }
    
    private void handleNewBill(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Check if billId is provided (for existing bill)
            String billIdParam = request.getParameter("billId");
            
            if (billIdParam != null && !billIdParam.trim().isEmpty()) {
                int billId = Integer.parseInt(billIdParam);
                System.out.println("DEBUG: Loading existing bill: " + billId);
                
                // Get all items from database
                List<Item> items = ItemDAO.getAllItems();
                System.out.println("DEBUG: Items retrieved: " + (items != null ? items.size() : "null"));
                
                // Get bill items
                List<BillItem> billItems = BillItemDAO.getBillItemsByBillId(billId);
                System.out.println("DEBUG: Bill items retrieved: " + (billItems != null ? billItems.size() : "null"));
                
                // Set attributes for JSP
                request.setAttribute("billId", billId);
                request.setAttribute("items", items);
                request.setAttribute("billItems", billItems);
                
                forwardToView(request, response, "/Views/createBill.jsp");
            } else {
                // No billId provided, show form to create new bill
                System.out.println("DEBUG: Showing new bill creation form");
                forwardToView(request, response, "/Views/newBillForm.jsp");
            }
                
        } catch (NumberFormatException e) {
            System.out.println("DEBUG: NumberFormatException: " + e.getMessage());
            forwardWithError(request, response, "Invalid bill ID: " + e.getMessage());
        } catch (Exception e) {
            System.out.println("DEBUG: Exception in handleNewBill: " + e.getMessage());
            e.printStackTrace();
            forwardWithError(request, response, "Error: " + e.getMessage());
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