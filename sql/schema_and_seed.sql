-- E-Commerce Order Management: schema and sample data
-- Generated from the local training database.
-- Use only when preparing a fresh training database.

CREATE DATABASE IF NOT EXISTS ecommerce_support
  CHARACTER SET utf8mb4;
USE ecommerce_support;

SET FOREIGN_KEY_CHECKS = 0;

-- Table: customers
CREATE TABLE `customers` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table: products
CREATE TABLE `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `product_name` varchar(100) NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock_quantity` int DEFAULT '0',
  `status` enum('AVAILABLE','OUT_OF_STOCK','INACTIVE') DEFAULT 'AVAILABLE',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table: orders
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `order_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `total_amount` decimal(10,2) NOT NULL,
  `order_status` enum('PENDING','CONFIRMED','PROCESSING','SHIPPED','DELIVERED','CANCELLED','FAILED') DEFAULT 'PENDING',
  `payment_status` enum('PENDING','SUCCESS','FAILED','REFUNDED') DEFAULT 'PENDING',
  `shipping_city` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table: order_items
CREATE TABLE `order_items` (
  `order_item_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table: payments
CREATE TABLE `payments` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `transaction_id` varchar(50) NOT NULL,
  `payment_method` enum('CARD','UPI','NETBANKING','WALLET') NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_status` enum('INITIATED','SUCCESS','FAILED','REFUNDED') DEFAULT 'INITIATED',
  `payment_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `failure_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  UNIQUE KEY `transaction_id` (`transaction_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Sample data: customers (5 rows)
INSERT INTO `customers` (`customer_id`, `customer_name`, `email`, `phone`, `city`, `status`, `created_at`) VALUES (1, 'Rahul Sharma', 'rahul.sharma@example.com', '9876543210', 'Pune', 'ACTIVE', '2026-10-07 13:55:16');
INSERT INTO `customers` (`customer_id`, `customer_name`, `email`, `phone`, `city`, `status`, `created_at`) VALUES (2, 'Priya Patil', 'priya.patil@example.com', '9876543211', 'Mumbai', 'ACTIVE', '2026-10-07 13:55:16');
INSERT INTO `customers` (`customer_id`, `customer_name`, `email`, `phone`, `city`, `status`, `created_at`) VALUES (3, 'Amit Deshmukh', 'amit.deshmukh@example.com', '9876543212', 'Nagpur', 'ACTIVE', '2026-10-07 13:55:16');
INSERT INTO `customers` (`customer_id`, `customer_name`, `email`, `phone`, `city`, `status`, `created_at`) VALUES (4, 'Sneha Kulkarni', 'sneha.kulkarni@example.com', '9876543213', 'Nashik', 'ACTIVE', '2026-10-07 13:55:16');
INSERT INTO `customers` (`customer_id`, `customer_name`, `email`, `phone`, `city`, `status`, `created_at`) VALUES (5, 'Vikas Joshi', 'vikas.joshi@example.com', '9876543214', 'Aurangabad', 'INACTIVE', '2026-10-07 13:55:16');

