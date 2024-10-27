CREATE DATABASE  IF NOT EXISTS `sistema_pedido` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `sistema_pedido`;
-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: sistema_pedido
-- ------------------------------------------------------
-- Server version	5.7.36-log

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
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `CLIENTE_CODIGO` int(11) NOT NULL AUTO_INCREMENT,
  `CLIENTE_NOME` varchar(80) DEFAULT NULL,
  `CLIENTE_CIDADE` varchar(80) DEFAULT NULL,
  `CLIENTE_UF` char(2) DEFAULT NULL,
  PRIMARY KEY (`CLIENTE_CODIGO`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'Joao','Barueri','SP'),(2,'Maria','Barueri','SP'),(3,'Lucas','Osasco','SP'),(4,'Mario','Osasco','SP'),(5,'Leonardo','Itapevi','SP'),(6,'Marcos','Guarulhos','SP'),(7,'Giovana','Floarianópolis','SC'),(8,'Jamil','Frederico Westphalen','RS'),(9,'Manoela','Osasco','SP'),(10,'Givaldo','Itapevi','SP'),(11,'Noeli','Barueri','SP'),(12,'Lucas Fernandes','Osasco','SP'),(13,'Matheus','Sananduva','RS'),(14,'Jeane','Itapevi','SP'),(15,'Rose','Itapevi','SP'),(16,'Rosa','Osasco','SP'),(17,'Alberto','Barueri','SP'),(18,'Luiz','Barueri','SP'),(19,'Flavio','Osasco','SP'),(20,'Matheus Flavio','Rio de Janeiro','RJ');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `PEDIDO_NUMERO` int(11) NOT NULL,
  `CLIENTE_CODIGO` int(11) NOT NULL,
  `PEDIDO_DATAEMISSAO` date DEFAULT NULL,
  `PEDIDO_VALORTOTAL` decimal(14,2) DEFAULT NULL,
  PRIMARY KEY (`PEDIDO_NUMERO`),
  KEY `fk_PEDIDOS_CLIENTE_idx` (`CLIENTE_CODIGO`),
  CONSTRAINT `fk_PEDIDOS_CLIENTE` FOREIGN KEY (`CLIENTE_CODIGO`) REFERENCES `cliente` (`CLIENTE_CODIGO`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos_produtos`
--

DROP TABLE IF EXISTS `pedidos_produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos_produtos` (
  `PEDIDO_CODIGOITEM` int(11) NOT NULL AUTO_INCREMENT,
  `PEDIDO_NUMERO` int(11) NOT NULL,
  `PRODUTO_CODIGO` int(11) NOT NULL,
  `PEDIDOPRODUTO_QUANT` decimal(6,2) NOT NULL,
  `PEDIDOPRODUTO_VLRTOTAL` decimal(15,2) NOT NULL,
  `PEDIDOPRODUTO_VLRUNIT` decimal(6,2) NOT NULL,
  PRIMARY KEY (`PEDIDO_CODIGOITEM`,`PEDIDO_NUMERO`,`PRODUTO_CODIGO`),
  KEY `fk_PEDIDOS_PRODUTOS_PRODUTO1_idx` (`PRODUTO_CODIGO`),
  KEY `fk_PEDIDOS_PRODUTOS_PEDIDOS1_idx` (`PEDIDO_NUMERO`),
  CONSTRAINT `fk_PEDIDOS_PRODUTOS_PEDIDOS1` FOREIGN KEY (`PEDIDO_NUMERO`) REFERENCES `pedidos` (`PEDIDO_NUMERO`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_PEDIDOS_PRODUTOS_PRODUTO1` FOREIGN KEY (`PRODUTO_CODIGO`) REFERENCES `produto` (`PRODUTO_CODIGO`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos_produtos`
--

LOCK TABLES `pedidos_produtos` WRITE;
/*!40000 ALTER TABLE `pedidos_produtos` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedidos_produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto`
--

DROP TABLE IF EXISTS `produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto` (
  `PRODUTO_CODIGO` int(11) NOT NULL AUTO_INCREMENT,
  `PRODUTO_DESCRICAO` varchar(80) DEFAULT NULL,
  `PRODUTO_PRECOVENDA` decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (`PRODUTO_CODIGO`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto`
--

LOCK TABLES `produto` WRITE;
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;
INSERT INTO `produto` VALUES (1,'Tomate',5.00),(2,'Arroz',30.00),(3,'Feijão',20.00),(4,'Ketchup',8.00),(5,'Bolo',11.59),(6,'Farinha',11.40),(7,'Celular',1400.00),(8,'Caneca',200.00),(9,'Monitor',100.00),(10,'Teclado',200.00),(11,'Mouse',238.00),(12,'Geladeira',1400.00),(13,'Chocolate',3.50),(14,'Coberta',88.00),(15,'Janela',230.00),(16,'Travesseiro',50.00),(17,'Cama',1.50),(18,'Ventilador',99.99),(19,'Garrafa',12.98),(20,'Colher',5.00);
/*!40000 ALTER TABLE `produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'sistema_pedido'
--

--
-- Dumping routines for database 'sistema_pedido'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-27 18:46:17
