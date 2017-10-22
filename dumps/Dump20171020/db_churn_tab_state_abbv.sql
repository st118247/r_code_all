CREATE DATABASE  IF NOT EXISTS `db_churn` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `db_churn`;
-- MySQL dump 10.13  Distrib 5.7.19, for Linux (x86_64)
--
-- Host: localhost    Database: db_churn
-- ------------------------------------------------------
-- Server version	5.7.19-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tab_state_abbv`
--

DROP TABLE IF EXISTS `tab_state_abbv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tab_state_abbv` (
  `state` varchar(20) DEFAULT NULL,
  `abbrev` varchar(2) DEFAULT NULL,
  `region` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tab_state_abbv`
--

LOCK TABLES `tab_state_abbv` WRITE;
/*!40000 ALTER TABLE `tab_state_abbv` DISABLE KEYS */;
INSERT INTO `tab_state_abbv` VALUES ('Alabama','AL','south'),('Alaska','AK','west'),('Arizona','AZ','west'),('Arkansas','AR','south'),('California','CA','west'),('Colorado','CO','west'),('Connecticut','CT','northeast'),('Delaware','DE','south'),('Columbia','DC','south'),('Florida','FL','south'),('Georgia','GA','south'),('Hawaii','HI','west'),('Idaho','ID','west'),('Illinois','IL','midwest'),('Indiana','IN','midwest'),('Iowa','IA','midwest'),('Kansas','KS','midwest'),('Kentucky','KY','south'),('Louisiana','LA','south'),('Maine','ME','northeast'),('Maryland','MD','south'),('Massachusetts','MA','northeast'),('Michigan','MI','midwest'),('Minnesota','MN','midwest'),('Mississippi','MS','south'),('Missouri','MO','midwest'),('Montana','MT','west'),('Nebraska','NE','midwest'),('Nevada','NV','west'),('New Hampshire','NH','northeast'),('New Jersey','NJ','northeast'),('New Mexico','NM','west'),('New York','NY','northeast'),('North Carolina','NC','south'),('North Dakota','ND','midwest'),('Ohio','OH','midwest'),('Oklahoma','OK','south'),('Oregon','OR','west'),('Pennsylvania','PA','northeast'),('Rhode Island','RI','northeast'),('South Carolina','SC','south'),('South Dakota','SD','midwest'),('Tennessee','TN','south'),('Texas','TX','south'),('Utah','UT','west'),('Vermont','VT','northeast'),('Virginia','VA','south'),('Washington','WA','west'),('West Virginia','WV','south'),('Wisconsin','WI','midwest'),('Wyoming','WY','west');
/*!40000 ALTER TABLE `tab_state_abbv` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-10-20 14:50:55
