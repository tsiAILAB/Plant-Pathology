-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 14, 2020 at 09:59 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.2.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pds_web`
--

-- --------------------------------------------------------

--
-- Table structure for table `apis`
--

CREATE TABLE `apis` (
  `id` int(11) NOT NULL,
  `api_name` varchar(100) NOT NULL,
  `api_url` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `apis`
--

INSERT INTO `apis` (`id`, `api_name`, `api_url`) VALUES
(1, 'UPLOAD_IMAGE', 'https://localhost:44379/uploadimage');

-- --------------------------------------------------------

--
-- Table structure for table `landing_page_crops`
--

CREATE TABLE `landing_page_crops` (
  `id` int(11) NOT NULL,
  `crop_icon_image` varchar(200) NOT NULL,
  `crop_name` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `landing_page_crops`
--

INSERT INTO `landing_page_crops` (`id`, `crop_icon_image`, `crop_name`) VALUES
(2, 'tomato.jpg', 'Tomato'),
(3, 'potato.jpg', 'Potato'),
(4, 'maze.jpg', 'Maze'),
(5, 'mango.png', 'Mango');

-- --------------------------------------------------------

--
-- Table structure for table `uploaded_image_for_diagnosis`
--

CREATE TABLE `uploaded_image_for_diagnosis` (
  `id` int(100) NOT NULL,
  `crop_name` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `verification_status` int(11) NOT NULL,
  `otp` int(100) NOT NULL,
  `role` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `email`, `password`, `verification_status`, `otp`, `role`) VALUES
(40, 'admin', 'c75fcabd468a3f09c9dd778dbd96458e', 1, 95545, 'admin_role'),
(41, 'jksutradhor@gmail.com', '4124bc0a9335c27f086f24ba207a4912', 1, 28537, 'user_role');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `apis`
--
ALTER TABLE `apis`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `landing_page_crops`
--
ALTER TABLE `landing_page_crops`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `uploaded_image_for_diagnosis`
--
ALTER TABLE `uploaded_image_for_diagnosis`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `apis`
--
ALTER TABLE `apis`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `landing_page_crops`
--
ALTER TABLE `landing_page_crops`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `uploaded_image_for_diagnosis`
--
ALTER TABLE `uploaded_image_for_diagnosis`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
