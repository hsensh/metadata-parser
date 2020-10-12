-- MySQL dump 10.13  Distrib 8.0.18, for Win64 (x86_64)
--
-- Host: localhost    Database: testdb
-- ------------------------------------------------------
-- Server version	8.0.18

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `active` tinyint(1) DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'TestCustomer',18,0,'2020-05-03 21:51:29','2020-05-03 21:51:36');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `links`
--

DROP TABLE IF EXISTS `links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `links` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `links`
--

LOCK TABLES `links` WRITE;
/*!40000 ALTER TABLE `links` DISABLE KEYS */;
INSERT INTO `links` VALUES (1,'http://www.google.com'),(2,'http://www.google.com'),(3,'http://www.facebook.com'),(4,'http://www.twitter.com'),(5,'http://www.instagram.com');
/*!40000 ALTER TABLE `links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metas`
--

DROP TABLE IF EXISTS `metas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `link_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `metas_FK` (`link_id`),
  CONSTRAINT `metas_FK` FOREIGN KEY (`link_id`) REFERENCES `links` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metas`
--

LOCK TABLES `metas` WRITE;
/*!40000 ALTER TABLE `metas` DISABLE KEYS */;
INSERT INTO `metas` VALUES (1,'meta0',1),(2,'meta1',1),(3,'meta0',2),(4,'meta1',2),(5,'meta0',3),(6,'meta1',3),(7,'meta2',3),(8,'meta3',3),(9,'meta4',3),(10,'meta5',3),(11,'meta6',3),(12,'meta7',3),(13,'meta8',3),(14,'meta9',3),(15,'meta10',3),(16,'meta11',3),(17,'meta12',3),(18,'meta13',3),(19,'meta14',3),(20,'meta15',3),(21,'meta16',3),(22,'meta17',3),(23,'meta18',3),(24,'meta0',4),(25,'meta1',4),(26,'meta2',4),(27,'meta3',4),(28,'meta4',4),(29,'meta5',4),(30,'meta6',4),(31,'meta7',4),(32,'meta8',4),(33,'meta9',4),(34,'meta10',4),(35,'meta0',5),(36,'meta1',5),(37,'meta2',5),(38,'meta3',5),(39,'meta4',5),(40,'meta5',5),(41,'meta6',5),(42,'meta7',5),(43,'meta8',5),(44,'meta9',5),(45,'meta10',5),(46,'meta11',5),(47,'meta12',5),(48,'meta13',5),(49,'meta14',5),(50,'meta15',5),(51,'meta16',5),(52,'meta17',5),(53,'meta18',5);
/*!40000 ALTER TABLE `metas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pairs`
--

DROP TABLE IF EXISTS `pairs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pairs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `meta_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `value` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `meta_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pairs_FK` (`meta_id`),
  CONSTRAINT `pairs_FK` FOREIGN KEY (`meta_id`) REFERENCES `metas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pairs`
--

LOCK TABLES `pairs` WRITE;
/*!40000 ALTER TABLE `pairs` DISABLE KEYS */;
INSERT INTO `pairs` VALUES (1,'content','/images/branding/googleg/1x/googleg_standard_color_128dp.png',2),(2,'itemprop','image',2),(3,'content','/images/branding/googleg/1x/googleg_standard_color_128dp.png',4),(4,'itemprop','image',4),(5,'name','robots',23),(6,'content','noodp,noydir',23),(7,'http-equiv','origin-trial',34),(8,'content','Apir4chqTX+4eFxKD+ErQlKRB/VtZ/dvnLfd9Y9Nenl5r1xJcf81alryTHYQiuUlz9Q49MqGXqyaiSmqWzHUqQwAAABneyJvcmlnaW4iOiJodHRwczovL3R3aXR0ZXIuY29tOjQ0MyIsImZlYXR1cmUiOiJDb250YWN0c01hbmFnZXIiLCJleHBpcnkiOjE1NzUwMzUyODMsImlzU3ViZG9tYWluIjp0cnVlfQ==',34),(9,'content','Create an account or log in to Instagram - A simple, fun & creative way to capture, edit & share photos, videos & messages with friends & family.',53),(10,'name','description',53);
/*!40000 ALTER TABLE `pairs` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-12 16:02:55
