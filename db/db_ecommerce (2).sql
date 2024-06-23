-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 23, 2024 at 02:59 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_ecommerce`
--

-- --------------------------------------------------------

--
-- Table structure for table `detail_pesanan`
--

CREATE TABLE `detail_pesanan` (
  `id_detail` int(11) NOT NULL,
  `id_pesanan` int(11) NOT NULL,
  `id_produk` int(11) NOT NULL,
  `nama_produk` varchar(255) NOT NULL,
  `harga` decimal(10,2) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `status` enum('Pending','Processed','Delivered','Cancelled') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `favorit`
--

CREATE TABLE `favorit` (
  `id_favorit` int(11) NOT NULL,
  `id_produk` int(11) NOT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `favorit`
--

INSERT INTO `favorit` (`id_favorit`, `id_produk`, `id_user`) VALUES
(2, 11, 8),
(3, 6, 23),
(4, 7, 23);

-- --------------------------------------------------------

--
-- Table structure for table `kategori`
--

CREATE TABLE `kategori` (
  `id_kategori` bigint(20) UNSIGNED NOT NULL,
  `nama_kategori` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kategori`
--

INSERT INTO `kategori` (`id_kategori`, `nama_kategori`, `created_at`, `updated_at`) VALUES
(3, 'Clothing', '2024-05-31 20:18:03', '2024-05-31 20:18:03'),
(4, 'Shoes', '2024-05-31 20:18:22', '2024-05-31 20:18:22'),
(5, 'Accesories', '2024-05-31 20:18:39', '2024-05-31 20:18:39'),
(6, 'Bag', '2024-05-31 20:20:12', '2024-05-31 20:20:12');

-- --------------------------------------------------------

--
-- Table structure for table `keranjang`
--

CREATE TABLE `keranjang` (
  `id_keranjang` int(11) NOT NULL,
  `id_produk` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `harga` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `keranjang`
--

INSERT INTO `keranjang` (`id_keranjang`, `id_produk`, `id_user`, `jumlah`, `harga`) VALUES
(1, 6, 8, 1, 299000.00),
(2, 7, 8, 1, 199000.00),
(3, 9, 8, 1, 99000.00),
(4, 10, 8, 1, 10000.00),
(5, 7, 9, 1, 199000.00),
(6, 21, 8, 1, 150000.00),
(7, 13, 8, 1, 799000.00),
(8, 13, 23, 1, 799000.00),
(9, 9, 23, 1, 99000.00),
(10, 6, 24, 1, 299000.00),
(11, 9, 26, 1, 99000.00);

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
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000002_create_kategori_table', 1),
(3, '0001_01_01_000002_create_produk_table', 1),
(4, '0001_01_01_000000_create_user_table', 2),
(5, '2024_05_31_153128_create_personal_access_tokens_table', 3);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id_order` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `status` enum('pending','processing','completed','cancelled') NOT NULL,
  `alamat` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id_order`, `id_user`, `order_date`, `total_amount`, `status`, `alamat`) VALUES
