-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 07, 2024 at 11:24 AM
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
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`id`, `name`, `code`, `symbol`, `exchange_rate`, `is_default`, `created_at`, `updated_at`) VALUES
(1, 'USD', 'USD', '$', 1.00, 1, '2023-10-03 20:18:02', '2023-11-14 13:10:02'),
(2, 'RTGS', 'RTGS', 'RTGS', 6000.00, 0, '2023-10-03 20:57:21', '2023-11-14 13:10:02'),
(3, 'Rand', 'ZAR', 'ZAR', 3500.00, 0, '2023-11-14 12:56:17', '2023-11-14 13:10:02');

-- --------------------------------------------------------

--
-- Table structure for table `currency_payment_methods`
--

CREATE TABLE `currency_payment_methods` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `currency_id` bigint(20) UNSIGNED NOT NULL,
  `payment_method_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `currency_payment_methods`
--

INSERT INTO `currency_payment_methods` (`id`, `currency_id`, `payment_method_id`, `created_at`, `updated_at`) VALUES
(6, 3, 3, '2023-11-14 13:09:44', '2023-11-14 13:09:44'),
(7, 3, 2, '2023-11-14 13:09:44', '2023-11-14 13:09:44'),
(8, 3, 1, '2023-11-14 13:09:44', '2023-11-14 13:09:44'),
(9, 1, 3, '2023-11-14 13:10:02', '2023-11-14 13:10:02'),
(10, 1, 2, '2023-11-14 13:10:02', '2023-11-14 13:10:02'),
(11, 1, 1, '2023-11-14 13:10:02', '2023-11-14 13:10:02');

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
  `route_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `name`, `email`, `phone_number`, `address`, `lat`, `lon`, `created_at`, `updated_at`, `route_id`) VALUES
(1, 'Denzel Muto', 'denzel@gmail.com', '0772440088', '6 Fairway Mt Pleasant Harare', -17.8525279, 30.9870269, '2023-09-29 06:43:20', '2023-11-14 11:21:56', 3),
(2, 'Brandon Mwale', 'mwale830@gmail.com', '0719920372', '581 Juru Growth Point Goromonzi', -17.7672324, 31.0478433, '2023-09-30 17:33:42', '2023-11-14 10:14:53', 2),
(3, 'Brian Mhuka', 'brian@gmail.com', '0772424088', '6 Bulawayo road , Bulawayo Zimbabwe', -20.1457125, 28.5873388, '2023-11-14 10:07:56', '2023-11-14 10:07:56', 6),
(4, 'Daniel', 'Mwere', '0772240088', 'Bulawayo Rainbow towers', -20.1586838, 28.5872618, '2023-11-14 11:41:53', '2023-11-14 11:41:53', 6),
(5, 'Cash Account', 'cash@axissol.com', '0772423088', '14 Arundale Road', NULL, NULL, '2023-11-16 06:26:36', '2023-11-16 06:26:36', NULL),
(9, 'Gilbet Moyo', 'gilbet@gmail.com', '078232322987', '6 Fairway Mt Pleasant', NULL, NULL, '2023-11-18 14:32:28', '2023-11-18 14:32:28', 4),
(10, 'Maybe Muti', 'maybemuti@gmail.com', '0782323387', '8 Fairway Mt Pleasant', NULL, NULL, '2023-11-18 14:32:28', '2023-11-18 14:32:28', 4);

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
(1, 1, 2, '2023-10-18 12:06:10', '2023-10-18 12:06:10'),
(2, 2, 2, '2023-10-18 12:06:10', '2023-10-18 12:06:10'),
(3, 3, 5, '2023-11-14 11:49:53', '2023-11-14 11:49:53'),
(4, 4, 5, '2023-11-14 11:49:53', '2023-11-14 11:49:53'),
(5, 5, 6, '2023-11-16 06:30:48', '2023-11-16 06:30:48'),
(6, 5, 7, '2023-11-28 11:04:25', '2023-11-28 11:04:25'),
(7, 9, 8, '2023-11-29 05:22:03', '2023-11-29 05:22:03'),
(8, 10, 8, '2023-11-29 05:22:03', '2023-11-29 05:22:03'),
(9, 5, 8, '2023-11-29 05:22:03', '2023-11-29 05:22:03');

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
-- Table structure for table `general_settings`
--

CREATE TABLE `general_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `value` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `general_settings`
--

INSERT INTO `general_settings` (`id`, `name`, `type`, `value`, `created_at`, `updated_at`) VALUES
(1, 'Defaults warehouse per driver', 'Warehouse', 1, '2023-10-05 17:00:39', '2023-11-14 07:32:57'),
(2, 'Defaults  truck per driver', 'Trucks', 1, '2023-10-05 17:01:23', '2023-11-14 07:32:57'),
(3, 'Allow Multiple Loadsheets Per Driver', 'Loadsheets', 0, '2023-10-17 11:43:03', '2023-11-14 07:32:57'),
(4, 'Routes', 'Routes', 1, '2023-11-14 06:49:30', '2023-11-14 07:32:57');

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
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loadsheets`
--

