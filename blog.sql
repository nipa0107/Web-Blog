-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 05, 2024 at 01:11 PM
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
-- Database: `blog`
--

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

CREATE TABLE `comment` (
  `id` int(11) NOT NULL,
  `author` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `timestamp` datetime(6) DEFAULT NULL,
  `post_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `comment`
--

INSERT INTO `comment` (`id`, `author`, `content`, `timestamp`, `post_id`) VALUES
(1, 'Rinrada', 'จริงมาก', '2024-02-29 19:25:16.000000', 1),
(2, 'Rinrada', 'เรียนแปดครึ่งยังมีแรง', '2024-02-29 19:25:32.000000', 2),
(3, 'Sasithorn', 'ครับ', '2024-03-01 00:51:22.000000', 1),
(4, 'Sasithorn', 'จริงงงงงงง', '2024-03-01 00:51:35.000000', 2),
(5, '1', '11', '2024-03-01 08:14:56.000000', 1),
(6, 'Nipa', 'ร้อนจริงงงงงงง', '2024-03-01 08:40:56.000000', 1),
(7, '1', 'สวัสดี', '2024-03-01 08:46:31.000000', 1),
(8, 'Sasithorn', '1', '2024-03-01 08:47:29.000000', 1),
(9, 'Sasithorn', '2', '2024-03-01 08:47:31.000000', 1),
(10, 'Sasithorn', '3', '2024-03-01 08:47:34.000000', 1),
(11, 'Sasithorn', '4', '2024-03-01 08:47:37.000000', 1),
(12, 'Sasithorn', '5', '2024-03-01 08:47:40.000000', 1),
(13, 'Sasithorn', '6', '2024-03-01 08:47:44.000000', 1),
(14, 'Sasithorn', '7', '2024-03-01 08:47:46.000000', 1),
(15, 'Sasithorn', '8', '2024-03-01 08:47:48.000000', 1),
(16, 'Sasithorn', '9', '2024-03-01 08:47:51.000000', 1),
(17, 'Sasithorn', '10', '2024-03-01 08:47:54.000000', 1);

-- --------------------------------------------------------

--
-- Table structure for table `post`
--

CREATE TABLE `post` (
  `id` int(11) NOT NULL,
  `author` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `detail` varchar(255) DEFAULT NULL,
  `love` int(11) NOT NULL,
  `timestamp` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `post`
--

INSERT INTO `post` (`id`, `author`, `category`, `detail`, `love`, `timestamp`) VALUES
(1, 'Sasithorn', 'นอย', 'วันนี้อาการร้อนมากกกกกกกกกก นอยยยยย', 3, '2024-02-29'),
(2, 'Rinrada', 'การเรียน', 'วันนี้เรียนจาวาสนุกมากจริงง (หลอก)', 3, '2024-02-29'),
(4, 'Sasithorn', 'บ่น', 'ง่วงนอนจังเลย', 3, '2024-03-01'),
(7, 'Nipa', 'บ่น', 'ง่วงนอน', 0, '2024-03-01');

-- --------------------------------------------------------

--
-- Table structure for table `post_liked_usernames`
--

CREATE TABLE `post_liked_usernames` (
  `post_id` int(11) NOT NULL,
  `liked_username` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `post_liked_usernames`
--

INSERT INTO `post_liked_usernames` (`post_id`, `liked_username`) VALUES
(2, 'Rinrada'),
(2, 'Sasithorn'),
(4, 'Sasithorn'),
(1, 'Rinrada'),
(4, 'Rinrada'),
(2, '1'),
(4, '1'),
(1, '1'),
(1, 'Sasithorn');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `firstname`, `lastname`, `password`, `username`) VALUES
(1, 'Sasithorn', 'Sorndok', '1234', 'Sasithorn'),
(2, 'Rinrada', 'Boonmapat', '1234', 'Rinrada'),
(3, '1', '1', '1', '1'),
(4, 'Nipa', 'Sinthaisong', '1234', 'Nipa');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `comment`
--
ALTER TABLE `comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKs1slvnkuemjsq2kj4h3vhx7i1` (`post_id`);

--
-- Indexes for table `post`
--
ALTER TABLE `post`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `post_liked_usernames`
--
ALTER TABLE `post_liked_usernames`
  ADD KEY `FKfdy6n035varncx61695o161hm` (`post_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `comment`
--
ALTER TABLE `comment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `post`
--
ALTER TABLE `post`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comment`
--
ALTER TABLE `comment`
  ADD CONSTRAINT `FKs1slvnkuemjsq2kj4h3vhx7i1` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`);

--
-- Constraints for table `post_liked_usernames`
--
ALTER TABLE `post_liked_usernames`
  ADD CONSTRAINT `FKfdy6n035varncx61695o161hm` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
