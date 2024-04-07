-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 07, 2024 at 09:45 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `van_sales`
--

-- --------------------------------------------------------

--
-- Table structure for table `allocation_items`
--

CREATE TABLE `allocation_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `delivery_id` bigint(20) UNSIGNED DEFAULT NULL,
  `loadsheet_id` bigint(20) UNSIGNED DEFAULT NULL,
  `stock_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` double(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `allocation_items`
--

INSERT INTO `allocation_items` (`id`, `delivery_id`, `loadsheet_id`, `stock_id`, `quantity`, `created_at`, `updated_at`) VALUES
(1, NULL, 1, 15, 0.00, '2024-02-21 00:31:36', '2024-02-21 00:31:36'),
(2, NULL, 2, 17, 100.00, '2024-02-24 08:06:37', '2024-02-24 08:06:37'),
(3, 10, NULL, 17, 0.00, '2024-02-24 08:11:48', '2024-02-24 08:11:48'),
(4, 11, NULL, 17, 20.00, '2024-02-24 08:13:20', '2024-02-24 08:13:20'),
(5, NULL, 4, 19, 1000.00, '2024-02-26 07:14:19', '2024-02-26 07:14:19'),
(6, NULL, 4, 20, 1000.00, '2024-02-26 07:14:19', '2024-02-26 07:14:19'),
(7, NULL, 4, 21, 1200.00, '2024-02-26 07:14:20', '2024-02-26 07:14:20'),
(8, NULL, 4, 22, 1000.00, '2024-02-26 07:14:20', '2024-02-26 07:14:20'),
(9, NULL, 4, 23, 3400.00, '2024-02-26 07:14:20', '2024-02-26 07:14:20'),
(10, NULL, 4, 24, 4500.00, '2024-02-26 07:14:20', '2024-02-26 07:14:20'),
(11, NULL, 4, 25, 1200.00, '2024-02-26 07:14:20', '2024-02-26 07:14:20'),
(12, NULL, 5, 26, 5000.00, '2024-03-02 17:26:41', '2024-03-02 17:26:41'),
(13, NULL, 5, 27, 5000.00, '2024-03-02 17:26:41', '2024-03-02 17:26:41'),
(14, 12, NULL, 28, 100.00, '2024-03-02 17:54:09', '2024-03-02 17:54:09'),
(15, 12, NULL, 29, 100.00, '2024-03-02 17:54:09', '2024-03-02 17:54:09'),
(16, NULL, 6, 30, 10000.00, '2024-04-04 19:17:48', '2024-04-04 19:17:48'),
(17, NULL, 6, 31, 10000.00, '2024-04-04 19:17:48', '2024-04-04 19:17:48'),
(18, NULL, 6, 32, 10000.00, '2024-04-04 19:17:48', '2024-04-04 19:17:48'),
(19, NULL, 6, 33, 10000.00, '2024-04-04 19:17:48', '2024-04-04 19:17:48'),
(20, NULL, 6, 34, 10000.00, '2024-04-04 19:17:48', '2024-04-04 19:17:48'),
(21, NULL, 6, 35, 10000.00, '2024-04-04 19:17:48', '2024-04-04 19:17:48'),
(22, NULL, 6, 36, 10000.00, '2024-04-04 19:17:48', '2024-04-04 19:17:48');

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE `branches` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `company_id` bigint(20) UNSIGNED NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`id`, `name`, `address`, `phone_number`, `email`, `company_id`, `warehouse_id`, `created_at`, `updated_at`, `user_id`) VALUES
(1, 'Branch 2', '6 Fairway Mt Pleasant Rd, Harare Zimbabwe', '+263772440053', 'branch1@gmail.com', 2, 16, '2024-02-18 20:26:16', '2024-02-18 20:37:18', 12),
(2, 'Branch 3', '6 Fairway Mt Pleasant Rd, Harare Zimbabwe', '+26377244012', 'branch3@gmail.com', 2, 15, '2024-02-18 20:38:34', '2024-02-18 20:38:34', 15),
(3, 'Test Branch', 'Harare', '0773445566', 'testb@gmail.com', 7, 20, '2024-02-24 08:10:21', '2024-02-24 08:10:21', 21);

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

CREATE TABLE `companies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `bpn` varchar(255) NOT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `has_default_settings` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `companies`
--

INSERT INTO `companies` (`id`, `name`, `email`, `bpn`, `logo`, `description`, `phone`, `city`, `address`, `created_at`, `updated_at`, `has_default_settings`) VALUES
(2, 'Axis Solutions', 'admin@axis.com', '0772440088', NULL, 'Software dev company', '772440088', 'Harare', '7 Wingate Road', '2024-02-09 08:26:01', '2024-02-09 13:29:11', 1),
(4, 'Equals Solutions', 'admin@equals.com', '121212121212', NULL, 'Equals finance company', '7724212088', 'Harare', 'Mt Pleasant business park', '2024-02-09 09:07:28', '2024-02-09 13:29:06', 1),
(5, 'Riquid Energy Solutions', 'riquid@riquid.com', '0772440045', NULL, 'Solar sells', '772440088', 'Harare', '7 Wingate Road', '2024-02-09 13:41:55', '2024-02-09 20:29:17', 1),
(6, 'Teranics Inc', 'teranics@gmail.com', '121212121221', NULL, 'Teranics Tech Company', '772440012', 'Harare', '7 Wingate Road', '2024-02-19 10:43:49', '2024-02-19 10:43:49', 1),
(7, 'Econet', 'ecenet@econet.com', 'BP1232345', NULL, 'Econet wireless zimbabwe', '772441188', 'Harare', '109 Robert Mugabe Road', '2024-02-24 07:13:58', '2024-02-24 07:13:58', 1),
(8, 'Atrix', 'trix@gmail.com', '+263772440088', NULL, 'groceries', '772440088', 'Harare', '7 Wingate Road', '2024-03-02 16:55:27', '2024-03-02 16:55:28', 1),
(9, 'Priceless PVT LTD', 'admin@price.co.zw', 'BPN-3434346', NULL, 'Tinoitazvekutengesa magroceries isu', '772424534', 'Mutorashanga', '23 Muponda Road Mutorashanga', '2024-04-04 17:49:54', '2024-04-04 17:49:54', 1);

-- --------------------------------------------------------

--
-- Table structure for table `company_subscriptions`
--

CREATE TABLE `company_subscriptions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED NOT NULL,
  `subscription_id` bigint(20) UNSIGNED NOT NULL,
  `period` enum('Monthly','Yearly','Quarterly') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `company_subscriptions`
--

INSERT INTO `company_subscriptions` (`id`, `company_id`, `subscription_id`, `period`, `created_at`, `updated_at`) VALUES
(2, 2, 4, 'Monthly', '2024-02-09 08:26:01', '2024-02-09 08:26:01'),
(4, 4, 4, 'Yearly', '2024-02-09 09:07:28', '2024-02-09 09:07:28'),
(6, 5, 4, 'Monthly', '2024-02-09 20:33:36', '2024-02-09 21:03:59'),
(7, 6, 4, 'Yearly', '2024-02-19 10:43:49', '2024-02-19 10:43:49'),
(8, 7, 4, 'Monthly', '2024-02-24 07:13:58', '2024-02-24 07:13:58'),
(9, 8, 4, 'Yearly', '2024-03-02 16:55:27', '2024-03-02 16:55:27'),
(10, 9, 4, 'Yearly', '2024-04-04 17:49:54', '2024-04-04 17:49:54');

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `symbol` varchar(255) DEFAULT NULL,
  `exchange_rate` double(8,2) NOT NULL DEFAULT 1.00,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`id`, `name`, `code`, `symbol`, `exchange_rate`, `is_default`, `created_at`, `updated_at`, `company_id`) VALUES
(1, 'USD', 'USD', '$', 1.00, 1, '2023-10-03 20:18:02', '2023-11-14 13:10:02', NULL),
(2, 'RTGS', 'RTGS', 'RTGS', 6000.00, 0, '2023-10-03 20:57:21', '2023-11-14 13:10:02', NULL),
(3, 'Rand', 'ZAR', 'ZAR', 3500.00, 0, '2023-11-14 12:56:17', '2023-11-14 13:10:02', NULL),
(4, 'USD', 'USD', '$', 16500.00, 1, '2024-02-09 11:47:28', '2024-02-27 17:06:21', 2),
(5, 'RTGS', 'RTGS', 'RTGS$', 16500.00, 0, '2024-02-09 11:47:54', '2024-02-27 17:06:21', 2),
(6, 'RAND', 'RAND', 'R', 16500.00, 0, '2024-02-09 11:48:32', '2024-02-27 17:06:21', 2),
(7, 'USD', 'USD', '$', 15000.00, 1, '2024-02-09 13:34:16', '2024-02-09 13:34:16', 4),
(8, 'RAND', 'RAND', 'R', 14000.00, 0, '2024-02-09 13:34:32', '2024-02-09 13:34:32', 4),
(9, 'USD', 'USD', '$', 16500.00, 1, '2024-02-09 13:45:46', '2024-02-09 13:45:46', 5),
(10, 'USD', 'USD', '$', 16500.00, 1, '2024-02-19 10:49:52', '2024-02-19 10:49:52', 6),
(11, 'RAND', 'RAND', 'ZAR', 10000.00, 0, '2024-02-19 10:50:20', '2024-02-19 10:50:20', 6),
(12, 'RTGS', 'RTGS', 'RTGS$', 16500.00, 0, '2024-02-19 10:50:40', '2024-02-19 10:50:40', 6),
(13, 'USD', 'USD', '$', 17000.00, 1, '2024-02-24 07:25:58', '2024-02-24 07:28:16', 7),
(14, 'USD', 'USD', '$', 17500.00, 1, '2024-03-02 17:04:43', '2024-03-02 17:04:43', 8),
(15, 'RTGS', 'RTGS', 'RTGS$', 5000.00, 0, '2024-03-02 17:05:14', '2024-03-02 17:05:14', 8),
(16, 'USD', 'USD', '$', 1.00, 1, '2024-04-04 18:39:54', '2024-04-04 18:39:54', 9),
(17, 'RAND', 'RAND', 'R', 20000.00, 0, '2024-04-04 18:41:10', '2024-04-04 18:41:10', 9),
(18, 'RTGS', 'RTGS', 'RTGS$', 40000.00, 0, '2024-04-04 18:41:26', '2024-04-04 18:41:26', 9);

-- --------------------------------------------------------

--
-- Table structure for table `currency_payment_methods`
--

CREATE TABLE `currency_payment_methods` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `currency_id` bigint(20) UNSIGNED NOT NULL,
  `payment_method_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `currency_payment_methods`
--

INSERT INTO `currency_payment_methods` (`id`, `currency_id`, `payment_method_id`, `created_at`, `updated_at`, `company_id`) VALUES
(6, 3, 3, '2023-11-14 13:09:44', '2023-11-14 13:09:44', NULL),
(7, 3, 2, '2023-11-14 13:09:44', '2023-11-14 13:09:44', NULL),
(8, 3, 1, '2023-11-14 13:09:44', '2023-11-14 13:09:44', NULL),
(9, 1, 3, '2023-11-14 13:10:02', '2023-11-14 13:10:02', NULL),
(10, 1, 2, '2023-11-14 13:10:02', '2023-11-14 13:10:02', NULL),
(11, 1, 1, '2023-11-14 13:10:02', '2023-11-14 13:10:02', NULL),
(12, 13, 18, '2024-02-24 07:28:16', '2024-02-24 07:28:16', 7),
(13, 13, 17, '2024-02-24 07:28:16', '2024-02-24 07:28:16', 7),
(14, 13, 16, '2024-02-24 07:28:16', '2024-02-24 07:28:16', 7),
(15, 6, 4, '2024-02-27 17:05:22', '2024-02-27 17:05:22', 2),
(16, 5, 6, '2024-02-27 17:05:40', '2024-02-27 17:05:40', 2),
(17, 5, 5, '2024-02-27 17:05:40', '2024-02-27 17:05:40', 2),
(18, 4, 6, '2024-02-27 17:06:21', '2024-02-27 17:06:21', 2),
(19, 4, 5, '2024-02-27 17:06:21', '2024-02-27 17:06:21', 2),
(20, 4, 4, '2024-02-27 17:06:21', '2024-02-27 17:06:21', 2);

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `lat` double DEFAULT NULL,
  `lon` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `route_id` bigint(20) UNSIGNED DEFAULT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `name`, `email`, `phone_number`, `address`, `lat`, `lon`, `created_at`, `updated_at`, `route_id`, `company_id`) VALUES
(1, 'Denzel Muto', 'denzel@gmail.com', '0772440088', '6 Fairway Mt Pleasant Harare', -17.8525279, 30.9870269, '2023-09-29 06:43:20', '2023-11-14 11:21:56', 3, NULL),
(2, 'Brandon Mwale', 'mwale830@gmail.com', '0719920372', '581 Juru Growth Point Goromonzi', -17.7672324, 31.0478433, '2023-09-30 17:33:42', '2023-11-14 10:14:53', 2, NULL),
(3, 'Brian Mhuka', 'brian@gmail.com', '0772424088', '6 Bulawayo road , Bulawayo Zimbabwe', -20.1457125, 28.5873388, '2023-11-14 10:07:56', '2023-11-14 10:07:56', 6, NULL),
(4, 'Daniel', 'Mwere', '0772240088', 'Bulawayo Rainbow towers', -20.1586838, 28.5872618, '2023-11-14 11:41:53', '2023-11-14 11:41:53', 6, NULL),
(5, 'Cash Account', 'cash@axissol.com', '0772423088', '14 Arundale Road', NULL, NULL, '2023-11-16 06:26:36', '2023-11-16 06:26:36', NULL, NULL),
(9, 'Gilbet Moyo', 'gilbet@gmail.com', '078232322987', '6 Fairway Mt Pleasant', NULL, NULL, '2023-11-18 14:32:28', '2023-11-18 14:32:28', 4, NULL),
(10, 'Maybe Muti', 'maybemuti@gmail.com', '0782323387', '8 Fairway Mt Pleasant', NULL, NULL, '2023-11-18 14:32:28', '2023-11-18 14:32:28', 4, NULL),
(11, 'Trevor Sibanda', 'trevor@gmail.com', '17604439894', '987 ROSE LN\n05', -17.7512608, 31.0619109, '2024-02-09 13:37:39', '2024-02-09 13:37:39', 8, 4),
(12, 'Customer First', 'first@gmailc.om', '0772440012', '7 Wingate Road', -17.8262928, 31.0503723, '2024-02-15 07:36:13', '2024-02-15 07:36:13', 10, 2),
(14, 'Denzel Mwale', 'b@gmail.com', '+263772440212', '123 House Stand Shawasha Hills', -17.7610714, 31.1882189, '2024-02-19 10:54:35', '2024-02-19 10:54:35', 11, 6),
(16, 'Test Customer', 'test@gmail.com', '0772440023', '7 Wingate Road', -17.8216288, 31.0492259, '2024-02-24 08:07:35', '2024-02-24 08:07:35', 12, 7),
(17, 'Cash Account', 'tcash@gmail.com', '0772440013', '7 Wingate Road', -17.8216288, 31.0492259, '2024-02-24 08:07:53', '2024-02-24 08:07:53', 12, 7),
(19, 'Cash Account', 'cash@axissolkk.com', '+263772440088', '7 Wingate Road', -17.8262928, 31.0503723, '2024-03-02 17:16:54', '2024-03-02 17:16:54', 13, 8);

-- --------------------------------------------------------

--
-- Table structure for table `customer_stops`
--

CREATE TABLE `customer_stops` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `loadsheet_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customer_stops`
--

INSERT INTO `customer_stops` (`id`, `customer_id`, `loadsheet_id`, `created_at`, `updated_at`) VALUES
(15, 12, 3, '2024-02-26 06:47:26', '2024-02-26 06:47:26'),
(16, 12, 4, '2024-02-26 07:14:19', '2024-02-26 07:14:19'),
(17, 19, 5, '2024-03-02 17:26:40', '2024-03-02 17:26:40'),
(18, 19, 5, '2024-03-02 17:26:40', '2024-03-02 17:26:40');

-- --------------------------------------------------------

--
-- Table structure for table `deliveries`
--

CREATE TABLE `deliveries` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `delivery_sheet_id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` enum('Draft','Pending','Delivered','Cancelled','Returned') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `deliveries`
--

INSERT INTO `deliveries` (`id`, `delivery_sheet_id`, `customer_id`, `company_id`, `status`, `created_at`, `updated_at`) VALUES
(8, 12, 12, NULL, 'Pending', '2024-02-15 09:03:23', '2024-02-15 09:03:23'),
(9, 14, 14, NULL, 'Pending', '2024-02-19 11:00:39', '2024-02-19 11:00:39'),
(10, 15, 16, NULL, 'Pending', '2024-02-24 08:11:48', '2024-02-24 08:11:48'),
(11, 15, 17, NULL, 'Pending', '2024-02-24 08:13:20', '2024-02-24 08:13:20'),
(12, 16, 19, NULL, 'Pending', '2024-03-02 17:54:09', '2024-03-02 17:54:09');