INSERT INTO `loadsheets` (`id`, `loadsheet_number`, `user_id`, `truck_id`, `warehouse_id`, `status`, `route_id`, `start_date_time`, `created_at`, `updated_at`) VALUES
(1, 'LS0001', 2, 6, 7, 'Cancelled', 2, '2023-10-08T11:29:00.000Z', '2023-10-04 18:29:49', '2023-11-06 23:51:50'),
(2, 'LS0002', 8, 1, 1, 'Cancelled', 3, '2023-10-20 13:00', '2023-10-17 11:26:18', '2023-11-06 23:51:57'),
(3, 'LS0003', 8, 2, 1, 'Completed', 4, '2023-11-08T01:56:00.000Z', '2023-11-06 23:57:01', '2023-11-07 00:16:20'),
(4, 'LS0004', 9, 1, 1, 'Created', 2, '2023-11-15T10:34:00.000Z', '2023-11-14 08:34:16', '2023-11-14 08:34:16'),
(5, 'LS0005', 8, 2, 5, 'Created', 6, '2023-11-17T13:49:00.000Z', '2023-11-14 11:49:53', '2023-11-14 11:49:53'),
(6, 'LS0006', 3, 6, 2, 'Created', 4, '2023-11-24T08:29:00.000Z', '2023-11-16 06:30:48', '2023-11-16 06:30:48'),
(7, 'LS0007', 7, 4, 7, 'Confirmed', 7, '2023-11-30T13:02:00.000Z', '2023-11-28 11:04:24', '2023-11-29 05:21:26'),
(8, 'LS0008', 2, 5, 10, 'Completed', 4, '2023-12-01T07:21:00.000Z', '2023-11-29 05:22:03', '2023-11-29 05:43:01');

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
(1, 1, 'Created', 1, 'Loadsheet Created', '2023-10-04 18:29:49', '2023-10-04 18:29:49'),
(2, 2, 'Created', 1, 'Loadsheet Created', '2023-10-17 11:26:18', '2023-10-17 11:26:18'),
(3, 2, 'Loaded', 1, 'Loadsheet Loaded', '2023-10-18 11:54:27', '2023-10-18 11:54:27'),
(4, 2, 'Completed', 8, 'Loadsheet Completed', '2023-10-18 12:02:07', '2023-10-18 12:02:07'),
(5, 2, 'Completed', 8, 'Loadsheet Completed', '2023-10-18 12:02:38', '2023-10-18 12:02:38'),
(6, 2, 'Started', 8, 'Loadsheet Started', '2023-10-18 12:05:41', '2023-10-18 12:05:41'),
(7, 2, 'Customer Stops Added', 1, 'Customer Stops Added', '2023-10-18 12:06:10', '2023-10-18 12:06:10'),
(8, 2, 'Synced', 8, 'Loadsheet Sales Synced', '2023-10-18 20:53:44', '2023-10-18 20:53:44'),
(9, 2, 'Deleted', 1, 'Detail With Stock ID 2 Deleted', '2023-11-06 23:31:07', '2023-11-06 23:31:07'),
(10, 2, 'Cancelled', 1, 'Loadsheet Cancelled', '2023-11-06 23:31:17', '2023-11-06 23:31:17'),
(11, 1, 'Cancelled', 1, 'Loadsheet Cancelled', '2023-11-06 23:51:50', '2023-11-06 23:51:50'),
(12, 2, 'Updated', 1, 'Loadsheet Updated Changes:{\"start_date_time\":\"2023-10-20 13:00\",\"updated_at\":\"2023-11-07 01:51:57\"}', '2023-11-06 23:51:57', '2023-11-06 23:51:57'),
(13, 3, 'Created', 1, 'Loadsheet Created', '2023-11-06 23:57:01', '2023-11-06 23:57:01'),
(14, 3, 'Loaded', 1, 'Loadsheet Loaded', '2023-11-06 23:59:30', '2023-11-06 23:59:30'),
(15, 3, 'Loaded', 1, 'Loadsheet Loaded', '2023-11-06 23:59:53', '2023-11-06 23:59:53'),
(16, 3, 'Loaded', 1, 'Loadsheet Loaded', '2023-11-07 00:00:34', '2023-11-07 00:00:34'),
(17, 3, 'Started', 8, 'Loadsheet Started', '2023-11-07 00:02:05', '2023-11-07 00:02:05'),
(18, 3, 'Completed', 8, 'Loadsheet Completed', '2023-11-07 00:16:20', '2023-11-07 00:16:20'),
(19, 3, 'Synced', 8, 'Loadsheet Sales Synced', '2023-11-07 00:18:13', '2023-11-07 00:18:13'),
(20, 3, 'Synced', 8, 'Loadsheet Sales Synced', '2023-11-07 00:19:28', '2023-11-07 00:19:28'),
(21, 4, 'Created', 1, 'Loadsheet Created', '2023-11-14 08:34:16', '2023-11-14 08:34:16'),
(22, 5, 'Created', 1, 'Loadsheet Created', '2023-11-14 11:49:53', '2023-11-14 11:49:53'),
(23, 5, 'Customer Stops Added', 1, 'Customer Stops Added', '2023-11-14 11:49:53', '2023-11-14 11:49:53'),
(24, 6, 'Created', 1, 'Loadsheet Created', '2023-11-16 06:30:48', '2023-11-16 06:30:48'),
(25, 6, 'Customer Stops Added', 1, 'Customer Stops Added', '2023-11-16 06:30:48', '2023-11-16 06:30:48'),
(26, 3, 'Synced', 8, 'Loadsheet Sales Synced', '2023-11-18 14:25:31', '2023-11-18 14:25:31'),
(27, 7, 'Created', 1, 'Loadsheet Created', '2023-11-28 11:04:24', '2023-11-28 11:04:24'),
(28, 7, 'Customer Stops Added', 1, 'Customer Stops Added', '2023-11-28 11:04:25', '2023-11-28 11:04:25'),
(29, 7, 'Loaded', 1, 'Loadsheet Loaded', '2023-11-28 11:04:25', '2023-11-28 11:04:25'),
(30, 3, 'Synced', 8, 'Loadsheet Sales Synced', '2023-11-29 05:19:11', '2023-11-29 05:19:11'),
(31, 7, 'Confirmed', 1, 'Loadsheet Confirmed', '2023-11-29 05:21:26', '2023-11-29 05:21:26'),
(32, 8, 'Created', 1, 'Loadsheet Created', '2023-11-29 05:22:03', '2023-11-29 05:22:03'),
(33, 8, 'Customer Stops Added', 1, 'Customer Stops Added', '2023-11-29 05:22:03', '2023-11-29 05:22:03'),
(34, 8, 'Loaded', 1, 'Loadsheet Loaded', '2023-11-29 05:22:03', '2023-11-29 05:22:03'),
(35, 8, 'Confirmed', 1, 'Loadsheet Confirmed', '2023-11-29 05:22:40', '2023-11-29 05:22:40'),
(36, 8, 'Synced', 8, 'Loadsheet Sales Synced', '2023-11-29 05:42:29', '2023-11-29 05:42:29'),
(37, 8, 'Completed', 1, 'Loadsheet Completed', '2023-11-29 05:43:01', '2023-11-29 05:43:01');

