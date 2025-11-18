-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 18, 2025 at 06:36 AM
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
-- Database: `details`
--

-- --------------------------------------------------------

--
-- Table structure for table `ankita_products`
--

CREATE TABLE `ankita_products` (
  `id` int(100) NOT NULL,
  `p_name` varchar(160) NOT NULL,
  `p_price` int(100) NOT NULL,
  `p_des` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ankita_products`
--

INSERT INTO `ankita_products` (`id`, `p_name`, `p_price`, `p_des`) VALUES
(1, 'laptop', 50000, 'smart laptop'),
(2, 'mobile', 50000, 'smart phone');

-- --------------------------------------------------------

--
-- Table structure for table `ankita_user`
--

CREATE TABLE `ankita_user` (
  `id` int(100) DEFAULT NULL,
  `name` varchar(160) NOT NULL,
  `email` varchar(100) NOT NULL,
  `mobile` int(100) NOT NULL,
  `password` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ankita_user`
--

INSERT INTO `ankita_user` (`id`, `name`, `email`, `mobile`, `password`) VALUES
(NULL, 'a@gmail.com', '123', 0, 1212121212),
(1, 'ankita', 'a@gmail.com', 1212121212, 123);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
