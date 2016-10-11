-- MySQL dump 10.9
--
-- Host: localhost    Database: exceptions
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
-- Table structure for table `access_test`
--

DROP TABLE IF EXISTS `access_test`;
CREATE TABLE `access_test` (
  `id` int(11) NOT NULL auto_increment,
  `ts` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `a_double` double default '0',
  `a_long_text` longtext,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `access_test`
--


/*!40000 ALTER TABLE `access_test` DISABLE KEYS */;
LOCK TABLES `access_test` WRITE;
INSERT INTO `access_test` VALUES (1,'2003-02-19 10:21:38',1,'abc'),(2,'2003-02-19 10:21:42',2,NULL);
UNLOCK TABLES;
/*!40000 ALTER TABLE `access_test` ENABLE KEYS */;

--
-- Table structure for table `exporttable`
--

DROP TABLE IF EXISTS `exporttable`;
CREATE TABLE `exporttable` (
  `id` int(11) NOT NULL default '0',
  `a_char` varchar(10) default NULL,
  `a_text` text,
  `a_blob` blob,
  `a_date` date default '0000-00-00',
  `a_time` time default '00:00:00',
  `a_timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `a_float` float default '0',
  `a_decimal` decimal(10,3) default '0.000',
  `a_enum` enum('a','b','c') default 'a',
  `a_set` set('e','f','g') default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `exporttable`
--


/*!40000 ALTER TABLE `exporttable` DISABLE KEYS */;
LOCK TABLES `exporttable` WRITE;
INSERT INTO `exporttable` VALUES (1,'char char','text text','blob blob','2001-12-31','12:30:00','2000-11-17 16:46:43',3.14159,'0.012','b','e,g'),(2,'\' \" \\ ; +','adsf',NULL,'2000-11-17','16:54:54','2000-11-17 16:54:54',-2.3e-37,'12.345','a','f,g');
UNLOCK TABLES;
/*!40000 ALTER TABLE `exporttable` ENABLE KEYS */;

--
-- Table structure for table `importtable1`
--

DROP TABLE IF EXISTS `importtable1`;
CREATE TABLE `importtable1` (
  `id` int(11) NOT NULL auto_increment,
  `a_number` double default '0',
  `a_date` datetime default '0000-00-00 00:00:00',
  `a_time` time default '00:00:00',
  `a_string` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `importtable1`
--


/*!40000 ALTER TABLE `importtable1` DISABLE KEYS */;
LOCK TABLES `importtable1` WRITE;
INSERT INTO `importtable1` VALUES (18,12.3,'0000-00-00 00:00:00','17:30:00','text'),(19,-0.0033,'2000-12-31 00:00:00','11:20:00','text in quotes'),(20,1,'0000-00-00 00:00:00','00:13:00','german text with ‰ˆ¸ﬂ'),(21,12.3,'0000-00-00 00:00:00','17:30:00','text'),(22,-0.0033,'2000-12-31 00:00:00','11:20:00','text in quotes'),(23,1,'0000-00-00 00:00:00','00:13:00','german text with ‰ˆ¸ﬂ');
UNLOCK TABLES;
/*!40000 ALTER TABLE `importtable1` ENABLE KEYS */;

--
-- Table structure for table `importtable2`
--

DROP TABLE IF EXISTS `importtable2`;
CREATE TABLE `importtable2` (
  `id` int(11) NOT NULL auto_increment,
  `a_blob` blob,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `importtable2`
--


/*!40000 ALTER TABLE `importtable2` DISABLE KEYS */;
LOCK TABLES `importtable2` WRITE;
INSERT INTO `importtable2` VALUES (1,NULL),(2,'NULL'),(3,NULL),(4,NULL),(5,'\n'),(6,'\n'),(7,'0x414243'),(8,'0x414243'),(9,'blob blob'),(10,'blob blob');
UNLOCK TABLES;
/*!40000 ALTER TABLE `importtable2` ENABLE KEYS */;

--
-- Table structure for table `test_blob`
--

DROP TABLE IF EXISTS `test_blob`;
CREATE TABLE `test_blob` (
  `id` int(11) NOT NULL auto_increment,
  `a_blob` blob,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `test_blob`
--


/*!40000 ALTER TABLE `test_blob` DISABLE KEYS */;
LOCK TABLES `test_blob` WRITE;
INSERT INTO `test_blob` VALUES (1,'\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ÄÅÇÉÑÖÜáàâäãåçéèêëíìîïñóòôöõúùûü†°¢£§•¶ß®©™´¨≠ÆØ∞±≤≥¥µ∂∑∏π∫ªºΩæø¿¡¬√ƒ≈∆«»… ÀÃÕŒœ–—“”‘’÷◊ÿŸ⁄€‹›ﬁﬂ‡·‚„‰ÂÊÁËÈÍÎÏÌÓÔÒÚÛÙıˆ˜¯˘˙˚¸˝˛ˇ\0	\n\r\Z !\"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~ÄÅÇÉÑÖÜáàâäãåçéèêëíìîïñóòôöõúùûü†°¢£§•¶ß®©™´¨≠ÆØ∞±≤≥¥µ∂∑∏π∫ªºΩæø¿¡¬√ƒ≈∆«»… ÀÃÕŒœ–—“”‘’÷◊ÿŸ⁄€‹›ﬁﬂ‡·‚„‰ÂÊÁËÈÍÎÏÌÓÔÒÚÛÙıˆ˜¯˘˙˚¸˝˛ˇ');
UNLOCK TABLES;
/*!40000 ALTER TABLE `test_blob` ENABLE KEYS */;

--
-- Table structure for table `test_date`
--

DROP TABLE IF EXISTS `test_date`;
CREATE TABLE `test_date` (
  `id` int(11) NOT NULL auto_increment,
  `a_date` date default NULL,
  `a_time` time default NULL,
  `a_datetime` datetime default NULL,
  `a_timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `test_date`
--


/*!40000 ALTER TABLE `test_date` DISABLE KEYS */;
LOCK TABLES `test_date` WRITE;
INSERT INTO `test_date` VALUES (1,'2005-12-31','23:59:59','2005-12-31 23:59:59','2005-12-31 23:59:59');
UNLOCK TABLES;
/*!40000 ALTER TABLE `test_date` ENABLE KEYS */;

--
-- Table structure for table `test_enum`
--

DROP TABLE IF EXISTS `test_enum`;
CREATE TABLE `test_enum` (
  `id` int(11) NOT NULL auto_increment,
  `a_enum` enum('a','b','c','d','e') default NULL,
  `a_set` set('a','b','c','d','e') default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `test_enum`
--


/*!40000 ALTER TABLE `test_enum` DISABLE KEYS */;
LOCK TABLES `test_enum` WRITE;
INSERT INTO `test_enum` VALUES (1,'a','a'),(2,'e','b,c,d'),(4,NULL,NULL);
UNLOCK TABLES;
/*!40000 ALTER TABLE `test_enum` ENABLE KEYS */;

--
-- Table structure for table `test_null`
--

DROP TABLE IF EXISTS `test_null`;
CREATE TABLE `test_null` (
  `id` int(11) NOT NULL auto_increment,
  `a_text` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `test_null`
--


/*!40000 ALTER TABLE `test_null` DISABLE KEYS */;
LOCK TABLES `test_null` WRITE;
INSERT INTO `test_null` VALUES (1,NULL),(2,''),(3,'a text'),(4,'?');
UNLOCK TABLES;
/*!40000 ALTER TABLE `test_null` ENABLE KEYS */;

--
-- Table structure for table `test_sort1`
--

DROP TABLE IF EXISTS `test_sort1`;
CREATE TABLE `test_sort1` (
  `id` int(11) default NULL,
  `latin1char` char(1) default NULL,
  `utf8char` char(1) character set utf8 default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `test_sort1`
--


/*!40000 ALTER TABLE `test_sort1` DISABLE KEYS */;
LOCK TABLES `test_sort1` WRITE;
INSERT INTO `test_sort1` VALUES (33,'!','!'),(34,'\"','\"'),(35,'#','#'),(36,'$','$'),(37,'%','%'),(38,'&','&'),(39,'\'','\''),(40,'(','('),(41,')',')'),(42,'*','*'),(43,'+','+'),(44,',',','),(45,'-','-'),(46,'.','.'),(47,'/','/'),(48,'0','0'),(49,'1','1'),(50,'2','2'),(51,'3','3'),(52,'4','4'),(53,'5','5'),(54,'6','6'),(55,'7','7'),(56,'8','8'),(57,'9','9'),(58,':',':'),(59,';',';'),(60,'<','<'),(61,'=','='),(62,'>','>'),(63,'?','?'),(64,'@','@'),(65,'A','A'),(66,'B','B'),(67,'C','C'),(68,'D','D'),(69,'E','E'),(70,'F','F'),(71,'G','G'),(72,'H','H'),(73,'I','I'),(74,'J','J'),(75,'K','K'),(76,'L','L'),(77,'M','M'),(78,'N','N'),(79,'O','O'),(80,'P','P'),(81,'Q','Q'),(82,'R','R'),(83,'S','S'),(84,'T','T'),(85,'U','U'),(86,'V','V'),(87,'W','W'),(88,'X','X'),(89,'Y','Y'),(90,'Z','Z'),(91,'[','['),(92,'\\','\\'),(93,']',']'),(94,'^','^'),(95,'_','_'),(96,'`','`'),(97,'a','a'),(98,'b','b'),(99,'c','c'),(100,'d','d'),(101,'e','e'),(102,'f','f'),(103,'g','g'),(104,'h','h'),(105,'i','i'),(106,'j','j'),(107,'k','k'),(108,'l','l'),(109,'m','m'),(110,'n','n'),(111,'o','o'),(112,'p','p'),(113,'q','q'),(114,'r','r'),(115,'s','s'),(116,'t','t'),(117,'u','u'),(118,'v','v'),(119,'w','w'),(120,'x','x'),(121,'y','y'),(122,'z','z'),(123,'{','{'),(124,'|','|'),(125,'}','}'),(126,'~','~'),(161,'°','°'),(162,'¢','¢'),(163,'£','£'),(164,'§','§'),(165,'•','•'),(166,'¶','¶'),(167,'ß','ß'),(168,'®','®'),(169,'©','©'),(170,'™','™'),(171,'´','´'),(172,'¨','¨'),(173,'≠','≠'),(174,'Æ','Æ'),(175,'Ø','Ø'),(176,'∞','∞'),(177,'±','±'),(178,'≤','≤'),(179,'≥','≥'),(180,'¥','¥'),(181,'µ','µ'),(182,'∂','∂'),(183,'∑','∑'),(184,'∏','∏'),(185,'π','π'),(186,'∫','∫'),(187,'ª','ª'),(188,'º','º'),(189,'Ω','Ω'),(190,'æ','æ'),(191,'ø','ø'),(192,'¿','¿'),(193,'¡','¡'),(194,'¬','¬'),(195,'√','√'),(196,'ƒ','ƒ'),(197,'≈','≈'),(198,'∆','∆'),(199,'«','«'),(200,'»','»'),(201,'…','…'),(202,' ',' '),(203,'À','À'),(204,'Ã','Ã'),(205,'Õ','Õ'),(206,'Œ','Œ'),(207,'œ','œ'),(208,'–','–'),(209,'—','—'),(210,'“','“'),(211,'”','”'),(212,'‘','‘'),(213,'’','’'),(214,'÷','÷'),(215,'◊','◊'),(216,'ÿ','ÿ'),(217,'Ÿ','Ÿ'),(218,'⁄','⁄'),(219,'€','€'),(220,'‹','‹'),(221,'›','›'),(222,'ﬁ','ﬁ'),(223,'ﬂ','ﬂ'),(224,'‡','‡'),(225,'·','·'),(226,'‚','‚'),(227,'„','„'),(228,'‰','‰'),(229,'Â','Â'),(230,'Ê','Ê'),(231,'Á','Á'),(232,'Ë','Ë'),(233,'È','È'),(234,'Í','Í'),(235,'Î','Î'),(236,'Ï','Ï'),(237,'Ì','Ì'),(238,'Ó','Ó'),(239,'Ô','Ô'),(240,'',''),(241,'Ò','Ò'),(242,'Ú','Ú'),(243,'Û','Û'),(244,'Ù','Ù'),(245,'ı','ı'),(246,'ˆ','ˆ'),(247,'˜','˜'),(248,'¯','¯'),(249,'˘','˘'),(250,'˙','˙'),(251,'˚','˚'),(252,'¸','¸'),(253,'˝','˝'),(254,'˛','˛'),(255,'ˇ','ˇ');
UNLOCK TABLES;
/*!40000 ALTER TABLE `test_sort1` ENABLE KEYS */;

--
-- Table structure for table `test_sort2`
--

DROP TABLE IF EXISTS `test_sort2`;
CREATE TABLE `test_sort2` (
  `id` int(11) NOT NULL auto_increment,
  `latin1text` varchar(100) character set latin1 collate latin1_german1_ci default NULL,
  `utf8text` varchar(100) character set utf8 default NULL,
  PRIMARY KEY  (`id`),
  KEY `latin1text` (`latin1text`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `test_sort2`
--


/*!40000 ALTER TABLE `test_sort2` DISABLE KEYS */;
LOCK TABLES `test_sort2` WRITE;
INSERT INTO `test_sort2` VALUES (1,'abc','abc'),(2,'Abc','Abc'),(3,'ABC','ABC'),(4,'Bar','Bar'),(5,'Barenboim','Barenboim'),(6,'B‰r','B‰r'),(7,'B‰ren','B‰ren'),(8,'b‰rtig','b‰rtig'),(9,'ƒrger','ƒrger');
UNLOCK TABLES;
/*!40000 ALTER TABLE `test_sort2` ENABLE KEYS */;

--
-- Table structure for table `testall`
--

DROP TABLE IF EXISTS `testall`;
CREATE TABLE `testall` (
  `id` int(11) NOT NULL auto_increment,
  `a_big_int` bigint(20) default '0',
  `a_char` varchar(10) default NULL,
  `a_text` text,
  `a_blob` blob,
  `a_date` date default '0000-00-00',
  `a_time` time default '00:00:00',
  `a_timestamp` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `a_float` float default '0',
  `a_decimal` decimal(10,3) default '0.000',
  `a_enum` enum('a','b','c') default 'a',
  `a_set` set('e','f','g') default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `testall`
--


/*!40000 ALTER TABLE `testall` DISABLE KEYS */;
LOCK TABLES `testall` WRITE;
INSERT INTO `testall` VALUES (1,0,'char char','text text','blob blob','2001-12-31','12:30:00','2000-11-17 16:46:43',3.14159,'0.012','b','e,g'),(2,0,'\' \" \\ ; +','adsf',NULL,'2000-11-17','16:54:54','2000-11-17 16:54:54',-2.3e-37,'12.345','a','f,g'),(3,0,NULL,NULL,NULL,NULL,'00:00:00','2003-02-14 08:11:03',0,'0.000','a',NULL),(4,1234567890123456,NULL,NULL,NULL,NULL,'00:00:00','2003-02-14 10:12:01',0,'0.000','a',NULL),(10,123,NULL,NULL,NULL,'0000-00-00','00:00:00','2003-02-14 10:29:25',0,'0.000','a',NULL),(11,0,NULL,NULL,NULL,'0000-00-00','00:00:00','2005-01-26 15:31:04',10,'0.000','a',NULL),(12,0,NULL,NULL,NULL,'0000-00-00','00:00:00','2005-01-26 15:31:23',10,'0.000','a',NULL),(13,0,NULL,NULL,NULL,'0000-00-00','00:00:00','2005-01-26 15:31:51',10,'0.000','a',NULL),(14,0,NULL,NULL,NULL,'0000-00-00','00:00:00','2005-01-26 15:32:28',10,'0.000','a',NULL),(15,0,NULL,NULL,NULL,'0000-00-00','00:00:00','2005-01-26 15:34:04',10,'0.000','a',NULL);
UNLOCK TABLES;
/*!40000 ALTER TABLE `testall` ENABLE KEYS */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