-- --------------------------------------------------------

--
-- Table structure for table `load_sheet_details`
--

CREATE TABLE `load_sheet_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `load_sheet_id` bigint(20) UNSIGNED NOT NULL,
  `stock_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` double(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `load_sheet_details`
--

INSERT INTO `load_sheet_details` (`id`, `load_sheet_id`, `stock_id`, `quantity`, `created_at`, `updated_at`) VALUES
(2, 3, 2, 300.00, '2023-11-06 23:59:30', '2023-11-06 23:59:30'),
(3, 3, 3, 300.00, '2023-11-06 23:59:30', '2023-11-06 23:59:30'),
(4, 3, 14, 300.00, '2023-11-06 23:59:53', '2023-11-06 23:59:53'),
(5, 3, 11, 300.00, '2023-11-06 23:59:53', '2023-11-06 23:59:53'),
(6, 3, 13, 300.00, '2023-11-06 23:59:53', '2023-11-06 23:59:53'),
(7, 3, 12, 300.00, '2023-11-07 00:00:34', '2023-11-07 00:00:34'),
(8, 7, 1, 5000.00, '2023-11-28 11:04:25', '2023-11-28 11:04:25'),
(9, 8, 5, 2000.00, '2023-11-29 05:22:03', '2023-11-29 05:22:03'),
(10, 8, 6, 2000.00, '2023-11-29 05:22:03', '2023-11-29 05:22:03'),
(11, 8, 7, 2000.00, '2023-11-29 05:22:03', '2023-11-29 05:22:03'),
(12, 8, 8, 2000.00, '2023-11-29 05:22:03', '2023-11-29 05:22:03'),
(13, 8, 9, 2000.00, '2023-11-29 05:22:03', '2023-11-29 05:22:03'),
(14, 8, 10, 2000.00, '2023-11-29 05:22:03', '2023-11-29 05:22:03');

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
(33, '2023_09_26_142348_create_sale_orders_table', 9),
(34, '2023_09_26_142528_create_sale_order_details_table', 9),
(35, '2023_11_01_081441_create_payment_methods_table', 10),
(36, '2023_11_07_013438_add_is_available_to_users_table', 11),
(37, '2023_11_14_093403_add_warehouse_id_to_users_table', 12),
(38, '2023_11_14_093912_add_address_to_users_table', 12),
(39, '2023_11_14_120505_add_route_id_to_customers_table', 13),
(40, '2023_11_14_143133_create_currency_payment_methods_table', 14),
(41, '2023_11_16_075719_add_is_main_warehouse_to_warehouses_table', 15),
(42, '2023_11_29_071325_add_totals_to_sales_orders_table', 16);

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
(2, 'App\\Models\\User', 9);

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
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_methods`
--

INSERT INTO `payment_methods` (`id`, `name`, `is_default`, `created_at`, `updated_at`) VALUES
(1, 'Cash', 1, '2023-11-01 06:42:39', '2023-11-01 06:42:39'),
(2, 'Zipit', 0, '2023-11-01 06:42:46', '2023-11-01 06:42:46'),
(3, 'Transfer', 0, '2023-11-14 11:31:29', '2023-11-14 11:31:29');

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
(15, 'sales_management', 'web', '2023-11-01 07:01:16', '2023-11-01 07:01:16');

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
(3, 'App\\Models\\User', 8, 's22ultrasamsung', '9166e9d7fb4a617d07ebe396f059cfcaef5c8b5ce8f0134b4684c8af95bbfb44', '[\"*\"]', '2023-11-29 05:42:29', NULL, '2023-11-07 00:01:54', '2023-11-29 05:42:29');

-- --------------------------------------------------------

--
-- Table structure for table `pricing_methods`
--

CREATE TABLE `pricing_methods` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pricing_methods`
--

INSERT INTO `pricing_methods` (`id`, `name`, `is_default`, `created_at`, `updated_at`) VALUES
(1, 'Exchange Rate', 1, '2023-10-03 20:19:35', '2023-10-04 10:07:03'),
(2, 'Fixed Price Per Currency', 0, '2023-10-03 20:19:56', '2023-10-04 10:07:03');

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
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `code`, `description`, `product_category_id`, `reorder_level`, `image`, `tax_id`, `unit_measure_id`, `discount`, `retail_unit_price`, `wholesale_unit_price`, `created_at`, `updated_at`) VALUES
(1, 'PH0001', 'Red Bull', 4, 200.00, 'products/sp6r1o0UU6P7s9daWMKh88B3v2SfagAygVYFIcNc.jpg', 4, 4, 3.00, NULL, NULL, '2023-10-03 21:23:15', '2023-11-07 02:54:39'),
(2, 'PH0002', 'Coke Drink', 4, 600.00, 'products/zs5r8GmAFGXuzoTHIeVDLq4xodfLFjKC9jVr5U0V.jpg', 1, 4, NULL, NULL, NULL, '2023-10-18 12:37:49', '2023-10-18 12:37:49'),
(3, 'PH0003', 'Chompkins', 1, 3000.00, 'products/2gyS8YKDnrnoJh2741qE4sJ4k4bWEh7L0mUoLdRy.png', 2, 1, NULL, NULL, NULL, '2023-11-06 23:29:02', '2023-11-06 23:29:02'),
(4, 'PH0004', 'Spuds', 1, 3000.00, 'products/hkgtJJuXIbHcb1emTOfZ8JapPNp50I9Ecyy1h7Hl.png', 2, 1, NULL, NULL, NULL, '2023-11-06 23:29:19', '2023-11-06 23:29:19'),
(5, 'PH0005', 'Lays', 1, 4000.00, 'products/R0UalGkhTF1CeeBBMHEhwF86wMxaxz7JELc67qhN.jpg', 2, 1, NULL, NULL, NULL, '2023-11-06 23:29:41', '2023-11-06 23:29:41'),
(6, 'PH0006', 'Red Bull', 4, 4000.00, 'products/Uqcu9gbUPI08qYIwuYGu3D0haPeb2NK8X1bc3Yph.jpg', 2, 4, NULL, NULL, NULL, '2023-11-06 23:30:14', '2023-11-06 23:30:14'),
(7, 'PH0007', 'Pepsi', 4, 5000.00, 'products/agjHi1R58QxpQPxXsGNSmN0pdZYAW8Hq6wcGI8YB.png', 2, 4, NULL, NULL, NULL, '2023-11-06 23:30:46', '2023-11-07 02:54:15');

-- --------------------------------------------------------

--
-- Table structure for table `product_categories`
--

CREATE TABLE `product_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_categories`
--

INSERT INTO `product_categories` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Snacks', 'Groceries snacks for children and siblings', '2023-09-28 12:26:14', '2023-09-28 12:26:38'),
(3, 'test', 'tets', '2023-09-30 11:00:51', '2023-09-30 11:00:51'),
(4, 'Drinks', 'Drinks', '2023-09-30 17:28:09', '2023-09-30 17:28:09');

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
  `is_default` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_pricings`
