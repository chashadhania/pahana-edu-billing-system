<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Help Center - Pahana Edu Bookshop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary: #3498db;
            --secondary: #2980b9;
            --accent: #e74c3c;
            --light: #ecf0f1;
            --dark: #2c3e50;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            color: #333;
            line-height: 1.6;
        }
        
        .navbar {
            background-color: var(--primary);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        .help-header {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            color: white;
            padding: 3rem 0;
            margin-bottom: 2rem;
            border-radius: 0 0 20px 20px;
        }
        
        .help-card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            margin-bottom: 20px;
            height: 100%;
        }
        
        .help-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
        }
        
        .help-card .card-header {
            background-color: var(--primary);
            color: white;
            border-radius: 10px 10px 0 0 !important;
            font-weight: 600;
        }
        
        .step-number {
            display: inline-block;
            width: 30px;
            height: 30px;
            background-color: var(--secondary);
            color: white;
            text-align: center;
            line-height: 30px;
            border-radius: 50%;
            margin-right: 10px;
            font-weight: bold;
        }
        
        .help-section {
            margin-bottom: 3rem;
        }
        
        .section-title {
            border-left: 5px solid var(--secondary);
            padding-left: 15px;
            margin-bottom: 25px;
            color: var(--dark);
        }
        
        .search-box {
            max-width: 500px;
            margin: 0 auto 30px;
        }
        
        .feature-icon {
            font-size: 1.5rem;
            color: var(--secondary);
            margin-bottom: 15px;
        }
        
        .quick-links {
            background-color: var(--light);
            border-radius: 10px;
            padding: 20px;
            position: sticky;
            top: 20px;
        }
        
        .quick-links .list-group-item {
            border: none;
            border-left: 3px solid transparent;
            transition: all 0.3s ease;
        }
        
        .quick-links .list-group-item:hover {
            border-left: 3px solid var(--secondary);
            background-color: #f8f9fa;
        }
        
        .contact-support {
            background: linear-gradient(135deg, var(--secondary) 0%, var(--primary) 100%);
            color: white;
            border-radius: 10px;
            padding: 30px;
        }
        
        footer {
            background-color:#3498db;
            color: white;
            padding: 2rem 0;
            margin-top: 3rem;
        }
        
        .back-to-top {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: var(--secondary);
            color: white;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease;
            z-index: 1000;
        }
        
        .back-to-top:hover {
            background-color: var(--primary);
            transform: translateY(-3px);
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="fas fa-book-open me-2"></i>Pahana Edu Bookshop
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
              
            </div>
        </div>
    </nav>

    <!-- Header Section -->
    <header class="help-header text-center">
        <div class="container">
            <h1 class="display-4 fw-bold"><i class="fas fa-question-circle me-2"></i>Help Center</h1>
            <p class="lead">Everything you need to know to use the Pahana Edu Bookshop System</p>
            
          
        </div>
    </header>

    <!-- Main Content -->
    <div class="container">
        <div class="row">
            <!-- Quick Links Sidebar -->
            <div class="col-lg-4">
                <div class="quick-links mb-4">
                    <h4 class="mb-3">Quick Links</h4>
                    <div class="list-group">
                        <a href="#getting-started" class="list-group-item list-group-item-action">
                            <i class="fas fa-play-circle me-2"></i>Getting Started
                        </a>
                        <a href="#inventory" class="list-group-item list-group-item-action">
                            <i class="fas fa-boxes me-2"></i>Bookstore Management
                        </a>
                        <a href="#billing" class="list-group-item list-group-item-action">
                            <i class="fas fa-receipt me-2"></i>Billing & Invoicing
                        </a>
                        <a href="#customer" class="list-group-item list-group-item-action">
                            <i class="fas fa-users me-2"></i>Customer Management
                        </a>
                       
                        <a href="#troubleshooting" class="list-group-item list-group-item-action">
                            <i class="fas fa-wrench me-2"></i>Troubleshooting
                        </a>
                    </div>
                </div>
                
                <div class="contact-support text-center p-4 mb-4">
                    <h4><i class="fas fa-headset me-2"></i>Need More Help?</h4>
                    <p>Our support team is here to assist you</p>
                    <a href="mailto:support@pahanaedubookshop.com" class="btn btn-light btn-sm mt-2">
                        <i class="fas fa-envelope me-1"></i> Contact Support
                    </a>
                </div>
            </div>
            
            <!-- Help Content -->
            <div class="col-lg-8">
                <!-- Getting Started Section -->
                <section id="getting-started" class="help-section">
                    <h2 class="section-title">Getting Started</h2>
                    
                    <div class="row">
                        <div class="col-md-6 mb-4">
                            <div class="help-card card">
                                <div class="card-header">System Overview</div>
                                <div class="card-body">
                                    <p>The Pahana Edu Bookshop System helps you manage inventory, customers, and billing in one place.</p>
                                    <ul>
                                        <li>Track book inventory levels</li>
                                        <li>Manage customer accounts</li>
                                        <li>Create and print invoices</li>
                                        <li>Generate sales reports</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-6 mb-4">
                            <div class="help-card card">
                                <div class="card-header">Login & Navigation</div>
                                <div class="card-body">
                                    <p><strong>To access the system:</strong></p>
                                    <ol>
                                        <li>Open your web browser and go to the system URL</li>
                                        <li>Enter your username and password</li>
                                        <li>Click the Login button</li>
                                    </ol>
                                    <p>After logging in, use the main menu to navigate between different sections.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                
                <!-- Inventory Management Section -->
                <section id="inventory" class="help-section">
                    <h2 class="section-title">Bookstore Management</h2>
                    
                    <div class="help-card card mb-4">
                        <div class="card-header">Adding New Items</div>
                        <div class="card-body">
                            <p><span class="step-number">1</span> From the dashboard, click on <strong>BookStore Management</strong></p>
                            <p><span class="step-number">2</span> Click the <strong>Add New Item</strong> button</p>
                            <p><span class="step-number">3</span> Fill in the item details (ID, Name, Price, Quantity)</p>
                            <p><span class="step-number">4</span> Click <strong>Save Item</strong> to add to inventory</p>
                        </div>
                    </div>
                    
                    <div class="help-card card mb-4">
                        <div class="card-header">Editing & Deleting Items</div>
                        <div class="card-body">
                            <p><span class="step-number">1</span> Go to <strong>BookStore Management</strong></p>
                            <p><span class="step-number">2</span> Find the item you want to modify</p>
                            <p><span class="step-number">3</span> Click the <strong>Edit</strong> button to update details</p>
                            <p><span class="step-number">4</span> Click the <strong>Delete</strong> button to remove an item</p>
                            <div class="alert alert-warning mt-3">
                                <i class="fas fa-exclamation-triangle me-2"></i>
                                <strong>Note:</strong> Deleting an item will remove it permanently from the system.
                            </div>
                        </div>
                    </div>
                </section>
                
                <!-- Billing Section -->
                <section id="billing" class="help-section">
                    <h2 class="section-title">Billing & Invoicing</h2>
                    
                    <div class="help-card card mb-4">
                        <div class="card-header">Creating a New Bill</div>
                        <div class="card-body">
                            <p><span class="step-number">1</span> Click on <strong>Billing</strong> in the main menu</p>
                            <p><span class="step-number">2</span> Select a customer account or create a new one</p>
                            <p><span class="step-number">3</span> Add items to the bill by searching and selecting from inventory</p>
                            <p><span class="step-number">4</span> Adjust quantities as needed</p>
                            <p><span class="step-number">5</span> Click <strong>Generate Bill</strong> to create the invoice</p>
                        </div>
                    </div>
                    
                    <div class="help-card card mb-4">
                        <div class="card-header">Printing Invoices</div>
                        <div class="card-body">
                            <p><span class="step-number">1</span> After generating a bill, click the <strong>Print</strong> button</p>
                            <p><span class="step-number">2</span> Review the invoice preview</p>
                            <p><span class="step-number">3</span> Select your printer and adjust settings if needed</p>
                            <p><span class="step-number">4</span> Click <strong>Print</strong> to get a hard copy</p>
                            <p class="mt-3">You can also save invoices as PDF for digital records.</p>
                        </div>
                    </div>
                </section>
                
                <!-- Customer Management Section -->
                <section id="customer" class="help-section">
                    <h2 class="section-title">Customer Management</h2>
                    
                    <div class="row">
                        <div class="col-md-6 mb-4">
                            <div class="help-card card">
                                <div class="card-header">Adding Customers</div>
                                <div class="card-body">
                                    <p><span class="step-number">1</span> Go to <strong>Customer Management</strong></p>
                                    <p><span class="step-number">2</span> Click <strong>Add New Customer</strong></p>
                                    <p><span class="step-number">3</span> Fill in customer details (Name, Account Number, Contact Info)</p>
                                    <p><span class="step-number">4</span> Click <strong>Save Customer</strong></p>
                                </div>
                            </div>
                        </div>
                        
                </section>
                
                <!-- Reports Section -->
               
                <!-- Troubleshooting Section -->
                <section id="troubleshooting" class="help-section">
                    <h2 class="section-title">Troubleshooting</h2>
                    
                    <div class="help-card card mb-4">
                        <div class="card-header">Common Issues & Solutions</div>
                        <div class="card-body">
                            <div class="accordion" id="troubleshootingAccordion">
                                <div class="accordion-item">
                                    <h2 class="accordion-header">
                                        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#issue1">
                                            Can't log in to the system
                                        </button>
                                    </h2>
                                    <div id="issue1" class="accordion-collapse collapse show" data-bs-parent="#troubleshootingAccordion">
                                        <div class="accordion-body">
                                            <p>If you're unable to log in:</p>
                                            <ol>
                                                <li>Check that your username and password are correct</li>
                                                <li>Ensure Caps Lock is not enabled</li>
                                                <li>Try resetting your password using the "Forgot Password" link</li>
                                                <li>Contact system administrator if issues persist</li>
                                            </ol>
                                        </div>
                                    </div>
                                </div>
                                <div class="accordion-item">
                                    <h2 class="accordion-header">
                                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#issue2">
                                            Bill not generating correctly
                                        </button>
                                    </h2>
                                    <div id="issue2" class="accordion-collapse collapse" data-bs-parent="#troubleshootingAccordion">
                                        <div class="accordion-body">
                                            <p>If bills aren't generating properly:</p>
                                            <ol>
                                                <li>Check that all required fields are filled</li>
                                                <li>Verify that items are in stock</li>
                                                <li>Ensure customer account is active</li>
                                                <li>Try refreshing the page and generating again</li>
                                            </ol>
                                        </div>
                                    </div>
                                </div>
                                <div class="accordion-item">
                                    <h2 class="accordion-header">
                                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#issue3">
                                            Items not showing in inventory
                                        </button>
                                    </h2>
                                    <div id="issue3" class="accordion-collapse collapse" data-bs-parent="#troubleshootingAccordion">
                                        <div class="accordion-body">
                                            <p>If items aren't appearing in inventory:</p>
                                            <ol>
                                                <li>Check if the item was properly saved</li>
                                                <li>Verify that you're looking in the correct category</li>
                                                <li>Try using the search function</li>
                                                <li>Check if any filters are applied</li>
                                            </ol>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="text-center">
        <div class="container">
            <p>&copy; 2025 Pahana Edu Bookshop Management System. All rights reserved.</p>
            <p>For additional support, email: support@pahanaedubookshop.com</p>
        </div>
    </footer>

    <!-- Back to Top Button -->
    <a href="#" class="back-to-top">
        <i class="fas fa-arrow-up"></i>
    </a>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Back to top button functionality
        const backToTopButton = document.querySelector('.back-to-top');
        
        window.addEventListener('scroll', () => {
            if (window.pageYOffset > 300) {
                backToTopButton.style.display = 'flex';
            } else {
                backToTopButton.style.display = 'none';
            }
        });
        
        backToTopButton.addEventListener('click', (e) => {
            e.preventDefault();
            window.scrollTo({ top: 0, behavior: 'smooth' });
        });
        
        // Simple search functionality
        document.querySelector('.search-box button').addEventListener('click', () => {
            const searchTerm = document.querySelector('.search-box input').value.toLowerCase();
            if (searchTerm) {
                alert('Search functionality would show results for: ' + searchTerm);
                // In a real implementation, this would filter help content
            }
        });
    </script>
</body>
</html>