-- --------------------------------------------------------

--
-- Table structure for table `delivery_histories`
--

CREATE TABLE `delivery_histories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `delivery_sheet_id` bigint(20) UNSIGNED NOT NULL,
  `status` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `delivery_histories`
--

INSERT INTO `delivery_histories` (`id`, `delivery_sheet_id`, `status`, `user_id`, `description`, `created_at`, `updated_at`) VALUES
(3, 12, 'Created', 12, 'Delivery Sheet Created', '2024-02-15 08:07:20', '2024-02-15 08:07:20'),
(4, 12, 'Delivery Added', 12, 'Delivery Added', '2024-02-15 09:03:24', '2024-02-15 09:03:24'),
(5, 12, 'Confirmed', 12, 'DeliverySheet Confirmed', '2024-02-15 12:20:31', '2024-02-15 12:20:31'),
(6, 12, 'Started', 17, 'DeliverySheet Started', '2024-02-15 16:06:50', '2024-02-15 16:06:50'),
(7, 12, 'Completed', 17, 'DeliverySheet Completed', '2024-02-15 18:27:54', '2024-02-15 18:27:54'),
(8, 12, 'Completed', 17, 'DeliverySheet Completed', '2024-02-15 18:29:07', '2024-02-15 18:29:07'),
(9, 13, 'Created', 12, 'Delivery Sheet Created', '2024-02-18 20:25:31', '2024-02-18 20:25:31'),
(10, 14, 'Created', 18, 'Delivery Sheet Created', '2024-02-19 10:56:56', '2024-02-19 10:56:56'),
(11, 14, 'Delivery Added', 18, 'Delivery Added', '2024-02-19 11:00:39', '2024-02-19 11:00:39'),
(12, 14, 'Started', 19, 'DeliverySheet Started', '2024-02-19 12:18:09', '2024-02-19 12:18:09'),
(13, 14, 'Completed', 19, 'DeliverySheet Completed', '2024-02-19 12:18:23', '2024-02-19 12:18:23'),
(14, 15, 'Created', 20, 'Delivery Sheet Created', '2024-02-24 08:11:18', '2024-02-24 08:11:18'),
(15, 15, 'Delivery Added', 20, 'Delivery Added', '2024-02-24 08:11:48', '2024-02-24 08:11:48'),
(16, 15, 'Delivery Added', 20, 'Delivery Added', '2024-02-24 08:13:20', '2024-02-24 08:13:20'),
(17, 16, 'Created', 24, 'Delivery Sheet Created', '2024-03-02 17:52:34', '2024-03-02 17:52:34'),
(18, 16, 'Delivery Added', 24, 'Delivery Added', '2024-03-02 17:54:09', '2024-03-02 17:54:09');

-- --------------------------------------------------------

--
-- Table structure for table `delivery_sheets`
--

CREATE TABLE `delivery_sheets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `truck_id` bigint(20) UNSIGNED NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` enum('Draft','Created','Loaded','Confirmed','Started','Completed') NOT NULL,
  `route_id` bigint(20) UNSIGNED DEFAULT NULL,
  `start_date_time` varchar(255) DEFAULT NULL,
  `end_date_time` varchar(255) DEFAULT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `delivery_sheet_number` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `delivery_sheets`
--

INSERT INTO `delivery_sheets` (`id`, `user_id`, `truck_id`, `warehouse_id`, `status`, `route_id`, `start_date_time`, `end_date_time`, `company_id`, `created_at`, `updated_at`, `delivery_sheet_number`) VALUES
(12, 17, 8, 15, 'Completed', 10, '2024-02-19T10:07:00.000Z', NULL, 2, '2024-02-15 08:07:20', '2024-02-15 18:27:54', NULL),
(13, 17, 8, 15, 'Created', 10, '2024-02-20T22:25:00.000Z', NULL, 2, '2024-02-18 20:25:31', '2024-02-18 20:25:31', NULL),
(14, 19, 11, 17, 'Completed', 11, '2024-02-22T12:56:00.000Z', NULL, 6, '2024-02-19 10:56:56', '2024-02-19 12:18:23', 'DS0001'),
(15, 22, 12, 20, 'Created', 12, '2024-02-26T10:11:00.000Z', NULL, 7, '2024-02-24 08:11:18', '2024-02-24 08:11:18', 'DS0001'),
(16, 26, 15, 21, 'Created', 13, '2024-03-04T09:52:00.000Z', NULL, 8, '2024-03-02 17:52:34', '2024-03-02 17:52:34', '0001');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `features`
--

CREATE TABLE `features` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `general_settings`
--

CREATE TABLE `general_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `value` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `general_settings`
--

INSERT INTO `general_settings` (`id`, `name`, `type`, `value`, `created_at`, `updated_at`, `company_id`) VALUES
(1, 'Defaults warehouse per driver', 'Warehouse', 1, '2023-10-05 17:00:39', '2023-11-14 07:32:57', NULL),
(2, 'Defaults  truck per driver', 'Trucks', 1, '2023-10-05 17:01:23', '2023-11-14 07:32:57', NULL),
(3, 'Allow Multiple Loadsheets Per Driver', 'Loadsheets', 0, '2023-10-17 11:43:03', '2023-11-14 07:32:57', NULL),
(4, 'Routes', 'Routes', 1, '2023-11-14 06:49:30', '2023-11-14 07:32:57', NULL),
(53, 'Defaults warehouse per driver', 'Warehouse', 1, '2024-02-09 13:29:06', '2024-02-09 13:29:06', 4),
(54, 'Defaults  truck per driver', 'Trucks', 1, '2024-02-09 13:29:06', '2024-02-09 13:29:06', 4),
(55, 'Allow Multiple Loadsheets Per Driver', 'Loadsheets', 0, '2024-02-09 13:29:06', '2024-02-09 13:29:06', 4),
(56, 'Routes', 'Routes', 1, '2024-02-09 13:29:06', '2024-02-09 13:29:06', 4),
(57, 'Defaults warehouse per driver', 'Warehouse', 1, '2024-02-09 13:29:11', '2024-02-26 06:47:41', 2),
(58, 'Defaults  truck per driver', 'Trucks', 1, '2024-02-09 13:29:11', '2024-02-26 06:47:41', 2),
(59, 'Allow Multiple Loadsheets Per Driver', 'Loadsheets', 1, '2024-02-09 13:29:11', '2024-02-26 06:47:41', 2),
(60, 'Routes', 'Routes', 1, '2024-02-09 13:29:11', '2024-02-26 06:47:41', 2),
(61, 'Defaults warehouse per driver', 'Warehouse', 1, '2024-02-09 13:41:55', '2024-02-09 13:41:55', 5),
(62, 'Defaults  truck per driver', 'Trucks', 1, '2024-02-09 13:41:55', '2024-02-09 13:41:55', 5),
(63, 'Allow Multiple Loadsheets Per Driver', 'Loadsheets', 0, '2024-02-09 13:41:55', '2024-02-09 13:41:55', 5),
(64, 'Routes', 'Routes', 1, '2024-02-09 13:41:55', '2024-02-09 13:41:55', 5),
(65, 'Single Delivery Per Driver', 'Deliveries', 1, '2024-02-15 06:34:01', '2024-02-26 06:47:41', 2),
(66, 'Defaults warehouse per driver', 'Warehouse', 1, '2024-02-19 10:43:49', '2024-02-19 11:01:15', 6),
(67, 'Defaults  truck per driver', 'Trucks', 1, '2024-02-19 10:43:49', '2024-02-19 11:01:15', 6),
(68, 'Allow Multiple Loadsheets Per Driver', 'Loadsheets', 1, '2024-02-19 10:43:49', '2024-02-19 11:01:15', 6),
(69, 'Routes', 'Routes', 1, '2024-02-19 10:43:49', '2024-02-19 11:01:15', 6),
(70, 'Single Delivery Per Driver', 'Deliveries', 1, NULL, '2024-02-19 11:01:15', 6),
(71, 'Single Delivery Per Driver', 'Deliveries', 0, NULL, NULL, NULL),
(72, 'Defaults warehouse per driver', 'Warehouse', 1, '2024-02-24 07:13:58', '2024-02-24 07:13:58', 7),
(73, 'Defaults  truck per driver', 'Trucks', 1, '2024-02-24 07:13:58', '2024-02-24 07:13:58', 7),
(74, 'Allow Multiple Loadsheets Per Driver', 'Loadsheets', 0, '2024-02-24 07:13:58', '2024-02-24 07:13:58', 7),
(75, 'Routes', 'Routes', 1, '2024-02-24 07:13:58', '2024-02-24 07:13:58', 7),
(76, 'Single Delivery Per Driver', 'Deliveries', 0, '2024-02-24 07:13:58', '2024-02-24 07:13:58', 7),
(77, 'Defaults warehouse per driver', 'Warehouse', 1, '2024-03-02 16:55:28', '2024-03-02 16:55:28', 8),
(78, 'Defaults  truck per driver', 'Trucks', 1, '2024-03-02 16:55:28', '2024-03-02 16:55:28', 8),
(79, 'Allow Multiple Loadsheets Per Driver', 'Loadsheets', 0, '2024-03-02 16:55:28', '2024-03-02 16:55:28', 8),
(80, 'Routes', 'Routes', 1, '2024-03-02 16:55:28', '2024-03-02 16:55:28', 8),
(81, 'Single Delivery Per Driver', 'Deliveries', 0, '2024-03-02 16:55:28', '2024-03-02 16:55:28', 8),
(82, 'Defaults warehouse per driver', 'Warehouse', 1, '2024-04-04 17:49:54', '2024-04-04 17:49:54', 9),
(83, 'Defaults  truck per driver', 'Trucks', 1, '2024-04-04 17:49:54', '2024-04-04 17:49:54', 9),
(84, 'Allow Multiple Loadsheets Per Driver', 'Loadsheets', 0, '2024-04-04 17:49:54', '2024-04-04 17:49:54', 9),
(85, 'Routes', 'Routes', 1, '2024-04-04 17:49:54', '2024-04-04 17:49:54', 9),
(86, 'Single Delivery Per Driver', 'Deliveries', 0, '2024-04-04 17:49:54', '2024-04-04 17:49:54', 9);

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `delivery_id` bigint(20) UNSIGNED DEFAULT NULL,
  `delivery_sheet_id` bigint(20) UNSIGNED DEFAULT NULL,
  `loadsheet_id` bigint(20) UNSIGNED DEFAULT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `invoice_number` varchar(255) NOT NULL,
  `status` enum('Pending','Canceled','Paid') NOT NULL,
  `type` enum('Delivery','LoadSheet','Branch') NOT NULL,
  `discount` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`discount`)),
  `tax` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`tax`)),
  `totals` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`totals`)),
  `customer_signature` varchar(255) DEFAULT NULL,
  `driver_signature` varchar(255) DEFAULT NULL,
  `receipt_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `invoices`
--

INSERT INTO `invoices` (`id`, `delivery_id`, `delivery_sheet_id`, `loadsheet_id`, `branch_id`, `customer_id`, `invoice_number`, `status`, `type`, `discount`, `tax`, `totals`, `customer_signature`, `driver_signature`, `receipt_url`, `created_at`, `updated_at`, `company_id`) VALUES
(1, 8, 12, NULL, NULL, 12, '2732323', 'Paid', 'Delivery', '{\"USD\": 2.4, \"RTGS\": 8250000}', '[]', '{\"USD\": 120, \"RTGS\": 165000}', NULL, NULL, NULL, '2024-02-19 07:18:05', '2024-02-19 07:18:05', 2),
(2, NULL, NULL, 11, NULL, 12, '2723323', 'Paid', 'LoadSheet', '{\"USD\": 2.4, \"RTGS\": 8250000}', '[]', '{\"USD\": 120, \"RTGS\": 165000}', NULL, NULL, NULL, '2024-02-19 07:19:38', '2024-02-19 07:19:38', 2),
(3, NULL, NULL, NULL, 2, 12, '2722323', 'Paid', 'Branch', '{\"USD\": 2.4, \"RTGS\": 8250000}', '[]', '{\"USD\": 120, \"RTGS\": 165000}', NULL, NULL, NULL, '2024-02-19 07:30:18', '2024-02-19 07:30:18', 2),
(4, 9, 14, NULL, NULL, 12, '2712323', 'Paid', 'Delivery', '{\"USD\": 2.4, \"RTGS\": 8250000}', '[]', '{\"USD\": 120, \"RTGS\": 165000}', NULL, NULL, NULL, '2024-02-19 12:18:41', '2024-02-19 12:18:41', 6),
(5, NULL, NULL, 5, NULL, 19, '867676', 'Paid', 'LoadSheet', '{\"USD\": 0, \"RTGS\": 0}', '{\"USD\": 0, \"RTGS\": 0}', '{\"USD\": 120, \"RTGS\": 165000}', NULL, NULL, NULL, '2024-03-02 18:08:28', '2024-03-02 18:08:28', 2);

-- --------------------------------------------------------

--
-- Table structure for table `invoice_items`
--

CREATE TABLE `invoice_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `invoice_id` bigint(20) UNSIGNED NOT NULL,
  `stock_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` double(8,2) NOT NULL,
  `is_synced` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `invoice_items`
--

INSERT INTO `invoice_items` (`id`, `invoice_id`, `stock_id`, `quantity`, `is_synced`, `created_at`, `updated_at`) VALUES
(1, 1, 15, 20.00, 1, '2024-02-19 07:18:05', '2024-02-19 07:18:05'),
(2, 2, 15, 20.00, 1, '2024-02-19 07:19:38', '2024-02-19 07:19:38'),
(3, 3, 15, 20.00, 1, '2024-02-19 07:30:18', '2024-02-19 07:30:18'),
(4, 4, 15, 20.00, 1, '2024-02-19 12:18:41', '2024-02-19 12:18:41'),
(5, 5, 26, 20.00, 1, '2024-03-02 18:08:29', '2024-03-02 18:08:29');

-- --------------------------------------------------------

--
-- Table structure for table `loadsheets`
--