--

INSERT INTO `product_pricings` (`id`, `product_id`, `currency_id`, `pricing_method_id`, `retail_price`, `wholesale_price`, `discount`, `created_at`, `updated_at`, `is_default`) VALUES
(1, 34, 1, 1, 12.00, 10.00, 1.00, '2023-10-03 21:19:37', '2023-10-03 21:19:37', 1),
(2, 1, 1, 1, 15.00, 12.00, 5.00, '2023-10-03 21:23:15', '2023-11-07 02:54:39', 1),
(3, 2, 1, 1, 6.00, 5.00, 0.00, '2023-10-18 12:37:49', '2023-10-18 12:37:49', 1),
(4, 3, 1, 1, 12.00, 10.00, 0.00, '2023-11-06 23:29:02', '2023-11-06 23:29:02', 1),
(5, 4, 1, 1, 10.00, 8.00, 0.00, '2023-11-06 23:29:19', '2023-11-06 23:29:19', 1),
(6, 5, 1, 1, 13.00, 11.00, 0.00, '2023-11-06 23:29:41', '2023-11-06 23:29:41', 1),
(7, 6, 1, 1, 8.00, 7.00, 0.00, '2023-11-06 23:30:14', '2023-11-06 23:30:14', 1),
(8, 7, 1, 1, 6.00, 4.00, 0.00, '2023-11-06 23:30:46', '2023-11-07 02:54:15', 1);

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
(3, 'security', 'web', '2023-09-26 20:42:46', '2023-09-26 20:42:46');

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
(3, 1),
(3, 3),
(4, 1),
(4, 3),
(5, 1),
(6, 3),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1);

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
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `routes`
--

INSERT INTO `routes` (`id`, `name`, `start_lat`, `start_lon`, `number_centers`, `created_at`, `updated_at`) VALUES
(2, 'Mt Pleasant Rout', -17.77054, 31.04834, 2, '2023-09-29 08:46:49', '2023-09-29 08:46:49'),
(3, 'Harare CBD', -17.8306176, 31.0471112, 2, '2023-09-29 11:02:39', '2023-09-29 11:02:39'),
(4, 'Bulawayo Centre', -20.1565221, 28.5809517, 3, '2023-09-29 11:04:51', '2023-09-29 11:04:51'),
(5, 'Mutoko', -17.4033669, 32.2224783, 4, '2023-09-29 13:20:41', '2023-09-29 13:20:41'),
(6, 'Bulawayo', -20.1457125, 28.5873388, 5, '2023-09-30 11:04:29', '2023-09-30 11:04:29'),
(7, 'Marondera', -18.1885141, 31.5487439, 3, '2023-09-30 17:36:11', '2023-09-30 17:36:11');

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
(19, 7, -17.8216288, 31.0492259, NULL, '2023-09-30 17:36:11', '2023-09-30 17:36:11', 'Harare');

-- --------------------------------------------------------

--
-- Table structure for table `sale_orders`
--

CREATE TABLE `sale_orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_number` varchar(255) NOT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `loadsheet_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` enum('Pending','Canceled','Paid') NOT NULL,
  `payment_method` enum('Cash','Ecocash','Swipe','Bank Transfer') DEFAULT NULL,
  `currency_id` bigint(20) UNSIGNED DEFAULT NULL,
  `discount` double(8,2) DEFAULT NULL,
  `tax` double(8,2) DEFAULT NULL,
  `total` double DEFAULT NULL,
  `total_items_synced` int(11) NOT NULL DEFAULT 0,
  `total_items_failed_synced` int(11) NOT NULL DEFAULT 0,
  `is_synced` tinyint(1) NOT NULL DEFAULT 0,
  `customer_signature` varchar(255) DEFAULT NULL,
  `driver_signature` varchar(255) DEFAULT NULL,
  `receipt_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `totals` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`totals`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sale_orders`
--

