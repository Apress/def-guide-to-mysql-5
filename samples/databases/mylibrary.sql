-- MySQL dump 10.9
--
-- Host: localhost    Database: mylibrary
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
-- Table structure for table `authors`
--

DROP TABLE IF EXISTS `authors`;
CREATE TABLE `authors` (
  `authID` int(11) NOT NULL auto_increment,
  `authName` varchar(60) collate latin1_german1_ci NOT NULL default '',
  `ts` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`authID`),
  KEY `authName` (`authName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;

--
-- Dumping data for table `authors`
--


/*!40000 ALTER TABLE `authors` DISABLE KEYS */;
LOCK TABLES `authors` WRITE;
INSERT INTO `authors` VALUES (1,'Kofler Michael','2004-12-02 18:36:51'),(2,'Kramer David','2004-12-02 18:36:51'),(3,'Orfali Robert','2004-12-02 18:36:51'),(4,'Harkey Dan','2004-12-02 18:36:51'),(5,'Edwards Jeri','2004-12-02 18:36:51'),(6,'Ratschiller Tobias','2004-12-02 18:36:51'),(7,'Gerken Till','2004-12-02 18:36:51'),(12,'Yarger Randy Jay','2004-12-02 18:36:51'),(13,'Reese Georg','2004-12-02 18:36:51'),(14,'King Tim','2004-12-02 18:36:51'),(15,'Date Chris','2004-12-02 18:36:51'),(16,'Darween Hugh','2004-12-02 18:36:51'),(17,'Krause Jörg','2004-12-02 18:36:51'),(19,'Pohl Peter','2004-12-02 18:36:51'),(20,'Kopka Helmut','2004-12-02 18:36:51'),(21,'Komma Michael','2004-12-02 18:36:51'),(22,'Bitsch Gerhard','2004-12-02 18:36:51'),(23,'Holz Helmut','2004-12-02 18:36:51'),(24,'Schmitt Bernd','2004-12-02 18:36:51'),(25,'Tikart Andreas','2004-12-02 18:36:51'),(26,'Garfinkel Simon','2004-12-02 18:36:51'),(30,'DuBois Paul','2004-12-02 18:36:51'),(37,'Theodor Kallifatides','2004-12-02 18:36:51'),(38,'Goosens Michael','2004-12-02 18:36:51'),(39,'Rahtz Sebastian','2004-12-02 18:36:51'),(47,'Pollack Martin','2004-12-02 18:36:51'),(48,'Gilmore W.J.','2004-12-02 18:36:51'),(51,'Wellington Luke','2004-12-02 18:36:51'),(52,'Thomson Laura','2004-12-02 18:36:51'),(53,'Monjiam Bruce','2004-12-02 18:36:51'),(55,'Mankell Henning','2004-12-02 18:36:51'),(56,'Krüger Guido','2004-12-02 18:36:51'),(57,'Knausgård Karl Ove','2004-12-02 18:36:51'),(58,'Suter Martin','2004-12-02 18:36:51'),(60,'Öggl Bernd','2004-12-02 18:36:51'),(62,'Asimov Isaac','2004-12-02 18:36:51'),(64,'Laborenz Kai','2004-12-02 18:36:51'),(65,'Wolfgarten Sebastian','2004-12-02 18:36:51'),(66,'Atwood Margaret','2004-12-02 18:36:51'),(67,'Bear Greg','2004-12-02 18:36:51'),(68,'Coetzee J. M.','2004-12-02 18:36:51'),(69,'Gardell Jonas','2004-12-02 18:36:51'),(70,'Ibsen Henrik','2004-12-02 18:36:51'),(71,'Johnson Eyvind','2004-12-02 18:36:51'),(73,'Nesser Håkan','2004-12-02 18:36:51'),(74,'Riel Joern','2004-12-02 18:36:51'),(75,'Söderberg Hjalmar','2004-12-02 18:36:51'),(76,'Saramago Jose','2004-12-02 18:36:51'),(77,'van Heijden Adrianus Fr. Th.','2004-12-02 18:36:51'),(78,'Hauser Tobias','2004-12-02 18:36:51'),(81,'Lendecke Volker','2004-12-02 18:36:51'),(82,'Eller Frank','2004-12-02 18:36:51'),(83,'Schwichtenberg Holger','2004-12-02 18:36:51'),(86,'Wall Larry','2005-01-28 11:39:31'),(87,'Christiansen Tom','2005-01-28 11:39:31'),(88,'Orwant Jon','2005-01-28 11:39:31'),(89,'Gräbe Hans-Gert','2005-02-24 17:55:47');
UNLOCK TABLES;
/*!40000 ALTER TABLE `authors` ENABLE KEYS */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `catID` int(11) NOT NULL auto_increment,
  `catName` varchar(60) collate latin1_german1_ci NOT NULL default '',
  `parentCatID` int(11) default NULL,
  `ts` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`catID`),
  KEY `catName` (`catName`),
  KEY `parentCatID` (`parentCatID`),
  CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`parentCatID`) REFERENCES `categories` (`catID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;

--
-- Dumping data for table `categories`
--


/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
LOCK TABLES `categories` WRITE;
INSERT INTO `categories` VALUES (1,'Computer books',11,'2004-12-02 18:37:20'),(2,'Databases',1,'2004-12-02 18:37:20'),(3,'Programming',1,'2004-12-02 18:37:20'),(4,'Relational Databases',2,'2004-12-02 18:37:20'),(5,'Object-oriented databases',2,'2004-12-02 18:37:20'),(6,'PHP',3,'2004-12-02 18:37:20'),(7,'Perl',3,'2004-12-02 18:37:20'),(8,'SQL',2,'2004-12-02 18:37:20'),(9,'Children\'s books',11,'2004-12-02 18:37:20'),(10,'Literature and fiction',11,'2004-12-02 18:37:20'),(11,'All books',NULL,'2004-12-02 18:37:20'),(34,'MySQL',2,'2004-12-02 18:37:20'),(36,'LaTeX, TeX',1,'2004-12-02 18:37:20'),(50,'Java',3,'2004-12-02 18:37:20'),(51,'Visual Basic',3,'2004-12-02 18:37:20'),(52,'VBA',3,'2004-12-02 18:37:20'),(53,'C#',3,'2004-12-02 18:37:20'),(54,'C',3,'2004-12-02 18:37:20'),(55,'C++',3,'2004-12-02 18:37:20'),(56,'Operating Systems',1,'2004-12-02 18:37:20'),(57,'Linux',56,'2004-12-02 18:37:20'),(58,'Mac OS',56,'2004-12-02 18:37:20'),(59,'Windows',56,'2004-12-02 18:37:20'),(60,'Visual Basic .NET',3,'2004-12-02 18:37:20'),(64,'Sience Fiction',10,'2004-12-02 18:37:20'),(65,'Fantasy',10,'2004-12-02 18:37:20'),(66,'History',10,'2004-12-02 18:37:20'),(77,'PostgreSQL',2,'2004-12-02 18:37:20'),(86,'Microsoft Access',2,'2004-12-02 18:37:20'),(87,'SQLite',2,'2004-12-02 18:37:20');
UNLOCK TABLES;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;

--
-- Table structure for table `fullauthors`
--

DROP TABLE IF EXISTS `fullauthors`;
CREATE TABLE `fullauthors` (
  `authName` varchar(60) character set latin1 collate latin1_german1_ci NOT NULL default '',
  `authID` int(11) NOT NULL default '0',
  FULLTEXT KEY `authName` (`authName`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `fullauthors`
--


/*!40000 ALTER TABLE `fullauthors` DISABLE KEYS */;
LOCK TABLES `fullauthors` WRITE;
INSERT INTO `fullauthors` VALUES ('Asimov Isaac',62),('Atwood Margaret',66),('Bear Greg',67),('Bitsch Gerhard',22),('Coetzee J. M.',68),('Darween Hugh',16),('Date Chris',15),('DuBois Paul',30),('Edwards Jeri',5),('Eller Frank',82),('Gardell Jonas',69),('Garfinkel Simon',26),('Gerken Till',7),('Gilmore W.J.',48),('Goosens Michael',38),('Harkey Dan',4),('Hauser Tobias',78),('Holz Helmut',23),('Ibsen Henrik',70),('Johnson Eyvind',71),('King Tim',14),('Knausgård Karl Ove',57),('Kofler Michael',1),('Komma Michael',21),('Kopka Helmut',20),('Kramer David',2),('Krause Jörg',17),('Krüger Guido',56),('Laborenz Kai',64),('Lendecke Volker',81),('Mankell Henning',55),('Monjiam Bruce',53),('Nesser Håkan',73),('Öggl Bernd',60),('Orfali Robert',3),('Pohl Peter',19),('Pollack Martin',47),('Rahtz Sebastian',39),('Ratschiller Tobias',6),('Reese Georg',13),('Riel Joern',74),('Saramago Jose',76),('Schmitt Bernd',24),('Schwichtenberg Holger',83),('Söderberg Hjalmar',75),('Suter Martin',58),('Theodor Kallifatides',37),('Thomson Laura',52),('Tikart Andreas',25),('van Heijden Adrianus Fr. Th.',77),('Wellington Luke',51),('Wolfgarten Sebastian',65),('Yarger Randy Jay',12);
UNLOCK TABLES;
/*!40000 ALTER TABLE `fullauthors` ENABLE KEYS */;

--
-- Table structure for table `fulltitles`
--

DROP TABLE IF EXISTS `fulltitles`;
CREATE TABLE `fulltitles` (
  `titleID` int(11) NOT NULL default '0',
  `title` varchar(100) character set latin1 collate latin1_german1_ci NOT NULL default '',
  `subtitle` varchar(100) character set latin1 collate latin1_german1_ci default NULL,
  `authors` varchar(255) character set latin1 collate latin1_german1_ci default NULL,
  FULLTEXT KEY `title` (`title`,`subtitle`,`authors`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `fulltitles`
--


/*!40000 ALTER TABLE `fulltitles` DISABLE KEYS */;
LOCK TABLES `fulltitles` WRITE;
INSERT INTO `fulltitles` VALUES (1,'Linux','Installation, Konfiguration, Anwendung','Kofler Michael'),(2,'The Definitive Guide to Excel VBA',NULL,'Kofler Michael, Kramer David'),(3,'Client/Server Survival Guide',NULL,'Edwards Jeri, Harkey Dan, Orfali Robert'),(4,'Web Application Development with PHP 4.0',NULL,'Gerken Till, Ratschiller Tobias'),(7,'MySQL','','DuBois Paul'),(9,'MySQL & mSQL',NULL,'King Tim, Reese Georg, Yarger Randy Jay'),(11,'A Guide to the SQL Standard',NULL,'Darween Hugh, Date Chris'),(13,'Visual Basic 6','Programmiertechniken, Datenbanken, Internet','Kofler Michael'),(14,'Excel 2000 programmieren',NULL,'Kofler Michael'),(17,'PHP - Grundlagen und Lösungen','Webserver-Programmierung unter Windows und Linux','Krause Jörg'),(18,'Nennen wir ihn Anna',NULL,'Pohl Peter'),(19,'Alltid den där Annette',NULL,'Pohl Peter'),(20,'Jag saknar dig, jag saknar dig',NULL,'Pohl Peter'),(21,'LaTeX',NULL,'Kopka Helmut'),(22,'Mathematica','Einführung, Anwendung, Referenz','Kofler Michael'),(23,'Maple',NULL,'Bitsch Gerhard, Kofler Michael, Komma Michael'),(24,'VBA-Programmierung mit Excel 7',NULL,'Kofler Michael'),(25,'Linux für Internet und Intranet',NULL,'Holz Helmut, Schmitt Bernd, Tikart Andreas'),(27,'Practical UNIX & Internet security',NULL,'Garfinkel Simon'),(30,'Visual Basic Datenbankprogrammierung','Client/Server-Systeme','Kofler Michael'),(32,'Ute av verden',NULL,'Knausgård Karl Ove'),(33,'MySQL','Installation, Programmierung, Referenz','Kofler Michael'),(34,'MySQL',NULL,'Kofler Michael, Kramer David'),(41,'PHP 4',NULL,'Krause Jörg'),(42,'Kärleken',NULL,'Theodor Kallifatides'),(43,'Mit LaTeX ins Web','Elektronisches Publizieren mit TeX, HTML und XML','Goosens Michael, Rahtz Sebastian'),(51,'Anklage Vatermord','Der Fall Philipp Halsmann','Pollack Martin'),(52,'A Programmer\'s Introduction to PHP 4.0',NULL,'Gilmore W.J.'),(58,'Linux','Installation, Konfiguration, Anwendung','Kofler Michael'),(59,'PHP and MySQL Web Development',NULL,'Thomson Laura, Wellington Luke'),(60,'MySQL Cookbook','Solutions and Examples for MySQL Database Developers','DuBois Paul'),(61,'PostgreSQL','Einführung und Konzepte','Monjiam Bruce'),(63,'Comédia Infantil',NULL,'Mankell Henning'),(64,'Hunderna i Riga',NULL,'Mankell Henning'),(65,'Java','Handbuch der Java-Programmierung','Krüger Guido'),(66,'Ein perfekter Freund',NULL,'Suter Martin'),(67,'Linux im Büro','Jetzt lerne ich ...','Kofler Michael'),(68,'PHP 5 und MySQL 5','Grundlagen, Programmiertechniken, Beispiele','Kofler Michael, Öggl Bernd'),(69,'Visual C#','Grundlagen, Programmiertechniken, Windows-Anwendungen','Eller Frank, Kofler Michael'),(70,'Excel-VBA programmieren',NULL,'Kofler Michael'),(71,'Visual Basic .NET','Grundlagen, Programmiertechniken, Windows-Anwendungen','Kofler Michael'),(72,'I, Robot',NULL,'Asimov Isaac'),(75,'The Definitive Guide to MySQL',NULL,'Kofler Michael, Kramer David'),(77,'CSS-Praxis',NULL,'Laborenz Kai'),(78,'Apache Webserver 2.0','Installation, Konfiguration, Programmierung','Wolfgarten Sebastian'),(79,'Oryx and Crake',NULL,'Atwood Margaret'),(80,'Darwins Radio',NULL,'Bear Greg'),(81,'Disgrace',NULL,'Coetzee J. M.'),(82,'Life and Times of Michael K',NULL,'Coetzee J. M.'),(83,'Oskuld och andra texter',NULL,'Gardell Jonas'),(84,'Gengångare',NULL,'Ibsen Henrik'),(85,'Grupp Krilon',NULL,'Johnson Eyvind'),(86,'Dansläraren Återkomst',NULL,'Mankell Henning'),(87,'Och Picadilly Circus ligger inter i Kumla',NULL,'Nesser Håkan'),(88,'Nicht alle Eisbären halten Winterschlaf',NULL,'Riel Joern'),(89,'Das Haus meiner Väter',NULL,'Riel Joern'),(90,'Doktor Glas',NULL,'Söderberg Hjalmar'),(91,'Die Stadt der Blinden',NULL,'Saramago Jose'),(92,'Das Zentrum',NULL,'Saramago Jose'),(93,'Ein Tag, ein Leben',NULL,'van Heijden Adrianus Fr. Th.'),(94,'JavaScript','Interaktives und dynamisches Webpublishing','Hauser Tobias'),(95,'Windows Forms','dotnet essentials','Kofler Michael'),(97,'Samba',NULL,'Lendecke Volker'),(98,'Programmieren mit der .NET-Klassenbibliothek',NULL,'Eller Frank, Schwichtenberg Holger'),(99,'Programmieren mit der .NET-Klassenbibliothek, 2. Aufl.',NULL,'Eller Frank, Schwichtenberg Holger'),(101,'Das Atari ST Grafikbuch',NULL,'Kofler Michael');
UNLOCK TABLES;
/*!40000 ALTER TABLE `fulltitles` ENABLE KEYS */;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
CREATE TABLE `languages` (
  `langID` int(11) NOT NULL auto_increment,
  `langName` varchar(40) collate latin1_german1_ci NOT NULL default '',
  `ts` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`langID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;

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
  `publName` varchar(60) collate latin1_german1_ci NOT NULL default '',
  `ts` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`publID`),
  KEY `publName` (`publName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;

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
  CONSTRAINT `rel_title_author_ibfk_1` FOREIGN KEY (`authID`) REFERENCES `authors` (`authID`),
  CONSTRAINT `rel_title_author_ibfk_2` FOREIGN KEY (`titleID`) REFERENCES `titles` (`titleID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;

--
-- Dumping data for table `rel_title_author`
--


/*!40000 ALTER TABLE `rel_title_author` DISABLE KEYS */;
LOCK TABLES `rel_title_author` WRITE;
INSERT INTO `rel_title_author` VALUES (1,1,'2004-12-02 18:37:09'),(2,1,'2004-12-02 18:37:09'),(2,2,'2004-12-02 18:37:09'),(3,3,'2005-02-24 10:46:37'),(3,4,'2005-02-24 10:46:37'),(3,5,'2005-02-24 10:46:37'),(4,6,'2004-12-02 18:37:09'),(4,7,'2004-12-02 18:37:09'),(7,30,'2004-12-02 18:37:09'),(9,12,'2004-12-02 18:37:09'),(9,13,'2004-12-02 18:37:09'),(9,14,'2004-12-02 18:37:09'),(11,15,'2004-12-02 18:37:09'),(11,16,'2004-12-02 18:37:09'),(13,1,'2004-12-02 18:37:09'),(14,1,'2004-12-02 18:37:09'),(17,17,'2004-12-02 18:37:09'),(18,19,'2004-12-02 18:37:09'),(19,19,'2004-12-02 18:37:09'),(20,19,'2004-12-02 18:37:09'),(21,20,'2004-12-02 18:37:09'),(22,1,'2005-02-24 18:01:59'),(22,89,'2005-02-24 18:01:59'),(23,1,'2004-12-02 18:37:09'),(23,21,'2004-12-02 18:37:09'),(23,22,'2004-12-02 18:37:09'),(24,1,'2004-12-02 18:37:09'),(25,23,'2004-12-02 18:37:09'),(25,24,'2004-12-02 18:37:09'),(25,25,'2004-12-02 18:37:09'),(27,26,'2004-12-02 18:37:09'),(30,1,'2004-12-02 18:37:09'),(32,57,'2004-12-02 18:37:09'),(33,1,'2004-12-02 18:37:09'),(34,1,'2004-12-02 18:37:09'),(34,2,'2004-12-02 18:37:09'),(41,17,'2004-12-02 18:37:09'),(42,37,'2004-12-02 18:37:09'),(43,38,'2004-12-02 18:37:09'),(43,39,'2004-12-02 18:37:09'),(51,47,'2004-12-02 18:37:09'),(52,48,'2004-12-02 18:37:09'),(58,1,'2004-12-02 18:37:09'),(59,51,'2004-12-02 18:37:09'),(59,52,'2004-12-02 18:37:09'),(60,30,'2004-12-02 18:37:09'),(61,53,'2004-12-02 18:37:09'),(63,55,'2004-12-02 18:37:09'),(64,55,'2004-12-02 18:37:09'),(65,56,'2004-12-02 18:37:09'),(66,58,'2004-12-02 18:37:09'),(67,1,'2004-12-02 18:37:09'),(68,1,'2004-12-02 18:37:09'),(68,60,'2004-12-02 18:37:09'),(69,1,'2004-12-02 18:37:09'),(69,82,'2004-12-02 18:37:09'),(70,1,'2004-12-02 18:37:09'),(71,1,'2004-12-02 18:37:09'),(72,62,'2004-12-02 18:37:09'),(75,1,'2004-12-02 18:37:09'),(75,2,'2004-12-02 18:37:09'),(77,64,'2004-12-02 18:37:09'),(78,65,'2004-12-02 18:37:09'),(79,66,'2004-12-02 18:37:09'),(80,67,'2004-12-02 18:37:09'),(81,68,'2004-12-02 18:37:09'),(82,68,'2004-12-02 18:37:09'),(83,69,'2004-12-02 18:37:09'),(84,70,'2004-12-02 18:37:09'),(85,71,'2004-12-02 18:37:09'),(86,55,'2004-12-02 18:37:09'),(87,73,'2004-12-02 18:37:09'),(88,74,'2004-12-02 18:37:09'),(89,74,'2004-12-02 18:37:09'),(90,75,'2004-12-02 18:37:09'),(91,76,'2004-12-02 18:37:09'),(92,76,'2004-12-02 18:37:09'),(93,77,'2004-12-02 18:37:09'),(94,78,'2004-12-02 18:37:09'),(95,1,'2004-12-02 18:37:09'),(97,81,'2004-12-02 18:37:09'),(98,82,'2004-12-02 18:37:09'),(98,83,'2004-12-02 18:37:09'),(99,82,'2004-12-02 18:37:09'),(99,83,'2004-12-02 18:37:09'),(101,1,'2004-12-02 18:37:09'),(109,86,'2005-01-28 11:39:30'),(109,87,'2005-01-28 11:39:30'),(109,88,'2005-01-28 11:39:30');
UNLOCK TABLES;
/*!40000 ALTER TABLE `rel_title_author` ENABLE KEYS */;

--
-- Table structure for table `titles`
--

DROP TABLE IF EXISTS `titles`;
CREATE TABLE `titles` (
  `titleID` int(11) NOT NULL auto_increment,
  `title` varchar(100) collate latin1_german1_ci NOT NULL default '',
  `subtitle` varchar(100) collate latin1_german1_ci default NULL,
  `edition` tinyint(4) default NULL,
  `publID` int(11) default NULL,
  `catID` int(11) default NULL,
  `langID` int(11) default NULL,
  `year` int(11) default NULL,
  `isbn` varchar(20) collate latin1_german1_ci default NULL,
  `comment` varchar(255) collate latin1_german1_ci default NULL,
  `ts` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `authors` varchar(255) collate latin1_german1_ci default NULL,
  PRIMARY KEY  (`titleID`),
  KEY `publIdIndex` (`publID`),
  KEY `langID` (`langID`),
  KEY `catID` (`catID`),
  KEY `title` (`title`),
  CONSTRAINT `titles_ibfk_1` FOREIGN KEY (`publID`) REFERENCES `publishers` (`publID`),
  CONSTRAINT `titles_ibfk_2` FOREIGN KEY (`langID`) REFERENCES `languages` (`langID`),
  CONSTRAINT `titles_ibfk_3` FOREIGN KEY (`catID`) REFERENCES `categories` (`catID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;

--
-- Dumping data for table `titles`
--


/*!40000 ALTER TABLE `titles` DISABLE KEYS */;
LOCK TABLES `titles` WRITE;
INSERT INTO `titles` VALUES (1,'Linux','Installation, Konfiguration, Anwendung',5,1,57,2,2000,NULL,NULL,'2005-02-28 13:34:21','Kofler Michael'),(2,'The Definitive Guide to Excel VBA',NULL,NULL,2,3,NULL,2000,NULL,NULL,'2005-02-28 13:34:22','Kofler Michael; Kramer David'),(3,'Client/Server Survival Guide',NULL,NULL,1,2,NULL,1997,NULL,NULL,'2005-02-28 13:34:22','Edwards Jeri; Harkey Dan; Orfali Robert'),(4,'Web Application Development with PHP 4.0',NULL,NULL,3,6,NULL,2000,NULL,NULL,'2005-02-28 13:34:22','Gerken Till; Ratschiller Tobias'),(7,'MySQL','',0,3,34,NULL,2000,'','','2005-02-28 13:34:22','DuBois Paul'),(9,'MySQL & mSQL',NULL,NULL,4,34,NULL,1999,NULL,NULL,'2005-02-28 13:34:22','King Tim; Reese Georg; Yarger Randy Jay'),(11,'A Guide to the SQL Standard',NULL,NULL,1,8,1,1997,NULL,NULL,'2005-02-28 13:34:22','Darween Hugh; Date Chris'),(13,'Visual Basic 6','Programmiertechniken, Datenbanken, Internet',NULL,1,51,2,1998,NULL,NULL,'2005-02-28 13:34:22','Kofler Michael'),(14,'Excel 2000 programmieren',NULL,4,1,3,2,NULL,NULL,NULL,'2005-02-28 13:34:22','Kofler Michael'),(17,'PHP - Grundlagen und Lösungen','Webserver-Programmierung unter Windows und Linux',NULL,5,6,2,NULL,NULL,NULL,'2005-02-28 13:34:22','Krause Jörg'),(18,'Nennen wir ihn Anna',NULL,NULL,NULL,9,2,NULL,NULL,NULL,'2005-02-28 13:34:22','Pohl Peter'),(19,'Alltid den där Annette',NULL,NULL,NULL,9,3,NULL,NULL,NULL,'2005-02-28 13:34:22','Pohl Peter'),(20,'Jag saknar dig, jag saknar dig',NULL,NULL,NULL,9,3,NULL,NULL,NULL,'2005-02-28 13:34:22','Pohl Peter'),(21,'LaTeX',NULL,NULL,1,36,2,2000,NULL,NULL,'2005-02-28 13:34:22','Kopka Helmut'),(22,'Mathematica','Einführung, Anwendung, Referenz',4,1,1,2,1998,'3827312086','CAS','2005-02-28 13:34:22','Gräbe Hans-Gert; Kofler Michael'),(23,'Maple',NULL,4,1,1,2,2001,NULL,'CAS','2005-02-28 13:34:22','Bitsch Gerhard; Kofler Michael; Komma Michael'),(24,'VBA-Programmierung mit Excel 7',NULL,NULL,1,3,2,NULL,NULL,NULL,'2005-02-28 13:34:22','Kofler Michael'),(25,'Linux für Internet und Intranet',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2005-02-28 13:34:22','Holz Helmut; Schmitt Bernd; Tikart Andreas'),(27,'Practical UNIX & Internet Security',NULL,2,4,1,1,1996,'1565921488',NULL,'2005-02-28 13:34:22','Garfinkel Simon'),(30,'Visual Basic Datenbankprogrammierung','Client/Server-Systeme',1,1,2,2,1999,NULL,NULL,'2005-02-28 13:34:22','Kofler Michael'),(32,'Ute av verden',NULL,NULL,NULL,10,4,1998,NULL,NULL,'2005-02-28 13:34:22','Knausgård Karl Ove'),(33,'MySQL','Installation, Programmierung, Referenz',1,1,34,2,2001,'3827317622',NULL,'2005-02-28 13:34:22','Kofler Michael'),(34,'MySQL',NULL,1,2,34,1,2001,NULL,'translation','2005-02-28 13:34:22','Kofler Michael; Kramer David'),(41,'PHP 4',NULL,NULL,NULL,6,2,NULL,'3-446-21546-8',NULL,'2005-02-28 13:34:22','Krause Jörg'),(42,'Kärleken',NULL,NULL,9,10,3,1978,NULL,NULL,'2005-02-28 13:34:22','Theodor Kallifatides'),(43,'Mit LaTeX ins Web','Elektronisches Publizieren mit TeX, HTML und XML',NULL,1,36,2,2000,NULL,NULL,'2005-02-28 13:34:22','Goosens Michael; Rahtz Sebastian'),(51,'Anklage Vatermord','Der Fall Philipp Halsmann',1,16,10,2,2002,'3552052062',NULL,'2005-02-28 13:34:22','Pollack Martin'),(52,'A Programmer\'s Introduction to PHP 4.0',NULL,NULL,2,6,1,NULL,NULL,NULL,'2005-02-28 13:34:22','Gilmore W.J.'),(58,'Linux','Installation, Konfiguration, Anwendung',6,1,57,2,2001,NULL,NULL,'2005-02-28 13:34:22','Kofler Michael'),(59,'PHP and MySQL Web Development',NULL,NULL,NULL,6,1,NULL,NULL,NULL,'2005-02-28 13:34:22','Thomson Laura; Wellington Luke'),(60,'MySQL Cookbook','Solutions and Examples for MySQL Database Developers',NULL,4,34,1,2003,NULL,NULL,'2005-02-28 13:34:22','DuBois Paul'),(61,'PostgreSQL','Einführung und Konzepte',NULL,1,4,2,NULL,NULL,NULL,'2005-02-28 13:34:22','Monjiam Bruce'),(63,'Comédia Infantil',NULL,NULL,17,10,3,NULL,'9173246433',NULL,'2005-02-28 13:34:22','Mankell Henning'),(64,'Hunderna i Riga',NULL,NULL,17,10,3,NULL,'9173246549).',NULL,'2005-02-28 13:34:22','Mankell Henning'),(65,'Java','Handbuch der Java-Programmierung',NULL,1,3,2,2002,NULL,NULL,'2005-02-28 13:34:22','Krüger Guido'),(66,'Ein perfekter Freund',NULL,NULL,19,10,2,NULL,NULL,NULL,'2005-02-28 13:34:22','Suter Martin'),(67,'Linux im Büro','Jetzt lerne ich ...',1,20,57,2,2004,NULL,NULL,'2005-02-28 13:34:22','Kofler Michael'),(68,'PHP 5 und MySQL 5','Grundlagen, Programmiertechniken, Beispiele',1,1,6,2,2005,NULL,NULL,'2005-02-28 13:34:22','Kofler Michael; Öggl Bernd'),(69,'Visual C#','Grundlagen, Programmiertechniken, Windows-Anwendungen',1,1,53,2,2003,NULL,NULL,'2005-02-28 13:34:22','Eller Frank; Kofler Michael'),(70,'Excel-VBA programmieren',NULL,6,1,3,2,2004,NULL,NULL,'2005-02-28 13:34:22','Kofler Michael'),(71,'Visual Basic .NET','Grundlagen, Programmiertechniken, Windows-Anwendungen',1,1,60,2,2002,NULL,NULL,'2005-02-28 13:34:22','Kofler Michael'),(72,'I, Robot',NULL,NULL,NULL,64,1,NULL,NULL,NULL,'2005-02-28 13:34:22','Asimov Isaac'),(75,'The Definitive Guide to MySQL',NULL,2,2,34,1,2003,NULL,NULL,'2005-02-28 13:34:22','Kofler Michael; Kramer David'),(77,'CSS-Praxis',NULL,2,21,1,2,2004,NULL,NULL,'2005-02-28 13:34:22','Laborenz Kai'),(78,'Apache Webserver 2.0','Installation, Konfiguration, Programmierung',1,1,1,2,2003,NULL,NULL,'2005-02-28 13:34:22','Wolfgarten Sebastian'),(79,'Oryx and Crake',NULL,1,NULL,64,1,2003,NULL,NULL,'2005-02-28 13:34:22','Atwood Margaret'),(80,'Darwin\'s Radio',NULL,NULL,NULL,64,1,NULL,NULL,NULL,'2005-02-28 13:34:22','Bear Greg'),(81,'Disgrace',NULL,1,NULL,10,1,NULL,NULL,NULL,'2005-02-28 13:34:22','Coetzee J. M.'),(82,'Life and Times of Michael K',NULL,1,NULL,10,1,NULL,NULL,NULL,'2005-02-28 13:34:22','Coetzee J. M.'),(83,'Oskuld och andra texter',NULL,NULL,NULL,10,3,NULL,NULL,NULL,'2005-02-28 13:34:22','Gardell Jonas'),(84,'Gengångare',NULL,NULL,NULL,10,3,NULL,NULL,NULL,'2005-02-28 13:34:22','Ibsen Henrik'),(85,'Grupp Krilon',NULL,NULL,NULL,10,3,NULL,NULL,NULL,'2005-02-28 13:34:22','Johnson Eyvind'),(86,'Dansläraren Återkomst',NULL,NULL,NULL,10,3,NULL,NULL,NULL,'2005-02-28 13:34:22','Mankell Henning'),(87,'Och Picadilly Circus ligger inte i Kumla',NULL,NULL,NULL,10,3,NULL,NULL,NULL,'2005-02-28 13:34:22','Nesser Håkan'),(88,'Nicht alle Eisbären halten Winterschlaf',NULL,NULL,NULL,10,2,NULL,NULL,NULL,'2005-02-28 13:34:22','Riel Joern'),(89,'Das Haus meiner Väter',NULL,NULL,NULL,10,2,NULL,NULL,NULL,'2005-02-28 13:34:22','Riel Joern'),(90,'Doktor Glas',NULL,NULL,NULL,10,3,NULL,NULL,NULL,'2005-02-28 13:34:22','Söderberg Hjalmar'),(91,'Die Stadt der Blinden',NULL,NULL,NULL,10,2,NULL,NULL,NULL,'2005-02-28 13:34:22','Saramago Jose'),(92,'Das Zentrum',NULL,NULL,NULL,10,2,NULL,NULL,NULL,'2005-02-28 13:34:22','Saramago Jose'),(93,'Ein Tag, ein Leben',NULL,NULL,NULL,10,2,NULL,NULL,NULL,'2005-02-28 13:34:22','van Heijden Adrianus Fr. Th.'),(94,'JavaScript','Interaktives und dynamisches Webpublishing',NULL,20,1,2,NULL,NULL,NULL,'2005-02-28 13:34:22','Hauser Tobias'),(95,'Windows Forms','dotnet essentials',NULL,1,60,2,2002,NULL,NULL,'2005-02-28 13:34:22','Kofler Michael'),(97,'Samba',NULL,NULL,23,57,2,2003,NULL,NULL,'2005-02-28 13:34:22','Lendecke Volker'),(98,'Programmieren mit der .NET-Klassenbibliothek',NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,'2005-02-28 13:34:22','Eller Frank; Schwichtenberg Holger'),(99,'Programmieren mit der .NET-Klassenbibliothek, 2. Aufl.',NULL,NULL,1,60,2,2003,NULL,NULL,'2005-02-28 13:34:22','Eller Frank; Schwichtenberg Holger'),(101,'Das Atari ST Grafikbuch',NULL,NULL,24,NULL,NULL,NULL,NULL,NULL,'2005-02-28 13:34:22','Kofler Michael'),(109,'Programming Perl',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2005-02-28 13:34:22','Christiansen Tom; Orwant Jon; Wall Larry');
UNLOCK TABLES;
/*!40000 ALTER TABLE `titles` ENABLE KEYS */;

--
-- Table structure for table `v1`
--

DROP TABLE IF EXISTS `v1`;

--
-- View structure for view `v1`
--

DROP VIEW IF EXISTS `v1`;
CREATE ALGORITHM=UNDEFINED VIEW `mylibrary`.`v1` AS select `mylibrary`.`titles`.`titleID` AS `titleID`,`mylibrary`.`titles`.`title` AS `title`,`mylibrary`.`titles`.`subtitle` AS `subtitle`,`mylibrary`.`titles`.`edition` AS `edition` from `mylibrary`.`titles`;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

