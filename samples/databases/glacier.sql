-- MySQL dump 10.9
--
-- Host: localhost    Database: glacier
-- ------------------------------------------------------
-- Server version	5.0.2-alpha-standard-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES latin1 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE="NO_AUTO_VALUE_ON_ZERO" */;

--
-- Table structure for table `glacier`
--

DROP TABLE IF EXISTS `glacier`;
CREATE TABLE `glacier` (
  `id` int(11) NOT NULL default '0',
  `border` polygon NOT NULL default '',
  `ela` linestring NOT NULL default '',
  `ref` point NOT NULL default '',
  `name` varchar(20) default NULL,
  PRIMARY KEY  (`id`),
  SPATIAL KEY `border` (`border`(32)),
  SPATIAL KEY `ela` (`ela`(32)),
  SPATIAL KEY `ref` (`ref`(32))
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `glacier`
--


/*!40000 ALTER TABLE `glacier` DISABLE KEYS */;
LOCK TABLES `glacier` WRITE;
INSERT INTO `glacier` VALUES (1,'\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0à£@\0\0\0\0\0pó@\0\0\0\0\0@è@\0\0\0\0\0à£@\0\0\0\0\0à£@\0\0\0\0\0X´@\0\0\0\0\0pß@\0\0\0\0\0à≥@\0\0\0\0\0pß@\0\0\0\0\0p∑@\0\0\0\0\0X´@\0\0\0\0\0dπ@\0\0\0\0\0@Ø@\0\0\0\0\0|µ@\0\0\0\0\0î±@\0\0\0\0\0pß@\0\0\0\0\0|µ@\0\0\0\0\0@ü@\0\0\0\0\0à£@\0\0\0\0\0pó@\0\0\0\0\0\0\0\0Ü™@\0\0\0\0\0¶@\0\0\0\0\0*Æ@\0\0\0\0\00¶@\0\0\0\0\0¸Ø@\0\0\0\0\0å¢@\0\0\0\0\0Ü™@\0\0\0\0\0D§@\0\0\0\0\0Ü™@\0\0\0\0\0¶@','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0à£@\0\0\0\0\0X´@\0\0\0\0\0î±@\0\0\0\0\0pß@','\0\0\0\0\0\0\0\0\0\0\0\0D¶@\0\0\0\0\0\\¢@','gl_1'),(2,'\0\0\0\0\0\0\0\0\0\0\n\0\0\0\0\0\0\0\0Xª@\0\0\0\0\0@ü@\0\0\0\0\0|µ@\0\0\0\0\0@ü@\0\0\0\0\0dπ@\0\0\0\0\0pß@\0\0\0\0\0dπ@\0\0\0\0\0à≥@\0\0\0\0\0Xª@\0\0\0\0\0|µ@\0\0\0\0\0@ø@\0\0\0\0\0à≥@\0\0\0\0\0ö¿@\0\0\0\0\0@Ø@\0\0\0\0\0@ø@\0\0\0\0\0pß@\0\0\0\0\0ö¿@\0\0\0\0\0à£@\0\0\0\0\0Xª@\0\0\0\0\0@ü@','\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0dπ@\0\0\0\0\0X´@\0\0\0\0\0@ø@\0\0\0\0\0pß@','\0\0\0\0\0\0\0\0\0\0\0\0Rº@\0\0\0\0\0|•@','gl_2');
UNLOCK TABLES;
/*!40000 ALTER TABLE `glacier` ENABLE KEYS */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