INSERT INTO `sale_orders` (`id`, `order_number`, `customer_id`, `loadsheet_id`, `status`, `payment_method`, `currency_id`, `discount`, `tax`, `total`, `total_items_synced`, `total_items_failed_synced`, `is_synced`, `customer_signature`, `driver_signature`, `receipt_url`, `created_at`, `updated_at`, `totals`) VALUES
(10, '1', 1, 2, 'Paid', 'Cash', 1, 0.00, 0.00, 2000, 1, 0, 0, NULL, NULL, NULL, '2023-10-18 20:25:50', '2023-10-18 20:25:50', NULL),
(11, '3', 2, 2, 'Paid', 'Cash', 1, 0.00, 0.00, 3000, 1, 0, 0, NULL, NULL, NULL, '2023-10-18 20:25:50', '2023-10-18 20:25:50', NULL),
(12, '67', 1, 3, 'Paid', 'Cash', 1, 0.00, 0.00, 2000, 4, 0, 0, NULL, NULL, NULL, '2023-11-07 00:18:13', '2023-11-07 00:18:13', NULL),
(13, '68', 2, 3, 'Paid', 'Cash', 1, 0.00, 0.00, 3000, 2, 0, 0, NULL, NULL, NULL, '2023-11-07 00:18:13', '2023-11-07 00:18:13', NULL),
(14, '69', 2, 3, 'Paid', 'Cash', 1, 0.00, 0.00, 3000, 2, 0, 0, NULL, NULL, NULL, '2023-11-07 00:19:28', '2023-11-07 00:19:28', NULL),
(15, '5643', 9, 3, 'Paid', 'Cash', 1, 0.00, 0.00, 2000, 4, 0, 0, NULL, NULL, NULL, '2023-11-18 14:25:31', '2023-11-18 14:32:28', NULL),
(16, '5678', 10, 3, 'Paid', 'Cash', 1, 0.00, 0.00, 3000, 2, 0, 0, NULL, NULL, NULL, '2023-11-18 14:25:31', '2023-11-18 14:32:28', NULL),
(17, '031ebf41-fabb-4206-836b-b54a0f5861a6', NULL, 3, 'Paid', 'Cash', 1, 0.00, 0.00, 2000, 4, 0, 0, NULL, NULL, NULL, '2023-11-29 05:19:11', '2023-11-29 05:19:11', '{\"USD\":2000,\"RTGS\":0}'),
(18, '031ebf41-fabb-4206-836b-b54a0f5DFR', 5, 8, 'Paid', 'Cash', 1, 0.00, 0.00, 3500, 3, 0, 0, NULL, NULL, NULL, '2023-11-29 05:42:29', '2023-11-29 05:42:29', '{\"USD\":1750,\"RTGS\":10500000}'),
(19, '565657', 5, 8, 'Paid', 'Cash', 1, 0.00, 0.00, 6000, 3, 0, 0, NULL, NULL, NULL, '2023-11-29 05:42:29', '2023-11-29 05:42:29', '{\"USD\":3000,\"RTGS\":12000000,\"Rand\":3500000}');

-- --------------------------------------------------------

--
-- Table structure for table `sale_order_details`
--

