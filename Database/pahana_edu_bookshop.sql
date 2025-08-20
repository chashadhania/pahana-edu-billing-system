-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 20, 2025 at 08:47 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pahana_edu_bookshop`
--

-- --------------------------------------------------------

--
-- Table structure for table `bills`
--

CREATE TABLE `bills` (
  `bill_id` int(11) NOT NULL,
  `customer_account` varchar(20) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `bill_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bills`
--

INSERT INTO `bills` (`bill_id`, `customer_account`, `total_amount`, `bill_date`, `status`) VALUES
(32, 'CUST001', 3500.00, '2025-08-20 05:46:13', 'Completed'),
(33, 'CUST002', 4400.00, '2025-08-20 05:50:06', 'Completed'),
(34, 'CUST002', 22800.00, '2025-08-20 05:53:47', 'Completed'),
(35, 'CUST001', 2500.00, '2025-08-20 06:06:33', 'Completed'),
(36, 'CUST002', 2500.00, '2025-08-20 06:07:30', 'Completed'),
(37, 'CUST001', 1500.00, '2025-08-20 06:08:08', 'Completed'),
(38, 'CUST001', 2000.00, '2025-08-20 06:12:58', 'Completed'),
(39, 'CUST001', 2000.00, '2025-08-20 06:16:26', 'Completed'),
(40, 'CUST001', 2000.00, '2025-08-20 17:26:37', 'Completed'),
(41, 'CUST001', 1500.00, '2025-08-20 17:28:05', 'Draft');

-- --------------------------------------------------------

--
-- Table structure for table `bill_items`
--

CREATE TABLE `bill_items` (
  `bill_id` int(11) NOT NULL,
  `item_id` varchar(20) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bill_items`
--

INSERT INTO `bill_items` (`bill_id`, `item_id`, `quantity`, `unit_price`) VALUES
(32, 'ITEM1002', 1, 2000.00),
(32, 'ITEM1005', 1, 1500.00),
(33, 'ITEM1007', 1, 1600.00),
(33, 'ITEM1009', 2, 1400.00),
(34, 'ITEM1005', 14, 1500.00),
(34, 'ITEM1006', 1, 1800.00),
(35, 'ITEM1010', 1, 2500.00),
(36, 'ITEM1010', 1, 2500.00),
(37, 'ITEM1005', 1, 1500.00),
(38, 'ITEM1002', 1, 2000.00),
(39, 'ITEM1004', 1, 2000.00),
(40, 'ITEM1004', 1, 2000.00),
(41, 'ITEM1005', 1, 1500.00);

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `account_number` varchar(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `address` text NOT NULL,
  `telephone` varchar(15) NOT NULL,
  `units_consumed` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`account_number`, `name`, `address`, `telephone`, `units_consumed`, `created_at`, `updated_at`) VALUES
('CUST001', 'Chashadani', '123 Main St', '0111234568', 25, '2025-08-20 01:31:27', '2025-08-20 01:31:27'),
('CUST002', 'Deshan', '123 ,Kandy', '0774542525', 35, '2025-08-20 05:45:10', '2025-08-20 05:45:10');

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `item_id` varchar(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`item_id`, `name`, `price`, `quantity`, `created_at`, `updated_at`) VALUES
('ITEM1001', 'The Alchemist', 2000.00, 0, '2025-08-17 04:00:20', '2025-08-20 02:21:33'),
('ITEM1002', 'Atomic Habits', 2000.00, 10, '2025-08-17 04:13:07', '2025-08-20 06:13:00'),
('ITEM1003', 'Dune', 2222.00, 0, '2025-08-19 16:07:44', '2025-08-20 03:56:32'),
('ITEM1004', 'The Midnight Library', 2000.00, 0, '2025-08-20 01:32:22', '2025-08-20 17:26:40'),
('ITEM1005', 'The Great Gatsby', 1500.00, 8, '2025-08-20 05:45:00', '2025-08-20 17:28:07'),
('ITEM1006', 'To Kill a Mockingbird', 1800.00, 17, '2025-08-20 05:50:00', '2025-08-20 05:53:50'),
('ITEM1007', '1984', 1600.00, 29, '2025-08-20 05:55:00', '2025-08-20 05:50:09'),
('ITEM1008', 'Pride and Prejudice', 1700.00, 15, '2025-08-20 06:00:00', '2025-08-20 06:00:00'),
('ITEM1009', 'The Catcher in the Rye', 1400.00, 20, '2025-08-20 06:05:00', '2025-08-20 05:50:14'),
('ITEM1010', 'The Lord of the Rings', 2500.00, 8, '2025-08-20 06:10:00', '2025-08-20 06:07:35');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `role` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `created_at`, `role`) VALUES
(1, 'admin', 'admin123', '2025-08-20 05:31:37', 'admin'),
(2, 'cashier', 'random123', '2025-08-20 10:43:33', 'cashier'),
(3, 'manager', 'random123', '2025-08-20 10:43:58', 'manager');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bills`
--
ALTER TABLE `bills`
  ADD PRIMARY KEY (`bill_id`);

--
-- Indexes for table `bill_items`
--
ALTER TABLE `bill_items`
  ADD PRIMARY KEY (`bill_id`,`item_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`account_number`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`item_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bills`
--
ALTER TABLE `bills`
  MODIFY `bill_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bill_items`
--
ALTER TABLE `bill_items`
  ADD CONSTRAINT `bill_items_ibfk_1` FOREIGN KEY (`bill_id`) REFERENCES `bills` (`bill_id`),
  ADD CONSTRAINT `bill_items_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