(20, 8, '2024-06-12', 119000.00, 'pending', 'Padang'),
(21, 9, '2024-06-12', 199000.00, 'pending', 'jakarta'),
(22, 8, '2024-06-12', 300000.00, 'pending', 'Jakarta'),
(23, 8, '2024-06-12', 1598000.00, 'pending', 'Padang'),
(24, 23, '2024-06-16', 997000.00, 'pending', 'Perumahan abc Jakarta Barat'),
(27, 24, '2024-06-23', 299000.00, 'pending', 'Jl. Mawar'),
(28, 26, '2024-06-23', 99000.00, 'pending', 'Jl. Mawar'),
(29, 24, '2024-06-23', 299000.00, 'pending', 'Jl. Mawar'),
(30, 26, '2024-06-23', 99000.00, 'pending', 'Jl. Mawar');

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `id_detail` int(11) NOT NULL,
  `id_order` int(11) DEFAULT NULL,
  `id_produk` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price_per_unit` decimal(10,2) DEFAULT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`id_detail`, `id_order`, `id_produk`, `quantity`, `price_per_unit`, `subtotal`) VALUES
(9, 20, 9, 1, 99000.00, 99000.00),
(10, 20, 10, 2, 10000.00, 20000.00),
(11, 21, 7, 1, 199000.00, 199000.00),
(12, 22, 21, 2, 150000.00, 300000.00),
(13, 23, 13, 2, 799000.00, 1598000.00),
(14, 24, 13, 1, 799000.00, 799000.00),
(15, 24, 9, 2, 99000.00, 198000.00),
(16, 27, 6, 1, 299000.00, 299000.00),
(17, 28, 9, 1, 99000.00, 99000.00),
(18, 29, 6, 1, 299000.00, 299000.00),
(19, 30, 9, 1, 99000.00, 99000.00);

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--

CREATE TABLE `pembayaran` (
  `id_pembayaran` int(11) NOT NULL,
  `nama_bank` varchar(100) NOT NULL,
  `jumlah_pembayaran` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- Table structure for table `pesanan`
--

CREATE TABLE `pesanan` (
  `id_pesanan` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_produk` int(11) NOT NULL,
  `no_resi` varchar(255) DEFAULT NULL,
  `status` enum('Pending','Processed','Delivered','Cancelled') NOT NULL,
  `keterangan` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `pesanan`
