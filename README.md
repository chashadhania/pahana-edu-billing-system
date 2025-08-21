# Pahana Edu Billing System

A secure, web-based billing and customer management system built for Pahana Edu Bookshop in Colombo. This system replaces error-prone manual processes with an automated solution for managing customer accounts, inventory, and billing.

## 🚀 Features

- **🔐 Secure User Authentication:** Role-based login system for staff.
- **👥 Customer Management:** Add, view, edit, and manage customer accounts with unique account numbers.
- **📦 Inventory Management:** Full CRUD (Create, Read, Update, Delete) operations for book inventory.
- **🧾 Automated Billing:** Generate and print accurate bills based on items and quantities. Calculates totals automatically.
- **📊 Reporting:** Generate sales reports, low stock alerts, and customer debtors reports.
- **❓ Help Section:** Integrated user guide and documentation.

## 🛠️ Built With

- **Backend:** Java Servlets, JavaServer Pages (JSP)
- **Frontend:** HTML5, CSS3, Bootstrap 5, JavaScript
- **Database:** MySQL
- **Server:** Apache Tomcat
- **Build Tool:** Maven
- **Testing:** JUnit, Mockito, Selenium
- **Version Control:** Git / GitHub

## 📋 Prerequisites

Before you begin, ensure you have the following installed on your system:
- Java Development Kit (JDK) 11 or higher
- Apache Maven 3.6+
- Apache Tomcat 9.x or higher
- MySQL Server 8.0 or higher
- A modern web browser (Chrome, Firefox, Edge)

## 🗄️ Database Setup

1.  Connect to your MySQL server as root.
2.  Create a new database:
    ```sql
    CREATE DATABASE pahana_edu_bookshop;
    ```
3.  Import the provided SQL script to create tables and insert sample data:
    ```bash
    mysql -u [username] -p pahana_edu_db < database/pahana_edu_sample_data.sql
    ```
4.  Update the database connection settings in the source code to match your MySQL credentials (usually in `src/main/java/util/DatabaseConnector.java` or similar).

## 🚦 Installation & Deployment

### 1. Clone the Repository
```bash
git clone https://github.com/your-username/pahana-edu-billing-system.git
cd pahana-edu-billing-system