-- Sample data: products (8 rows)
INSERT INTO `products` (`product_id`, `product_name`, `category`, `price`, `stock_quantity`, `status`, `created_at`) VALUES (1, 'Laptop Backpack', 'Accessories', 1499.00, 25, 'AVAILABLE', '2026-10-07 13:59:03');
INSERT INTO `products` (`product_id`, `product_name`, `category`, `price`, `stock_quantity`, `status`, `created_at`) VALUES (2, 'Wireless Mouse', 'Accessories', 799.00, 50, 'AVAILABLE', '2026-10-07 13:59:03');
INSERT INTO `products` (`product_id`, `product_name`, `category`, `price`, `stock_quantity`, `status`, `created_at`) VALUES (3, 'Mechanical Keyboard', 'Electronics', 2499.00, 15, 'AVAILABLE', '2026-10-07 13:59:03');
INSERT INTO `products` (`product_id`, `product_name`, `category`, `price`, `stock_quantity`, `status`, `created_at`) VALUES (4, 'USB-C Hub', 'Electronics', 1299.00, 30, 'AVAILABLE', '2026-10-07 13:59:03');
INSERT INTO `products` (`product_id`, `product_name`, `category`, `price`, `stock_quantity`, `status`, `created_at`) VALUES (5, 'Bluetooth Headphones', 'Electronics', 1999.00, 0, 'OUT_OF_STOCK', '2026-10-07 13:59:03');
INSERT INTO `products` (`product_id`, `product_name`, `category`, `price`, `stock_quantity`, `status`, `created_at`) VALUES (6, 'Office Chair', 'Furniture', 8999.00, 8, 'AVAILABLE', '2026-10-07 13:59:03');
INSERT INTO `products` (`product_id`, `product_name`, `category`, `price`, `stock_quantity`, `status`, `created_at`) VALUES (7, 'Monitor Stand', 'Furniture', 1799.00, 12, 'AVAILABLE', '2026-10-07 13:59:03');
INSERT INTO `products` (`product_id`, `product_name`, `category`, `price`, `stock_quantity`, `status`, `created_at`) VALUES (8, 'Webcam', 'Electronics', 2299.00, 0, 'OUT_OF_STOCK', '2026-10-07 13:59:03');

-- Sample data: orders (8 rows)
INSERT INTO `orders` (`order_id`, `customer_id`, `order_date`, `total_amount`, `order_status`, `payment_status`, `shipping_city`) VALUES (1, 1, '2026-10-07 14:01:14', 2298.00, 'CONFIRMED', 'SUCCESS', 'Pune');
INSERT INTO `orders` (`order_id`, `customer_id`, `order_date`, `total_amount`, `order_status`, `payment_status`, `shipping_city`) VALUES (2, 2, '2026-10-07 14:01:14', 1499.00, 'PROCESSING', 'SUCCESS', 'Mumbai');
INSERT INTO `orders` (`order_id`, `customer_id`, `order_date`, `total_amount`, `order_status`, `payment_status`, `shipping_city`) VALUES (3, 3, '2026-10-07 14:01:14', 2499.00, 'SHIPPED', 'SUCCESS', 'Nagpur');
INSERT INTO `orders` (`order_id`, `customer_id`, `order_date`, `total_amount`, `order_status`, `payment_status`, `shipping_city`) VALUES (4, 4, '2026-10-07 14:01:14', 8999.00, 'DELIVERED', 'SUCCESS', 'Nashik');
INSERT INTO `orders` (`order_id`, `customer_id`, `order_date`, `total_amount`, `order_status`, `payment_status`, `shipping_city`) VALUES (5, 1, '2026-10-07 14:01:14', 1999.00, 'PENDING', 'PENDING', 'Pune');
INSERT INTO `orders` (`order_id`, `customer_id`, `order_date`, `total_amount`, `order_status`, `payment_status`, `shipping_city`) VALUES (6, 5, '2026-10-07 14:01:14', 799.00, 'CANCELLED', 'REFUNDED', 'Aurangabad');
INSERT INTO `orders` (`order_id`, `customer_id`, `order_date`, `total_amount`, `order_status`, `payment_status`, `shipping_city`) VALUES (7, 2, '2026-10-07 14:01:14', 1299.00, 'FAILED', 'FAILED', 'Mumbai');
INSERT INTO `orders` (`order_id`, `customer_id`, `order_date`, `total_amount`, `order_status`, `payment_status`, `shipping_city`) VALUES (8, 3, '2026-10-07 14:01:14', 2299.00, 'PENDING', 'SUCCESS', 'Nagpur');