--
DELIMITER $$
CREATE TRIGGER `before_insert_pesanan` BEFORE INSERT ON `pesanan` FOR EACH ROW BEGIN
    SET NEW.no_resi = CONCAT('00', NEW.id_pesanan);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_update_pesanan` BEFORE UPDATE ON `pesanan` FOR EACH ROW BEGIN
    SET NEW.no_resi = CONCAT('00', NEW.id_pesanan);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `produk`
--

CREATE TABLE `produk` (
  `id_produk` int(11) NOT NULL,
  `id_kategori` bigint(20) UNSIGNED NOT NULL,
  `nama_produk` varchar(255) NOT NULL,
  `gambar` varchar(255) NOT NULL,
  `harga` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `keterangan` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `produk`
--

INSERT INTO `produk` (`id_produk`, `id_kategori`, `nama_produk`, `gambar`, `harga`, `stock`, `keterangan`, `created_at`, `updated_at`) VALUES
(6, 3, 'Black 1950s Butterfly Patchwork Vintage Dress', '1717253353.jpg', 299000.00, 30, 'Petticoats added for volume sold separately. Composition: 100% Polyester Stretch: No Stretch Closure: Front Buttons Length: Knee-Length Butterfly mesh stitching', '2024-06-01 07:49:13', '2024-06-06 01:18:52'),
(7, 3, 'Cute Sweater Strawberry', '1717253958.jpg', 199000.00, 20, 'The latest swater with original quality and affordable prices can support your appearance', '2024-06-01 07:59:18', '2024-06-06 01:19:16'),
(8, 3, 'Cute Sweater Flower', '1717254015.jpg', 199000.00, 20, 'The latest swater with original quality and affordable prices can support your appearance', '2024-06-01 08:00:15', '2024-06-06 01:19:26'),
(9, 5, 'Black and white sunglasses', '1717254230.jpg', 99000.00, 10, 'Look with the latest fashion style using glasses', '2024-06-01 08:03:50', '2024-06-06 01:19:41'),
(10, 5, 'Hair Accessories', '1717254371.jpg', 10000.00, 100, 'Sustainably made in England with the finest couture silk, these Scrunchies are renowned \'the best silk scrunchies on the market\' by Glamour Magazine', '2024-06-01 08:06:11', '2024-06-06 01:19:52'),
(11, 6, 'bamboo circular bag', '1717254773.jpg', 150000.00, 24, 'Bamboo bags are cute, structured straw bags in rectangular and circular styles that girls love.', '2024-06-01 08:12:53', '2024-06-06 01:20:13'),
(12, 6, 'Bag Black Cute', '1717254826.jpg', 150000.00, 15, 'Cute bag with good quality', '2024-06-01 08:13:46', '2024-06-06 01:20:50'),
(13, 4, 'Converse black', '1717255084.jpg', 799000.00, 30, 'The selection of Converse shoe collections in casual style is right. Not only that, this branded sneakers model also makes it easy to wear and provides more active free movement.', '2024-06-01 08:18:04', '2024-06-06 01:21:03'),
(14, 4, 'Converse Chuck Taylor All Star', '1717255198.jpg', 899000.00, 20, 'The selection of Converse shoe collections in casual style is right. Not only that, this branded sneakers model also makes it easy to wear and provides more active free movement.', '2024-06-01 08:19:58', '2024-06-06 01:21:18'),
(15, 5, 'Rhinestone Flower Decor Bracelet', '1717255442.jpg', 59000.00, 15, 'Yellow gold fashionable collar glass link embellished jewelry', '2024-06-01 08:24:02', '2024-06-06 01:21:31'),
(16, 5, 'Flower Bracelet', '1717255588.jpg', 15000.00, 15, 'Flower bracelet cute', '2024-06-01 08:26:28', '2024-06-06 01:21:43'),
(18, 6, 'Pink bag', '1717255843.jpg', 200000.00, 20, 'Gorgeous pink clutch bag', '2024-06-01 08:30:43', '2024-06-06 01:21:55'),
(19, 3, 'Hoodies Women Casual', '1717256785.jpg', 250000.00, 12, 'Hoodies women casual aesthetic kawaii pink', '2024-06-01 08:46:25', '2024-06-06 01:20:37'),
(20, 3, 'Jaket Women Casual', '1717256815.jpg', 250000.00, 10, 'Jaket women casual aesthetic kawaii pink', '2024-06-01 08:46:55', '2024-06-06 01:22:18'),
(21, 3, 'Sweater', '1717257074.jpg', 150000.00, 12, 'Sweater cute aesthetic', '2024-06-01 08:51:14', '2024-06-06 01:22:31'),
(22, 3, 'Sweater love', '1717257098.jpg', 150000.00, 20, 'Sweater cute aesthetic love', '2024-06-01 08:51:38', '2024-06-06 01:22:07'),
(23, 4, 'Women shoes', '1717257263.jpg', 299000.00, 20, 'Women shoes with good quality', '2024-06-01 08:54:23', '2024-06-06 01:22:42'),
(24, 4, 'Sandal Rose Pink', '1717257384.jpg', 99000.00, 40, 'This pair of Oran Sandals are in Rose Petale calfskin with the iconic H crossover strap and rose petale leather soles.', '2024-06-01 08:56:24', '2024-06-06 01:22:53'),
(25, 4, 'New Balance', '1717257445.jpg', 699000.00, 5, 'New Balance MR530SG Blanc / Indigo naturel - White / 10', '2024-06-01 08:57:25', '2024-06-06 01:23:07'),
(26, 4, 'New Balance', '1717257484.jpg', 699000.00, 5, 'New Balance Kids 480 (Little Kid) Girl\'s Shoes White/Orb Pink : 13.5 Little Kid W', '2024-06-01 08:58:04', '2024-06-06 01:23:18'),
(27, 5, 'Paisley Silk Bandana', '1717257647.jpg', 49000.00, 10, 'Accent your look with this bandana, made with luxuriously soft silk.', '2024-06-01 09:00:47', '2024-06-06 01:23:33'),
(28, 5, 'Minimalist Solid Headband', '1717257774.jpg', 99000.00, 50, 'Pink casual collar fabric plain wide headband embellished women accessories', '2024-06-01 09:02:54', '2024-06-06 01:24:21'),
(29, 6, 'Tote Bag', '1717257909.jpg', 150000.00, 30, 'Indulge in luxury with our Handmade Genuine Leather Tote Shopping Bag.', '2024-06-01 09:05:09', '2024-06-06 01:25:01'),
(30, 6, 'Miu Miu Bag', '1717258123.jpg', 499000.00, 50, 'Miu Miu Wander matelassé shoulder bag Highlights black lambskin nappa leather matelassé effect gold-tone', '2024-06-01 09:08:43', '2024-06-06 01:24:34'),
(32, 6, 'Tote Bag', '1717258338.jpg', 150000.00, 50, 'Tote bag with soft and cute material', '2024-06-01 09:12:18', '2024-06-06 01:24:45');

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
('3ynOpLiGRGYx1o7iJk6Qx6FuZKCi7pj01EtA65XN', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN1hTakxLNFpwQXhROWR4V0xES3JJSXVEMml5dG82RzV0V2I5WXM3RiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjg6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9vcmRlcnMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1717838644),
('e2mj2OCG03IEkrFYBxnPXVZh3YQW4XHWMwy9kV8s', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWHZPNUZiR3ZYTXJ0N1hpNENhYzdhNFluNFVreTBNd2dEY3ZXNlJseiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9vcmRlcnMvOS9wZGYiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1717849832);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `fullname` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nohp` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `code_verification` varchar(10) DEFAULT NULL,
  `otp_expiry` datetime DEFAULT NULL,
  `user_status` enum('unverified','verified','banned') DEFAULT 'unverified'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `fullname`, `username`, `email`, `password`, `nohp`, `created_at`, `updated_at`, `code_verification`, `otp_expiry`, `user_status`) VALUES