CREATE TABLE `loadsheets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `loadsheet_number` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `truck_id` bigint(20) UNSIGNED NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` enum('Draft','Created','Loaded','Confirmed','Completed','Started','Cancelled') NOT NULL,
  `route_id` bigint(20) UNSIGNED NOT NULL,
  `start_date_time` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loadsheets`
--

INSERT INTO `loadsheets` (`id`, `loadsheet_number`, `user_id`, `truck_id`, `warehouse_id`, `status`, `route_id`, `start_date_time`, `created_at`, `updated_at`, `company_id`) VALUES
(1, 'LS0001', 17, 8, 15, 'Cancelled', 10, '2024-02-22T02:31:00.000Z', '2024-02-21 00:31:36', '2024-02-26 07:13:54', 2),
(2, 'LS0001', 21, 13, 20, 'Loaded', 12, '2024-02-26T10:06:00.000Z', '2024-02-24 08:06:37', '2024-02-24 08:06:37', 7),
(3, '0002', 23, 8, 19, 'Cancelled', 10, '2024-02-28T06:30:00.000Z', '2024-02-26 06:47:26', '2024-02-26 07:13:46', 2),
(4, '0004', 23, 8, 19, 'Completed', 10, '2024-02-28T06:15:00.000Z', '2024-02-26 07:14:19', '2024-03-02 18:13:54', 2),
(5, '0001', 25, 14, 22, 'Completed', 13, '2024-03-25T09:26:00.000Z', '2024-03-02 17:26:40', '2024-03-02 18:27:05', 8),
(6, 'LS0001', 28, 17, 24, 'Started', 14, '2024-04-11T21:17:00.000Z', '2024-04-04 19:17:48', '2024-04-06 22:56:45', 9);

-- --------------------------------------------------------

--
-- Table structure for table `loadsheet_histories`
--

CREATE TABLE `loadsheet_histories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `loadsheet_id` bigint(20) UNSIGNED NOT NULL,
  `status` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loadsheet_histories`
--

INSERT INTO `loadsheet_histories` (`id`, `loadsheet_id`, `status`, `user_id`, `description`, `created_at`, `updated_at`) VALUES
(1, 1, 'Created', 12, 'Loadsheet Created', '2024-02-21 00:31:36', '2024-02-21 00:31:36'),
(2, 1, 'Customer Stops Added', 12, 'Customer Stops Added', '2024-02-21 00:31:36', '2024-02-21 00:31:36'),
(3, 1, 'Loaded', 12, 'Loadsheet Loaded', '2024-02-21 00:31:36', '2024-02-21 00:31:36'),
(4, 1, 'Customer Stop Deleted', 12, 'Customer Stop Deleted: Customer First', '2024-02-21 00:35:44', '2024-02-21 00:35:44'),
(5, 2, 'Created', 20, 'Loadsheet Created', '2024-02-24 08:06:37', '2024-02-24 08:06:37'),
(6, 2, 'Customer Stops Added', 20, 'Customer Stops Added', '2024-02-24 08:06:37', '2024-02-24 08:06:37'),
(7, 2, 'Loaded', 20, 'Loadsheet Loaded', '2024-02-24 08:06:37', '2024-02-24 08:06:37'),
(8, 3, 'Created', 12, 'Loadsheet Created', '2024-02-26 06:47:26', '2024-02-26 06:47:26'),
(9, 3, 'Customer Stops Added', 12, 'Customer Stops Added', '2024-02-26 06:47:26', '2024-02-26 06:47:26'),
(10, 3, 'Loaded', 12, 'Loadsheet Loaded', '2024-02-26 06:47:26', '2024-02-26 06:47:26'),
(11, 3, 'Cancelled', 12, 'Loadsheet Cancelled', '2024-02-26 07:13:46', '2024-02-26 07:13:46'),
(12, 1, 'Cancelled', 12, 'Loadsheet Cancelled', '2024-02-26 07:13:54', '2024-02-26 07:13:54'),
(13, 4, 'Created', 12, 'Loadsheet Created', '2024-02-26 07:14:19', '2024-02-26 07:14:19'),
(14, 4, 'Customer Stops Added', 12, 'Customer Stops Added', '2024-02-26 07:14:19', '2024-02-26 07:14:19'),
(15, 4, 'Loaded', 12, 'Loadsheet Loaded', '2024-02-26 07:14:20', '2024-02-26 07:14:20'),
(16, 4, 'Confirmed', 12, 'Loadsheet Confirmed', '2024-02-26 21:58:37', '2024-02-26 21:58:37'),
(17, 4, 'Started', 23, 'Loadsheet Started', '2024-02-29 09:33:01', '2024-02-29 09:33:01'),
(18, 4, 'Started', 23, 'Loadsheet Started', '2024-02-29 09:34:35', '2024-02-29 09:34:35'),
(19, 4, 'Started', 23, 'Loadsheet Started', '2024-02-29 09:35:23', '2024-02-29 09:35:23'),
(20, 4, 'Started', 23, 'Loadsheet Started', '2024-02-29 09:44:17', '2024-02-29 09:44:17'),
(21, 4, 'Started', 23, 'Loadsheet Started', '2024-02-29 09:44:49', '2024-02-29 09:44:49'),
(22, 4, 'Started', 23, 'Loadsheet Started', '2024-02-29 09:46:35', '2024-02-29 09:46:35'),
(23, 4, 'Started', 23, 'Loadsheet Started', '2024-02-29 15:56:50', '2024-02-29 15:56:50'),
(24, 4, 'Started', 23, 'Loadsheet Started', '2024-03-01 01:55:32', '2024-03-01 01:55:32'),
(25, 4, 'Started', 23, 'Loadsheet Started', '2024-03-01 03:00:22', '2024-03-01 03:00:22'),
(26, 5, 'Created', 24, 'Loadsheet Created', '2024-03-02 17:26:40', '2024-03-02 17:26:40'),
(27, 5, 'Customer Stops Added', 24, 'Customer Stops Added', '2024-03-02 17:26:40', '2024-03-02 17:26:40'),
(28, 5, 'Loaded', 24, 'Loadsheet Loaded', '2024-03-02 17:26:41', '2024-03-02 17:26:41'),
(29, 5, 'Confirmed', 24, 'Loadsheet Confirmed', '2024-03-02 17:28:32', '2024-03-02 17:28:32'),
(30, 5, 'Started', 25, 'Loadsheet Started', '2024-03-02 17:39:36', '2024-03-02 17:39:36'),
(31, 4, 'Completed', 12, 'Loadsheet Completed', '2024-03-02 18:13:54', '2024-03-02 18:13:54'),
(32, 5, 'Completed', 24, 'Loadsheet Completed', '2024-03-02 18:27:05', '2024-03-02 18:27:05'),
(33, 6, 'Created', 27, 'Loadsheet Created', '2024-04-04 19:17:48', '2024-04-04 19:17:48'),
(34, 6, 'Customer Stops Added', 27, 'Customer Stops Added', '2024-04-04 19:17:48', '2024-04-04 19:17:48'),
(35, 6, 'Loaded', 27, 'Loadsheet Loaded', '2024-04-04 19:17:48', '2024-04-04 19:17:48'),
(36, 6, 'Confirmed', 27, 'Loadsheet Confirmed', '2024-04-04 19:19:48', '2024-04-04 19:19:48'),
(37, 6, 'Started', 28, 'Loadsheet Started', '2024-04-04 20:41:03', '2024-04-04 20:41:03'),
(38, 6, 'Started', 28, 'Loadsheet Started', '2024-04-06 22:56:45', '2024-04-06 22:56:45');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2014_10_12_200000_add_two_factor_columns_to_users_table', 1),
(4, '2019_08_19_000000_create_failed_jobs_table', 1),
(5, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(6, '2023_09_26_132114_create_sessions_table', 1),
(7, '2023_09_26_132726_create_permission_tables', 1),
(8, '2023_09_26_134443_create_warehouses_table', 1),
(9, '2023_09_26_134454_create_product_categories_table', 1),
(10, '2023_09_26_134505_create_unit_measures_table', 1),
(11, '2023_09_26_134506_create_taxes_table', 1),
(12, '2023_09_26_134507_create_products_table', 1),
(13, '2023_09_26_134529_create_stocks_table', 1),
(14, '2023_09_26_140125_create_trucks_table', 1),
(15, '2023_09_26_140502_create_customers_table', 1),
(16, '2023_09_26_140622_create_routes_table', 1),
(18, '2023_09_26_141428_create_route_nodes_table', 1),
(19, '2023_09_26_141801_create_load_sheet_details_table', 1),
(20, '2023_09_26_142127_create_customer_stops_table', 1),
(23, '2023_09_29_085730_add_name_to_route_nodes_table', 2),
(24, '2023_09_30_095037_create_loadsheet_histories_table', 3),
(25, '2023_09_26_140623_create_loadsheets_table', 4),
(26, '2023_10_03_210934_create_currencies_table', 5),
(27, '2023_10_03_211008_create_pricing_methods_table', 5),
(29, '2023_10_03_211036_create_product_pricings_table', 6),
(31, '2023_10_03_212730_add_is_default_to_product_pricings_table', 7),
(32, '2023_10_05_125824_create_general_settings_table', 8),
(35, '2023_11_01_081441_create_payment_methods_table', 10),
(36, '2023_11_07_013438_add_is_available_to_users_table', 11),
(37, '2023_11_14_093403_add_warehouse_id_to_users_table', 12),
(38, '2023_11_14_093912_add_address_to_users_table', 12),
(39, '2023_11_14_120505_add_route_id_to_customers_table', 13),
(40, '2023_11_14_143133_create_currency_payment_methods_table', 14),
(41, '2023_11_16_075719_add_is_main_warehouse_to_warehouses_table', 15),
(42, '2023_11_29_071325_add_totals_to_sales_orders_table', 16),
(43, '2014_09_11_000000_create_users_table_create_companies_table', 17),
(45, '2024_02_08_093757_create_features_table', 17),
(46, '2024_02_08_095202_create_subscriptions_table', 17),
(47, '2024_02_08_095436_create_company_subscriptions_table', 17),
(48, '2024_02_08_092836_add_user_type_to_users_table', 18),
(49, '2024_02_08_135420_add_features_to_subscriptions_table', 19),
(50, '2024_02_09_120509_add_company_id_to_warehouses_table', 20),
(51, '2024_02_09_120642_add_company_id_to_sale_orders_table', 20),
(52, '2024_02_09_120821_add_company_id_to_product_categories_table', 20),
(53, '2024_02_09_120846_add_company_id_to_unit_measures_table', 20),
(54, '2024_02_09_120859_add_company_id_to_taxes_table', 20),
(55, '2024_02_09_120917_add_company_id_to_products_table', 20),
(56, '2024_02_09_120931_add_company_id_to_stocks_table', 20),
(57, '2024_02_09_120953_add_company_id_to_trucks_table', 20),
(58, '2024_02_09_121001_add_company_id_to_customers_table', 20),
(59, '2024_02_09_121014_add_company_id_to_routes_table', 20),
(60, '2024_02_09_121046_add_company_id_to_loadsheets_table', 20),
(61, '2024_02_09_121118_add_company_id_to_load_sheet_details_table', 20),
(62, '2024_02_09_121157_add_company_id_to_currencies_table', 20),
(63, '2024_02_09_121209_add_company_id_to_pricing_methods_table', 20),
(64, '2024_02_09_121223_add_company_id_to_product_pricings_table', 20),
(65, '2024_02_09_121240_add_company_id_to_general_settings_table', 20),
(66, '2024_02_09_121257_add_company_id_to_payment_methods_table', 20),
(67, '2024_02_09_121314_add_company_id_to_currency_payment_methods_table', 20),
(68, '2024_02_09_152446_add_settings_to_companies_table', 21),
(69, '2024_02_13_185453_create_delivery_sheets_table', 22),
(70, '2024_02_13_185454_create_deliveries_table', 22),
(71, '2024_02_13_191024_create_delivery_items_table', 22),
(73, '2024_02_13_191349_create_delivery_histories_table', 23),
(74, '2023_09_26_142348_create_sale_orders_table', 24),
(75, '2023_09_26_142528_create_sale_order_details_table', 24),
(76, '2024_02_15_182028_create_delivery_invoices_table', 24),
(77, '2024_02_15_183246_create_delivery_invoice_items_table', 24),
(78, '2024_02_15_204728_add_delivery_sheet_id_to_delivery_invoices', 25),
(79, '2024_02_18_185335_create_branches_table', 26),
(80, '2024_02_18_220813_add_user_id_to_branches_table', 27),
(83, '2024_02_18_235706_create_invoices_table', 28),
(84, '2024_02_18_235914_create_invoice_items_table', 28),
(85, '2024_02_19_101412_add_delivery_sheet_number_to_delivery_sheets', 29),
(87, '2024_02_19_122103_add_company_id_to_invoices_table', 30),
(88, '2024_02_21_005509_create_allocation_items_table', 31);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(2, 'App\\Models\\User', 2),
(2, 'App\\Models\\User', 3),
(2, 'App\\Models\\User', 5),
(2, 'App\\Models\\User', 6),
(2, 'App\\Models\\User', 7),
(2, 'App\\Models\\User', 8),
(2, 'App\\Models\\User', 9),
(2, 'App\\Models\\User', 15),
(2, 'App\\Models\\User', 16),
(2, 'App\\Models\\User', 17),
(2, 'App\\Models\\User', 19),
(2, 'App\\Models\\User', 21),
(2, 'App\\Models\\User', 22),
(2, 'App\\Models\\User', 23),
(2, 'App\\Models\\User', 25),
(2, 'App\\Models\\User', 26),
(2, 'App\\Models\\User', 28),
(13, 'App\\Models\\User', 11),
(13, 'App\\Models\\User', 12),
(13, 'App\\Models\\User', 13),
(13, 'App\\Models\\User', 14),
(13, 'App\\Models\\User', 18),
(13, 'App\\Models\\User', 20),
(13, 'App\\Models\\User', 24),
(13, 'App\\Models\\User', 27);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_methods`
--

