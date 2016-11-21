-- phpMyAdmin SQL Dump
-- version 4.4.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Nov 19, 2016 at 09:56 AM
-- Server version: 5.6.26
-- PHP Version: 5.6.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lumentum_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `equipment_dateinfo`
--

CREATE TABLE IF NOT EXISTS `equipment_dateinfo` (
  `CalibrationDateIID` varchar(50) NOT NULL,
  `SerialNumber` varchar(50) NOT NULL,
  `Calibrationduedate` varchar(50) NOT NULL,
  `CalibrationInterval` varchar(50) NOT NULL,
  `CalibrationAlert` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `equipment_info`
--

CREATE TABLE IF NOT EXISTS `equipment_info` (
  `SerialNumber` varchar(50) NOT NULL,
  `EquipmentName` varchar(50) NOT NULL,
  `EquipmentNo` varchar(50) NOT NULL,
  `Manufacturer` varchar(50) NOT NULL,
  `Location` varchar(50) NOT NULL,
  `Model` varchar(50) NOT NULL,
  `Image` varchar(200) NOT NULL,
  `Quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `equipment_info`
--

INSERT INTO `equipment_info` (`SerialNumber`, `EquipmentName`, `EquipmentNo`, `Manufacturer`, `Location`, `Model`, `Image`, `Quantity`) VALUES
('', '', '', '', '', '', '', 0),
('12', 'ewqewq', 'eqw', 'ew', 'ewqeqw', 'ewq', '895430.png', 0),
('12454', 'fdsfsdfsd', 'fdsfs', 'fsdfs', 'fdsfs', 'fsdfs', '814700.png', 0),
('135', '55656', 'LIBRARY', 'kaflkdl', 'fdlk', 'sadlk', '13225.jpg', 3),
('2121', '21', '55454', 'Lenovo', 'Lucban', '12121=12', '508732.jpg', 43),
('4324', 'asd', 'ewew', 'asddas', 'dsa', 'DAS', '738604.png', 0),
('Charrr', 'DASds', 'catttt', 'ewewew', 'ewew', 'ew', '378155.jpg', 45),
('WOW', 'WOW', 'WOW', 'WOW', 'WOW', 'WOW', '267182.png', 0);

-- --------------------------------------------------------

--
-- Table structure for table `equipment_jdsuinfo`
--

CREATE TABLE IF NOT EXISTS `equipment_jdsuinfo` (
  `JDSUid` varchar(50) NOT NULL,
  `SerialNumber` varchar(50) NOT NULL,
  `FBNCalibration` varchar(50) NOT NULL,
  `Onetag` varchar(50) NOT NULL,
  `Lumentum` varchar(500) NOT NULL,
  `Consignment` varchar(50) NOT NULL,
  `BusinessUnit` varchar(50) NOT NULL,
  `JDSUniphase` varchar(50) NOT NULL,
  `CMSite` varchar(50) NOT NULL,
  `FBN` varchar(50) NOT NULL,
  `SSCI` varchar(50) NOT NULL,
  `Highsense` varchar(50) NOT NULL,
  `CTHS` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `equipment_trackinginfo`
--

CREATE TABLE IF NOT EXISTS `equipment_trackinginfo` (
  `TrackingNoid` varchar(50) NOT NULL,
  `SerialNumber` varchar(50) NOT NULL,
  `IEtracking` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE IF NOT EXISTS `login` (
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`username`, `password`) VALUES
('admin1@yahoo.com', '00001');

-- --------------------------------------------------------

--
-- Table structure for table `maintenance`
--

CREATE TABLE IF NOT EXISTS `maintenance` (
  `EquipmentNo` varchar(200) NOT NULL,
  `SerialNumber` varchar(200) NOT NULL,
  `EquipmentDesc` varchar(200) NOT NULL,
  `Status` varchar(50) NOT NULL,
  `Solution` varchar(200) NOT NULL,
  `Error` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `maintenance`
--

INSERT INTO `maintenance` (`EquipmentNo`, `SerialNumber`, `EquipmentDesc`, `Status`, `Solution`, `Error`) VALUES
('4324', 'dada', 'dasdadas', 'das', 'das', 'dsa');

-- --------------------------------------------------------

--
-- Table structure for table `testerbom`
--

CREATE TABLE IF NOT EXISTS `testerbom` (
  `TesterId` int(11) NOT NULL,
  `EquipmentNo` varchar(200) NOT NULL,
  `EquipmentDesc` varchar(200) NOT NULL,
  `Quantity` varchar(200) NOT NULL,
  `UnitCost` varchar(200) NOT NULL,
  `DiscountCost` varchar(200) NOT NULL,
  `TesterBom` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `equipment_dateinfo`
--
ALTER TABLE `equipment_dateinfo`
  ADD PRIMARY KEY (`CalibrationDateIID`),
  ADD KEY `SerialNumber` (`SerialNumber`);

--
-- Indexes for table `equipment_info`
--
ALTER TABLE `equipment_info`
  ADD PRIMARY KEY (`SerialNumber`),
  ADD KEY `EquipmentNo` (`EquipmentNo`);

--
-- Indexes for table `equipment_jdsuinfo`
--
ALTER TABLE `equipment_jdsuinfo`
  ADD PRIMARY KEY (`JDSUid`),
  ADD KEY `SerialNumber` (`SerialNumber`);

--
-- Indexes for table `equipment_trackinginfo`
--
ALTER TABLE `equipment_trackinginfo`
  ADD PRIMARY KEY (`TrackingNoid`),
  ADD KEY `SerialNumber` (`SerialNumber`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `maintenance`
--
ALTER TABLE `maintenance`
  ADD PRIMARY KEY (`EquipmentNo`),
  ADD KEY `SerialNumber` (`SerialNumber`);

--
-- Indexes for table `testerbom`
--
ALTER TABLE `testerbom`
  ADD PRIMARY KEY (`TesterId`),
  ADD KEY `EquipmentNo` (`EquipmentNo`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `testerbom`
--
ALTER TABLE `testerbom`
  MODIFY `TesterId` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `testerbom`
--
ALTER TABLE `testerbom`
  ADD CONSTRAINT `testerbom_ibfk_1` FOREIGN KEY (`EquipmentNo`) REFERENCES `equipment_info` (`EquipmentNo`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
