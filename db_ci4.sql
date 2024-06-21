-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 31, 2024 at 08:05 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_ci4`
--

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `version` varchar(255) NOT NULL,
  `class` varchar(255) NOT NULL,
  `group` varchar(255) NOT NULL,
  `namespace` varchar(255) NOT NULL,
  `time` int(11) NOT NULL,
  `batch` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `version`, `class`, `group`, `namespace`, `time`, `batch`) VALUES
(1, '2024-05-22-040528', 'App\\Database\\Migrations\\User', 'default', 'App', 1716350994, 1),
(2, '2024-05-22-040541', 'App\\Database\\Migrations\\Product', 'default', 'App', 1716350994, 1),
(3, '2024-05-22-040552', 'App\\Database\\Migrations\\Transaction', 'default', 'App', 1716350994, 1),
(4, '2024-05-22-040600', 'App\\Database\\Migrations\\TransactionDetail', 'default', 'App', 1716350994, 1);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) UNSIGNED NOT NULL,
  `nama` varchar(255) NOT NULL,
  `harga` double NOT NULL,
  `jumlah` int(5) NOT NULL,
  `foto` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `nama`, `harga`, `jumlah`, `foto`, `created_at`, `updated_at`) VALUES
(1, 'ASUS TUF A15 FA506NF', 10899000, 5, 'asus_tuf_a15.jpg', '2024-05-22 04:14:23', NULL),
(2, 'Asus Vivobook 14 A1404ZA', 6899000, 7, 'asus_vivobook_14.jpg', '2024-05-22 04:14:23', NULL),
(3, 'Lenovo IdeaPad Slim 3-14IAU7', 6299000, 5, 'lenovo_idepad_slim_3.jpg', '2024-05-22 04:14:23', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `id` int(11) UNSIGNED NOT NULL,
  `username` varchar(255) NOT NULL,
  `total_harga` double NOT NULL,
  `alamat` text NOT NULL,
  `ongkir` double DEFAULT NULL,
  `status` int(1) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `transaction_detail`
--

CREATE TABLE `transaction_detail` (
  `id` int(11) UNSIGNED NOT NULL,
  `transaction_id` int(11) UNSIGNED NOT NULL,
  `product_id` int(11) UNSIGNED NOT NULL,
  `jumlah` int(5) NOT NULL,
  `diskon` double DEFAULT NULL,
  `subtotal_harga` double NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(50) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `password`, `role`, `created_at`, `updated_at`) VALUES
(1, 'sadina.damanik', 'hakim.sakura@yahoo.co.id', '$2y$10$qc1vCxrvhKlvqq50RFCvIeNDZwWVNHh1ZpotcU6RiW66agWKSVJm.', 'admin', '2024-05-22 04:15:39', NULL),
(2, 'zhabibi', 'hasanah.ganjaran@maulana.asia', '$2y$10$I58nLON43m5CyCI8DkYJAez23SLYAER5u0DDWK/c8j5ESPs8Rx4IC', 'guest', '2024-05-22 04:15:39', NULL),
(3, 'wprastuti', 'sari53@gmail.co.id', '$2y$10$knLoLrlFaR98ULXJD4G5X.rUVbMZEKUxIr2pEQBzjYuPg.LlQfgQS', 'admin', '2024-05-22 04:15:39', NULL),
(4, 'sakura.hidayanto', 'salahudin.harjaya@yahoo.com', '$2y$10$d51mTNODPMS4bPLuIMmFMetKaa80UdCM0hxNWqqcpCjk1kuF8B2Le', 'guest', '2024-05-22 04:15:39', NULL),
(5, 'ausada', 'riyanti.iriana@gmail.co.id', '$2y$10$YJWkyM88tCVokJnrCkYjJ.ciy1cPHGinHAWISImwE7gKGm/9sSsHi', 'admin', '2024-05-22 04:15:40', NULL),
(6, 'timbul.kuswoyo', 'astuti.karya@gmail.co.id', '$2y$10$4pwdwsQ3HvGMGCywqEQPl.TGkDtsSnfaV0MSIt.zaKwsiLzpb7ozq', 'guest', '2024-05-22 04:15:40', NULL),
(7, 'wacana.karimah', 'kasiran.wulandari@gmail.com', '$2y$10$tJmqY4ytHmXfXJYJFT2dC.D8fcYz4JCCAFEprid41I9JtshYjAjz.', 'guest', '2024-05-22 04:15:40', NULL),
(8, 'susanti.raina', 'rahmawati.asman@gmail.com', '$2y$10$MgKR5OViOJz.DlQ2dsw6Me5qDygM/5ltOqIjssBD8Wq8cnryrAmfe', 'admin', '2024-05-22 04:15:40', NULL),
(9, 'cemplunk.mayasari', 'opung31@yuniar.biz', '$2y$10$mFCI2pxZouj3gzhUIO/jru5GqrqKKiSLkK.JEoPZMLIYPGZSE3W7C', 'admin', '2024-05-22 04:15:40', NULL),
(10, 'ihutagalung', 'jamil.sihotang@yulianti.co.id', '$2y$10$6a8rwNj3ALoEoYYMk1XIX.fGRtREQG0pQ5dECVkvZLWGt6XyxDGJe', 'admin', '2024-05-22 04:15:40', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transaction_detail`
--
ALTER TABLE `transaction_detail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transaction_detail`
--
ALTER TABLE `transaction_detail`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