CREATE TABLE `payment_methods` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_methods`
--

INSERT INTO `payment_methods` (`id`, `name`, `is_default`, `created_at`, `updated_at`, `company_id`) VALUES
(1, 'Cash', 1, '2023-11-01 06:42:39', '2023-11-01 06:42:39', NULL),
(2, 'Zipit', 0, '2023-11-01 06:42:46', '2023-11-01 06:42:46', NULL),
(3, 'Transfer', 0, '2023-11-14 11:31:29', '2023-11-14 11:31:29', NULL),
(4, 'Cash', 1, '2024-02-09 11:34:36', '2024-02-09 11:34:36', 2),
(5, 'Bank Transfer', 0, '2024-02-09 11:34:44', '2024-02-09 11:34:44', 2),
(6, 'Mobile', 0, '2024-02-09 11:34:51', '2024-02-09 11:34:51', 2),
(7, 'Cash', 1, '2024-02-09 13:33:36', '2024-02-09 13:33:36', 4),
(8, 'Bank Transfer', 0, '2024-02-09 13:33:42', '2024-02-09 13:33:42', 4),
(9, 'Mobile', 0, '2024-02-09 13:33:48', '2024-02-09 13:33:48', 4),
(10, 'Cash', 1, '2024-02-09 13:44:46', '2024-02-09 13:44:46', 5),
(11, 'Bank Transfer', 1, '2024-02-09 13:44:51', '2024-02-09 13:44:51', 5),
(12, 'Mobile', 1, '2024-02-09 13:44:57', '2024-02-09 13:44:57', 5),
(13, 'Cash', 1, '2024-02-19 10:49:03', '2024-02-19 10:49:03', 6),
(14, 'Bank Transfer', 1, '2024-02-19 10:49:08', '2024-02-19 10:49:08', 6),
(15, 'Mobile', 1, '2024-02-19 10:49:14', '2024-02-19 10:49:14', 6),
(16, 'Cash', 1, '2024-02-24 07:27:28', '2024-02-24 07:27:28', 7),
(17, 'Bank Transfer', 0, '2024-02-24 07:27:34', '2024-02-24 07:27:34', 7),
(18, 'Mobile', 0, '2024-02-24 07:27:40', '2024-02-24 07:27:40', 7),
(19, 'Cash', 1, '2024-03-02 17:03:05', '2024-03-02 17:03:05', 8),
(20, 'Bank Transfer', 1, '2024-03-02 17:03:13', '2024-03-02 17:03:13', 8),
(21, 'Cash', 1, '2024-04-04 18:31:40', '2024-04-04 18:38:53', 9),
(22, 'Bank Transfer', 0, '2024-04-04 18:31:47', '2024-04-04 18:38:53', 9),
(23, 'Mobile', 0, '2024-04-04 18:31:54', '2024-04-04 18:38:53', 9);

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'user_management', 'web', '2023-09-26 15:23:34', '2023-09-26 15:23:34'),
(2, 'role_permission_management', 'web', '2023-09-26 15:24:15', '2023-09-26 15:24:15'),
(3, 'dashboard', 'web', '2023-09-26 16:17:54', '2023-09-26 16:17:54'),
(4, 'loadsheet_management', 'web', '2023-09-26 21:47:25', '2023-09-26 21:47:25'),
(5, 'truck_management', 'web', '2023-09-27 06:44:49', '2023-09-27 06:44:49'),
(6, 'reports', 'web', '2023-09-27 06:49:42', '2023-09-27 06:49:42'),
(7, 'warehouse_management', 'web', '2023-09-27 11:13:55', '2023-09-27 11:13:55'),
(8, 'inventory_management', 'web', '2023-09-27 12:10:14', '2023-09-27 12:10:14'),
(9, 'product_management', 'web', '2023-09-27 12:19:04', '2023-09-27 12:19:04'),
(10, 'customer_management', 'web', '2023-09-29 06:40:38', '2023-09-29 06:40:38'),
(11, 'route_management', 'web', '2023-09-29 07:17:25', '2023-09-29 07:17:25'),
(12, 'product_settings_management', 'web', '2023-10-03 20:08:36', '2023-10-03 20:08:36'),
(13, 'settings_management', 'web', '2023-10-03 20:10:34', '2023-10-03 20:10:34'),
(14, 'general_settings_management', 'web', '2023-10-05 11:48:24', '2023-10-05 11:48:24'),
(15, 'sales_management', 'web', '2023-11-01 07:01:16', '2023-11-01 07:01:16'),
(16, 'company_management', 'web', '2024-02-08 09:26:56', '2024-02-08 09:26:56'),
(17, 'subscription_management', 'web', '2024-02-08 09:27:06', '2024-02-08 09:27:06'),
(18, 'delivery_management', 'web', '2024-02-13 16:52:51', '2024-02-13 16:52:51'),
(19, 'employee_management', 'web', '2024-02-13 18:51:26', '2024-02-13 18:51:26'),
(20, 'admin_dashboard', 'web', '2024-02-18 19:25:13', '2024-02-18 19:25:13'),
(21, 'branch_management', 'web', '2024-02-18 19:48:07', '2024-02-18 19:48:07');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 8, 's22ultrasamsung', '5b066561e5106d28aaf30453d58e5df02041cb13cd03d5f0aa7730ee6de14231', '[\"*\"]', '2023-10-18 20:53:44', NULL, '2023-10-17 10:34:04', '2023-10-18 20:53:44'),
(2, 'App\\Models\\User', 8, 's22ultrasamsung', '2444730c379e93be0347652db3e0a324e171a2fd71f5aa6a74359a69b64d8e3f', '[\"*\"]', NULL, NULL, '2023-10-19 07:26:54', '2023-10-19 07:26:54'),
(3, 'App\\Models\\User', 8, 's22ultrasamsung', '9166e9d7fb4a617d07ebe396f059cfcaef5c8b5ce8f0134b4684c8af95bbfb44', '[\"*\"]', '2023-11-29 05:42:29', NULL, '2023-11-07 00:01:54', '2023-11-29 05:42:29'),
(4, 'App\\Models\\User', 17, 's22ultrasamsung', '58d2ed468b0fb3fa334b722b5fe2beeb8c420ad3295f78d031738911908c1cc0', '[\"*\"]', '2024-02-16 08:31:09', NULL, '2024-02-15 16:03:49', '2024-02-16 08:31:09'),
(5, 'App\\Models\\User', 17, 's22ultrasamsung', 'dc658fc2b373fead67ee8889c2d73d9f02e0a376b91f2e8ae86b0258f2e55602', '[\"*\"]', '2024-02-19 07:30:18', NULL, '2024-02-18 23:18:06', '2024-02-19 07:30:18'),
(6, 'App\\Models\\User', 19, 's22ultrasamsung', '74a71bc1e9eae0657ab6b49f1455f591c9bd5dabe89ea7bf0cd4d2b108ac449b', '[\"*\"]', '2024-02-19 12:18:41', NULL, '2024-02-19 12:17:46', '2024-02-19 12:18:41'),
(7, 'App\\Models\\User', 23, '1234567890', 'fd7d3d9cbbd2cc358f9a309b10396df1b4a7906e600690e7c5225a58561947c2', '[\"*\"]', '2024-02-26 20:03:08', NULL, '2024-02-26 20:03:01', '2024-02-26 20:03:08'),
(8, 'App\\Models\\User', 23, 's22ultrasamsung', '432ca740cddd6495b2a8dbbae63f4d31ac82b7fcfff40729a7141faaebf60e07', '[\"*\"]', '2024-03-02 18:08:28', NULL, '2024-02-26 22:04:36', '2024-03-02 18:08:28'),
(9, 'App\\Models\\User', 23, '1234567890', 'ec77ecfb69b55e19b285303fbe76180a043ceb4b72eb368f421a0d42605dfb25', '[\"*\"]', '2024-02-27 01:20:06', NULL, '2024-02-27 01:16:18', '2024-02-27 01:20:06'),
(10, 'App\\Models\\User', 23, '1234567890', '98ebd9cf8e8f220eae063217db98d26c1585139333062ad7b81005faf7a2fad4', '[\"*\"]', '2024-02-27 06:09:32', NULL, '2024-02-27 05:13:39', '2024-02-27 06:09:32'),
(11, 'App\\Models\\User', 23, '1234567890', '3e346cabaa2bcde960f1c1aa596a737628589a38530a6013413a91eca90a2964', '[\"*\"]', '2024-02-27 05:46:29', NULL, '2024-02-27 05:46:27', '2024-02-27 05:46:29'),
(12, 'App\\Models\\User', 23, '1234567890', '34ae5ff36e0461d72607d9b54126451f59eea456a4605965c0c7fbc06816a92f', '[\"*\"]', '2024-02-27 05:48:10', NULL, '2024-02-27 05:48:08', '2024-02-27 05:48:10'),
(13, 'App\\Models\\User', 23, '1234567890', 'a3a21e94543359821e67e4f7cf940802a153af449a0596b266b08f2e142bed4a', '[\"*\"]', '2024-02-27 05:49:51', NULL, '2024-02-27 05:49:48', '2024-02-27 05:49:51'),
(14, 'App\\Models\\User', 23, '1234567890', '6658d1d31b081efc292778de2a9cbbffdc4f196fbd81c8ce7be04d4d62c59c1f', '[\"*\"]', '2024-02-27 05:57:43', NULL, '2024-02-27 05:52:23', '2024-02-27 05:57:43'),
(15, 'App\\Models\\User', 23, '1234567890', 'bee5c6d618a0ed8499e0937be310762a4f51e54859e227ee9f309331861bcec9', '[\"*\"]', '2024-02-27 05:58:36', NULL, '2024-02-27 05:58:34', '2024-02-27 05:58:36'),
(16, 'App\\Models\\User', 23, '1234567890', 'a44453910d35371beaa0e32791858c8657d2ffd8e9b004c86cd6b9c7ca05fb48', '[\"*\"]', '2024-02-27 06:20:05', NULL, '2024-02-27 06:10:28', '2024-02-27 06:20:05'),
(17, 'App\\Models\\User', 23, '1234567890', '266af7982dc821afdfe928f1d983329750407f97f0c344bb17fbc35dfd8bc1b3', '[\"*\"]', '2024-02-29 01:33:38', NULL, '2024-02-27 19:31:51', '2024-02-29 01:33:38'),
(18, 'App\\Models\\User', 23, '1234567890', '25c54eb8e1ad82d6c26c59723314dbac7485ca29f6c879c535b8529b7ae1de81', '[\"*\"]', '2024-02-27 21:51:41', NULL, '2024-02-27 21:22:42', '2024-02-27 21:51:41'),
(19, 'App\\Models\\User', 23, '1234567890', 'f3baa98b2afc7d0b831458812a472aa623d2113f8c72813a3c2bfb5ad04ab342', '[\"*\"]', '2024-02-27 22:09:23', NULL, '2024-02-27 21:54:24', '2024-02-27 22:09:23'),
(20, 'App\\Models\\User', 23, '1234567890', '651f4dffedafc99a6c415863f12a7ca75516af4618508d2fd64161e7b3e20090', '[\"*\"]', '2024-02-29 17:18:16', NULL, '2024-02-27 22:12:30', '2024-02-29 17:18:16'),
(21, 'App\\Models\\User', 23, '1234567890', '51a96dd9421e75797b809d0647b78d97e9b07f614f96578fa9919e207ede4857', '[\"*\"]', '2024-02-29 01:35:38', NULL, '2024-02-29 01:35:01', '2024-02-29 01:35:38'),
(22, 'App\\Models\\User', 23, '1234567890', 'b7c556e9f97cdbe27c737a15c88380cc7bcba29c9ba3ecf1698b3d32c7f759e9', '[\"*\"]', '2024-02-29 01:36:41', NULL, '2024-02-29 01:36:37', '2024-02-29 01:36:41'),
(23, 'App\\Models\\User', 23, '1234567890', '1f99aed085211af71fa2efe9c0192b399a71cc35991020ab7c728cc2520be2ef', '[\"*\"]', '2024-02-29 07:11:58', NULL, '2024-02-29 07:11:55', '2024-02-29 07:11:58'),
(24, 'App\\Models\\User', 23, '1234567890', '72ce54ddae5740d4e512e54e4d5176136069a2de48a3fa43f0864463924e6df1', '[\"*\"]', '2024-02-29 07:11:58', NULL, '2024-02-29 07:11:55', '2024-02-29 07:11:58'),
(25, 'App\\Models\\User', 23, '1234567890', '0b8b3998d09719394923d5315ae5d589dde4ee5bebafb7c81fc8e37684206246', '[\"*\"]', '2024-02-29 07:18:20', NULL, '2024-02-29 07:11:55', '2024-02-29 07:18:20'),
(26, 'App\\Models\\User', 23, '1234567890', '6f5a0d503d0e5dbd12701c828767a39bf7f5f64ca50a212ca7637044c1e33df4', '[\"*\"]', '2024-02-29 07:34:03', NULL, '2024-02-29 07:19:55', '2024-02-29 07:34:03'),
(27, 'App\\Models\\User', 23, '1234567890', 'f05ce9e13f1c764e6fe20de754c79236ec16fa6f5332cb74aba91e561669523b', '[\"*\"]', '2024-02-29 09:35:23', NULL, '2024-02-29 09:20:57', '2024-02-29 09:35:23'),
(28, 'App\\Models\\User', 23, '1234567890', 'f91195e9ae4d7d985180c76e79c6a1fd414e4af75529eceba1c3d875010c0420', '[\"*\"]', '2024-02-29 15:26:46', NULL, '2024-02-29 09:36:59', '2024-02-29 15:26:46'),
(29, 'App\\Models\\User', 23, '1234567890', '5c22af835966f686fd53dcb18969517233dda29868499bd931600effcccb5970', '[\"*\"]', '2024-02-29 17:34:11', NULL, '2024-02-29 15:55:19', '2024-02-29 17:34:11'),
(30, 'App\\Models\\User', 23, '1234567890', '5aca5f52fa3353ec12adf46236f7a189614ca4463b9d4efc3071d43427a9d63b', '[\"*\"]', NULL, NULL, '2024-03-01 01:52:30', '2024-03-01 01:52:30'),
(31, 'App\\Models\\User', 23, '1234567890', 'd90dce47a4b71d8897a60b8bb6dfa75de2986b98baddd8412e0884a554a80ac5', '[\"*\"]', '2024-03-01 17:30:30', NULL, '2024-03-01 01:52:59', '2024-03-01 17:30:30'),
(32, 'App\\Models\\User', 23, '1234567890', 'ddbd6dd9605eb251c358ef28b2ac8f8dbf45b1dfd4ef09936fc796264d5a01c4', '[\"*\"]', '2024-03-02 14:04:11', NULL, '2024-03-02 14:04:05', '2024-03-02 14:04:11'),
(33, 'App\\Models\\User', 23, '1234567890', 'f71d426545ccc88ef73173c4d53b822380ea28f01cfe867a5b2185be394bc48a', '[\"*\"]', '2024-03-02 14:21:45', NULL, '2024-03-02 14:15:34', '2024-03-02 14:21:45'),
(34, 'App\\Models\\User', 25, '1234567890', 'a7a89f6c9703d8c3ec1b330164b3a14fbf84274e9a4aad3028631c6a1db31f11', '[\"*\"]', '2024-03-02 17:44:35', NULL, '2024-03-02 17:30:58', '2024-03-02 17:44:35'),
(35, 'App\\Models\\User', 28, 's22ultrasamsung', 'dcb0334d838e411255697063d44aadd3ed78d506a0823d5de0a4a2423edde6ed', '[\"*\"]', '2024-04-04 19:19:55', NULL, '2024-04-04 19:18:46', '2024-04-04 19:19:55'),
(36, 'App\\Models\\User', 28, '1234567890', 'c07df4984175f9acb711eac6b5040a8c56b35e6ee53ada07f5f043a50677b57d', '[\"*\"]', '2024-04-04 21:12:22', NULL, '2024-04-04 20:07:46', '2024-04-04 21:12:22'),
(37, 'App\\Models\\User', 28, 's22ultrasamsung', 'd48a22e153406ac2597d89b0a1c1dba2e8b7efee9af18ee0245baf5c06a300ff', '[\"*\"]', '2024-04-06 21:20:14', NULL, '2024-04-06 21:19:55', '2024-04-06 21:20:14'),
(38, 'App\\Models\\User', 28, '1234567890', '9ff72e8cfac6e6c62c465ef5a2cf207e61fc151a319cdc81742c2e1d445c225a', '[\"*\"]', '2024-04-07 00:33:03', NULL, '2024-04-06 22:31:24', '2024-04-07 00:33:03');

-- --------------------------------------------------------

--
-- Table structure for table `pricing_methods`
--

CREATE TABLE `pricing_methods` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pricing_methods`
--

INSERT INTO `pricing_methods` (`id`, `name`, `is_default`, `created_at`, `updated_at`, `company_id`) VALUES
(1, 'Exchange Rate', 1, '2023-10-04 03:19:35', '2023-10-04 17:07:03', NULL),
(2, 'Fixed Price Per Currency', 0, '2023-10-04 03:19:56', '2023-10-04 17:07:03', NULL),
(8, 'Fixed Price Per Currency', 0, '2024-02-09 19:30:01', '2024-02-15 16:01:11', 2),
(9, 'Exchange Rate', 1, '2024-02-09 19:30:09', '2024-02-15 16:01:11', 2),
(10, 'Exchange Rate', 1, '2024-02-09 21:33:20', '2024-02-09 21:33:20', 4),
(11, 'Fixed Price Per Currency', 1, '2024-02-09 21:33:27', '2024-02-09 21:33:27', 4),
(12, 'Exchange Rate', 1, '2024-02-09 21:44:30', '2024-02-09 21:44:30', 5),
(13, 'Fixed Price Per Currency', 0, '2024-02-09 21:44:37', '2024-02-09 21:44:37', 5),
(14, 'Fixed Price Per Currency', 0, '2024-02-19 18:49:21', '2024-02-19 18:49:21', 6),
(15, 'Exchange Rate', 1, '2024-02-19 18:49:28', '2024-02-19 18:49:28', 6),
(16, 'Exchange Rate', 1, '2024-03-02 17:04:08', '2024-03-02 17:04:08', 8),
(17, 'Fixed Price Per Currency', 0, '2024-03-02 17:04:17', '2024-03-02 17:04:17', 8),
(18, 'Fixed Price Per Currency', 1, '2024-04-04 18:39:07', '2024-04-04 18:39:07', 9),
(19, 'Exchange Rate', 0, '2024-04-04 18:39:13', '2024-04-04 18:39:13', 9);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `product_category_id` bigint(20) UNSIGNED NOT NULL,
  `reorder_level` double(8,2) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `tax_id` bigint(20) UNSIGNED NOT NULL,
  `unit_measure_id` bigint(20) UNSIGNED NOT NULL,
  `discount` double(8,2) DEFAULT NULL,
  `retail_unit_price` double(8,2) DEFAULT NULL,
  `wholesale_unit_price` double(8,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `code`, `description`, `product_category_id`, `reorder_level`, `image`, `tax_id`, `unit_measure_id`, `discount`, `retail_unit_price`, `wholesale_unit_price`, `created_at`, `updated_at`, `company_id`) VALUES
