-- MySQL dump 10.9
--
-- Host: localhost    Database: mylibraryutf8
-- ------------------------------------------------------
-- Server version	5.0.2-alpha-standard-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE="NO_AUTO_VALUE_ON_ZERO" */;

--
-- Table structure for table `authors`
--

DROP TABLE IF EXISTS `authors`;
CREATE TABLE `authors` (
  `authID` int(11) NOT NULL auto_increment,
  `authName` varchar(60) NOT NULL default '',
  `ts` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`authID`),
  KEY `authName` (`authName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `authors`
--


/*!40000 ALTER TABLE `authors` DISABLE KEYS */;
LOCK TABLES `authors` WRITE;
INSERT INTO `authors` VALUES (1,'Kofler Michael','2004-12-02 18:36:50'),(2,'Kramer David','2004-12-02 18:36:50'),(3,'Orfali Robert','2004-12-02 18:36:50'),(4,'Harkey Dan','2004-12-02 18:36:50'),(5,'Edwards Jeri','2004-12-02 18:36:50'),(6,'Ratschiller Tobias','2004-12-02 18:36:50'),(7,'Gerken Till','2004-12-02 18:36:50'),(12,'Yarger Randy Jay','2004-12-02 18:36:50'),(13,'Reese Georg','2004-12-02 18:36:50'),(14,'King Tim','2004-12-02 18:36:50'),(15,'Date Chris','2004-12-02 18:36:50'),(16,'Darween Hugh','2004-12-02 18:36:50'),(17,'Krause Jörg','2004-12-02 18:36:50'),(19,'Pohl Peter','2004-12-02 18:36:50'),(20,'Kopka Helmut','2004-12-02 18:36:50'),(21,'Komma Michael','2004-12-02 18:36:50'),(22,'Bitsch Gerhard','2004-12-02 18:36:50'),(23,'Holz Helmut','2004-12-02 18:36:50'),(24,'Schmitt Bernd','2004-12-02 18:36:50'),(25,'Tikart Andreas','2004-12-02 18:36:50'),(26,'Garfinkel Simon','2004-12-02 18:36:50'),(30,'DuBois Paul','2004-12-02 18:36:50'),(37,'Theodor Kallifatides','2004-12-02 18:36:50'),(38,'Goosens Michael','2004-12-02 18:36:50'),(39,'Rahtz Sebastian','2004-12-02 18:36:50'),(47,'Pollack Martin','2004-12-02 18:36:50'),(48,'Gilmore W.J.','2004-12-02 18:36:50'),(51,'Wellington Luke','2004-12-02 18:36:50'),(52,'Thomson Laura','2004-12-02 18:36:50'),(53,'Monjiam Bruce','2004-12-02 18:36:50'),(55,'Mankell Henning','2004-12-02 18:36:50'),(56,'Krüger Guido','2004-12-02 18:36:50'),(57,'Knausgård Karl Ove','2004-12-02 18:36:50'),(58,'Suter Martin','2004-12-02 18:36:50'),(60,'Öggl Bernd','2004-12-02 18:36:50'),(62,'Asimov Isaac','2004-12-02 18:36:50'),(64,'Laborenz Kai','2004-12-02 18:36:50'),(65,'Wolfgarten Sebastian','2004-12-02 18:36:50'),(66,'Atwood Margaret','2004-12-02 18:36:50'),(67,'Bear Greg','2004-12-02 18:36:50'),(68,'Coetzee J. M.','2004-12-02 18:36:50'),(69,'Gardell Jonas','2004-12-02 18:36:50'),(70,'Ibsen Henrik','2004-12-02 18:36:50'),(71,'Johnson Eyvind','2004-12-02 18:36:50'),(73,'Nesser Håkan','2004-12-02 18:36:50'),(74,'Riel Joern','2004-12-02 18:36:50'),(75,'Söderberg Hjalmar','2004-12-02 18:36:50'),(76,'Saramago Jose','2004-12-02 18:36:50'),(77,'van Heijden Adrianus Fr. Th.','2004-12-02 18:36:50'),(78,'Hauser Tobias','2004-12-02 18:36:50'),(81,'Lendecke Volker','2004-12-02 18:36:50'),(82,'Eller Frank','2004-12-02 18:36:50'),(83,'Schwichtenberg Holger','2004-12-02 18:36:50'),(86,'Wall Larry','2005-01-28 11:39:30'),(87,'Christiansen Tom','2005-01-28 11:39:30'),(88,'Orwant Jon','2005-01-28 11:39:30'),(89,'Gräbe Hans-Gert','2005-02-24 17:55:46');
UNLOCK TABLES;
/*!40000 ALTER TABLE `authors` ENABLE KEYS */;

--
-- Table structure for table `authors1`
--

DROP TABLE IF EXISTS `authors1`;
CREATE TABLE `authors1` (
  `authID` int(11) NOT NULL auto_increment,
  `authName` varchar(60) NOT NULL default '',
  `ts` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`authID`),
  KEY `authName` (`authName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `authors1`
--


/*!40000 ALTER TABLE `authors1` DISABLE KEYS */;
LOCK TABLES `authors1` WRITE;
INSERT INTO `authors1` VALUES (1,'Kofler Michael','2004-12-02 18:36:50'),(2,'Kramer David','2004-12-02 18:36:50'),(3,'Orfali Robert','2004-12-02 18:36:50'),(4,'Harkey Dan','2004-12-02 18:36:50'),(5,'Edwards Jeri','2004-12-02 18:36:50'),(6,'Ratschiller Tobias','2004-12-02 18:36:50'),(7,'Gerken Till','2004-12-02 18:36:50'),(12,'Yarger Randy Jay','2004-12-02 18:36:50'),(13,'Reese Georg','2004-12-02 18:36:50'),(14,'King Tim','2004-12-02 18:36:50'),(15,'Date Chris','2004-12-02 18:36:50'),(16,'Darween Hugh','2004-12-02 18:36:50'),(17,'Krause Jörg','2004-12-02 18:36:50'),(19,'Pohl Peter','2004-12-02 18:36:50'),(20,'Kopka Helmut','2004-12-02 18:36:50'),(21,'Komma Michael','2004-12-02 18:36:50'),(22,'Bitsch Gerhard','2004-12-02 18:36:50'),(23,'Holz Helmut','2004-12-02 18:36:50'),(24,'Schmitt Bernd','2004-12-02 18:36:50'),(25,'Tikart Andreas','2004-12-02 18:36:50'),(26,'Garfinkel Simon','2004-12-02 18:36:50'),(30,'DuBois Paul','2004-12-02 18:36:50'),(37,'Theodor Kallifatides','2004-12-02 18:36:50'),(38,'Goosens Michael','2004-12-02 18:36:50'),(39,'Rahtz Sebastian','2004-12-02 18:36:50'),(47,'Pollack Martin','2004-12-02 18:36:50'),(48,'Gilmore W.J.','2004-12-02 18:36:50'),(51,'Wellington Luke','2004-12-02 18:36:50'),(52,'Thomson Laura','2004-12-02 18:36:50'),(53,'Monjiam Bruce','2004-12-02 18:36:50'),(55,'Mankell Henning','2004-12-02 18:36:50'),(56,'Krüger Guido','2004-12-02 18:36:50'),(57,'Knausgård Karl Ove','2004-12-02 18:36:50'),(58,'Suter Martin','2004-12-02 18:36:50'),(60,'Öggl Bernd','2004-12-02 18:36:50'),(62,'Asimov Isaac','2004-12-02 18:36:50'),(64,'Laborenz Kai','2004-12-02 18:36:50'),(65,'Wolfgarten Sebastian','2004-12-02 18:36:50'),(66,'Atwood Margaret','2004-12-02 18:36:50'),(67,'Bear Greg','2004-12-02 18:36:50'),(68,'Coetzee J. M.','2004-12-02 18:36:50'),(69,'Gardell Jonas','2004-12-02 18:36:50'),(70,'Ibsen Henrik','2004-12-02 18:36:50'),(71,'Johnson Eyvind','2004-12-02 18:36:50'),(73,'Nesser Håkan','2004-12-02 18:36:50'),(74,'Riel Joern','2004-12-02 18:36:50'),(75,'Söderberg Hjalmar','2004-12-02 18:36:50'),(76,'Saramago Jose','2004-12-02 18:36:50'),(77,'van Heijden Adrianus Fr. Th.','2004-12-02 18:36:50'),(78,'Hauser Tobias','2004-12-02 18:36:50'),(81,'Lendecke Volker','2004-12-02 18:36:50'),(82,'Eller Frank','2004-12-02 18:36:50'),(83,'Schwichtenberg Holger','2004-12-02 18:36:50'),(86,'Wall Larry','2005-01-28 11:39:30'),(87,'Christiansen Tom','2005-01-28 11:39:30'),(88,'Orwant Jon','2005-01-28 11:39:30'),(89,'Gräbe Hans-Gert','2005-02-24 17:55:46');
UNLOCK TABLES;
/*!40000 ALTER TABLE `authors1` ENABLE KEYS */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `catID` int(11) NOT NULL auto_increment,
  `catName` varchar(60) NOT NULL default '',
  `parentCatID` int(11) default NULL,
  `ts` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`catID`),
  KEY `catName` (`catName`),
  KEY `parentCatID` (`parentCatID`),
  CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`parentCatID`) REFERENCES `categories` (`catID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `categories`
--


/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
LOCK TABLES `categories` WRITE;
INSERT INTO `categories` VALUES (1,'Computer books',11,'2004-12-02 18:37:20'),(2,'Databases',1,'2004-12-02 18:37:20'),(3,'Programming',1,'2004-12-02 18:37:20'),(4,'Relational Databases',2,'2004-12-02 18:37:20'),(5,'Object-oriented databases',2,'2004-12-02 18:37:20'),(6,'PHP',3,'2004-12-02 18:37:20'),(7,'Perl',3,'2004-12-02 18:37:20'),(8,'SQL',2,'2004-12-02 18:37:20'),(9,'Children\'s books',11,'2004-12-02 18:37:20'),(10,'Literature and fiction',11,'2004-12-02 18:37:20'),(11,'All books',NULL,'2004-12-02 18:37:20'),(34,'MySQL',2,'2004-12-02 18:37:20'),(36,'LaTeX, TeX',1,'2004-12-02 18:37:20'),(50,'Java',3,'2004-12-02 18:37:20'),(51,'Visual Basic',3,'2004-12-02 18:37:20'),(52,'VBA',3,'2004-12-02 18:37:20'),(53,'C#',3,'2004-12-02 18:37:20'),(54,'C',3,'2004-12-02 18:37:20'),(55,'C++',3,'2004-12-02 18:37:20'),(56,'Operating Systems',1,'2004-12-02 18:37:20'),(57,'Linux',56,'2004-12-02 18:37:20'),(58,'Mac OS',56,'2004-12-02 18:37:20'),(59,'Windows',56,'2004-12-02 18:37:20'),(60,'Visual Basic .NET',3,'2004-12-02 18:37:20'),(64,'Sience Fiction',10,'2004-12-02 18:37:20'),(65,'Fantasy',10,'2004-12-02 18:37:20'),(66,'History',10,'2004-12-02 18:37:20'),(77,'PostgreSQL',2,'2004-12-02 18:37:20'),(86,'Microsoft Access',2,'2004-12-02 18:37:20'),(87,'SQLite',2,'2004-12-02 18:37:20');
UNLOCK TABLES;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
CREATE TABLE `languages` (
  `langID` int(11) NOT NULL auto_increment,
  `langName` varchar(40) NOT NULL default '',
  `ts` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`langID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `languages`
--


/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
LOCK TABLES `languages` WRITE;
INSERT INTO `languages` VALUES (1,'english','2004-12-02 18:37:02'),(2,'deutsch','2004-12-02 18:37:02'),(3,'svensk','2004-12-02 18:37:02'),(4,'norsk','2004-12-02 18:37:02');
UNLOCK TABLES;
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;

--
-- Table structure for table `publishers`
--

DROP TABLE IF EXISTS `publishers`;
CREATE TABLE `publishers` (
  `publID` int(11) NOT NULL auto_increment,
  `publName` varchar(60) NOT NULL default '',
  `ts` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`publID`),
  KEY `publName` (`publName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `publishers`
--


/*!40000 ALTER TABLE `publishers` DISABLE KEYS */;
LOCK TABLES `publishers` WRITE;
INSERT INTO `publishers` VALUES (1,'Addison-Wesley','2004-12-02 18:36:58'),(2,'Apress','2004-12-02 18:36:58'),(3,'New Riders','2004-12-02 18:36:58'),(4,'O\'Reilly & Associates','2004-12-02 18:36:58'),(5,'Hanser','2004-12-02 18:36:58'),(9,'Bonnier Pocket','2004-12-02 18:36:58'),(16,'Zsolnay','2004-12-02 18:36:58'),(17,'Ordfront förlag AB','2004-12-02 18:36:58'),(19,'Diogenes Verlag','2004-12-02 18:36:58'),(20,'Markt und Technik','2004-12-02 18:36:58'),(21,'Galileo','2004-12-02 18:36:58'),(23,'dpunkt','2004-12-02 18:36:58'),(24,'Sybex','2004-12-02 18:36:58');
UNLOCK TABLES;
/*!40000 ALTER TABLE `publishers` ENABLE KEYS */;

--
-- Table structure for table `rel_title_author`
--

DROP TABLE IF EXISTS `rel_title_author`;
CREATE TABLE `rel_title_author` (
  `titleID` int(11) NOT NULL default '0',
  `authID` int(11) NOT NULL default '0',
  `ts` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`titleID`,`authID`),
  KEY `authID` (`authID`),
  CONSTRAINT `rel_title_author_ibfk_1` FOREIGN KEY (`titleID`) REFERENCES `titles` (`titleID`),
  CONSTRAINT `rel_title_author_ibfk_2` FOREIGN KEY (`authID`) REFERENCES `authors` (`authID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rel_title_author`
--


/*!40000 ALTER TABLE `rel_title_author` DISABLE KEYS */;
LOCK TABLES `rel_title_author` WRITE;
INSERT INTO `rel_title_author` VALUES (1,1,'2004-12-02 18:37:09'),(2,1,'2004-12-02 18:37:09'),(2,2,'2004-12-02 18:37:09'),(3,3,'2005-02-24 10:46:37'),(3,4,'2005-02-24 10:46:37'),(3,5,'2005-02-24 10:46:37'),(4,6,'2004-12-02 18:37:09'),(4,7,'2004-12-02 18:37:09'),(7,30,'2004-12-02 18:37:09'),(9,12,'2004-12-02 18:37:09'),(9,13,'2004-12-02 18:37:09'),(9,14,'2004-12-02 18:37:09'),(11,15,'2004-12-02 18:37:09'),(11,16,'2004-12-02 18:37:09'),(13,1,'2004-12-02 18:37:09'),(14,1,'2004-12-02 18:37:09'),(17,17,'2004-12-02 18:37:09'),(18,19,'2004-12-02 18:37:09'),(19,19,'2005-03-01 11:27:01'),(20,19,'2004-12-02 18:37:09'),(21,20,'2004-12-02 18:37:09'),(22,1,'2005-02-24 18:01:59'),(22,89,'2005-02-24 18:01:59'),(23,1,'2004-12-02 18:37:09'),(23,21,'2004-12-02 18:37:09'),(23,22,'2004-12-02 18:37:09'),(24,1,'2004-12-02 18:37:09'),(25,23,'2004-12-02 18:37:09'),(25,24,'2004-12-02 18:37:09'),(25,25,'2004-12-02 18:37:09'),(27,26,'2004-12-02 18:37:09'),(30,1,'2004-12-02 18:37:09'),(32,57,'2004-12-02 18:37:09'),(33,1,'2004-12-02 18:37:09'),(34,1,'2004-12-02 18:37:09'),(34,2,'2004-12-02 18:37:09'),(41,17,'2004-12-02 18:37:09'),(42,37,'2004-12-02 18:37:09'),(43,38,'2004-12-02 18:37:09'),(43,39,'2004-12-02 18:37:09'),(51,47,'2004-12-02 18:37:09'),(52,48,'2004-12-02 18:37:09'),(58,1,'2004-12-02 18:37:09'),(59,51,'2004-12-02 18:37:09'),(59,52,'2004-12-02 18:37:09'),(60,30,'2004-12-02 18:37:09'),(61,53,'2004-12-02 18:37:09'),(63,55,'2004-12-02 18:37:09'),(64,55,'2004-12-02 18:37:09'),(65,56,'2004-12-02 18:37:09'),(66,58,'2004-12-02 18:37:09'),(67,1,'2004-12-02 18:37:09'),(68,1,'2004-12-02 18:37:09'),(68,60,'2004-12-02 18:37:09'),(69,1,'2004-12-02 18:37:09'),(69,82,'2004-12-02 18:37:09'),(70,1,'2004-12-02 18:37:09'),(71,1,'2004-12-02 18:37:09'),(72,62,'2004-12-02 18:37:09'),(75,1,'2004-12-02 18:37:09'),(75,2,'2004-12-02 18:37:09'),(77,64,'2004-12-02 18:37:09'),(78,65,'2004-12-02 18:37:09'),(79,66,'2004-12-02 18:37:09'),(80,67,'2004-12-02 18:37:09'),(81,68,'2004-12-02 18:37:09'),(82,68,'2004-12-02 18:37:09'),(83,69,'2004-12-02 18:37:09'),(84,70,'2004-12-02 18:37:09'),(85,71,'2004-12-02 18:37:09'),(86,55,'2004-12-02 18:37:09'),(87,73,'2004-12-02 18:37:09'),(88,74,'2004-12-02 18:37:09'),(89,74,'2004-12-02 18:37:09'),(90,75,'2004-12-02 18:37:09'),(91,76,'2004-12-02 18:37:09'),(92,76,'2004-12-02 18:37:09'),(93,77,'2004-12-02 18:37:09'),(94,78,'2004-12-02 18:37:09'),(95,1,'2004-12-02 18:37:09'),(97,81,'2004-12-02 18:37:09'),(98,82,'2004-12-02 18:37:09'),(98,83,'2004-12-02 18:37:09'),(99,82,'2004-12-02 18:37:09'),(99,83,'2004-12-02 18:37:09'),(101,1,'2004-12-02 18:37:09'),(109,86,'2005-01-28 11:39:30'),(109,87,'2005-01-28 11:39:30'),(109,88,'2005-01-28 11:39:30');
UNLOCK TABLES;
/*!40000 ALTER TABLE `rel_title_author` ENABLE KEYS */;

--
-- Table structure for table `titles`
--

DROP TABLE IF EXISTS `titles`;
CREATE TABLE `titles` (
  `titleID` int(11) NOT NULL auto_increment,
  `title` varchar(100) NOT NULL default '',
  `subtitle` varchar(100) default NULL,
  `edition` tinyint(4) default NULL,
  `publID` int(11) default NULL,
  `catID` int(11) default NULL,
  `langID` int(11) default NULL,
  `year` int(11) default NULL,
  `isbn` varchar(20) default NULL,
  `comment` varchar(255) default NULL,
  `ts` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `authors` varchar(255) default NULL,
  PRIMARY KEY  (`titleID`),
  KEY `publIdIndex` (`publID`),
  KEY `langID` (`langID`),
  KEY `catID` (`catID`),
  KEY `title` (`title`),
  CONSTRAINT `titles_ibfk_1` FOREIGN KEY (`publID`) REFERENCES `publishers` (`publID`),
  CONSTRAINT `titles_ibfk_2` FOREIGN KEY (`catID`) REFERENCES `categories` (`catID`),
  CONSTRAINT `titles_ibfk_3` FOREIGN KEY (`langID`) REFERENCES `languages` (`langID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `titles`
--


/*!40000 ALTER TABLE `titles` DISABLE KEYS */;
LOCK TABLES `titles` WRITE;
INSERT INTO `titles` VALUES (1,'Linux','Installation, Konfiguration, Anwendung',5,1,57,2,2000,NULL,NULL,'2005-02-28 13:34:21','Kofler Michael'),(2,'The Definitive Guide to Excel VBA',NULL,NULL,2,3,NULL,2000,NULL,NULL,'2005-02-28 13:34:22','Kofler Michael; Kramer David'),(3,'Client/Server Survival Guide',NULL,NULL,1,2,NULL,1997,NULL,NULL,'2005-02-28 13:34:22','Edwards Jeri; Harkey Dan; Orfali Robert'),(4,'Web Application Development with PHP 4.0',NULL,NULL,3,6,NULL,2000,NULL,NULL,'2005-02-28 13:34:22','Gerken Till; Ratschiller Tobias'),(7,'MySQL','',0,3,34,NULL,2000,'','','2005-02-28 13:34:22','DuBois Paul'),(9,'MySQL & mSQL',NULL,NULL,4,34,NULL,1999,NULL,NULL,'2005-02-28 13:34:22','King Tim; Reese Georg; Yarger Randy Jay'),(11,'A Guide to the SQL Standard',NULL,NULL,1,8,1,1997,NULL,NULL,'2005-02-28 13:34:22','Darween Hugh; Date Chris'),(13,'Visual Basic 6','Programmiertechniken, Datenbanken, Internet',NULL,1,51,2,1998,NULL,NULL,'2005-02-28 13:34:22','Kofler Michael'),(14,'Excel 2000 programmieren',NULL,4,1,3,2,NULL,NULL,NULL,'2005-02-28 13:34:22','Kofler Michael'),(17,'PHP - Grundlagen und Lösungen','Webserver-Programmierung unter Windows und Linux',NULL,5,6,2,NULL,NULL,NULL,'2005-02-28 13:34:22','Krause Jörg'),(18,'Nennen wir ihn Anna',NULL,NULL,NULL,9,2,NULL,NULL,NULL,'2005-02-28 13:34:22','Pohl Peter'),(19,'Alltid den där Annette',NULL,NULL,NULL,9,3,NULL,NULL,NULL,'2005-03-01 11:27:01','Pohl Peter'),(20,'Jag saknar dig, jag saknar dig',NULL,NULL,NULL,9,3,NULL,NULL,NULL,'2005-02-28 13:34:22','Pohl Peter'),(21,'LaTeX',NULL,NULL,1,36,2,2000,NULL,NULL,'2005-02-28 13:34:22','Kopka Helmut'),(22,'Mathematica','Einführung, Anwendung, Referenz',4,1,1,2,1998,'3827312086','CAS','2005-02-28 13:34:22','Gräbe Hans-Gert; Kofler Michael'),(23,'Maple',NULL,4,1,1,2,2001,NULL,'CAS','2005-02-28 13:34:22','Bitsch Gerhard; Kofler Michael; Komma Michael'),(24,'VBA-Programmierung mit Excel 7',NULL,NULL,1,3,2,NULL,NULL,NULL,'2005-02-28 13:34:22','Kofler Michael'),(25,'Linux für Internet und Intranet',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2005-02-28 13:34:22','Holz Helmut; Schmitt Bernd; Tikart Andreas'),(27,'Practical UNIX & Internet Security',NULL,2,4,1,1,1996,'1565921488',NULL,'2005-02-28 13:34:22','Garfinkel Simon'),(30,'Visual Basic Datenbankprogrammierung','Client/Server-Systeme',1,1,2,2,1999,NULL,NULL,'2005-02-28 13:34:22','Kofler Michael'),(32,'Ute av verden',NULL,NULL,NULL,10,4,1998,NULL,NULL,'2005-02-28 13:34:22','Knausgård Karl Ove'),(33,'MySQL','Installation, Programmierung, Referenz',1,1,34,2,2001,'3827317622',NULL,'2005-02-28 13:34:22','Kofler Michael'),(34,'MySQL',NULL,1,2,34,1,2001,NULL,'translation','2005-02-28 13:34:22','Kofler Michael; Kramer David'),(41,'PHP 4',NULL,NULL,NULL,6,2,NULL,'3-446-21546-8',NULL,'2005-02-28 13:34:22','Krause Jörg'),(42,'Kärleken',NULL,NULL,9,10,3,1978,NULL,NULL,'2005-02-28 13:34:22','Theodor Kallifatides'),(43,'Mit LaTeX ins Web','Elektronisches Publizieren mit TeX, HTML und XML',NULL,1,36,2,2000,NULL,NULL,'2005-02-28 13:34:22','Goosens Michael; Rahtz Sebastian'),(51,'Anklage Vatermord','Der Fall Philipp Halsmann',1,16,10,2,2002,'3552052062',NULL,'2005-02-28 13:34:22','Pollack Martin'),(52,'A Programmer\'s Introduction to PHP 4.0',NULL,NULL,2,6,1,NULL,NULL,NULL,'2005-02-28 13:34:22','Gilmore W.J.'),(58,'Linux','Installation, Konfiguration, Anwendung',6,1,57,2,2001,NULL,NULL,'2005-02-28 13:34:22','Kofler Michael'),(59,'PHP and MySQL Web Development',NULL,NULL,NULL,6,1,NULL,NULL,NULL,'2005-02-28 13:34:22','Thomson Laura; Wellington Luke'),(60,'MySQL Cookbook','Solutions and Examples for MySQL Database Developers',NULL,4,34,1,2003,NULL,NULL,'2005-02-28 13:34:22','DuBois Paul'),(61,'PostgreSQL','Einführung und Konzepte',NULL,1,4,2,NULL,NULL,NULL,'2005-02-28 13:34:22','Monjiam Bruce'),(63,'Comédia Infantil',NULL,NULL,17,10,3,NULL,'9173246433',NULL,'2005-02-28 13:34:22','Mankell Henning'),(64,'Hunderna i Riga',NULL,NULL,17,10,3,NULL,'9173246549).',NULL,'2005-02-28 13:34:22','Mankell Henning'),(65,'Java','Handbuch der Java-Programmierung',NULL,1,3,2,2002,NULL,NULL,'2005-02-28 13:34:22','Krüger Guido'),(66,'Ein perfekter Freund',NULL,NULL,19,10,2,NULL,NULL,NULL,'2005-02-28 13:34:22','Suter Martin'),(67,'Linux im Büro','Jetzt lerne ich ...',1,20,57,2,2004,NULL,NULL,'2005-02-28 13:34:22','Kofler Michael'),(68,'PHP 5 und MySQL 5','Grundlagen, Programmiertechniken, Beispiele',1,1,6,2,2005,NULL,NULL,'2005-02-28 13:34:22','Kofler Michael; Öggl Bernd'),(69,'Visual C#','Grundlagen, Programmiertechniken, Windows-Anwendungen',1,1,53,2,2003,NULL,NULL,'2005-02-28 13:34:22','Eller Frank; Kofler Michael'),(70,'Excel-VBA programmieren',NULL,6,1,3,2,2004,NULL,NULL,'2005-02-28 13:34:22','Kofler Michael'),(71,'Visual Basic .NET','Grundlagen, Programmiertechniken, Windows-Anwendungen',1,1,60,2,2002,NULL,NULL,'2005-02-28 13:34:22','Kofler Michael'),(72,'I, Robot',NULL,NULL,NULL,64,1,NULL,NULL,NULL,'2005-02-28 13:34:22','Asimov Isaac'),(75,'The Definitive Guide to MySQL',NULL,2,2,34,1,2003,NULL,NULL,'2005-02-28 13:34:22','Kofler Michael; Kramer David'),(77,'CSS-Praxis',NULL,2,21,1,2,2004,NULL,NULL,'2005-02-28 13:34:22','Laborenz Kai'),(78,'Apache Webserver 2.0','Installation, Konfiguration, Programmierung',1,1,1,2,2003,NULL,NULL,'2005-02-28 13:34:22','Wolfgarten Sebastian'),(79,'Oryx and Crake',NULL,1,NULL,64,1,2003,NULL,NULL,'2005-02-28 13:34:22','Atwood Margaret'),(80,'Darwin\'s Radio',NULL,NULL,NULL,64,1,NULL,NULL,NULL,'2005-02-28 13:34:22','Bear Greg'),(81,'Disgrace',NULL,1,NULL,10,1,NULL,NULL,NULL,'2005-02-28 13:34:22','Coetzee J. M.'),(82,'Life and Times of Michael K',NULL,1,NULL,10,1,NULL,NULL,NULL,'2005-02-28 13:34:22','Coetzee J. M.'),(83,'Oskuld och andra texter',NULL,NULL,NULL,10,3,NULL,NULL,NULL,'2005-02-28 13:34:22','Gardell Jonas'),(84,'Gengångare',NULL,NULL,NULL,10,3,NULL,NULL,NULL,'2005-02-28 13:34:22','Ibsen Henrik'),(85,'Grupp Krilon',NULL,NULL,NULL,10,3,NULL,NULL,NULL,'2005-02-28 13:34:22','Johnson Eyvind'),(86,'Dansläraren Återkomst',NULL,NULL,NULL,10,3,NULL,NULL,NULL,'2005-02-28 13:34:22','Mankell Henning'),(87,'Och Picadilly Circus ligger inte i Kumla',NULL,NULL,NULL,10,3,NULL,NULL,NULL,'2005-02-28 13:34:22','Nesser Håkan'),(88,'Nicht alle Eisbären halten Winterschlaf',NULL,NULL,NULL,10,2,NULL,NULL,NULL,'2005-02-28 13:34:22','Riel Joern'),(89,'Das Haus meiner Väter',NULL,NULL,NULL,10,2,NULL,NULL,NULL,'2005-02-28 13:34:22','Riel Joern'),(90,'Doktor Glas',NULL,NULL,NULL,10,3,NULL,NULL,NULL,'2005-02-28 13:34:22','Söderberg Hjalmar'),(91,'Die Stadt der Blinden',NULL,NULL,NULL,10,2,NULL,NULL,NULL,'2005-02-28 13:34:22','Saramago Jose'),(92,'Das Zentrum',NULL,NULL,NULL,10,2,NULL,NULL,NULL,'2005-02-28 13:34:22','Saramago Jose'),(93,'Ein Tag, ein Leben',NULL,NULL,NULL,10,2,NULL,NULL,NULL,'2005-02-28 13:34:22','van Heijden Adrianus Fr. Th.'),(94,'JavaScript','Interaktives und dynamisches Webpublishing',NULL,20,1,2,NULL,NULL,NULL,'2005-02-28 13:34:22','Hauser Tobias'),(95,'Windows Forms','dotnet essentials',NULL,1,60,2,2002,NULL,NULL,'2005-02-28 13:34:22','Kofler Michael'),(97,'Samba',NULL,NULL,23,57,2,2003,NULL,NULL,'2005-02-28 13:34:22','Lendecke Volker'),(98,'Programmieren mit der .NET-Klassenbibliothek',NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,'2005-02-28 13:34:22','Eller Frank; Schwichtenberg Holger'),(99,'Programmieren mit der .NET-Klassenbibliothek, 2. Aufl.',NULL,NULL,1,60,2,2003,NULL,NULL,'2005-02-28 13:34:22','Eller Frank; Schwichtenberg Holger'),(101,'Das Atari ST Grafikbuch',NULL,NULL,24,NULL,NULL,NULL,NULL,NULL,'2005-02-28 13:34:22','Kofler Michael'),(109,'Programming Perl',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2005-02-28 13:34:22','Christiansen Tom; Orwant Jon; Wall Larry');
UNLOCK TABLES;
/*!40000 ALTER TABLE `titles` ENABLE KEYS */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

