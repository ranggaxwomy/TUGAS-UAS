-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 03, 2026 at 10:16 AM
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
-- Database: `ujang_amazon`
--

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `customer_name` varchar(100) DEFAULT NULL,
  `total_price` double DEFAULT NULL,
  `status` varchar(20) DEFAULT 'Pending',
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `username` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `customer_name`, `total_price`, `status`, `order_date`, `username`) VALUES
(3, 'asdwa', 755800000, 'Selesai', '2025-12-02 01:32:52', 'test'),
(4, 'ddd', 755800000, 'Selesai', '2025-12-03 17:08:16', 'd'),
(5, 'Rangga', 750000000, 'Selesai', '2025-12-08 04:01:14', 'dd'),
(6, 'Divia', 1500000, 'Selesai', '2025-12-12 12:13:10', 'd'),
(7, 'ddd', 750000000, 'Selesai', '2025-12-12 12:14:51', 'd'),
(8, 'Davia', 4300000, 'Selesai', '2025-12-12 12:50:22', 'd'),
(9, 'ddd', 755850000, 'Selesai', '2025-12-12 12:59:48', 'D'),
(10, 'ASDAS', 5850000, 'Selesai', '2025-12-12 13:04:04', 'D'),
(11, 'DDD', 50000, 'Selesai', '2025-12-12 13:16:08', 'DD'),
(12, 'asd', 750000000, 'Selesai', '2025-12-14 06:41:23', 'd'),
(13, 'bagas', 750000000, 'Pending', '2025-12-16 03:10:00', 'bbb'),
(14, 'Ujang Resing', 5800000, 'Selesai', '2026-01-02 09:45:27', 'ujang'),
(15, 'Maman Resing', 4000000000, 'Selesai', '2026-01-02 10:00:18', 'maman');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `product_id` varchar(50) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `price`) VALUES
(1, 11, 'P4', 50000),
(2, 12, 'P3', 750000000),
(3, 13, 'P3', 750000000),
(4, 14, 'P1', 4300000),
(5, 14, 'P2', 1500000),
(6, 15, 'P5', 4000000000);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` varchar(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `price` double NOT NULL,
  `image_url` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `image_url`) VALUES
('43', 'Baju', 'Baju Keren', 500000, 'https://th.bing.com/th/id/OIP.SZd6M5BI4YxcCZbfxpGcyQHaEo?w=275&h=180&c=7&r=0&o=7&dpr=1.5&pid=1.7&rm=3'),
('P1', 'Musang Arab', 'Musang kualitas kelas atas, di sebut juga musang birahi', 4000005, 'https://1.bp.blogspot.com/-IsVZ9PbJwS8/T29Ribba2LI/AAAAAAAAAfQ/_Qbu3Z266uU/s1600/musang.jpg'),
('P2', 'Laba Laba Sunda', 'Laba Laba khas sunda mempunyai kulit keras', 1500000, 'https://aws2-br-pic.kwai.net/kimg/EKzM1y8qmgEKAnMzEg1waG90by1vdmVyc2VhGoQBdXBpYy8yMDIzLzA3LzE5LzEzL0JNakF5TXpBM01Ua3hNelF4TWpkZk1UVXdNREF4TXpNNE1UQTBOamd3WHpFMU1ERXdNelV3TWpFd01qZzNNVjh5WHpNPV9vZmZuX0IyNzBiOTRmNDMyNjc5YjA0MmEwZTI5ZWE0MzU2ZTZmNS53ZWJw.webp'),
('P3', 'Jarvis', 'Sistem AI yang canggih', 750000000, 'https://tse3.mm.bing.net/th/id/OIP.YYiOf5KNGxhG7HkEkbCRzgHaDc?rs=1&pid=ImgDetMain&o=7&rm=3'),
('P4', 'Keripik Pisang', 'Gurih, Enak, Murah', 50000, 'data:image/webp;base64,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'),
('P5', 'Helikopter', 'Jual Murah Edisi Ga Kepake', 4000000000, 'https://i.redd.it/e5am2yanxlv61.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `role` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`username`, `password`, `role`) VALUES
('admin', 'admin', 'ADMIN'),
('bbb', '111', 'USER'),
('d', 'd', 'USER'),
('dd', 'dd', 'USER'),
('l', 'l', 'USER'),
('maman', 'maman', 'USER'),
('r', 'r', 'USER'),
('test', 'test', 'USER'),
('ujang', 'ujang', 'USER'),
('w', 'w', 'USER');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