(1, 'PH0001', 'Red Bull', 4, 200.00, 'products/sp6r1o0UU6P7s9daWMKh88B3v2SfagAygVYFIcNc.jpg', 4, 4, 3.00, NULL, NULL, '2023-10-04 04:23:15', '2023-11-07 10:54:39', NULL),
(2, 'PH0002', 'Coke Drink', 4, 600.00, 'products/zs5r8GmAFGXuzoTHIeVDLq4xodfLFjKC9jVr5U0V.jpg', 1, 4, NULL, NULL, NULL, '2023-10-18 19:37:49', '2023-10-18 19:37:49', NULL),
(3, 'PH0003', 'Chompkins', 1, 3000.00, 'products/2gyS8YKDnrnoJh2741qE4sJ4k4bWEh7L0mUoLdRy.png', 2, 1, NULL, NULL, NULL, '2023-11-07 07:29:02', '2023-11-07 07:29:02', NULL),
(4, 'PH0004', 'Spuds', 1, 3000.00, 'products/hkgtJJuXIbHcb1emTOfZ8JapPNp50I9Ecyy1h7Hl.png', 2, 1, NULL, NULL, NULL, '2023-11-07 07:29:19', '2023-11-07 07:29:19', NULL),
(5, 'PH0005', 'Lays', 1, 4000.00, 'products/R0UalGkhTF1CeeBBMHEhwF86wMxaxz7JELc67qhN.jpg', 2, 1, NULL, NULL, NULL, '2023-11-07 07:29:41', '2023-11-07 07:29:41', NULL),
(6, 'PH0006', 'Red Bull', 4, 4000.00, 'products/Uqcu9gbUPI08qYIwuYGu3D0haPeb2NK8X1bc3Yph.jpg', 2, 4, NULL, NULL, NULL, '2023-11-07 07:30:14', '2023-11-07 07:30:14', NULL),
(7, 'PH0007', 'Pepsi', 4, 5000.00, 'products/agjHi1R58QxpQPxXsGNSmN0pdZYAW8Hq6wcGI8YB.png', 2, 4, NULL, NULL, NULL, '2023-11-07 07:30:46', '2023-11-07 10:54:15', NULL),
(8, '0001', 'Coke-Soft Drink', 6, 500.00, 'products/hlTTBCQajODkaaxFoFbrynMK8MxA4ryE1P8fQwwP.jpg', 5, 6, NULL, NULL, NULL, '2024-02-15 16:04:09', '2024-02-15 16:04:09', 2),
(9, '0001', 'Coke-Soft Drink', 8, 100.00, 'products/b3jYaMK89cqEcBb4UdGAKgRlnZ9iRjfYqzCH8rIO.jpg', 8, 7, NULL, NULL, NULL, '2024-02-19 18:58:54', '2024-02-19 18:58:54', 6),
(10, '0009', 'Coke 2 Soft drink', 6, 100.00, 'products/k9ZooYxinLwwYDq75rsZMw2k9E4jruc5aTAUcu0L.jpg', 5, 6, NULL, NULL, NULL, '2024-02-26 13:48:37', '2024-02-26 13:48:37', 2),
(11, '0011', 'test', 6, 40.00, 'products/bNXtRPIY8P0ldT6xXyF6NYfYgfr9qqOM16cdBLvj.jpg', 5, 6, NULL, NULL, NULL, '2024-02-26 14:03:35', '2024-02-26 14:03:35', 2),
(12, '0012', 'Lays', 5, 100.00, 'products/PAA57CNhzCxJnD9NxFcP2eYjmYsOAxKPLE61lEiy.jpg', 5, 5, NULL, NULL, NULL, '2024-02-26 14:22:24', '2024-02-26 14:22:24', 2),
(13, '0013', 'Heinken', 6, 100.00, 'products/HeHarZejTQ2ZogHcjwEBGn7DvHwn6AuBtt5JwGNg.jpg', 5, 6, NULL, NULL, NULL, '2024-02-26 14:22:51', '2024-02-26 14:22:51', 2),
(14, '0014', 'Minute Maid', 6, 100.00, 'products/fUUWrqY5CBv0FUKE3rfDMVwDoqYDwJHk8SKs2BGI.png', 5, 6, NULL, NULL, NULL, '2024-02-26 14:23:15', '2024-02-26 14:23:15', 2),
(15, '0015', 'Fanta', 6, 100.00, 'products/BANE9E7a6G2b6F99hmMEy6UzxqRR104IQrboZFh9.jpg', 5, 6, NULL, NULL, NULL, '2024-02-26 14:24:33', '2024-02-26 14:24:33', 2),
(16, '0001', 'Chompkins', 13, 100.00, 'products/MPURfnyMw8xK92Qpjnn9LBrdAQih0WX26d7vofhm.jpg', 11, 12, NULL, NULL, NULL, '2024-03-02 17:21:23', '2024-03-02 17:21:23', 8),
(17, '0017', 'Coke', 14, 100.00, 'products/QQGaYYILKgKnPVXf23EADgRaxrYPGn6UVTvYeC2P.jpg', 11, 11, NULL, NULL, NULL, '2024-03-02 17:22:06', '2024-03-02 17:22:06', 8),
(19, 'PH0001', 'Suger Hullets 2kgs', 16, 1000.00, 'products/pYbLy7jLlqT3NACGTEfmLUBqARMOEY3aR7MXZmuf.png', 12, 14, NULL, NULL, NULL, '2024-04-04 19:03:39', '2024-04-04 19:03:39', 9),
(20, 'PH0020', 'Coke 2 litre drink', 17, 1000.00, 'products/5X8daUkpV7L5UOwcvJo19lHCq8FXrQwSGeRi5aiw.png', 12, 16, NULL, NULL, NULL, '2024-04-04 19:05:34', '2024-04-04 19:05:34', 9),
(21, 'PH0021', 'Fanta 2 litre drink', 17, 1000.00, 'products/sXkxF6VERih2RU8y8JQYwRUFuWMJfahxTqxvtYcl.jpg', 12, 16, NULL, NULL, NULL, '2024-04-04 19:05:46', '2024-04-04 19:05:46', 9),
(22, 'PH0022', 'Dragon 500ml', 17, 1000.00, 'products/54FMUqjLlbYpZI0XubJnuxdnvYekoKFDJvI67ZWd.jpg', 12, 16, NULL, NULL, NULL, '2024-04-04 19:06:32', '2024-04-04 19:06:32', 9),
(23, 'PH0023', 'Switch Energy Drink 500ml', 17, 1000.00, 'products/86mHrZ90caT6HfCvPfnblUkuK4AYSUOFZxxU4huG.jpg', 12, 16, NULL, NULL, NULL, '2024-04-04 19:07:05', '2024-04-04 19:07:05', 9),
(24, 'PH0024', 'Gloria Flour 2kgs', 16, 1000.00, 'products/rRpmzPspDmf829CsaXNKOnRANofxcqRpKwkrM1KS.jpg', 12, 16, NULL, NULL, NULL, '2024-04-04 19:07:53', '2024-04-04 19:07:53', 9),
(25, 'PH0025', 'Fanta Can 300ml', 17, 1000.00, 'products/esR2yqvizQjrKSZT7nu4FsLTiMC6JCaqt6BFPt8n.jpg', 12, 16, NULL, NULL, NULL, '2024-04-04 19:08:37', '2024-04-04 19:08:37', 9);

-- --------------------------------------------------------

--
-- Table structure for table `product_categories`
--

CREATE TABLE `product_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_categories`
--

INSERT INTO `product_categories` (`id`, `name`, `description`, `created_at`, `updated_at`, `company_id`) VALUES
(1, 'Snacks', 'Groceries snacks for children and siblings', '2023-09-28 19:26:14', '2023-09-28 19:26:38', NULL),
(3, 'test', 'tets', '2023-09-30 18:00:51', '2023-09-30 18:00:51', NULL),
(4, 'Drinks', 'Drinks', '2023-10-01 00:28:09', '2023-10-01 00:28:09', NULL),
(5, 'Snacks', 'Snackes', '2024-02-10 00:38:58', '2024-02-10 00:38:58', 2),
(6, 'Drinks', 'Drinks', '2024-02-10 00:39:12', '2024-02-10 00:39:12', 2),
(7, 'Snacks', 'Snacks', '2024-02-19 18:57:27', '2024-02-19 18:57:27', 6),
(8, 'Drinks', 'Drinks', '2024-02-19 18:57:35', '2024-02-19 18:57:35', 6),
(9, 'Electronics', 'Electronics', '2024-02-26 13:46:33', '2024-02-26 13:46:33', 2),
(10, 'Clothings', 'Clothings', '2024-02-26 14:17:31', '2024-02-26 14:17:31', 2),
(11, 'Furniture', 'Furniture', '2024-02-26 14:18:00', '2024-02-26 14:18:00', 2),
(12, 'Cereals', 'Cereals', '2024-02-26 14:18:59', '2024-02-26 14:18:59', 2),
(13, 'Snacks', 'Snacks', '2024-03-02 17:20:18', '2024-03-02 17:20:18', 8),
(14, 'Drinks', 'Drinks', '2024-03-02 17:20:28', '2024-03-02 17:20:28', 8),
(15, 'Snacks', 'Snacks', '2024-04-04 18:41:52', '2024-04-04 18:41:52', 9),
(16, 'Groceries', 'Groceries', '2024-04-04 18:42:03', '2024-04-04 18:42:03', 9),
(17, 'Drinks', 'Drinks', '2024-04-04 18:42:14', '2024-04-04 18:42:14', 9);

-- --------------------------------------------------------

--
-- Table structure for table `product_pricings`
--

CREATE TABLE `product_pricings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `currency_id` bigint(20) UNSIGNED NOT NULL,
  `pricing_method_id` bigint(20) UNSIGNED NOT NULL,
  `retail_price` double(8,2) NOT NULL,
  `wholesale_price` double(8,2) DEFAULT NULL,
  `discount` double(8,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_pricings`
--

INSERT INTO `product_pricings` (`id`, `product_id`, `currency_id`, `pricing_method_id`, `retail_price`, `wholesale_price`, `discount`, `created_at`, `updated_at`, `is_default`, `company_id`) VALUES
(1, 34, 1, 1, 12.00, 10.00, 1.00, '2023-10-04 04:19:37', '2023-10-04 04:19:37', 1, NULL),
(2, 1, 1, 1, 15.00, 12.00, 5.00, '2023-10-04 04:23:15', '2023-11-07 10:54:39', 1, NULL),
(3, 2, 1, 1, 6.00, 5.00, 0.00, '2023-10-18 19:37:49', '2023-10-18 19:37:49', 1, NULL),
(4, 3, 1, 1, 12.00, 10.00, 0.00, '2023-11-07 07:29:02', '2023-11-07 07:29:02', 1, NULL),
(5, 4, 1, 1, 10.00, 8.00, 0.00, '2023-11-07 07:29:19', '2023-11-07 07:29:19', 1, NULL),
(6, 5, 1, 1, 13.00, 11.00, 0.00, '2023-11-07 07:29:41', '2023-11-07 07:29:41', 1, NULL),
(7, 6, 1, 1, 8.00, 7.00, 0.00, '2023-11-07 07:30:14', '2023-11-07 07:30:14', 1, NULL),
(8, 7, 1, 1, 6.00, 4.00, 0.00, '2023-11-07 07:30:46', '2023-11-07 10:54:15', 1, NULL),
(9, 8, 4, 9, 12.00, 10.00, 2.00, '2024-02-15 16:04:09', '2024-02-15 16:04:09', 1, 2),
(10, 9, 10, 15, 8.00, 8.00, 0.30, '2024-02-19 18:58:54', '2024-02-19 18:58:54', 1, 6),
(11, 10, 4, 9, 2.30, 1.75, 0.00, '2024-02-26 13:48:37', '2024-02-26 13:48:37', 1, 2),
(12, 11, 4, 9, 2.00, 2.00, 0.00, '2024-02-26 14:03:35', '2024-02-26 14:03:35', 1, 2),
(13, 12, 4, 9, 2.00, 1.70, 0.00, '2024-02-26 14:22:24', '2024-02-26 14:22:24', 1, 2),
(14, 13, 4, 9, 2.00, 1.70, 0.00, '2024-02-26 14:22:51', '2024-02-26 14:22:51', 1, 2),
(15, 14, 4, 9, 2.00, 1.70, 0.00, '2024-02-26 14:23:15', '2024-02-26 14:23:15', 1, 2),
(16, 15, 4, 9, 1.50, 1.25, 0.00, '2024-02-26 14:24:33', '2024-02-26 14:24:33', 1, 2),
(17, 16, 14, 16, 2.00, 2.00, -9.00, '2024-03-02 17:21:23', '2024-03-02 17:21:23', 1, 8),
(18, 17, 14, 16, 2.00, 2.00, 0.00, '2024-03-02 17:22:06', '2024-03-02 17:22:06', 1, 8),
(19, 19, 16, 18, 1.50, 1.50, 0.00, '2024-04-04 19:03:39', '2024-04-04 19:03:39', 1, 9),
(20, 19, 17, 18, 150.00, 150.00, 0.00, '2024-04-04 19:03:39', '2024-04-04 19:03:39', 0, 9),
(21, 19, 18, 18, 60000.00, 59999.00, 0.00, '2024-04-04 19:03:39', '2024-04-04 19:03:39', 0, 9),
(22, 20, 16, 18, 15.00, 15.00, 0.00, '2024-04-04 19:05:34', '2024-04-04 19:05:34', 1, 9),
(23, 20, 17, 18, 1500.00, 1500.00, 0.00, '2024-04-04 19:05:34', '2024-04-04 19:05:34', 0, 9),
(24, 20, 18, 18, 900000.00, 900000.00, 0.00, '2024-04-04 19:05:34', '2024-04-04 19:05:34', 0, 9),
(25, 21, 16, 18, 15.00, 15.00, 0.00, '2024-04-04 19:05:46', '2024-04-04 19:05:46', 1, 9),
(26, 21, 17, 18, 1500.00, 1500.00, 0.00, '2024-04-04 19:05:46', '2024-04-04 19:05:46', 0, 9),
(27, 21, 18, 18, 900000.00, 900000.00, 0.00, '2024-04-04 19:05:46', '2024-04-04 19:05:46', 0, 9),
(28, 22, 16, 18, 1.00, 1.00, 0.00, '2024-04-04 19:06:32', '2024-04-04 19:06:32', 1, 9),
(29, 22, 17, 18, 100.00, 100.00, 0.00, '2024-04-04 19:06:32', '2024-04-04 19:06:32', 0, 9),
(30, 22, 18, 18, 40000.00, 40000.00, 0.00, '2024-04-04 19:06:32', '2024-04-04 19:06:32', 0, 9),
(31, 23, 16, 18, 1.00, 1.00, 0.00, '2024-04-04 19:07:05', '2024-04-04 19:07:05', 1, 9),
(32, 23, 17, 18, 100.00, 100.00, 0.00, '2024-04-04 19:07:05', '2024-04-04 19:07:05', 0, 9),
(33, 23, 18, 18, 40000.00, 40000.00, 0.00, '2024-04-04 19:07:05', '2024-04-04 19:07:05', 0, 9),
(34, 24, 16, 18, 2.50, 2.50, 0.00, '2024-04-04 19:07:53', '2024-04-04 19:07:53', 1, 9),
(35, 24, 17, 18, 250.00, 250.00, 0.00, '2024-04-04 19:07:53', '2024-04-04 19:07:53', 0, 9),
(36, 24, 18, 18, 95000.00, 95000.00, 0.00, '2024-04-04 19:07:53', '2024-04-04 19:07:53', 0, 9),
(37, 25, 16, 18, 0.80, 0.80, 0.00, '2024-04-04 19:08:37', '2024-04-04 19:08:37', 1, 9),
(38, 25, 17, 18, 80.00, 77.00, 0.00, '2024-04-04 19:08:37', '2024-04-04 19:08:37', 0, 9),
(39, 25, 18, 18, 34997.00, 35000.00, 0.00, '2024-04-04 19:08:37', '2024-04-04 19:08:37', 0, 9);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'web', '2023-09-26 15:20:56', '2023-09-26 15:20:56'),
(2, 'salesman', 'web', '2023-09-26 20:41:03', '2023-09-26 20:41:03'),
(3, 'security', 'web', '2023-09-26 20:42:46', '2023-09-26 20:42:46'),
(13, 'company_admin', 'web', '2024-02-08 08:32:13', '2024-02-08 08:32:13');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(2, 1),
(3, 3),
(3, 13),
(4, 3),
(4, 13),
(5, 13),
(6, 3),
(6, 13),
(7, 13),
(8, 13),
(9, 13),
(10, 13),
(11, 13),
(12, 13),
(13, 13),
(14, 13),
(15, 13),
(16, 1),
(17, 1),
(18, 13),
(19, 13),
(20, 1),
(21, 13);

-- --------------------------------------------------------

--
-- Table structure for table `routes`
--

CREATE TABLE `routes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `start_lat` double DEFAULT NULL,
  `start_lon` double DEFAULT NULL,
  `number_centers` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `routes`
--

INSERT INTO `routes` (`id`, `name`, `start_lat`, `start_lon`, `number_centers`, `created_at`, `updated_at`, `company_id`) VALUES
(2, 'Mt Pleasant Rout', -17.77054, 31.04834, 2, '2023-09-29 08:46:49', '2023-09-29 08:46:49', NULL),
(3, 'Harare CBD', -17.8306176, 31.0471112, 2, '2023-09-29 11:02:39', '2023-09-29 11:02:39', NULL),
(4, 'Bulawayo Centre', -20.1565221, 28.5809517, 3, '2023-09-29 11:04:51', '2023-09-29 11:04:51', NULL),
(5, 'Mutoko', -17.4033669, 32.2224783, 4, '2023-09-29 13:20:41', '2023-09-29 13:20:41', NULL),
(6, 'Bulawayo', -20.1457125, 28.5873388, 5, '2023-09-30 11:04:29', '2023-09-30 11:04:29', NULL),
(7, 'Marondera', -18.1885141, 31.5487439, 3, '2023-09-30 17:36:11', '2023-09-30 17:36:11', NULL),
(8, 'Pendennis Road', -17.7623611, 31.0549298, 3, '2024-02-09 13:36:45', '2024-02-09 13:36:45', 4),
(9, 'Harare Central', -17.8125974, 31.0449768, 2, '2024-02-13 20:42:22', '2024-02-13 20:42:22', 5),
(10, 'Harare CBD', -17.8216288, 31.0492259, 2, '2024-02-14 22:19:11', '2024-02-14 22:19:11', 2),
(11, 'Harare CBD', -17.8216288, 31.0492259, 4, '2024-02-19 10:53:55', '2024-02-19 10:53:55', 6),
(12, 'Harare CBD', -17.8216288, 31.0492259, 2, '2024-02-24 08:05:47', '2024-02-24 08:05:47', 7),
(13, 'Harare CBD', -17.8216288, 31.0492259, 3, '2024-03-02 17:15:26', '2024-03-02 17:15:26', 8),
(14, 'Mutorashanga', -17.1476826, 30.6777101, 4, '2024-04-04 19:15:10', '2024-04-04 19:15:10', 9);

-- --------------------------------------------------------

--
-- Table structure for table `route_nodes`
--

CREATE TABLE `route_nodes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `route_id` bigint(20) UNSIGNED NOT NULL,
  `lat` double DEFAULT NULL,
  `lon` double DEFAULT NULL,
  `approx_distance` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `route_nodes`
--