CREATE TABLE `sale_order_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sale_order_id` bigint(20) UNSIGNED NOT NULL,
  `stock_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` double(8,2) NOT NULL,
  `total_price` double(8,2) NOT NULL,
  `is_synced` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sale_order_details`
--

INSERT INTO `sale_order_details` (`id`, `sale_order_id`, `stock_id`, `quantity`, `total_price`, `is_synced`, `created_at`, `updated_at`) VALUES
(3, 10, 2, 50.00, 2000.00, 1, '2023-10-18 20:25:50', '2023-10-18 20:25:50'),
(4, 11, 2, 40.00, 3000.00, 1, '2023-10-18 20:25:50', '2023-10-18 20:25:50'),
(5, 12, 2, 50.00, 750.00, 1, '2023-11-07 00:18:13', '2023-11-07 00:18:13'),
(6, 12, 3, 70.00, 420.00, 1, '2023-11-07 00:18:13', '2023-11-07 00:18:13'),
(7, 12, 14, 100.00, 1300.00, 1, '2023-11-07 00:18:13', '2023-11-07 00:18:13'),
(8, 12, 11, 80.00, 960.00, 1, '2023-11-07 00:18:13', '2023-11-07 00:18:13'),
(9, 13, 13, 200.00, 1200.00, 1, '2023-11-07 00:18:13', '2023-11-07 00:18:13'),
(10, 13, 12, 150.00, 1500.00, 1, '2023-11-07 00:18:13', '2023-11-07 00:18:13'),
(11, 14, 13, 30.00, 180.00, 1, '2023-11-07 00:19:28', '2023-11-07 00:19:28'),
(12, 14, 12, 30.00, 300.00, 1, '2023-11-07 00:19:28', '2023-11-07 00:19:28'),
(13, 15, 2, 50.00, 750.00, 1, '2023-11-18 14:25:31', '2023-11-18 14:25:31'),
(14, 15, 3, 70.00, 420.00, 1, '2023-11-18 14:25:31', '2023-11-18 14:25:31'),
(15, 15, 14, 100.00, 1300.00, 1, '2023-11-18 14:25:31', '2023-11-18 14:25:31'),
(16, 15, 11, 80.00, 960.00, 1, '2023-11-18 14:25:31', '2023-11-18 14:25:31'),
(17, 16, 13, 200.00, 1200.00, 1, '2023-11-18 14:25:31', '2023-11-18 14:25:31'),
(18, 16, 12, 150.00, 1500.00, 1, '2023-11-18 14:25:31', '2023-11-18 14:25:31'),
(19, 17, 2, 50.00, 750.00, 1, '2023-11-29 05:19:11', '2023-11-29 05:19:11'),
(20, 17, 3, 70.00, 420.00, 1, '2023-11-29 05:19:11', '2023-11-29 05:19:11'),
(21, 17, 14, 100.00, 1300.00, 1, '2023-11-29 05:19:11', '2023-11-29 05:19:11'),
(22, 17, 11, 80.00, 960.00, 1, '2023-11-29 05:19:11', '2023-11-29 05:19:11'),
(23, 18, 5, 100.00, 1500.00, 1, '2023-11-29 05:42:29', '2023-11-29 05:42:29'),
(24, 18, 6, 80.00, 800.00, 1, '2023-11-29 05:42:29', '2023-11-29 05:42:29'),
(25, 18, 7, 100.00, 1200.00, 1, '2023-11-29 05:42:29', '2023-11-29 05:42:29'),
(26, 19, 8, 200.00, 1200.00, 1, '2023-11-29 05:42:29', '2023-11-29 05:42:29'),
(27, 19, 9, 150.00, 900.00, 1, '2023-11-29 05:42:29', '2023-11-29 05:42:29'),
(28, 19, 10, 300.00, 3900.00, 1, '2023-11-29 05:42:29', '2023-11-29 05:42:29');

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
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `stocks`
--

INSERT INTO `stocks` (`id`, `product_id`, `warehouse_id`, `quantity`, `created_at`, `updated_at`) VALUES
(1, 1, 7, 0.00, '2023-10-04 18:28:29', '2023-11-28 11:04:25'),
(2, 1, 1, 5700.00, '2023-10-18 11:54:07', '2023-11-06 23:59:30'),
(3, 2, 1, 4200.00, '2023-10-18 12:38:13', '2023-11-06 23:59:30'),
(4, 1, 6, 3000.00, '2023-11-01 06:48:25', '2023-11-01 06:48:25'),
(5, 1, 10, 0.00, '2023-11-06 23:56:41', '2023-11-29 05:22:03'),
(6, 4, 10, 0.00, '2023-11-06 23:56:41', '2023-11-29 05:22:03'),
(7, 3, 10, 0.00, '2023-11-06 23:56:41', '2023-11-29 05:22:03'),
(8, 7, 10, 0.00, '2023-11-06 23:56:41', '2023-11-29 05:22:03'),
(9, 2, 10, 0.00, '2023-11-06 23:56:41', '2023-11-29 05:22:03'),
(10, 5, 10, 0.00, '2023-11-06 23:56:41', '2023-11-29 05:22:03'),
(11, 3, 1, 1700.00, '2023-11-06 23:58:48', '2023-11-06 23:59:53'),
(12, 4, 1, 1700.00, '2023-11-06 23:58:48', '2023-11-07 00:00:34'),
(13, 7, 1, 1700.00, '2023-11-06 23:58:48', '2023-11-06 23:59:53'),
(14, 5, 1, 1700.00, '2023-11-06 23:58:59', '2023-11-06 23:59:53');

-- --------------------------------------------------------

--
-- Table structure for table `taxes`
--

CREATE TABLE `taxes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `rate` double(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `taxes`
--

INSERT INTO `taxes` (`id`, `name`, `rate`, `created_at`, `updated_at`) VALUES
(1, 'Group A', 12.06, '2023-09-28 15:12:07', '2023-09-28 15:12:07'),
(2, 'Group C', 3.56, '2023-09-28 15:16:35', '2023-09-28 15:20:28'),
(4, 'Group D', 2.00, '2023-09-30 17:28:53', '2023-09-30 17:28:53');

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
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `trucks`
--

INSERT INTO `trucks` (`id`, `make_model`, `license_plate`, `color`, `start_mileage`, `is_available`, `created_at`, `updated_at`) VALUES
(1, 'Isuzu', 'ABD34527', 'blue', 135000.00, 0, '2023-09-29 06:08:22', '2023-11-14 08:34:16'),
(2, 'Toyota dyna 2018', 'ABC34526', 'grey', 120000.00, 0, '2023-09-29 06:11:55', '2023-11-14 11:49:53'),
(4, 'Mecedes', 'ABD34567', 'grey', 100000.00, 0, '2023-09-30 13:07:34', '2023-11-28 11:04:24'),
(5, '2018 Isuzu Dyna', 'ABC345246', 'black', 120000.00, 1, '2023-09-30 17:33:07', '2023-11-29 05:43:01'),
(6, 'Nissan Dyna 2017', 'ABD345234', 'green', 100000.00, 0, '2023-10-01 19:45:15', '2023-11-16 06:30:48');

-- --------------------------------------------------------

--
-- Table structure for table `unit_measures`
--

CREATE TABLE `unit_measures` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `unit_measures`
--

INSERT INTO `unit_measures` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Packets', '2023-09-28 14:57:48', '2023-09-28 14:57:48'),
(2, 'Bucketsb', '2023-09-28 15:16:44', '2023-09-28 15:19:02'),
(4, 'Boxes 1m X 2', '2023-09-30 17:28:41', '2023-09-30 17:28:41');

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
  `address` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `phone_number`, `email`, `email_verified_at`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `two_factor_confirmed_at`, `remember_token`, `current_team_id`, `profile_photo_path`, `created_at`, `updated_at`, `is_available`, `warehouse_id`, `route_id`, `truck_id`, `address`) VALUES
