/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 10.1.38-MariaDB : Database - pedidos
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`pedidos` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `pedidos`;

/*Table structure for table `categorias` */

DROP TABLE IF EXISTS `categorias`;

CREATE TABLE `categorias` (
  `CATEGORIAID` int(11) NOT NULL,
  `NOMBRECAT` char(50) NOT NULL,
  PRIMARY KEY (`CATEGORIAID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `categorias` */

insert  into `categorias`(`CATEGORIAID`,`NOMBRECAT`) values (100,'CARNICOS'),(200,'LACTEOS'),(300,'LIMPIEZA'),(400,'HIGINE PERSONAL'),(500,'MEDICINAS'),(600,'COSMETICOS'),(700,'REVISTAS');

/*Table structure for table `clientes` */

DROP TABLE IF EXISTS `clientes`;

CREATE TABLE `clientes` (
  `CLIENTEID` int(11) NOT NULL,
  `CEDULA_RUC` char(10) NOT NULL,
  `NOMBRECIA` char(30) NOT NULL,
  `NOMBRECONTACTO` char(50) NOT NULL,
  `DIRECCIONCLI` char(50) NOT NULL,
  `FAX` char(12) DEFAULT NULL,
  `EMAIL` char(50) DEFAULT NULL,
  `CELULAR` char(12) DEFAULT NULL,
  `FIJO` char(12) DEFAULT NULL,
  PRIMARY KEY (`CLIENTEID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `clientes` */

insert  into `clientes`(`CLIENTEID`,`CEDULA_RUC`,`NOMBRECIA`,`NOMBRECONTACTO`,`DIRECCIONCLI`,`FAX`,`EMAIL`,`CELULAR`,`FIJO`) values (1,'1890786576','SUPERMERCADO ESTRELLA','JUAN ALBAN','AV.AMAZONAS',NULL,NULL,NULL,NULL),(2,'1298765477','EL ROSADO','MARIA CORDERO','AV.AEL INCA',NULL,NULL,NULL,NULL),(3,'1009876567','DISTRIBUIDORA PRENSA','PEDRO PINTO','EL PINAR',NULL,NULL,NULL,NULL),(4,'1876090006','SU TIENDA','PABLO PONCE','AV.AMAZONAS',NULL,NULL,NULL,NULL),(5,'1893456776','SUPERMERCADO DORADO','LORENA PAZ','AV.6 DICIEMBRE',NULL,NULL,NULL,NULL),(6,'1678999891','MI COMISARIATO','ROSARIO UTRERAS','AV.AMAZONAS',NULL,NULL,NULL,NULL),(7,'1244567888','SUPERMERCADO DESCUENTO','LETICIA ORTEGA','AV.LA PRENSA',NULL,NULL,NULL,NULL),(8,'1456799022','EL DESCUENTO','JUAN TORRES','AV.PATRIA',NULL,NULL,NULL,NULL),(9,'1845677777','DE LUISE','JORGE PARRA','AV.AMAZONAS',NULL,NULL,NULL,NULL),(10,'183445667','YARBANTRELLA','PABLO POLIT','AV.REPUBLICA',NULL,NULL,NULL,NULL);

/*Table structure for table `detalle_ordenes` */

DROP TABLE IF EXISTS `detalle_ordenes`;

CREATE TABLE `detalle_ordenes` (
  `ORDENID` int(11) NOT NULL,
  `DETALLEID` int(11) NOT NULL,
  `PRODUCTOID` int(11) NOT NULL,
  `CANTIDAD` int(11) NOT NULL,
  PRIMARY KEY (`ORDENID`,`DETALLEID`),
  KEY `FK_DETALLE__PROD_DETA_PRODUCTO` (`PRODUCTOID`),
  CONSTRAINT `FK_DETALLE__ORDEN_DET_ORDENES` FOREIGN KEY (`ORDENID`) REFERENCES `ordenes` (`ORDENID`),
  CONSTRAINT `FK_DETALLE__PROD_DETA_PRODUCTO` FOREIGN KEY (`PRODUCTOID`) REFERENCES `productos` (`PRODUCTOID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `detalle_ordenes` */

insert  into `detalle_ordenes`(`ORDENID`,`DETALLEID`,`PRODUCTOID`,`CANTIDAD`) values (1,1,1,2),(1,2,4,1),(1,3,6,1),(1,4,9,1),(2,1,10,10),(2,2,13,20),(3,1,3,10),(4,1,9,12),(5,1,1,14),(5,2,4,20),(6,1,3,12),(7,1,11,10),(8,1,2,10),(8,2,5,14),(8,3,7,10),(9,1,11,10),(10,1,1,5);

/*Table structure for table `empleados` */

DROP TABLE IF EXISTS `empleados`;

CREATE TABLE `empleados` (
  `EMPLEADOID` int(11) NOT NULL,
  `NOMBRE` char(30) DEFAULT NULL,
  `APELLIDO` char(30) DEFAULT NULL,
  `FECHA_NAC` date DEFAULT NULL,
  `REPORTA_A` int(11) DEFAULT NULL,
  `EXTENSION` int(11) DEFAULT NULL,
  PRIMARY KEY (`EMPLEADOID`),
  KEY `FK_EMPLEADO_REPORTA` (`REPORTA_A`),
  CONSTRAINT `FK_EMPLEADO_REPORTA` FOREIGN KEY (`REPORTA_A`) REFERENCES `empleados` (`EMPLEADOID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `empleados` */

insert  into `empleados`(`EMPLEADOID`,`NOMBRE`,`APELLIDO`,`FECHA_NAC`,`REPORTA_A`,`EXTENSION`) values (1,'JUAN','CRUZ','0000-00-00',NULL,231),(2,'MARIO','SANCHEZ','0000-00-00',1,144),(3,'VERONICA','ARIAS','0000-00-00',1,234),(4,'PABLO','CELY','0000-00-00',2,567),(5,'DIEGO','ANDRADE','0000-00-00',2,890),(6,'JUAN','ANDRADE','0000-00-00',3,230),(7,'MARIA','NOBOA','0000-00-00',3,261);

/*Table structure for table `ordenes` */

DROP TABLE IF EXISTS `ordenes`;

CREATE TABLE `ordenes` (
  `ORDENID` int(11) NOT NULL,
  `EMPLEADOID` int(11) NOT NULL,
  `CLIENTEID` int(11) NOT NULL,
  `FECHAORDEN` date NOT NULL,
  `DESCUENTO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ORDENID`),
  KEY `FK_ORDENES_CLIEN_ORD_CLIENTES` (`CLIENTEID`),
  KEY `FK_ORDENES_EMPLE_ORD_EMPLEADO` (`EMPLEADOID`),
  CONSTRAINT `FK_ORDENES_CLIEN_ORD_CLIENTES` FOREIGN KEY (`CLIENTEID`) REFERENCES `clientes` (`CLIENTEID`),
  CONSTRAINT `FK_ORDENES_EMPLE_ORD_EMPLEADO` FOREIGN KEY (`EMPLEADOID`) REFERENCES `empleados` (`EMPLEADOID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `ordenes` */

insert  into `ordenes`(`ORDENID`,`EMPLEADOID`,`CLIENTEID`,`FECHAORDEN`,`DESCUENTO`) values (1,3,4,'2017-06-07',5),(2,3,4,'2002-06-07',10),(3,4,5,'2005-06-07',6),(4,2,6,'2006-06-07',2),(5,2,7,'2009-06-07',NULL),(6,4,5,'2012-06-07',10),(7,2,5,'2014-06-07',10),(8,3,2,'2013-06-07',10),(9,3,2,'2017-06-07',3),(10,2,2,'2018-06-07',2);

/*Table structure for table `productos` */

DROP TABLE IF EXISTS `productos`;

CREATE TABLE `productos` (
  `PRODUCTOID` int(11) NOT NULL,
  `PROVEEDORID` int(11) NOT NULL,
  `CATEGORIAID` int(11) NOT NULL,
  `DESCRIPCION` char(50) DEFAULT NULL,
  `PRECIOUNIT` decimal(10,0) NOT NULL,
  `EXISTENCIA` int(11) NOT NULL,
  PRIMARY KEY (`PRODUCTOID`),
  KEY `FK_PRODUCTO_CATE_PROD_CATEGORI` (`CATEGORIAID`),
  KEY `FK_PRODUCTO_PROV_PROD_PROVEEDO` (`PROVEEDORID`),
  CONSTRAINT `FK_PRODUCTO_CATE_PROD_CATEGORI` FOREIGN KEY (`CATEGORIAID`) REFERENCES `categorias` (`CATEGORIAID`),
  CONSTRAINT `FK_PRODUCTO_PROV_PROD_PROVEEDO` FOREIGN KEY (`PROVEEDORID`) REFERENCES `proveedores` (`PROVEEDORID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `productos` */

insert  into `productos`(`PRODUCTOID`,`PROVEEDORID`,`CATEGORIAID`,`DESCRIPCION`,`PRECIOUNIT`,`EXISTENCIA`) values (1,10,100,'SALCHICHAS VIENESAS','3',200),(2,10,100,'SALAMI DE AJO','4',300),(3,10,100,'BOTON PARA ASADO','5',400),(4,20,100,'SALCHICHAS DE POLLO','3',200),(5,20,100,'JAMON DE POLLO','3',100),(6,30,200,'YOGURT NATURAL','4',80),(7,30,200,'LECHE CHOCOLATE','2',90),(8,40,200,'YOGURT DE SABORES','2',200),(9,40,200,'CREMA DE LECHE','4',30),(10,50,600,'BASE DE MAQUILLAJE','15',40),(11,50,600,'RIMMEL','13',20),(13,60,600,'SOMBRA DE OJOS','10',100);

/*Table structure for table `proveedores` */

DROP TABLE IF EXISTS `proveedores`;

CREATE TABLE `proveedores` (
  `PROVEEDORID` int(11) NOT NULL,
  `NOMBREPROV` char(50) NOT NULL,
  `CONTACTO` char(50) NOT NULL,
  `CELUPROV` char(12) DEFAULT NULL,
  `FIJOPROV` char(12) DEFAULT NULL,
  PRIMARY KEY (`PROVEEDORID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `proveedores` */

insert  into `proveedores`(`PROVEEDORID`,`NOMBREPROV`,`CONTACTO`,`CELUPROV`,`FIJOPROV`) values (10,'DON DIEGO','MANUEL ANDRADE','099234567','2124456'),(20,'PRONACA','JUAN PEREZ','0923434467','2124456'),(30,'TONY','JORGE BRITO','099234567','2124456'),(40,'MIRAFLORES','MARIA PAZ','098124498','2458799'),(50,'ALMAY','PEDRO GONZALEZ','097654567','2507190'),(60,'REVLON','MONICA SALAS','099245678','2609876'),(70,'YANBAL','BETY ARIAS','098124458','2450887'),(80,'CLEANER','MANUEL ANDRADE','099234567','2124456'),(90,'BAYER','MANUEL ANDRADE','099234567','2124456'),(110,'PALMOLIVE','MANUEL ANDRADE','099234567','2124456'),(120,'JURIS','MANUEL ANDRADE','099234567','2124456');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