-- Sample data: order_items (9 rows)
INSERT INTO `order_items` (`order_item_id`, `order_id`, `product_id`, `quantity`, `unit_price`, `subtotal`) VALUES (1, 1, 2, 1, 799.00, 799.00);
INSERT INTO `order_items` (`order_item_id`, `order_id`, `product_id`, `quantity`, `unit_price`, `subtotal`) VALUES (2, 1, 4, 1, 1299.00, 1299.00);
INSERT INTO `order_items` (`order_item_id`, `order_id`, `product_id`, `quantity`, `unit_price`, `subtotal`) VALUES (3, 2, 1, 1, 1499.00, 1499.00);
INSERT INTO `order_items` (`order_item_id`, `order_id`, `product_id`, `quantity`, `unit_price`, `subtotal`) VALUES (4, 3, 3, 1, 2499.00, 2499.00);
INSERT INTO `order_items` (`order_item_id`, `order_id`, `product_id`, `quantity`, `unit_price`, `subtotal`) VALUES (5, 4, 6, 1, 8999.00, 8999.00);
INSERT INTO `order_items` (`order_item_id`, `order_id`, `product_id`, `quantity`, `unit_price`, `subtotal`) VALUES (6, 5, 5, 1, 1999.00, 1999.00);
INSERT INTO `order_items` (`order_item_id`, `order_id`, `product_id`, `quantity`, `unit_price`, `subtotal`) VALUES (7, 6, 2, 1, 799.00, 799.00);
INSERT INTO `order_items` (`order_item_id`, `order_id`, `product_id`, `quantity`, `unit_price`, `subtotal`) VALUES (8, 7, 4, 1, 1299.00, 1299.00);
INSERT INTO `order_items` (`order_item_id`, `order_id`, `product_id`, `quantity`, `unit_price`, `subtotal`) VALUES (9, 8, 8, 1, 2299.00, 2299.00);

-- Sample data: payments (8 rows)
INSERT INTO `payments` (`payment_id`, `order_id`, `transaction_id`, `payment_method`, `amount`, `payment_status`, `payment_date`, `failure_reason`) VALUES (1, 1, 'TXN100001', 'UPI', 2298.00, 'SUCCESS', '2026-10-07 14:05:37', NULL);
INSERT INTO `payments` (`payment_id`, `order_id`, `transaction_id`, `payment_method`, `amount`, `payment_status`, `payment_date`, `failure_reason`) VALUES (2, 2, 'TXN100002', 'CARD', 1499.00, 'SUCCESS', '2026-10-07 14:05:37', NULL);
INSERT INTO `payments` (`payment_id`, `order_id`, `transaction_id`, `payment_method`, `amount`, `payment_status`, `payment_date`, `failure_reason`) VALUES (3, 3, 'TXN100003', 'NETBANKING', 2499.00, 'SUCCESS', '2026-10-07 14:05:37', NULL);
INSERT INTO `payments` (`payment_id`, `order_id`, `transaction_id`, `payment_method`, `amount`, `payment_status`, `payment_date`, `failure_reason`) VALUES (4, 4, 'TXN100004', 'CARD', 8999.00, 'SUCCESS', '2026-10-07 14:05:37', NULL);
INSERT INTO `payments` (`payment_id`, `order_id`, `transaction_id`, `payment_method`, `amount`, `payment_status`, `payment_date`, `failure_reason`) VALUES (5, 5, 'TXN100005', 'UPI', 1999.00, 'INITIATED', '2026-10-07 14:05:37', NULL);
INSERT INTO `payments` (`payment_id`, `order_id`, `transaction_id`, `payment_method`, `amount`, `payment_status`, `payment_date`, `failure_reason`) VALUES (6, 6, 'TXN100006', 'WALLET', 799.00, 'REFUNDED', '2026-10-07 14:05:37', NULL);
INSERT INTO `payments` (`payment_id`, `order_id`, `transaction_id`, `payment_method`, `amount`, `payment_status`, `payment_date`, `failure_reason`) VALUES (7, 7, 'TXN100007', 'CARD', 1299.00, 'FAILED', '2026-10-07 14:05:37', 'Payment gateway timeout');
INSERT INTO `payments` (`payment_id`, `order_id`, `transaction_id`, `payment_method`, `amount`, `payment_status`, `payment_date`, `failure_reason`) VALUES (8, 8, 'TXN100008', 'UPI', 2299.00, 'SUCCESS', '2026-10-07 14:05:37', NULL);

SET FOREIGN_KEY_CHECKS = 1;