(1, 'Blessing', 'Mwale', '0772440088', 'admin@vansales.com', NULL, '$2y$10$YnAjkTBlRDxgyms5pNySOuRt0B.Vuw8zHzBgqtP1Yfmq6hto21Fmm', NULL, NULL, NULL, 'eN4AMHiQjv4EY819yA7wyJnYhmZ0HQHuLffriKQlN98T80PRfibjtWbaVtNO', NULL, NULL, '2023-09-26 14:18:06', '2023-09-26 14:18:06', 1, NULL, NULL, NULL, NULL),
(2, 'Tatenda', 'Pinjisi', '0719920372', 'tatenda@gmail.com', NULL, '$2y$10$BchUp3Q...6HlQeYrZ6y9uT/ZFj7DPna/vGKQB0CxuEJNwGOBGTl6', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-27 08:14:46', '2023-11-29 05:43:01', 1, NULL, NULL, NULL, NULL),
(3, 'Gibson', 'Mutunzi', '0719920375', 'gibson@gmail.com', NULL, '$2y$10$mdzn2eEvCmRFOizHvWtoNeSRqnLasXsVj2fjtlSHMJYmjWTt4ebza', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-27 08:16:12', '2023-11-16 06:30:48', 0, NULL, NULL, NULL, NULL),
(5, 'Brandon', 'Mwale', '0719920372', 'brandon@gmail.com', NULL, '$2y$10$7HAA4ZpBLNZgJOrlhIw4UOp1DDnmWm92q1oIZE4AQSloT28kwNnZi', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-30 10:36:05', '2023-09-30 10:36:05', 1, NULL, NULL, NULL, NULL),
(6, 'TRACY', 'TAXLIEN', '17604439894', 'tax@gmail.com', NULL, '$2y$10$Z6IExpfJOqaq95fghOULye05irHa2ouav7NaFJDtWfymu/7GFZJse', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-30 10:39:37', '2023-09-30 10:39:37', 1, NULL, NULL, NULL, NULL),
(7, 'Kelvin', 'Mairosi', '0773109140', 'kelvin@outlook.com', NULL, '$2y$10$9jcJK0FAv0c1p/Ehsr2J/.tzAdcpWuWJfQF6NGP7QdzF.5.g8N.Y6', NULL, NULL, NULL, NULL, NULL, NULL, '2023-09-30 17:37:54', '2023-11-28 11:04:25', 0, NULL, NULL, NULL, NULL),
(8, 'Maybe', 'Muchabaiwa', '17604439878', 'maybe@gmail.com', NULL, '$2y$10$XfyfpXoArcWIwKoKJ68LX.3PKSLzJb0Dh6hIZ.yUO39.5XwvTwgkm', NULL, NULL, NULL, NULL, NULL, NULL, '2023-10-01 19:18:53', '2023-11-14 11:49:53', 0, 5, 6, 2, '6 Fairway Mt Pleasant Rd, Harare Zimbabwe'),
(9, 'Melbone', 'Musharukwa', '0772440455', 'mebone@axissol.com', NULL, '$2y$10$a9.lgxoYRTLMDJxs/7G7vOoTMliFxGmwa2wnD84TrLrvDL4pj2yOe', NULL, NULL, NULL, NULL, NULL, NULL, '2023-11-14 08:06:48', '2023-11-14 08:34:16', 0, 1, 2, 1, '6 Fairway Mt Pleasant Rd, Harare Zimbabwe');

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
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `warehouses`
--

INSERT INTO `warehouses` (`id`, `is_main_warehouse`, `code`, `name`, `location`, `main_warehouse_id`, `created_at`, `updated_at`) VALUES
(1, 0, 'WH0001', 'Penin', 'West gate', NULL, '2023-09-27 11:26:18', '2023-09-27 11:50:06'),
(2, 0, 'WH0002', 'Hulanda', '6 Fairway Mt Pleasant , Harare', NULL, '2023-09-27 11:33:15', '2023-09-27 11:33:15'),
(3, 0, 'WH0003', 'Pepa', 'Malborough', NULL, '2023-09-27 11:50:34', '2023-09-27 11:50:34'),
(4, 0, 'WH0004', 'Peter', 'Malborough High', NULL, '2023-09-27 11:50:45', '2023-09-27 11:50:45'),
(5, 0, 'WH0005', 'Murehwa', 'Murehwa Bhora', NULL, '2023-09-27 11:51:06', '2023-09-27 11:51:06'),
(6, 0, 'WH0006', 'Mutoko', 'Mutoko growth point', NULL, '2023-09-27 11:51:21', '2023-09-27 11:51:21'),
(7, 1, 'WH0007', 'Marondera', 'Marondera Rudhaka', NULL, '2023-09-27 11:51:46', '2023-11-16 06:16:50'),
(8, 0, 'WH0008', 'Test code', 'Teste code', NULL, '2023-09-30 07:23:30', '2023-09-30 07:23:30'),
(9, 0, 'WH0009', 'jhhj', 'jjhjhj', NULL, '2023-09-30 11:00:09', '2023-09-30 11:00:09'),
(10, 0, 'WH0010', 'Chikurubhi', 'Chikurubhi', NULL, '2023-09-30 17:24:48', '2023-09-30 17:24:48');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `currency_payment_methods`
--
ALTER TABLE `currency_payment_methods`
  ADD PRIMARY KEY (`id`),
  ADD KEY `currency_payment_methods_currency_id_foreign` (`currency_id`),
  ADD KEY `currency_payment_methods_payment_method_id_foreign` (`payment_method_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customers_email_unique` (`email`),
  ADD UNIQUE KEY `customers_phone_number_unique` (`phone_number`),
  ADD KEY `customers_route_id_foreign` (`route_id`);

--
-- Indexes for table `customer_stops`
--
ALTER TABLE `customer_stops`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_stops_customer_id_foreign` (`customer_id`),
  ADD KEY `customer_stops_loadsheet_id_foreign` (`loadsheet_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `general_settings`
--
ALTER TABLE `general_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loadsheets`
--
ALTER TABLE `loadsheets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `loadsheets_user_id_foreign` (`user_id`),
  ADD KEY `loadsheets_truck_id_foreign` (`truck_id`),
  ADD KEY `loadsheets_warehouse_id_foreign` (`warehouse_id`),
  ADD KEY `loadsheets_route_id_foreign` (`route_id`);

--
-- Indexes for table `loadsheet_histories`
--
ALTER TABLE `loadsheet_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `loadsheet_histories_loadsheet_id_foreign` (`loadsheet_id`),
  ADD KEY `loadsheet_histories_user_id_foreign` (`user_id`);

--
-- Indexes for table `load_sheet_details`
--
ALTER TABLE `load_sheet_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `load_sheet_details_load_sheet_id_foreign` (`load_sheet_id`),
  ADD KEY `load_sheet_details_stock_id_foreign` (`stock_id`);

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
  ADD PRIMARY KEY (`id`);

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
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_product_category_id_foreign` (`product_category_id`),
  ADD KEY `products_tax_id_foreign` (`tax_id`),
  ADD KEY `products_unit_measure_id_foreign` (`unit_measure_id`);

--
-- Indexes for table `product_categories`
--
ALTER TABLE `product_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_pricings`
--
ALTER TABLE `product_pricings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_pricings_product_id_foreign` (`product_id`),
  ADD KEY `product_pricings_currency_id_foreign` (`currency_id`),
  ADD KEY `product_pricings_pricing_method_id_foreign` (`pricing_method_id`);

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
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `route_nodes`
--
ALTER TABLE `route_nodes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `route_nodes_route_id_foreign` (`route_id`);

--
-- Indexes for table `sale_orders`
--
ALTER TABLE `sale_orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sale_orders_customer_id_foreign` (`customer_id`),
  ADD KEY `sale_orders_loadsheet_id_foreign` (`loadsheet_id`);

--
-- Indexes for table `sale_order_details`
--
ALTER TABLE `sale_order_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sale_order_details_sale_order_id_foreign` (`sale_order_id`),
  ADD KEY `sale_order_details_stock_id_foreign` (`stock_id`);

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
  ADD KEY `stocks_warehouse_id_foreign` (`warehouse_id`);

--
-- Indexes for table `taxes`
--
ALTER TABLE `taxes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trucks`
--
ALTER TABLE `trucks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `unit_measures`
--
ALTER TABLE `unit_measures`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `warehouses`
--
ALTER TABLE `warehouses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `warehouses_main_warehouse_id_foreign` (`main_warehouse_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `currency_payment_methods`
--
ALTER TABLE `currency_payment_methods`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `customer_stops`
--
ALTER TABLE `customer_stops`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `general_settings`
--
ALTER TABLE `general_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `loadsheets`
--
ALTER TABLE `loadsheets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `loadsheet_histories`
--
ALTER TABLE `loadsheet_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `load_sheet_details`
--
ALTER TABLE `load_sheet_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `payment_methods`
--
ALTER TABLE `payment_methods`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `pricing_methods`
--
ALTER TABLE `pricing_methods`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `product_categories`
--
ALTER TABLE `product_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `product_pricings`
--
ALTER TABLE `product_pricings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `routes`
--
ALTER TABLE `routes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `route_nodes`
--
ALTER TABLE `route_nodes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `sale_orders`
--
ALTER TABLE `sale_orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `sale_order_details`
--
ALTER TABLE `sale_order_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `stocks`
--
ALTER TABLE `stocks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `taxes`
--
ALTER TABLE `taxes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `trucks`
--
ALTER TABLE `trucks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `unit_measures`
--
ALTER TABLE `unit_measures`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `warehouses`
--
ALTER TABLE `warehouses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `currency_payment_methods`
--
ALTER TABLE `currency_payment_methods`
  ADD CONSTRAINT `currency_payment_methods_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `currency_payment_methods_payment_method_id_foreign` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `customers_route_id_foreign` FOREIGN KEY (`route_id`) REFERENCES `routes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `customer_stops`
--
ALTER TABLE `customer_stops`
  ADD CONSTRAINT `customer_stops_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `customer_stops_loadsheet_id_foreign` FOREIGN KEY (`loadsheet_id`) REFERENCES `loadsheets` (`id`);

--
-- Constraints for table `loadsheets`
--
ALTER TABLE `loadsheets`
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
-- Constraints for table `load_sheet_details`
--
ALTER TABLE `load_sheet_details`
  ADD CONSTRAINT `load_sheet_details_load_sheet_id_foreign` FOREIGN KEY (`load_sheet_id`) REFERENCES `loadsheets` (`id`),
  ADD CONSTRAINT `load_sheet_details_stock_id_foreign` FOREIGN KEY (`stock_id`) REFERENCES `stocks` (`id`);

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
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_product_category_id_foreign` FOREIGN KEY (`product_category_id`) REFERENCES `product_categories` (`id`),
  ADD CONSTRAINT `products_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `taxes` (`id`),
  ADD CONSTRAINT `products_unit_measure_id_foreign` FOREIGN KEY (`unit_measure_id`) REFERENCES `unit_measures` (`id`);

--
-- Constraints for table `product_pricings`
--
-- ALTER TABLE `product_pricings`
--   ADD CONSTRAINT `product_pricings_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
--   ADD CONSTRAINT `product_pricings_pricing_method_id_foreign` FOREIGN KEY (`pricing_method_id`) REFERENCES `pricing_methods` (`id`),
--   ADD CONSTRAINT `product_pricings_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `route_nodes`
--
ALTER TABLE `route_nodes`
  ADD CONSTRAINT `route_nodes_route_id_foreign` FOREIGN KEY (`route_id`) REFERENCES `routes` (`id`);

--
-- Constraints for table `sale_orders`
--
ALTER TABLE `sale_orders`
  ADD CONSTRAINT `sale_orders_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `sale_orders_loadsheet_id_foreign` FOREIGN KEY (`loadsheet_id`) REFERENCES `loadsheets` (`id`);

--
-- Constraints for table `sale_order_details`
--
ALTER TABLE `sale_order_details`
  ADD CONSTRAINT `sale_order_details_sale_order_id_foreign` FOREIGN KEY (`sale_order_id`) REFERENCES `sale_orders` (`id`),
  ADD CONSTRAINT `sale_order_details_stock_id_foreign` FOREIGN KEY (`stock_id`) REFERENCES `stocks` (`id`);

--
-- Constraints for table `stocks`
--
ALTER TABLE `stocks`
  ADD CONSTRAINT `stocks_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `stocks_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_route_id_foreign` FOREIGN KEY (`route_id`) REFERENCES `warehouses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `users_warehouse_id_foreign` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `warehouses`
--
ALTER TABLE `warehouses`
  ADD CONSTRAINT `warehouses_main_warehouse_id_foreign` FOREIGN KEY (`main_warehouse_id`) REFERENCES `warehouses` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
