-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: shopkart_db
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `brand` varchar(50) DEFAULT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `quantity` int DEFAULT '0',
  `image` varchar(255) DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Wireless Headphones','boat','Noise cancelling wireless headphones',1500.00,9,'images/products/headphones.jpg',1),(2,'Cotton T-Shirt','H&M','Comfortable cotton round-neck t-shirt',300.00,0,'images/products/t-shirt.jpg',2),(3,'Non-Stick Pan','Prestige','24cm non-stick frying pan',899.00,20,'images/products/pan.jpg',3),(4,'Notebook Set','Classmate','Pack of 5 ruled notebooks',199.00,50,'images/products/notebook.jpg',4),(7,'Bluetooth Speaker','Boat','Portable speaker with deep bass',1999.00,19,'images/products/speaker.jpg',1),(8,'Smartwatch','Pro Plus','Fitness tracking smartwatch',2999.00,16,'images/products/smartwatch.jpg',1),(9,'Power Bank','Mi','10000mAh fast charging power bank',899.00,40,'images/products/powerbank.jpg',1),(10,'Denim Jacket','Levis','Classic blue denim jacket',3599.00,12,'images/products/denim.jpg',2),(11,'Running Shoes','Puma','Lightweight running shoes',1799.00,22,'images/products/s.jpg',2),(12,'Formal Shirt','Van Heusen','Slim fit formal shirt',1099.00,30,'images/products/formal.jpg',2),(13,'Electric Kettle','Prestige','1.5L stainless steel kettle',799.00,25,'images/products/kettle.jpg',3),(14,'Bedsheet Set','Bombay Dyeing','Cotton double bedsheet with pillow covers',1000.00,15,'images/products/bedsheet.jpg',3),(15,'Table Lamp','Philips','LED study table lamp',599.00,20,'images/products/lamp.jpg',3),(16,'Gel Pen Pack','Cello','Pack of 10 smooth gel pens',149.00,60,'images/products/pen.jpg',4),(17,'Sketchbook','Faber-Castell','A4 sketchbook, 100 pages',249.00,35,'images/products/sketchbook.jpg',4),(18,'Desk Organizer','Nataraj','Multi-compartment desk organizer',349.00,28,'images/products/deskorg.jpg',4);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-17 18:51:27