(1, 'Rizka Wulandari', 'rizka', 'rizka@gmail.com', '$2y$12$MV4G0oqcZOACKO1Jey9BjuVMMXejhMGX3fluvN9bsNPqgeEiTFYqO', '081266673392', NULL, '2024-06-06 00:30:23', NULL, NULL, 'unverified'),
(3, 'Nadira Aprilia', 'nadira', 'nadira@gmail.com', '$2y$12$JW/PSPuGdodLl4R3THB/GuPyiBKiCmiLhNzVlZLb8CTtMXLlGmOGe', '081270631452', '2024-06-06 00:36:40', '2024-06-06 00:36:40', NULL, NULL, 'unverified'),
(5, 'Yulianti', 'yuli', 'yui@gmail.com', '$2y$12$QLnB9lXlahTNWHOh8ZQ7zuSAgtPXE9RaDmnnk5iXT06FJZnHFtS92', '081270631452', '2024-06-06 03:04:43', '2024-06-06 03:04:43', NULL, NULL, 'unverified'),
(6, 'Admin', 'admin', 'admin@gmail.com', '$2y$12$hinCcm3nRvyjhsSEOZNfJuX2GzuqPGXL6F5j46/MppDO6iooUHhPa', '081266678934', '2024-06-06 03:37:27', '2024-06-06 03:37:27', NULL, NULL, 'unverified'),
(8, 'fira faradilla', 'fira', 'fira@gmail.com', '$2y$10$N3bZYaWsCHvKeo9vdpD5x.2pqoTyx69yTK12GtEtH2BYgyXHZSXti', '082391282112', NULL, NULL, NULL, NULL, 'unverified'),
(9, 'nana', 'nana', 'nana@gmail.com', '$2y$10$/C0MTDIzAoJo29PcOp49k.Df4RqEsUYZoleQSk6aFESk3l5gFjtvO', '21221', NULL, NULL, NULL, NULL, 'unverified'),
(23, 'fira fara', 'firaaa', 'firafaradilla80@gmail.com', '$2y$10$zFfedQVFv6EJX5E9eCHngeGCeoaEoR9oAL5KJVFy6Lskut7NY28GS', '08230001000', '2024-06-16 07:13:25', '2024-06-16 07:13:25', '9371', '2024-06-16 09:24:31', 'verified'),
(24, 'Fitri Yanti', 'fitri', 'fitriyantii1701@gmail.com', '$2y$10$PLX/nmId11hE.9LedUb.7uDYhwaSUAg/DoLvCDCHWx672g3KeTZRK', '081234567809', '2024-06-21 21:41:09', '2024-06-21 21:41:09', '7404', '2024-06-22 23:54:49', 'verified'),
(26, 'Fitri Yanti', 'yanti12345', 'fitriyantioppo234@gmail.com', '$2y$10$/PTOUaz7KmiTFKQaXqsLP.bkxuW8a8vT0H4ouCnxUkCWpUw8st8vu', '081234567809', '2024-06-22 23:46:12', '2024-06-22 23:46:12', '7135', '2024-06-23 01:58:02', 'verified');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `detail_pesanan`
--
ALTER TABLE `detail_pesanan`
  ADD PRIMARY KEY (`id_detail`),
  ADD KEY `id_pesanan` (`id_pesanan`),
  ADD KEY `id_produk` (`id_produk`);