INSERT INTO `route_nodes` (`id`, `route_id`, `lat`, `lon`, `approx_distance`, `created_at`, `updated_at`, `name`) VALUES
(1, 2, -17.77054, 31.04834, NULL, '2023-09-29 08:46:49', '2023-09-29 08:46:49', 'Fairway'),
(2, 2, -17.77054, 31.04834, NULL, '2023-09-29 08:46:49', '2023-09-29 08:46:49', 'Pendenis'),
(3, 3, -17.7672324, 31.0478433, NULL, '2023-09-29 11:02:39', '2023-09-29 11:02:39', 'Mount Pleasant'),
(4, 3, -17.6931793, 31.1105187, NULL, '2023-09-29 11:02:39', '2023-09-29 11:02:39', 'Hatcliffe'),
(5, 4, -19.4656559, 29.8124125, NULL, '2023-09-29 11:04:51', '2023-09-29 11:04:51', 'Gweru'),
(6, 4, -18.1380146, 30.147383, NULL, '2023-09-29 11:04:51', '2023-09-29 11:04:51', 'Chegutu'),
(7, 4, -17.8306176, 31.0471112, NULL, '2023-09-29 11:04:51', '2023-09-29 11:04:51', 'Harare CBD'),
(8, 5, -17.6501872, 31.7787019, NULL, '2023-09-29 13:20:41', '2023-09-29 13:20:41', 'Murehwa'),
(9, 5, -17.6838727, 31.4687615, NULL, '2023-09-29 13:20:41', '2023-09-29 13:20:41', 'Juru bhora Shoping Centre'),
(10, 5, -17.8108357, 31.0851019, NULL, '2023-09-29 13:20:41', '2023-09-29 13:20:41', 'Newlands'),
(11, 5, -17.8306176, 31.0471112, NULL, '2023-09-29 13:20:41', '2023-09-29 13:20:41', 'Harare CBD'),
(12, 6, -19.4656559, 29.8124125, NULL, '2023-09-30 11:04:29', '2023-09-30 11:04:29', 'Gweru'),
(13, 6, -18.1380146, 30.147383, NULL, '2023-09-30 11:04:29', '2023-09-30 11:04:29', 'Chegutu'),
(14, 6, -17.8764842, 30.6742324, NULL, '2023-09-30 11:04:29', '2023-09-30 11:04:29', 'Norton'),
(15, 6, -18.0197815, 31.067907, NULL, '2023-09-30 11:04:29', '2023-09-30 11:04:29', 'Chitungwiza'),
(16, 6, -18.1885141, 31.5487439, NULL, '2023-09-30 11:04:29', '2023-09-30 11:04:29', 'Marondera'),
(17, 7, -17.7532767, 31.5812375, NULL, '2023-09-30 17:36:11', '2023-09-30 17:36:11', 'Musami'),
(18, 7, -17.6784574, 31.4698984, NULL, '2023-09-30 17:36:11', '2023-09-30 17:36:11', 'Juru'),
(19, 7, -17.8216288, 31.0492259, NULL, '2023-09-30 17:36:11', '2023-09-30 17:36:11', 'Harare'),
(20, 8, -17.8067527, 31.0406769, NULL, '2024-02-09 13:36:45', '2024-02-09 13:36:45', 'Belgravia'),
(21, 8, -17.8216288, 31.0492259, NULL, '2024-02-09 13:36:45', '2024-02-09 13:36:45', 'Harare CBD'),
(22, 8, -18.0197815, 31.067907, NULL, '2024-02-09 13:36:45', '2024-02-09 13:36:45', 'Chitungwiza'),
(23, 9, -17.8216288, 31.0492259, NULL, '2024-02-13 20:42:22', '2024-02-13 20:42:22', 'Harare CBD'),
(24, 9, -17.7672324, 31.0478433, NULL, '2024-02-13 20:42:22', '2024-02-13 20:42:22', 'Mount Pleasant'),
(25, 10, -17.8108357, 31.0851019, NULL, '2024-02-14 22:19:11', '2024-02-14 22:19:11', 'Newlands'),
(26, 10, -17.7953731, 31.1280781, NULL, '2024-02-14 22:19:11', '2024-02-14 22:19:11', 'Chisipite'),
(27, 11, -17.8108357, 31.0851019, NULL, '2024-02-19 10:53:55', '2024-02-19 10:53:55', 'Newlands'),
(28, 11, -17.7953731, 31.1280781, NULL, '2024-02-19 10:53:55', '2024-02-19 10:53:55', 'Chisipite'),
(29, 11, -17.7446398, 31.1166193, NULL, '2024-02-19 10:53:55', '2024-02-19 10:53:55', 'Greystone Park'),
(30, 11, -17.7610714, 31.1882189, NULL, '2024-02-19 10:53:55', '2024-02-19 10:53:55', 'Shawasha Hills'),
(31, 12, -17.7672324, 31.0478433, NULL, '2024-02-24 08:05:47', '2024-02-24 08:05:47', 'Mount Pleasant'),
(32, 12, -17.7953731, 31.1280781, NULL, '2024-02-24 08:05:47', '2024-02-24 08:05:47', 'Chisipite'),
(33, 13, 43.5978075, -84.7675139, NULL, '2024-03-02 17:15:26', '2024-03-02 17:15:26', 'Mount Pleasant'),
(34, 13, -17.7831732, 31.1190755, NULL, '2024-03-02 17:15:26', '2024-03-02 17:15:26', 'Chisipite Shopping Centre'),
(35, 13, -17.7652263, 31.0593087, NULL, '2024-03-02 17:15:26', '2024-03-02 17:15:26', 'Groom Bridge'),
(36, 14, -17.1476826, 30.6777101, NULL, '2024-04-04 19:15:10', '2024-04-04 19:15:10', 'Mutorashanga'),
(37, 14, -18.9254047, 29.8237692, NULL, '2024-04-04 19:15:10', '2024-04-04 19:15:10', 'Kwekwe'),
(38, 14, -18.1380146, 30.147383, NULL, '2024-04-04 19:15:10', '2024-04-04 19:15:10', 'Chegutu'),
(39, 14, -17.8216288, 31.0492259, NULL, '2024-04-04 19:15:10', '2024-04-04 19:15:10', 'Harare CBD');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('2MTJiG4uKu0eRk1pqYjLOgEdIhqyuyPkkbcKl3NA', 24, '156.146.59.30', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoibVhyU3hsSVVrRU5JdHZqb2JUS2tQYW5RTmUwaTFTa2tncTZ4Z1NYTyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MjQ7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTg6Imh0dHA6Ly9heGltb3MtMDAxLXNpdGUxMi5odGVtcHVybC5jb20vY29tcGFueS9sb2Fkc2hlZXRzLzUiO319', 1709375299),
('WGLy8sti3kcMbaPzM8UIlGEdKvYj1qSAeRyfoCeB', 1, '154.120.241.142', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiS3ZSdzJzdHZjOE5Cc3JCM0Jkd3FqRjVNa2JLYXBOcDBFQkdqZkVqQyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo1NToiaHR0cDovL2F4aW1vcy0wMDEtc2l0ZTEyLmh0ZW1wdXJsLmNvbS9jb21wYW55L2Rhc2hib2FyZCI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjQzOiJodHRwOi8vYXhpbW9zLTAwMS1zaXRlMTIuaHRlbXB1cmwuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTt9', 1709369944);

-- --------------------------------------------------------

--
-- Table structure for table `stocks`
--

CREATE TABLE `stocks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` double(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `stocks`
--

INSERT INTO `stocks` (`id`, `product_id`, `warehouse_id`, `quantity`, `created_at`, `updated_at`, `company_id`) VALUES
(1, 1, 7, 0.00, '2023-10-04 18:28:29', '2023-11-28 11:04:25', NULL),
(2, 1, 1, 5700.00, '2023-10-18 11:54:07', '2023-11-06 23:59:30', NULL),
(3, 2, 1, 4200.00, '2023-10-18 12:38:13', '2023-11-06 23:59:30', NULL),
(4, 1, 6, 3000.00, '2023-11-01 06:48:25', '2023-11-01 06:48:25', NULL),
(5, 1, 10, 0.00, '2023-11-06 23:56:41', '2023-11-29 05:22:03', NULL),
(6, 4, 10, 0.00, '2023-11-06 23:56:41', '2023-11-29 05:22:03', NULL),
(7, 3, 10, 0.00, '2023-11-06 23:56:41', '2023-11-29 05:22:03', NULL),
(8, 7, 10, 0.00, '2023-11-06 23:56:41', '2023-11-29 05:22:03', NULL),
(9, 2, 10, 0.00, '2023-11-06 23:56:41', '2023-11-29 05:22:03', NULL),
(10, 5, 10, 0.00, '2023-11-06 23:56:41', '2023-11-29 05:22:03', NULL),
(11, 3, 1, 1700.00, '2023-11-06 23:58:48', '2023-11-06 23:59:53', NULL),
(12, 4, 1, 1700.00, '2023-11-06 23:58:48', '2023-11-07 00:00:34', NULL),
(13, 7, 1, 1700.00, '2023-11-06 23:58:48', '2023-11-06 23:59:53', NULL),
(14, 5, 1, 1700.00, '2023-11-06 23:58:59', '2023-11-06 23:59:53', NULL),
(15, 8, 15, 0.00, '2024-02-15 08:04:43', '2024-02-16 08:08:47', 2),
(16, 9, 17, 9900.00, '2024-02-19 10:59:38', '2024-02-19 11:00:39', 6),
(17, 11, 20, 180.00, '2024-02-24 07:46:56', '2024-02-24 08:13:20', 7),
(18, 10, 20, 100.00, '2024-02-24 08:12:22', '2024-02-24 08:12:22', 7),
(19, 8, 19, 0.00, '2024-02-26 07:12:13', '2024-02-26 07:14:19', 2),
(20, 10, 19, 0.00, '2024-02-26 07:12:23', '2024-02-26 07:14:19', 2),
(21, 11, 19, 0.00, '2024-02-26 07:13:08', '2024-02-26 07:14:20', 2),
(22, 12, 19, 0.00, '2024-02-26 07:13:08', '2024-02-26 07:14:20', 2),
(23, 13, 19, 0.00, '2024-02-26 07:13:08', '2024-02-26 07:14:20', 2),
(24, 14, 19, 0.00, '2024-02-26 07:13:08', '2024-02-26 07:14:20', 2),
(25, 15, 19, 0.00, '2024-02-26 07:13:08', '2024-02-26 07:14:20', 2),
(26, 17, 22, 0.00, '2024-03-02 17:25:00', '2024-03-02 17:26:41', 8),
(27, 16, 22, 0.00, '2024-03-02 17:25:00', '2024-03-02 17:26:41', 8),
(28, 17, 21, 4900.00, '2024-03-02 17:53:40', '2024-03-02 17:54:09', 8),
(29, 16, 21, 4900.00, '2024-03-02 17:53:40', '2024-03-02 17:54:09', 8),
(30, 19, 24, 0.00, '2024-04-04 19:17:32', '2024-04-04 19:17:48', 9),
(31, 20, 24, 0.00, '2024-04-04 19:17:32', '2024-04-04 19:17:48', 9),
(32, 21, 24, 0.00, '2024-04-04 19:17:32', '2024-04-04 19:17:48', 9),
(33, 22, 24, 0.00, '2024-04-04 19:17:32', '2024-04-04 19:17:48', 9),
(34, 23, 24, 0.00, '2024-04-04 19:17:32', '2024-04-04 19:17:48', 9),
(35, 24, 24, 0.00, '2024-04-04 19:17:32', '2024-04-04 19:17:48', 9),
(36, 25, 24, 0.00, '2024-04-04 19:17:32', '2024-04-04 19:17:48', 9);

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `price` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `features` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`features`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subscriptions`
--

INSERT INTO `subscriptions` (`id`, `name`, `description`, `price`, `created_at`, `updated_at`, `features`) VALUES
(2, 'Starter', 'Starater Package', '200.00', '2024-02-08 11:56:24', '2024-02-08 12:15:47', '[\"dashboard\", \"loadsheet_management\", \"truck_management\", \"reports\"]'),
(4, 'Premium', 'Premium package', '5000.00', '2024-02-08 12:13:35', '2024-03-02 16:59:03', '[\"dashboard\", \"truck_management\", \"reports\", \"warehouse_management\", \"inventory_management\", \"product_management\", \"customer_management\", \"route_management\", \"product_settings_management\", \"settings_management\", \"general_settings_management\", \"sales_management\", \"loadsheet_management\", \"delivery_management\", \"employee_management\", \"branch_management\"]');

-- --------------------------------------------------------

--
-- Table structure for table `taxes`
--

CREATE TABLE `taxes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `rate` double(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `taxes`
--

INSERT INTO `taxes` (`id`, `name`, `rate`, `created_at`, `updated_at`, `company_id`) VALUES
(1, 'Group A', 12.06, '2023-09-28 15:12:07', '2023-09-28 15:12:07', NULL),
(2, 'Group C', 3.56, '2023-09-28 15:16:35', '2023-09-28 15:20:28', NULL),
(4, 'Group D', 2.00, '2023-09-30 17:28:53', '2023-09-30 17:28:53', NULL),
(5, 'Class A', 2.00, '2024-02-09 16:40:20', '2024-02-09 16:40:20', 2),
(6, 'Class B', 1.00, '2024-02-09 16:40:27', '2024-02-09 16:40:27', 2),
(7, 'Class A', 1.00, '2024-02-19 10:51:11', '2024-02-19 10:51:11', 6),
(8, 'VAT', 0.20, '2024-02-19 10:51:21', '2024-02-19 10:51:21', 6),
(9, 'Class A', 0.20, '2024-02-24 07:40:44', '2024-02-24 07:40:44', 7),
(10, 'VAT', 0.50, '2024-02-24 07:40:52', '2024-02-24 07:40:52', 7),
(11, 'Class A', 2.00, '2024-03-02 17:19:29', '2024-03-02 17:19:29', 8),
(12, 'Vat', 0.20, '2024-04-04 18:42:39', '2024-04-04 18:42:39', 9);

-- --------------------------------------------------------

--
-- Table structure for table `trucks`
--

CREATE TABLE `trucks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `make_model` varchar(255) NOT NULL,
  `license_plate` varchar(255) NOT NULL,
  `color` varchar(255) DEFAULT NULL,
  `start_mileage` double(8,2) DEFAULT NULL,
  `is_available` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `trucks`
--

INSERT INTO `trucks` (`id`, `make_model`, `license_plate`, `color`, `start_mileage`, `is_available`, `created_at`, `updated_at`, `company_id`) VALUES
(1, 'Isuzu', 'ABD34527', 'blue', 135000.00, 0, '2023-09-29 06:08:22', '2023-11-14 08:34:16', NULL),
(2, 'Toyota dyna 2018', 'ABC34526', 'grey', 120000.00, 0, '2023-09-29 06:11:55', '2023-11-14 11:49:53', NULL),
(4, 'Mecedes', 'ABD34567', 'grey', 100000.00, 0, '2023-09-30 13:07:34', '2023-11-28 11:04:24', NULL),
(5, '2018 Isuzu Dyna', 'ABC345246', 'black', 120000.00, 1, '2023-09-30 17:33:07', '2023-11-29 05:43:01', NULL),
(6, 'Nissan Dyna 2017', 'ABD345234', 'green', 100000.00, 0, '2023-10-01 19:45:15', '2023-11-16 06:30:48', NULL),
(7, 'Isuzu', 'ABC34524', 'white', 100000.00, 1, '2024-02-09 16:41:09', '2024-02-21 00:27:35', 2),
(8, 'Toyota dyna 2018', 'ABC34523', 'silver', 50000.00, 1, '2024-02-09 16:41:27', '2024-03-02 18:13:54', 2),
(9, 'Isuzu', 'ABC56823', 'white', 120000.00, 1, '2024-02-13 20:40:47', '2024-02-13 20:40:47', 5),
(10, 'Isuzu 2015', 'ABC5687', 'white', 100000.00, 1, '2024-02-19 10:55:12', '2024-02-19 10:55:12', 6),
(11, 'Toyota Dyna 2015', 'ABC5612', 'white', 100000.00, 1, '2024-02-19 10:55:23', '2024-02-19 12:18:23', 6),
(12, 'Isuzu 2015', 'ABC56875', 'white', 120000.00, 0, '2024-02-24 07:38:19', '2024-02-24 08:11:18', 7),
(13, 'Toyota Dyna 2015', 'ABC56834', 'white', 120000.00, 0, '2024-02-24 07:38:30', '2024-02-24 08:06:37', 7),
(14, 'Izuzu', 'ABC5684545', 'white', 100000.00, 1, '2024-03-02 17:17:30', '2024-03-02 18:27:05', 8),
(15, 'Toyota Dyna 2015', 'ABC561234', 'white', 98000.00, 0, '2024-03-02 17:52:18', '2024-03-02 17:52:34', 8),
(16, 'Isuzu 2015', 'ABC568765', 'white', 50000.00, 1, '2024-04-04 19:10:09', '2024-04-04 19:10:09', 9),
(17, 'Toyota Dyna 2015', 'ABC5634545', 'white', 50000.00, 0, '2024-04-04 19:10:28', '2024-04-04 19:17:48', 9),
(18, 'Isuzu 2015', 'ABC3434545', 'white', 50000.00, 1, '2024-04-04 19:10:40', '2024-04-04 19:10:40', 9);

-- --------------------------------------------------------

--
-- Table structure for table `unit_measures`
--

CREATE TABLE `unit_measures` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `unit_measures`
--

INSERT INTO `unit_measures` (`id`, `name`, `created_at`, `updated_at`, `company_id`) VALUES
(1, 'Packets', '2023-09-28 14:57:48', '2023-09-28 14:57:48', NULL),
(2, 'Bucketsb', '2023-09-28 15:16:44', '2023-09-28 15:19:02', NULL),
(4, 'Boxes 1m X 2', '2023-09-30 17:28:41', '2023-09-30 17:28:41', NULL),
(5, 'Packets', '2024-02-09 16:39:45', '2024-02-09 16:39:45', 2),
(6, 'Crates', '2024-02-09 16:39:51', '2024-02-09 16:39:51', 2),
(7, 'Crates', '2024-02-19 10:50:56', '2024-02-19 10:50:56', 6),
(8, 'Boxes', '2024-02-19 10:51:00', '2024-02-19 10:51:00', 6),
(9, 'Crates', '2024-02-24 07:40:25', '2024-02-24 07:40:25', 7),
(10, 'Boxes', '2024-02-24 07:40:30', '2024-02-24 07:40:30', 7),
(11, 'Crates', '2024-03-02 17:19:39', '2024-03-02 17:19:39', 8),
(12, 'Boxes', '2024-03-02 17:19:50', '2024-03-02 17:19:50', 8),
(13, 'Boxes', '2024-04-04 18:42:50', '2024-04-04 18:42:58', 9),
(14, 'Packets', '2024-04-04 18:43:04', '2024-04-04 18:43:04', 9),
(15, '24 Crates', '2024-04-04 18:43:19', '2024-04-04 18:43:19', 9),
(16, '12 Crates', '2024-04-04 18:43:25', '2024-04-04 18:43:25', 9);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `two_factor_secret` text DEFAULT NULL,
  `two_factor_recovery_codes` text DEFAULT NULL,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `current_team_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profile_photo_path` varchar(2048) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_available` tinyint(1) NOT NULL DEFAULT 1,
  `warehouse_id` bigint(20) UNSIGNED DEFAULT NULL,
  `route_id` bigint(20) UNSIGNED DEFAULT NULL,
  `truck_id` bigint(20) UNSIGNED DEFAULT NULL,
  `address` text DEFAULT NULL,
  `type` enum('External','Internal') NOT NULL DEFAULT 'External',
  `company_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `phone_number`, `email`, `email_verified_at`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `two_factor_confirmed_at`, `remember_token`, `current_team_id`, `profile_photo_path`, `created_at`, `updated_at`, `is_available`, `warehouse_id`, `route_id`, `truck_id`, `address`, `type`, `company_id`) VALUES
(1, 'admin', 'admin', '0772440088', 'admin@vansales.com', NULL, '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NULL, NULL, NULL, 'UI2EfiM0mgntEucDATaCGwpg8Yz1w57EjQsf2qOBJw1R3w7n50sF8uz1bDh0', NULL, NULL, '2023-09-26 14:18:06', '2023-09-26 14:18:06', 1, NULL, NULL, NULL, NULL, 'Internal', NULL),
(2, 'Tatenda', 'Pinjisi', '0719920372', 'tatenda@gmail.com', NULL, '$2y$10$BchUp3Q...6HlQeYrZ6y9uT/ZFj7DPna/vGKQB0CxuEJNwGOBGTl6', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-27 08:14:46', '2023-11-29 05:43:01', 1, NULL, NULL, NULL, NULL, 'External', NULL),
(3, 'Gibson', 'Mutunzi', '0719920375', 'gibson@gmail.com', NULL, '$2y$10$mdzn2eEvCmRFOizHvWtoNeSRqnLasXsVj2fjtlSHMJYmjWTt4ebza', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-27 08:16:12', '2023-11-16 06:30:48', 1, NULL, NULL, NULL, NULL, 'External', NULL),
(5, 'Brandon', 'Mwale', '0719920372', 'brandon@gmail.com', NULL, '$2y$10$7HAA4ZpBLNZgJOrlhIw4UOp1DDnmWm92q1oIZE4AQSloT28kwNnZi', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-30 10:36:05', '2023-09-30 10:36:05', 1, NULL, NULL, NULL, NULL, 'External', NULL),
(6, 'TRACY', 'TAXLIEN', '17604439894', 'tax@gmail.com', NULL, '$2y$10$Z6IExpfJOqaq95fghOULye05irHa2ouav7NaFJDtWfymu/7GFZJse', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-30 10:39:37', '2023-09-30 10:39:37', 1, NULL, NULL, NULL, NULL, 'External', NULL),
(7, 'Kelvin', 'Mairosi', '0773109140', 'kelvin@outlook.com', NULL, '$2y$10$9jcJK0FAv0c1p/Ehsr2J/.tzAdcpWuWJfQF6NGP7QdzF.5.g8N.Y6', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-30 17:37:54', '2023-11-28 11:04:25', 1, NULL, NULL, NULL, NULL, 'External', NULL),
(8, 'Maybe', 'Muchabaiwa', '17604439878', 'maybe@gmail.com', NULL, '$2y$10$XfyfpXoArcWIwKoKJ68LX.3PKSLzJb0Dh6hIZ.yUO39.5XwvTwgkm', NULL, NULL, NULL, NULL, NULL, NULL, '2023-10-01 19:18:53', '2023-11-14 11:49:53', 1, 5, 6, 2, '6 Fairway Mt Pleasant Rd, Harare Zimbabwe', 'External', NULL),
(9, 'Melbone', 'Musharukwa', '0772440455', 'mebone@axissol.com', NULL, '$2y$10$a9.lgxoYRTLMDJxs/7G7vOoTMliFxGmwa2wnD84TrLrvDL4pj2yOe', NULL, NULL, NULL, NULL, NULL, NULL, '2023-11-14 08:06:48', '2023-11-14 08:34:16', 1, 1, 2, 1, '6 Fairway Mt Pleasant Rd, Harare Zimbabwe', 'External', NULL),
(11, 'Blessing', 'Mwale', '+263772440088', 'belssing@axis.com', NULL, '$2y$10$2k9zpa/UoHNgGVI2XfgaCORCIHaKr1vVHxJBj2tS0QcOWakQ/pv5m', NULL, NULL, NULL, NULL, NULL, NULL, '2024-02-09 08:26:01', '2024-02-09 08:26:01', 1, NULL, NULL, NULL, '7 Wingate Road', 'External', NULL),
(12, 'DEnzel', 'Mwale', '07724403232', 'denzel@axisol.com', NULL, '$2y$10$uo62c/r2lpmp0/5qsYCJzOQP9TXYCFhwLjGSQZr3OI6/x4STnmGna', NULL, NULL, NULL, NULL, NULL, NULL, '2024-02-09 08:59:47', '2024-02-09 08:59:47', 1, NULL, NULL, NULL, '6 Fairway Mt Pleasant harare', 'External', 2),
(13, 'Tatenda', 'Muto', '+2637724400231', 'tatenda@equals.co.zw', NULL, '$2y$10$FYReqHe53BFFOgeyLXuxWer0WcdLVciXgMRE1eAwM6LOIoBFwjs1C', NULL, NULL, NULL, NULL, NULL, NULL, '2024-02-09 09:07:29', '2024-02-09 09:07:29', 1, NULL, NULL, NULL, '7 Wingate Road', 'External', 4),
(14, 'Trevor', 'Sibanda', '+263772440032', 'trevor@riquid.com', NULL, '$2y$10$qv3hnxrsRdBxFjqYk1NTD.oax/XzskgX0mLDJZcjW8SujIIoq.xlS', NULL, NULL, NULL, 'Qdq7s1qCvH4T3nfYoKfBFFI6sc454MfZ0sEqjTyfwYddNx493KxNU8rAWcP2', NULL, NULL, '2024-02-09 13:41:55', '2024-02-09 13:41:55', 1, NULL, NULL, NULL, '6 Fairway Mt Pleasant Rd, Harare Zimbabwe', 'External', 5),
(15, 'Blessing', 'Mwale', '+263772440088', 'blessing@gmail.com', NULL, '$2y$10$pSHfja15G4WluNf9cXC4FeZM3XwkV7cUfutlcrFFHLXfN2mcWJqtW', NULL, NULL, NULL, NULL, NULL, NULL, '2024-02-14 22:38:49', '2024-02-15 07:49:59', 1, NULL, NULL, NULL, '7 Wingate Road', 'External', 2),
(16, 'Draxler', 'Muto', '0772440088', 'test@gmail.com', NULL, '$2y$10$.MxT7fAqvFFmqLZIFZBGmusgQHlDi8IH.xpIT6zMVKluVV35kLS92', NULL, NULL, NULL, NULL, NULL, NULL, '2024-02-15 06:23:00', '2024-02-15 06:36:07', 1, 12, 10, 7, '7 Wingate Road', 'External', 2),
(17, 'Blessing', 'Mwale', '+263772440088', 'blessingmwalein@gmail.com', NULL, '$2y$10$oNHEWYYTyif7tIZshPS9Z.jYodhx4nTQ9VSmHAvWWWnPgkXT2bQ6m', NULL, NULL, NULL, NULL, NULL, NULL, '2024-02-15 08:06:43', '2024-02-26 07:13:54', 1, 15, 10, 8, '7 Wingate Road', 'External', 2),
(18, 'Blessing', 'Mwale', '+263772440228', 'blessing@teranics.com', NULL, '$2y$10$SSX.vc2jZ4p7wK/YPPnaCORigsMHwx1b41Coegn1GBmnowYQjzdAe', NULL, NULL, NULL, NULL, NULL, NULL, '2024-02-19 10:43:49', '2024-02-19 10:43:49', 1, NULL, NULL, NULL, '6 Fairway Mt Pleasant Rd, Harare Zimbabwe', 'External', 6),
(19, 'Tatenda', 'Chipuka', '+26377244012', 'tatenda@teranics.com', NULL, '$2y$10$LPWntloJoeAXe7CbV8qJUe2Eu23ogeCyZE9Zgj8cWDz/QZ7PXtmwa', NULL, NULL, NULL, NULL, NULL, NULL, '2024-02-19 10:56:44', '2024-02-19 12:18:23', 1, 17, 11, 11, '7 Wingate Road', 'External', 6),
(20, 'Econet', 'Wireless', '+263772440022', 'userecenet@econet.com', NULL, '$2y$10$SSX.vc2jZ4p7wK/YPPnaCORigsMHwx1b41Coegn1GBmnowYQjzdAe', NULL, NULL, NULL, NULL, NULL, NULL, '2024-02-24 07:13:58', '2024-02-24 07:13:58', 1, NULL, NULL, NULL, '6 Fairway Mt Pleasant Rd, Harare Zimbabwe', 'External', 7),
(21, 'Blessing', 'Mwale', '+2637724400123', 'blessing@econet.com', NULL, '$2y$10$/9KbRSmjcRh6nYpqAGMbhug8wO4kxQ0IGeSsAZi/xWllPJjV3G53a', NULL, NULL, NULL, NULL, NULL, NULL, '2024-02-24 08:06:20', '2024-02-24 08:06:37', 1, 20, 12, 13, '6 Fairway Mt Pleasant Rd, Harare Zimbabwe', 'External', 7),
(22, 'Test', 'User', '0772440023', 'draxler@gmail.com', NULL, '$2y$10$iT5X1KkamsyNH9D.Gx8PmuW0mh2yJv7qTrMoebhd.EBdw6LbRtmPa', NULL, NULL, NULL, NULL, NULL, NULL, '2024-02-24 08:11:04', '2024-02-24 08:11:18', 1, 20, 12, 13, '7 Wingate Road', 'External', 7),
(23, 'Denzel', 'Draxler', '+263772440234', 'denzi@axissol.com', NULL, '$2y$10$JQsY4CpJYT7nL1Bu/HR9S.aozoUH.CmZ4qrt51UhfwuEYCMQieODe', NULL, NULL, NULL, NULL, NULL, NULL, '2024-02-26 06:46:53', '2024-03-02 18:13:54', 1, 19, 10, 8, '6 Fairway Mt Pleasant Rd, Harare Zimbabwe', 'External', 2),
(24, 'Axtrix', 'User', '0772440088', 'user1@gmail.com', NULL, '$2y$10$By1TA6T0LiscfDApxQR/5O/6loCwsi2BWFm89ESaFLXppqMmcvdyq', NULL, NULL, NULL, NULL, NULL, NULL, '2024-03-02 16:55:28', '2024-03-02 16:55:28', 1, NULL, NULL, NULL, '7 Wingate Road', 'External', 8),
(25, 'Driver', 'First', '+263772442388', 'driver1@gmail.com', NULL, '$2y$10$GFJJ/3C2JK.PW2IAMnnIh.KxL.eMDOT4AyCfy4RYnHpLk.7Tin/uO', NULL, NULL, NULL, NULL, NULL, NULL, '2024-03-02 17:18:56', '2024-03-02 18:27:05', 1, 22, 13, 14, '6 Fairway Mt Pleasant Rd, Harare Zimbabwe', 'External', 8),
(26, 'Delivery', 'Driver', '+263772442388', 'driver2@gmail.com', NULL, '$2y$10$FLvYNOoGRK5.NX0jNh6l2ubyRxAIQdImTjNLLAgN4tFOIZWeV0QIS', NULL, NULL, NULL, NULL, NULL, NULL, '2024-03-02 17:51:27', '2024-03-02 17:52:34', 0, 21, 13, 14, '6 Fairway Mt Pleasant Rd, Harare Zimbabwe', 'External', 8),
(27, 'Daniel', 'Mberi', '07724435645', 'daniel@price.co.zw', NULL, '$2y$10$KqMU97yIOQVExlOmObW8FOfxiyhNX.A9uiWsDnTnsdVUkpB3PmcCe', NULL, NULL, NULL, NULL, NULL, NULL, '2024-04-04 17:49:54', '2024-04-04 17:49:54', 1, NULL, NULL, NULL, '6 Mbepe road, Mutorashanga', 'External', 9),
(28, 'Bili', 'Fe', '0712445564', 'biliat@price.co.zw', NULL, '$2y$10$SNLmjtDPrvo5JN/9bW15TOpRHOhV7xn/gZTudsmxxkLGoo9CAve6W', NULL, NULL, NULL, NULL, NULL, NULL, '2024-04-04 19:16:10', '2024-04-04 19:17:48', 0, 24, 14, 17, '7 Wingate Road Mutorashanga', 'External', 9);

-- --------------------------------------------------------

--
-- Table structure for table `warehouses`
--

CREATE TABLE `warehouses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `is_main_warehouse` tinyint(1) NOT NULL DEFAULT 0,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `main_warehouse_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `warehouses`
--

INSERT INTO `warehouses` (`id`, `is_main_warehouse`, `code`, `name`, `location`, `main_warehouse_id`, `created_at`, `updated_at`, `company_id`) VALUES
(1, 0, 'WH0001', 'Penin', 'West gate', NULL, '2023-09-27 18:26:18', '2023-09-27 18:50:06', NULL),
(2, 0, 'WH0002', 'Hulanda', '6 Fairway Mt Pleasant , Harare', NULL, '2023-09-27 18:33:15', '2023-09-27 18:33:15', NULL),
(3, 0, 'WH0003', 'Pepa', 'Malborough', NULL, '2023-09-27 18:50:34', '2023-09-27 18:50:34', NULL),
(4, 0, 'WH0004', 'Peter', 'Malborough High', NULL, '2023-09-27 18:50:45', '2023-09-27 18:50:45', NULL),
(5, 0, 'WH0005', 'Murehwa', 'Murehwa Bhora', NULL, '2023-09-27 18:51:06', '2023-09-27 18:51:06', NULL),
(6, 0, 'WH0006', 'Mutoko', 'Mutoko growth point', NULL, '2023-09-27 18:51:21', '2023-09-27 18:51:21', NULL),
(7, 1, 'WH0007', 'Marondera', 'Marondera Rudhaka', NULL, '2023-09-27 18:51:46', '2023-11-16 14:16:50', NULL),
(8, 0, 'WH0008', 'Test code', 'Teste code', NULL, '2023-09-30 14:23:30', '2023-09-30 14:23:30', NULL),
(9, 0, 'WH0009', 'jhhj', 'jjhjhj', NULL, '2023-09-30 18:00:09', '2023-09-30 18:00:09', NULL),
(10, 0, 'WH0010', 'Chikurubhi', 'Chikurubhi', NULL, '2023-10-01 00:24:48', '2023-10-01 00:24:48', NULL),
(11, 1, '0001', 'Warehouse Test', '6 Fairway Mt Pleasant', NULL, '2024-02-09 21:32:52', '2024-02-09 21:32:52', 4),
(12, 1, '0001', 'Main Warehouse', '6 Fairway Mt Pleasant Harare', NULL, '2024-02-10 00:42:24', '2024-02-10 00:42:24', 2),
(13, 1, '0001', 'Main', 'Harare CBD', NULL, '2024-02-14 04:40:59', '2024-02-14 04:40:59', 5),
(14, 0, '0014', 'Second', 'Chisipite', NULL, '2024-02-14 04:41:13', '2024-02-14 04:41:13', 5),
(15, 0, '0013', 'Mt Pleasant Warehouse', '6 Fairway Mt Pleasant', NULL, '2024-02-15 16:00:18', '2024-02-15 16:00:18', 2),
(16, 0, '0016', 'Groome Bridge warehouse', '6 Fairway Mt Pleasant', NULL, '2024-02-19 04:37:07', '2024-02-19 04:37:07', 2),
(17, 1, '0001', 'Hombarume', 'Westgate', NULL, '2024-02-19 18:51:37', '2024-02-19 18:51:37', 6),
(18, 0, '0018', 'Chipiko', 'Murehwa', NULL, '2024-02-19 18:51:52', '2024-02-19 18:51:52', 6),
(19, 0, '0017', 'Denzel Harare Warehouse', '6 Fairway Mt Pleasant Harare', NULL, '2024-02-26 13:45:18', '2024-02-26 13:45:18', 2),
(21, 1, '0001', 'Harare CBD', 'Harare CBD', NULL, '2024-03-02 17:05:42', '2024-03-02 17:05:42', 8),
(22, 0, '0022', 'Mutare Warehouse', 'Mutare Center', NULL, '2024-03-02 17:05:59', '2024-03-02 17:05:59', 8),
(23, 1, 'WH0001', 'Murorashanga Main', 'Murorashanga Shopping Centre', NULL, '2024-04-04 19:11:49', '2024-04-04 19:11:49', 9),
(24, 0, 'WH0024', 'Warehouse 1 Price', 'Mutorashanga', NULL, '2024-04-04 19:12:30', '2024-04-04 19:12:30', 9),
(25, 0, 'WH0025', 'Warehouse 2 Price', 'Harare', NULL, '2024-04-04 19:12:41', '2024-04-04 19:12:41', 9),
(26, 0, 'WH0026', 'Warehouse 3 Price', 'Kweke', NULL, '2024-04-04 19:12:48', '2024-04-04 19:12:48', 9);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `allocation_items`
--
ALTER TABLE `allocation_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `allocation_items_delivery_id_foreign` (`delivery_id`),
  ADD KEY `allocation_items_loadsheet_id_foreign` (`loadsheet_id`),
  ADD KEY `allocation_items_stock_id_foreign` (`stock_id`);

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`id`),
  ADD KEY `branches_company_id_foreign` (`company_id`),
  ADD KEY `branches_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `branches_user_id_foreign` (`user_id`);

--
-- Indexes for table `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `companies_bpn_unique` (`bpn`);

--
-- Indexes for table `company_subscriptions`
--
ALTER TABLE `company_subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `company_subscriptions_company_id_foreign` (`company_id`),
  ADD KEY `company_subscriptions_subscription_id_foreign` (`subscription_id`);

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `currencies_company_id_foreign` (`company_id`);

--
-- Indexes for table `currency_payment_methods`
--
ALTER TABLE `currency_payment_methods`
  ADD PRIMARY KEY (`id`),
  ADD KEY `currency_payment_methods_currency_id_foreign` (`currency_id`),
  ADD KEY `currency_payment_methods_payment_method_id_foreign` (`payment_method_id`),
  ADD KEY `currency_payment_methods_company_id_foreign` (`company_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customers_email_unique` (`email`),
  ADD UNIQUE KEY `customers_phone_number_unique` (`phone_number`),
  ADD KEY `customers_route_id_foreign` (`route_id`),
  ADD KEY `customers_company_id_foreign` (`company_id`);

--
-- Indexes for table `customer_stops`
--
ALTER TABLE `customer_stops`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_stops_customer_id_foreign` (`customer_id`),
  ADD KEY `customer_stops_loadsheet_id_foreign` (`loadsheet_id`);

--
-- Indexes for table `deliveries`
--
ALTER TABLE `deliveries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `deliveries_delivery_sheet_id_foreign` (`delivery_sheet_id`),
  ADD KEY `deliveries_customer_id_foreign` (`customer_id`),
  ADD KEY `deliveries_company_id_foreign` (`company_id`);

--
-- Indexes for table `delivery_histories`
--
ALTER TABLE `delivery_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `delivery_histories_delivery_sheet_id_foreign` (`delivery_sheet_id`),
  ADD KEY `delivery_histories_user_id_foreign` (`user_id`);

--
-- Indexes for table `delivery_sheets`
--
ALTER TABLE `delivery_sheets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `delivery_sheets_user_id_foreign` (`user_id`),
  ADD KEY `delivery_sheets_truck_id_foreign` (`truck_id`),
  ADD KEY `delivery_sheets_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `delivery_sheets_route_id_foreign` (`route_id`),
  ADD KEY `delivery_sheets_company_id_foreign` (`company_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `features`
--
ALTER TABLE `features`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `general_settings`
--
ALTER TABLE `general_settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `general_settings_company_id_foreign` (`company_id`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invoices_delivery_id_foreign` (`delivery_id`),
  ADD KEY `invoices_delivery_sheet_id_foreign` (`delivery_sheet_id`),
  ADD KEY `invoices_loadsheet_id_foreign` (`loadsheet_id`),
  ADD KEY `invoices_branch_id_foreign` (`branch_id`),
  ADD KEY `invoices_customer_id_foreign` (`customer_id`),
  ADD KEY `invoices_company_id_foreign` (`company_id`);

--
-- Indexes for table `invoice_items`
--
ALTER TABLE `invoice_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invoice_items_invoice_id_foreign` (`invoice_id`),
  ADD KEY `invoice_items_stock_id_foreign` (`stock_id`);

--
-- Indexes for table `loadsheets`
--
ALTER TABLE `loadsheets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `loadsheets_user_id_foreign` (`user_id`),
  ADD KEY `loadsheets_truck_id_foreign` (`truck_id`),
  ADD KEY `loadsheets_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `loadsheets_route_id_foreign` (`route_id`),
  ADD KEY `loadsheets_company_id_foreign` (`company_id`);

--
-- Indexes for table `loadsheet_histories`
--
ALTER TABLE `loadsheet_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `loadsheet_histories_loadsheet_id_foreign` (`loadsheet_id`),
  ADD KEY `loadsheet_histories_user_id_foreign` (`user_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `payment_methods`
--
ALTER TABLE `payment_methods`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payment_methods_company_id_foreign` (`company_id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `pricing_methods`
--
ALTER TABLE `pricing_methods`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pricing_methods_company_id_foreign` (`company_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_product_category_id_foreign` (`product_category_id`),
  ADD KEY `products_tax_id_foreign` (`tax_id`),
  ADD KEY `products_unit_measure_id_foreign` (`unit_measure_id`),
  ADD KEY `products_company_id_foreign` (`company_id`);

--
-- Indexes for table `product_categories`
--
ALTER TABLE `product_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_categories_company_id_foreign` (`company_id`);

--
-- Indexes for table `product_pricings`
--
ALTER TABLE `product_pricings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_pricings_product_id_foreign` (`product_id`),
  ADD KEY `product_pricings_currency_id_foreign` (`currency_id`),
  ADD KEY `product_pricings_pricing_method_id_foreign` (`pricing_method_id`),
  ADD KEY `product_pricings_company_id_foreign` (`company_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `routes`
--
ALTER TABLE `routes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `routes_company_id_foreign` (`company_id`);

--
-- Indexes for table `route_nodes`
--
ALTER TABLE `route_nodes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `route_nodes_route_id_foreign` (`route_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `stocks`
--
ALTER TABLE `stocks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stocks_product_id_foreign` (`product_id`),
  ADD KEY `stocks_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `stocks_company_id_foreign` (`company_id`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `taxes`
--
ALTER TABLE `taxes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `taxes_company_id_foreign` (`company_id`);

--
-- Indexes for table `trucks`
--
ALTER TABLE `trucks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `trucks_company_id_foreign` (`company_id`);

--
-- Indexes for table `unit_measures`
--
ALTER TABLE `unit_measures`
  ADD PRIMARY KEY (`id`),
  ADD KEY `unit_measures_company_id_foreign` (`company_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_route_id_foreign` (`route_id`),
  ADD KEY `users_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `users_company_id_foreign` (`company_id`);

--
-- Indexes for table `warehouses`
--
ALTER TABLE `warehouses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `warehouses_main_warehouse_id_foreign` (`main_warehouse_id`),
  ADD KEY `warehouses_company_id_foreign` (`company_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `allocation_items`
--
ALTER TABLE `allocation_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `companies`
--
ALTER TABLE `companies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `company_subscriptions`
--
ALTER TABLE `company_subscriptions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `currency_payment_methods`
--
ALTER TABLE `currency_payment_methods`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `customer_stops`
--
ALTER TABLE `customer_stops`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `deliveries`
--
ALTER TABLE `deliveries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `delivery_histories`
--
ALTER TABLE `delivery_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `delivery_sheets`
--
ALTER TABLE `delivery_sheets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `features`
--
ALTER TABLE `features`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `general_settings`
--
ALTER TABLE `general_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `invoice_items`
--
ALTER TABLE `invoice_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `loadsheets`
--
ALTER TABLE `loadsheets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `loadsheet_histories`
--
ALTER TABLE `loadsheet_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT for table `payment_methods`
--
ALTER TABLE `payment_methods`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `pricing_methods`
--
ALTER TABLE `pricing_methods`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `product_categories`
--
ALTER TABLE `product_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `product_pricings`
--
ALTER TABLE `product_pricings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `routes`
--
ALTER TABLE `routes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `route_nodes`
--
ALTER TABLE `route_nodes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `stocks`
--
ALTER TABLE `stocks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `taxes`
--
ALTER TABLE `taxes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `trucks`
--
ALTER TABLE `trucks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `unit_measures`
--
ALTER TABLE `unit_measures`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `warehouses`
--
ALTER TABLE `warehouses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `allocation_items`
--
ALTER TABLE `allocation_items`
  ADD CONSTRAINT `allocation_items_delivery_id_foreign` FOREIGN KEY (`delivery_id`) REFERENCES `deliveries` (`id`),
  ADD CONSTRAINT `allocation_items_loadsheet_id_foreign` FOREIGN KEY (`loadsheet_id`) REFERENCES `loadsheets` (`id`),
  ADD CONSTRAINT `allocation_items_stock_id_foreign` FOREIGN KEY (`stock_id`) REFERENCES `stocks` (`id`);

--
-- Constraints for table `branches`
--
ALTER TABLE `branches`
  ADD CONSTRAINT `branches_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`),
  ADD CONSTRAINT `branches_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `branches_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `company_subscriptions`
--
ALTER TABLE `company_subscriptions`
  ADD CONSTRAINT `company_subscriptions_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`),
  ADD CONSTRAINT `company_subscriptions_subscription_id_foreign` FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`id`);

--
-- Constraints for table `currencies`
--
ALTER TABLE `currencies`
  ADD CONSTRAINT `currencies_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `currency_payment_methods`
--
ALTER TABLE `currency_payment_methods`
  ADD CONSTRAINT `currency_payment_methods_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `currency_payment_methods_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `currency_payment_methods_payment_method_id_foreign` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `customers_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `customers_route_id_foreign` FOREIGN KEY (`route_id`) REFERENCES `routes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `customer_stops`
--
ALTER TABLE `customer_stops`
  ADD CONSTRAINT `customer_stops_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `customer_stops_loadsheet_id_foreign` FOREIGN KEY (`loadsheet_id`) REFERENCES `loadsheets` (`id`);

--
-- Constraints for table `deliveries`
--
ALTER TABLE `deliveries`
  ADD CONSTRAINT `deliveries_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `deliveries_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `deliveries_delivery_sheet_id_foreign` FOREIGN KEY (`delivery_sheet_id`) REFERENCES `delivery_sheets` (`id`);

--
-- Constraints for table `delivery_histories`
--
ALTER TABLE `delivery_histories`
  ADD CONSTRAINT `delivery_histories_delivery_sheet_id_foreign` FOREIGN KEY (`delivery_sheet_id`) REFERENCES `delivery_sheets` (`id`),
  ADD CONSTRAINT `delivery_histories_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `delivery_sheets`
--
ALTER TABLE `delivery_sheets`
  ADD CONSTRAINT `delivery_sheets_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `delivery_sheets_route_id_foreign` FOREIGN KEY (`route_id`) REFERENCES `routes` (`id`),
  ADD CONSTRAINT `delivery_sheets_truck_id_foreign` FOREIGN KEY (`truck_id`) REFERENCES `trucks` (`id`),
  ADD CONSTRAINT `delivery_sheets_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `delivery_sheets_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `general_settings`
--
ALTER TABLE `general_settings`
  ADD CONSTRAINT `general_settings_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `invoices`
--
ALTER TABLE `invoices`
  ADD CONSTRAINT `invoices_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`),
  ADD CONSTRAINT `invoices_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`),
  ADD CONSTRAINT `invoices_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `invoices_delivery_id_foreign` FOREIGN KEY (`delivery_id`) REFERENCES `deliveries` (`id`),
  ADD CONSTRAINT `invoices_delivery_sheet_id_foreign` FOREIGN KEY (`delivery_sheet_id`) REFERENCES `delivery_sheets` (`id`),
  ADD CONSTRAINT `invoices_loadsheet_id_foreign` FOREIGN KEY (`loadsheet_id`) REFERENCES `loadsheets` (`id`);

--
-- Constraints for table `invoice_items`
--
ALTER TABLE `invoice_items`
  ADD CONSTRAINT `invoice_items_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`),
  ADD CONSTRAINT `invoice_items_stock_id_foreign` FOREIGN KEY (`stock_id`) REFERENCES `stocks` (`id`);

--
-- Constraints for table `loadsheets`
--
ALTER TABLE `loadsheets`
  ADD CONSTRAINT `loadsheets_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `loadsheets_route_id_foreign` FOREIGN KEY (`route_id`) REFERENCES `routes` (`id`),
  ADD CONSTRAINT `loadsheets_truck_id_foreign` FOREIGN KEY (`truck_id`) REFERENCES `trucks` (`id`),
  ADD CONSTRAINT `loadsheets_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `loadsheets_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `loadsheet_histories`
--
ALTER TABLE `loadsheet_histories`
  ADD CONSTRAINT `loadsheet_histories_loadsheet_id_foreign` FOREIGN KEY (`loadsheet_id`) REFERENCES `loadsheets` (`id`),
  ADD CONSTRAINT `loadsheet_histories_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `payment_methods`
--
ALTER TABLE `payment_methods`
  ADD CONSTRAINT `payment_methods_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `pricing_methods`
--
ALTER TABLE `pricing_methods`
  ADD CONSTRAINT `pricing_methods_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `products_product_category_id_foreign` FOREIGN KEY (`product_category_id`) REFERENCES `product_categories` (`id`),
  ADD CONSTRAINT `products_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `taxes` (`id`),
  ADD CONSTRAINT `products_unit_measure_id_foreign` FOREIGN KEY (`unit_measure_id`) REFERENCES `unit_measures` (`id`);

--
-- Constraints for table `product_categories`
--
ALTER TABLE `product_categories`
  ADD CONSTRAINT `product_categories_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_pricings`
--
ALTER TABLE `product_pricings`
  ADD CONSTRAINT `product_pricings_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `routes`
--
ALTER TABLE `routes`
  ADD CONSTRAINT `routes_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `route_nodes`
--
ALTER TABLE `route_nodes`
  ADD CONSTRAINT `route_nodes_route_id_foreign` FOREIGN KEY (`route_id`) REFERENCES `routes` (`id`);

--
-- Constraints for table `stocks`
--
ALTER TABLE `stocks`
  ADD CONSTRAINT `stocks_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `stocks_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `stocks_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `taxes`
--
ALTER TABLE `taxes`
  ADD CONSTRAINT `taxes_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `trucks`
--
ALTER TABLE `trucks`
  ADD CONSTRAINT `trucks_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `unit_measures`
--
ALTER TABLE `unit_measures`
  ADD CONSTRAINT `unit_measures_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`),
  ADD CONSTRAINT `users_route_id_foreign` FOREIGN KEY (`route_id`) REFERENCES `warehouses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `users_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `warehouses`
--
ALTER TABLE `warehouses`
  ADD CONSTRAINT `warehouses_company_id_foreign` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `warehouses_main_warehouse_id_foreign` FOREIGN KEY (`main_warehouse_id`) REFERENCES `warehouses` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
