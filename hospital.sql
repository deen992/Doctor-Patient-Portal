-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 10, 2025 at 07:51 AM
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
-- Database: `hospital`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointment`
--

CREATE TABLE `appointment` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `fullName` varchar(100) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `age` varchar(10) NOT NULL,
  `appointmentDate` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `diseases` varchar(200) DEFAULT NULL,
  `doctorId` int(11) NOT NULL,
  `address` text DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `comments` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `appointment`
--

INSERT INTO `appointment` (`id`, `userId`, `fullName`, `gender`, `age`, `appointmentDate`, `email`, `phone`, `diseases`, `doctorId`, `address`, `status`, `comments`) VALUES
(8, 1, 'Hafiz', 'male', '34', '1991-03-04', 'apitduden@gmail.com', '0102528532', 'Vomit', 2, 'kampung masjid lama,mukim tekai kiri', 'Approved', NULL),
(9, 3, 'SOFIA BINTI ABDULLAH', 'female', '34', '1991-03-04', 'sofian@gmail.com', '0146550585', 'Vomit', 2, 'kampung masjid lama,mukim tekai kiri', 'Pending', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

CREATE TABLE `doctor` (
  `id` int(11) NOT NULL,
  `fullName` varchar(100) NOT NULL,
  `dateOfBirth` varchar(20) DEFAULT NULL,
  `qualification` varchar(100) DEFAULT NULL,
  `specialist` varchar(100) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctor`
--

INSERT INTO `doctor` (`id`, `fullName`, `dateOfBirth`, `qualification`, `specialist`, `email`, `phone`, `password`) VALUES
(1, 'Dr Nazmi', '1987-03-03', 'Medical Bachelor', 'PSYCHIATRY', 'nazmi@medical.com', '0199084839', 'admin'),
(2, 'Dr Aidil Adha', '1989-03-05', 'Medical Bachelor', 'GENERAL PAEDIATRICS', 'aidil@medical.com', '0174926086', 'admin'),
(3, 'Dr Amar', '1878-03-04', 'Medical Bachelor', 'PSYCHIATRY', 'amar@medical.com', '0174926086', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `specialist`
--

CREATE TABLE `specialist` (
  `id` int(11) NOT NULL,
  `specialist_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `specialist`
--

INSERT INTO `specialist` (`id`, `specialist_name`) VALUES
(4, 'DENTIST'),
(2, 'GENERAL PAEDIATRICS'),
(3, 'GENERAL SURGERY'),
(5, 'Neurology'),
(1, 'PSYCHIATRY');

-- --------------------------------------------------------

--
-- Table structure for table `user_details`
--

CREATE TABLE `user_details` (
  `id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_details`
--

INSERT INTO `user_details` (`id`, `full_name`, `email`, `password`) VALUES
(1, 'Mohd Hafizuddin', 'apitduden@gmail.com', 'admin'),
(2, 'Administrator', 'admin@gmail.com', 'admin'),
(3, 'Nurul Nasriah', 'nurul@gmail.com', 'admin');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointment`
--
ALTER TABLE `appointment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`),
  ADD KEY `doctorId` (`doctorId`);

--
-- Indexes for table `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `specialist`
--
ALTER TABLE `specialist`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `specialist_name` (`specialist_name`);

--
-- Indexes for table `user_details`
--
ALTER TABLE `user_details`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointment`
--
ALTER TABLE `appointment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `doctor`
--
ALTER TABLE `doctor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `specialist`
--
ALTER TABLE `specialist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user_details`
--
ALTER TABLE `user_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointment`
--
ALTER TABLE `appointment`
  ADD CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user_details` (`id`),
  ADD CONSTRAINT `appointment_ibfk_2` FOREIGN KEY (`doctorId`) REFERENCES `doctor` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