--
-- Indexes for table `favorit`
--
ALTER TABLE `favorit`
  ADD PRIMARY KEY (`id_favorit`),
  ADD KEY `id_produk` (`id_produk`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id_kategori`);

--
-- Indexes for table `keranjang`
--
ALTER TABLE `keranjang`
  ADD PRIMARY KEY (`id_keranjang`),
  ADD KEY `id_produk` (`id_produk`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id_order`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`id_detail`),
  ADD KEY `id_order` (`id_order`),
  ADD KEY `id_produk` (`id_produk`);

--
-- Indexes for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`id_pembayaran`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `pesanan`
--
ALTER TABLE `pesanan`
  ADD PRIMARY KEY (`id_pesanan`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_produk` (`id_produk`);

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`id_produk`),
  ADD KEY `produk_id_kategori_foreign` (`id_kategori`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_username_unique` (`username`),
  ADD UNIQUE KEY `user_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `detail_pesanan`
--
ALTER TABLE `detail_pesanan`
  MODIFY `id_detail` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `favorit`
--
ALTER TABLE `favorit`
  MODIFY `id_favorit` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `kategori`
--
ALTER TABLE `kategori`
  MODIFY `id_kategori` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `keranjang`
--
ALTER TABLE `keranjang`
  MODIFY `id_keranjang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id_order` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id_detail` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `pembayaran`
--
ALTER TABLE `pembayaran`
  MODIFY `id_pembayaran` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pesanan`
--
ALTER TABLE `pesanan`
  MODIFY `id_pesanan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `produk`
--
ALTER TABLE `produk`
  MODIFY `id_produk` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detail_pesanan`
--
ALTER TABLE `detail_pesanan`
  ADD CONSTRAINT `detail_pesanan_ibfk_1` FOREIGN KEY (`id_pesanan`) REFERENCES `pesanan` (`id_pesanan`),
  ADD CONSTRAINT `detail_pesanan_ibfk_2` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id_produk`);

--
-- Constraints for table `favorit`
--
ALTER TABLE `favorit`
  ADD CONSTRAINT `favorit_ibfk_1` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id_produk`),
  ADD CONSTRAINT `favorit_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`);

--
-- Constraints for table `keranjang`
--
ALTER TABLE `keranjang`
  ADD CONSTRAINT `keranjang_ibfk_1` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id_produk`),
  ADD CONSTRAINT `keranjang_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`);

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`id_order`) REFERENCES `orders` (`id_order`),
  ADD CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id_produk`);

--
-- Constraints for table `pesanan`
--
ALTER TABLE `pesanan`
  ADD CONSTRAINT `pesanan_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `pesanan_ibfk_2` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id_produk`);

--
-- Constraints for table `produk`
--
ALTER TABLE `produk`
  ADD CONSTRAINT `produk_id_kategori_foreign` FOREIGN KEY (`id_kategori`) REFERENCES `kategori` (`id_kategori`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
