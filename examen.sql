-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 08, 2026 at 09:26 AM
-- Server version: 8.4.3
-- PHP Version: 8.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `examen`
--

-- --------------------------------------------------------

--
-- Table structure for table `detalle_pedidos`
--

CREATE TABLE `detalle_pedidos` (
  `iddetalle` int NOT NULL,
  `idpedido` int NOT NULL,
  `tamano` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ingredientes` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `num_pizzas` int NOT NULL,
  `subtotal` decimal(60,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `detalle_pedidos`
--

INSERT INTO `detalle_pedidos` (`iddetalle`, `idpedido`, `tamano`, `ingredientes`, `num_pizzas`, `subtotal`) VALUES
(1, 1, 'Chica', 'Piña', 1, 50),
(2, 1, 'Chica', 'Champiñones', 2, 100),
(3, 1, 'Chica', 'Piña', 1, 50),
(4, 1, 'Chica', 'Ninguno', 1, 40),
(5, 1, 'Chica', 'Ninguno', 1, 40),
(6, 1, 'Chica', 'Ninguno', 1, 40),
(7, 1, 'Chica', 'Ninguno', 1, 40),
(8, 2, 'Chica', 'Piña', 4, 200),
(9, 3, 'Grande', 'Piña, Champiñones', 3, 420),
(10, 4, 'Mediana', 'Piña', 1, 90),
(11, 5, 'Mediana', 'Jamón, Piña', 2, 200),
(12, 6, 'Mediana', 'Jamón', 2, 180),
(13, 6, 'Mediana', 'Champiñones', 1, 90);

-- --------------------------------------------------------

--
-- Table structure for table `pedidos`
--

CREATE TABLE `pedidos` (
  `idpedido` int NOT NULL,
  `nombre` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `direccion` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefono` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `total` decimal(60,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `pedidos`
--

INSERT INTO `pedidos` (`idpedido`, `nombre`, `direccion`, `telefono`, `fecha`, `total`) VALUES
(1, 'Pedro', '5 de mayo', '477-787-23', '2026-11-08', 360),
(2, 'Hernan', 'Heroes 206', '4792021949', '2026-11-08', 200),
(3, 'Julio', 'utl 100', '4778556203', '2026-11-08', 420),
(4, 'Julian', 'Escobedo', '4774512030', '2026-11-08', 90),
(5, 'Armando', 'Torres 10', '4778552084', '2026-11-08', 200),
(6, 'Ramses', 'Baltierra 289', '4785102316', '2026-11-08', 270);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `detalle_pedidos`
--
ALTER TABLE `detalle_pedidos`
  ADD PRIMARY KEY (`iddetalle`),
  ADD KEY `fk_pedido` (`idpedido`);

--
-- Indexes for table `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`idpedido`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `detalle_pedidos`
--
ALTER TABLE `detalle_pedidos`
  MODIFY `iddetalle` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `idpedido` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detalle_pedidos`
--
ALTER TABLE `detalle_pedidos`
  ADD CONSTRAINT `fk_pedido` FOREIGN KEY (`idpedido`) REFERENCES `pedidos` (`idpedido`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
