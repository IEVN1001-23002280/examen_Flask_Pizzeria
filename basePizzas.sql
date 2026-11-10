-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 10, 2026 at 01:56 AM
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
-- Table structure for table `clientes`
--

CREATE TABLE `clientes` (
  `idcliente` int NOT NULL,
  `nombre` varchar(60) NOT NULL,
  `telefono` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `clientes`
--

INSERT INTO `clientes` (`idcliente`, `nombre`, `telefono`) VALUES
(2, 'Angel', '4792021646'),
(3, 'Andres', '4778445103'),
(4, 'Roberto', '4975203164'),
(5, 'pedro', '47784451264'),
(6, 'Juan', '47845124'),
(7, 'Luis', '4775112302'),
(8, 'Romulo', '4795213164');

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
(1, 10, 'Chica', 'Piña', 3, 150),
(2, 11, 'Chica', 'Piña', 1, 50),
(3, 11, 'Chica', 'Champiñones', 1, 50),
(4, 11, 'Chica', 'Jamón', 2, 100),
(5, 12, 'Chica', 'Piña', 2, 100),
(6, 13, 'Mediana', 'Ninguno', 1, 80),
(7, 13, 'Chica', 'Piña', 1, 50),
(8, 13, 'Chica', 'Piña', 1, 50),
(9, 13, 'Chica', 'Champiñones', 1, 50),
(10, 14, 'Chica', 'Piña', 1, 50),
(11, 14, 'Chica', 'Champiñones', 1, 50),
(12, 14, 'Chica', 'Jamón', 1, 50),
(13, 15, 'Chica', 'Piña', 1, 50),
(14, 15, 'Chica', 'Piña', 1, 50),
(15, 15, 'Chica', 'Champiñones', 1, 50);

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
(6, 'Ramses', 'Baltierra 289', '4785102316', '2026-11-08', 270),
(7, 'Luis', 'Rancho 204', '4751235619', '2026-11-09', 6030),
(8, 'Angel', 'Manzanares 204', '4778552301', '2026-11-10', 50),
(9, 'Angel', 'Manzanares 203', '4792021646', '2026-11-10', 150),
(10, 'Andres', 'Gomez 203', '4778445103', '2026-11-10', 150),
(11, 'Roberto', 'Lima 510', '4975203164', '2026-11-10', 200),
(12, 'pedro', 'ppp201', '47784451264', '2026-11-10', 100),
(13, 'Juan', 'aaa 203', '47845124', '2026-11-10', 230),
(14, 'Luis', 'Lopez 203', '4775112302', '2026-11-10', 150),
(15, 'Romulo', 'Gote 201', '4795213164', '2026-11-10', 150);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`idcliente`);

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
-- AUTO_INCREMENT for table `clientes`
--
ALTER TABLE `clientes`
  MODIFY `idcliente` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `detalle_pedidos`
--
ALTER TABLE `detalle_pedidos`
  MODIFY `iddetalle` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `idpedido` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

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
