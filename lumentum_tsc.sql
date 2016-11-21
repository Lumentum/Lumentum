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
-- Database: `lumentum_tsc`
--

-- --------------------------------------------------------

--
-- Table structure for table `feature`
--

CREATE TABLE IF NOT EXISTS `feature` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `empty` varchar(200) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `feature`
--

INSERT INTO `feature` (`id`, `name`, `empty`) VALUES
(7, 'SPC', ''),
(8, 'Fiber Insertion Count Limit', ''),
(9, 'Socket Counter', ''),
(10, 'Temp Offset', ''),
(11, 'Path Loss Cal Limit', ''),
(12, 'DUT Board Insertion Count Limit', ''),
(13, 'Three Five Lock', ''),
(15, 'Lens Inspection', '');

--
-- Triggers `feature`
--
DELIMITER $$
CREATE TRIGGER `feature_after_delete` AFTER DELETE ON `feature`
 FOR EACH ROW BEGIN
 INSERT INTO logtable 
   ( fwd_sql, backwd_sql, modtable, moduser ) 
 VALUES 
   ( 
   CONCAT( "DELETE FROM feature WHERE id=", CAST( OLD.id AS CHAR ) ),
   CONCAT(
   "INSERT INTO feature (id, name, empty) VALUES (", 
      CAST( OLD.id AS CHAR ), ",",
      CAST( OLD.name AS CHAR ), ",",
      "'", OLD.empty, "'", ")" 
   ),
 "feature",
 user() 
 );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `feature_after_insert` AFTER INSERT ON `feature`
 FOR EACH ROW BEGIN
 INSERT INTO logtable                                   -- table that records the changes
   ( fwd_sql, backwd_sql, modtable, moduser ) 
 VALUES
   (
   CONCAT(
     "INSERT INTO feature (id, name, empty) VALUES (",
     CAST( NEW.id AS CHAR ), ",",
     CAST( NEW.name AS CHAR ), ",",
     "'", NEW.empty, "'", ")" 
   ),                                                                                         -- modifying operation
   CONCAT( "DELETE FROM feature WHERE id=", CAST( NEW.id AS CHAR ) ), -- undo operation
   "feature",                                                                             -- table affected
   user()                                                                                     -- modifier user
   );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `feature_after_update` AFTER UPDATE ON `feature`
 FOR EACH ROW BEGIN
 INSERT INTO logtable
   ( fwd_sql, backwd_sql, modtable, moduser )
 VALUES
   (
   CONCAT( 
     "UPDATE feature SET ",
     if( NEW.name = OLD.name, "", CONCAT( "name=", CAST( NEW.name AS CHAR ), "," ) ),
     if( NEW.empty = OLD.empty, "", CONCAT( "empty=", "'", CAST( NEW.empty AS CHAR ), "'," ) ),
     CONCAT( "id=", CAST( NEW.id AS CHAR ) ),
   " WHERE ", "id=", CAST( NEW.id AS CHAR )
   ),
   CONCAT(
     "UPDATE feature SET ",
     if( NEW.name = OLD.name, "", CONCAT( "name=", CAST( OLD.name AS CHAR ), "," ) ),
     if( NEW.empty = OLD.empty, "", CONCAT( "empty=", "'", CAST( OLD.empty AS CHAR ), "'," ) ),
     CONCAT( "id=", CAST( OLD.id AS CHAR ) ),
   " WHERE ", "id=", CAST( OLD.id AS CHAR )
   ),
   "feature",
   user()
   );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE IF NOT EXISTS `logs` (
  `log_id` int(11) NOT NULL,
  `log_testerid` varchar(200) NOT NULL,
  `log_testername` varchar(200) NOT NULL,
  `field_1` int(11) NOT NULL,
  `field_2` int(11) NOT NULL,
  `field_3` int(11) NOT NULL,
  `field_4` int(11) NOT NULL,
  `field_5` int(11) NOT NULL,
  `field_5_input1` varchar(200) NOT NULL,
  `field_5_input2` varchar(200) NOT NULL,
  `field_6` int(11) NOT NULL,
  `field_6_input1` varchar(200) NOT NULL,
  `field_7` int(11) NOT NULL,
  `field_7_input1` varchar(200) NOT NULL,
  `field_8` int(11) NOT NULL,
  `reason` varchar(200) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `logs`
--

INSERT INTO `logs` (`log_id`, `log_testerid`, `log_testername`, `field_1`, `field_2`, `field_3`, `field_4`, `field_5`, `field_5_input1`, `field_5_input2`, `field_6`, `field_6_input1`, `field_7`, `field_7_input1`, `field_8`, `reason`, `date`) VALUES
(17, 'E1-0000', 'Tester1', 1, 1, 1, 1, 1, '5', '5', 1, '5', 1, '5', 1, '', '2016-11-19 08:54:45'),
(18, 'E1-0000', 'Tester1', 1, 0, 1, 0, 1, '10', '10', 0, '10', 1, '10', 0, '                   Sudden rise of temperature', '2016-11-19 08:55:23');

-- --------------------------------------------------------

--
-- Table structure for table `logtable`
--

CREATE TABLE IF NOT EXISTS `logtable` (
  `serialnum` int(11) NOT NULL,
  `fwd_sql` varchar(512) DEFAULT '',
  `backwd_sql` varchar(512) DEFAULT '',
  `modtable` varchar(64) NOT NULL,
  `moduser` varchar(64) DEFAULT '',
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `logtable`
--

INSERT INTO `logtable` (`serialnum`, `fwd_sql`, `backwd_sql`, `modtable`, `moduser`, `ts`) VALUES
(14, 'UPDATE feature SET name=Lens Inspection,id=15 WHERE id=15', 'UPDATE feature SET name=Eight,id=15 WHERE id=15', 'feature', 'root@localhost', '2016-10-28 10:20:20'),
(15, 'DELETE FROM tester WHERE tester_id=322', 'INSERT INTO tester (tester_id, tester_name, tester_image) VALUES (322,sdas,''dsa'')', 'tester', 'root@localhost', '2016-10-28 10:21:02'),
(16, 'INSERT INTO tester (tester_id, tester_name, tester_image) VALUES (0000,Tester1,''859546.jpg'')', 'DELETE FROM tester WHERE tester_id=0000', 'tester', 'root@localhost', '2016-10-28 10:25:11'),
(17, 'UPDATE feature SET name=1,id=12 WHERE id=12', 'UPDATE feature SET name=DUT Board Insertion Count Limit,id=12 WHERE id=12', 'feature', 'root@localhost', '2016-11-03 14:31:32'),
(18, 'UPDATE feature SET name=2,id=8 WHERE id=8', 'UPDATE feature SET name=Fiber Insertion Count Limit,id=8 WHERE id=8', 'feature', 'root@localhost', '2016-11-03 14:31:36'),
(19, 'UPDATE feature SET name=3,id=15 WHERE id=15', 'UPDATE feature SET name=Lens Inspection,id=15 WHERE id=15', 'feature', 'root@localhost', '2016-11-03 14:31:39'),
(20, 'UPDATE feature SET name=4,id=11 WHERE id=11', 'UPDATE feature SET name=Path Loss Cal Limit,id=11 WHERE id=11', 'feature', 'root@localhost', '2016-11-03 14:31:52'),
(21, 'UPDATE feature SET name=5,id=9 WHERE id=9', 'UPDATE feature SET name=Socket Counter,id=9 WHERE id=9', 'feature', 'root@localhost', '2016-11-03 14:31:56'),
(22, 'UPDATE feature SET name=6,id=7 WHERE id=7', 'UPDATE feature SET name=SPC,id=7 WHERE id=7', 'feature', 'root@localhost', '2016-11-03 14:31:59'),
(23, 'UPDATE feature SET name=7,id=10 WHERE id=10', 'UPDATE feature SET name=Temp Offset,id=10 WHERE id=10', 'feature', 'root@localhost', '2016-11-03 14:32:03'),
(24, 'UPDATE feature SET name=8,id=13 WHERE id=13', 'UPDATE feature SET name=Three Five Lock,id=13 WHERE id=13', 'feature', 'root@localhost', '2016-11-03 14:32:07'),
(25, 'UPDATE feature SET name=SPC,id=12 WHERE id=12', 'UPDATE feature SET name=1,id=12 WHERE id=12', 'feature', 'root@localhost', '2016-11-03 14:33:51'),
(26, 'UPDATE feature SET name=SPC,id=7 WHERE id=7', 'UPDATE feature SET name=6,id=7 WHERE id=7', 'feature', 'root@localhost', '2016-11-03 14:37:07'),
(27, 'UPDATE feature SET name=Fiber,id=8 WHERE id=8', 'UPDATE feature SET name=2,id=8 WHERE id=8', 'feature', 'root@localhost', '2016-11-03 14:37:31'),
(28, 'UPDATE feature SET name=Socket,id=9 WHERE id=9', 'UPDATE feature SET name=5,id=9 WHERE id=9', 'feature', 'root@localhost', '2016-11-03 14:39:15'),
(29, 'UPDATE feature SET name=Temp,id=10 WHERE id=10', 'UPDATE feature SET name=7,id=10 WHERE id=10', 'feature', 'root@localhost', '2016-11-03 14:39:23'),
(30, 'UPDATE feature SET name=Path,id=11 WHERE id=11', 'UPDATE feature SET name=4,id=11 WHERE id=11', 'feature', 'root@localhost', '2016-11-03 14:39:34'),
(31, 'UPDATE feature SET name=DUT,id=12 WHERE id=12', 'UPDATE feature SET name=SPC,id=12 WHERE id=12', 'feature', 'root@localhost', '2016-11-03 14:40:00'),
(32, 'UPDATE feature SET name=Three,id=13 WHERE id=13', 'UPDATE feature SET name=8,id=13 WHERE id=13', 'feature', 'root@localhost', '2016-11-03 14:40:14'),
(33, 'UPDATE feature SET name=Lens,id=15 WHERE id=15', 'UPDATE feature SET name=3,id=15 WHERE id=15', 'feature', 'root@localhost', '2016-11-03 14:40:26'),
(34, 'UPDATE feature SET name=1,id=7 WHERE id=7', 'UPDATE feature SET name=SPC,id=7 WHERE id=7', 'feature', 'root@localhost', '2016-11-03 14:42:04'),
(35, 'UPDATE feature SET name=2,id=8 WHERE id=8', 'UPDATE feature SET name=Fiber,id=8 WHERE id=8', 'feature', 'root@localhost', '2016-11-03 14:42:08'),
(36, 'UPDATE feature SET name=3,id=9 WHERE id=9', 'UPDATE feature SET name=Socket,id=9 WHERE id=9', 'feature', 'root@localhost', '2016-11-03 14:42:11'),
(37, 'UPDATE feature SET name=4,id=10 WHERE id=10', 'UPDATE feature SET name=Temp,id=10 WHERE id=10', 'feature', 'root@localhost', '2016-11-03 14:42:15'),
(38, 'UPDATE feature SET name=5,id=11 WHERE id=11', 'UPDATE feature SET name=Path,id=11 WHERE id=11', 'feature', 'root@localhost', '2016-11-03 14:42:18'),
(39, 'UPDATE feature SET name=6,id=12 WHERE id=12', 'UPDATE feature SET name=DUT,id=12 WHERE id=12', 'feature', 'root@localhost', '2016-11-03 14:42:22'),
(40, 'UPDATE feature SET name=7,id=13 WHERE id=13', 'UPDATE feature SET name=Three,id=13 WHERE id=13', 'feature', 'root@localhost', '2016-11-03 14:42:26'),
(41, 'UPDATE feature SET name=8,id=15 WHERE id=15', 'UPDATE feature SET name=Lens,id=15 WHERE id=15', 'feature', 'root@localhost', '2016-11-03 14:42:30'),
(42, 'INSERT INTO tester (tester_id, tester_name, tester_image) VALUES (2323,dasda,''252122.jpg'')', 'DELETE FROM tester WHERE tester_id=2323', 'tester', 'root@localhost', '2016-11-03 14:43:34'),
(43, 'INSERT INTO feature (id, name, empty) VALUES (16,ffsdfs,'''')', 'DELETE FROM feature WHERE id=16', 'feature', 'root@localhost', '2016-11-10 08:18:03'),
(44, 'DELETE FROM feature WHERE id=16', 'INSERT INTO feature (id, name, empty) VALUES (16,ffsdfs,'''')', 'feature', 'root@localhost', '2016-11-10 08:18:06'),
(45, 'INSERT INTO feature (id, name, empty) VALUES (17,w,'''')', 'DELETE FROM feature WHERE id=17', 'feature', 'root@localhost', '2016-11-10 10:24:15'),
(46, 'DELETE FROM feature WHERE id=17', 'INSERT INTO feature (id, name, empty) VALUES (17,w,'''')', 'feature', 'root@localhost', '2016-11-11 03:51:43'),
(47, 'UPDATE feature SET name=SPC,id=7 WHERE id=7', 'UPDATE feature SET name=1,id=7 WHERE id=7', 'feature', 'root@localhost', '2016-11-11 15:34:52'),
(48, 'UPDATE feature SET name=Fiber Insertion Count Limit,id=8 WHERE id=8', 'UPDATE feature SET name=2,id=8 WHERE id=8', 'feature', 'root@localhost', '2016-11-11 15:35:10'),
(49, 'UPDATE feature SET name=Socket Counter,id=9 WHERE id=9', 'UPDATE feature SET name=3,id=9 WHERE id=9', 'feature', 'root@localhost', '2016-11-11 15:35:22'),
(50, 'UPDATE feature SET name=Temp Offset,id=10 WHERE id=10', 'UPDATE feature SET name=4,id=10 WHERE id=10', 'feature', 'root@localhost', '2016-11-11 15:35:32'),
(51, 'UPDATE feature SET name=Path Loss Cal Limit,id=11 WHERE id=11', 'UPDATE feature SET name=5,id=11 WHERE id=11', 'feature', 'root@localhost', '2016-11-11 15:35:48'),
(52, 'UPDATE feature SET name=DUT Board Insertion Count Limit,id=12 WHERE id=12', 'UPDATE feature SET name=6,id=12 WHERE id=12', 'feature', 'root@localhost', '2016-11-11 15:36:09'),
(53, 'UPDATE feature SET name=Three Five Lock,id=13 WHERE id=13', 'UPDATE feature SET name=7,id=13 WHERE id=13', 'feature', 'root@localhost', '2016-11-11 15:36:24'),
(54, 'UPDATE feature SET name=Lens Inspection,id=15 WHERE id=15', 'UPDATE feature SET name=8,id=15 WHERE id=15', 'feature', 'root@localhost', '2016-11-11 15:36:37'),
(55, 'UPDATE loggedtable SET tester_name=Tester2,tester_id=2323 WHERE tester_id=2323', 'UPDATE tester SET tester_name=dasda,tester_id=2323 WHERE tester_id=2323', 'loggedtable', 'root@localhost', '2016-11-11 15:36:51'),
(56, 'INSERT INTO tester (tester_id, tester_name, tester_image) VALUES (0123,Tester3,''124167.png'')', 'DELETE FROM tester WHERE tester_id=0123', 'tester', 'root@localhost', '2016-11-19 06:06:33'),
(57, 'DELETE FROM tester WHERE tester_id=2323', 'INSERT INTO tester (tester_id, tester_name, tester_image) VALUES (2323,Tester2,''252122.jpg'')', 'tester', 'root@localhost', '2016-11-19 08:32:51'),
(58, 'INSERT INTO tester (tester_id, tester_name, tester_image) VALUES (1111,Tester 2,''865949.jpg'')', 'DELETE FROM tester WHERE tester_id=1111', 'tester', 'root@localhost', '2016-11-19 08:33:41'),
(59, 'UPDATE loggedtable SET tester_id=2222 WHERE tester_id=2222', 'UPDATE tester SET tester_id=0123 WHERE tester_id=0123', 'loggedtable', 'root@localhost', '2016-11-19 08:50:42');

-- --------------------------------------------------------

--
-- Table structure for table `modify`
--

CREATE TABLE IF NOT EXISTS `modify` (
  `tester_id` varchar(200) NOT NULL,
  `tester_name` varchar(200) NOT NULL,
  `field_1` int(11) NOT NULL,
  `field_2` int(11) NOT NULL,
  `field_3` int(11) NOT NULL,
  `field_4` int(11) NOT NULL,
  `field_5` int(11) NOT NULL,
  `field_5_input1` varchar(200) NOT NULL,
  `field_5_input2` varchar(200) NOT NULL,
  `field_6` int(11) NOT NULL,
  `field_6_input1` varchar(200) NOT NULL,
  `field_7` int(11) NOT NULL,
  `field_7_input1` varchar(200) NOT NULL,
  `field_8` int(11) NOT NULL,
  `reason` varchar(200) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `modify`
--

INSERT INTO `modify` (`tester_id`, `tester_name`, `field_1`, `field_2`, `field_3`, `field_4`, `field_5`, `field_5_input1`, `field_5_input2`, `field_6`, `field_6_input1`, `field_7`, `field_7_input1`, `field_8`, `reason`, `date`) VALUES
('E1-0000', 'Tester1', 1, 0, 1, 0, 1, '10', '10', 0, '10', 1, '10', 0, '                   Sudden rise of temperature', '2016-11-19 08:55:23');

-- --------------------------------------------------------

--
-- Table structure for table `test`
--

CREATE TABLE IF NOT EXISTS `test` (
  `tester_name` varchar(200) NOT NULL,
  `field_5_input1` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `test`
--

INSERT INTO `test` (`tester_name`, `field_5_input1`) VALUES
('Tester1', '3');

-- --------------------------------------------------------

--
-- Table structure for table `tester`
--

CREATE TABLE IF NOT EXISTS `tester` (
  `tester_id` varchar(200) NOT NULL,
  `tester_name` varchar(200) NOT NULL,
  `tester_image` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tester`
--

INSERT INTO `tester` (`tester_id`, `tester_name`, `tester_image`) VALUES
('0000', 'Tester1', '859546.jpg'),
('1111', 'Tester 2', '865949.jpg'),
('2222', 'Tester3', '124167.png');

--
-- Triggers `tester`
--
DELIMITER $$
CREATE TRIGGER `tester_after_delete` AFTER DELETE ON `tester`
 FOR EACH ROW BEGIN
 INSERT INTO logtable 
   ( fwd_sql, backwd_sql, modtable, moduser ) 
 VALUES 
   ( 
   CONCAT( "DELETE FROM tester WHERE tester_id=", CAST( OLD.tester_id AS CHAR ) ),
   CONCAT(
   "INSERT INTO tester (tester_id, tester_name, tester_image) VALUES (", 
      CAST( OLD.tester_id AS CHAR ), ",",
      CAST( OLD.tester_name AS CHAR ), ",",
      "'", OLD.tester_image, "'",")" 
   ),
 "tester",
 user() 
 );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tester_after_insert` AFTER INSERT ON `tester`
 FOR EACH ROW BEGIN
 INSERT INTO logtable                                   -- table that records the changes
   ( fwd_sql, backwd_sql, modtable, moduser ) 
 VALUES
   (
   CONCAT(
     "INSERT INTO tester (tester_id, tester_name, tester_image) VALUES (",
     CAST( NEW.tester_id AS CHAR ), ",",
     CAST( NEW.tester_name AS CHAR ), ",",
     "'", NEW.tester_image, "'", ")" 
   ),                                                                                         
   CONCAT( "DELETE FROM tester WHERE tester_id=", CAST( NEW.tester_id AS CHAR ) ),
   "tester",                                                                            
   user()                                                                                    
   );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tester_after_update` AFTER UPDATE ON `tester`
 FOR EACH ROW BEGIN
 INSERT INTO logtable
   ( fwd_sql, backwd_sql, modtable, moduser )
 VALUES
   (
   CONCAT( 
     "UPDATE loggedtable SET ",
     if( NEW.tester_name = OLD.tester_name, "", CONCAT( "tester_name=", CAST( NEW.tester_name AS CHAR ), "," ) ),
     if( NEW.tester_image = OLD.tester_image, "", CONCAT( "tester_image=", "'", CAST( NEW.tester_image AS CHAR ), "'," ) ),
     CONCAT( "tester_id=", CAST( NEW.tester_id AS CHAR ) ),
   " WHERE ", "tester_id=", CAST( NEW.tester_id AS CHAR )
   ),
   CONCAT(
     "UPDATE tester SET ",
     if( NEW.tester_name = OLD.tester_name, "", CONCAT( "tester_name=", CAST( OLD.tester_name AS CHAR ), "," ) ),
     if( NEW.tester_image = OLD.tester_image, "", CONCAT( "tester_image=", "'", CAST( OLD.tester_image AS CHAR ), "'," ) ),
     CONCAT( "tester_id=", CAST( OLD.tester_id AS CHAR ) ),
   " WHERE ", "tester_id=", CAST( OLD.tester_id AS CHAR )
   ),
   "loggedtable",
   user()
   );
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `feature`
--
ALTER TABLE `feature`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`log_id`);

--
-- Indexes for table `logtable`
--
ALTER TABLE `logtable`
  ADD PRIMARY KEY (`serialnum`);

--
-- Indexes for table `modify`
--
ALTER TABLE `modify`
  ADD PRIMARY KEY (`tester_id`);

--
-- Indexes for table `test`
--
ALTER TABLE `test`
  ADD PRIMARY KEY (`tester_name`);

--
-- Indexes for table `tester`
--
ALTER TABLE `tester`
  ADD PRIMARY KEY (`tester_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `feature`
--
ALTER TABLE `feature`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `logtable`
--
ALTER TABLE `logtable`
  MODIFY `serialnum` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=60;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
