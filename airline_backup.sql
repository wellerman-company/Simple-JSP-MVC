-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Tempo de geração: 07-Mar-2021 às 01:34
-- Versão do servidor: 5.7.31
-- versão do PHP: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `airline_backup`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `cities`
--

DROP TABLE IF EXISTS `cities`;
CREATE TABLE IF NOT EXISTS `cities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE IF NOT EXISTS `clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `users_id` int(11) NOT NULL,
  `image` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `users_clients_index` (`users_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `clients_flights`
--

DROP TABLE IF EXISTS `clients_flights`;
CREATE TABLE IF NOT EXISTS `clients_flights` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clients_id` int(11) NOT NULL,
  `flights_id` int(11) NOT NULL,
  `state` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `clients_clients_flights_index` (`clients_id`),
  KEY `flights_clients_flights_index` (`flights_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `employees`
--

DROP TABLE IF EXISTS `employees`;
CREATE TABLE IF NOT EXISTS `employees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `users_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `users_index` (`users_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `flights`
--

DROP TABLE IF EXISTS `flights`;
CREATE TABLE IF NOT EXISTS `flights` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `departure_city` int(11) NOT NULL,
  `arrival_city` int(11) NOT NULL,
  `departure_date` date NOT NULL,
  `arrival_date` date NOT NULL,
  `planes_id` int(11) NOT NULL,
  `seats_economic` int(11) NOT NULL,
  `seats_first` int(11) NOT NULL,
  `seats_economic_current` int(11) NOT NULL,
  `seats_first_current` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dep_city_flight_index` (`departure_city`),
  KEY `arr_city_flight_index` (`arrival_city`),
  KEY `planes_flights_index` (`planes_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `planes`
--

DROP TABLE IF EXISTS `planes`;
CREATE TABLE IF NOT EXISTS `planes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `NIF` text NOT NULL,
  `state` tinyint(1) NOT NULL,
  `email` text NOT NULL,
  `password` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `clients`
--
ALTER TABLE `clients`
  ADD CONSTRAINT `users_clients_index` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `clients_flights`
--
ALTER TABLE `clients_flights`
  ADD CONSTRAINT `clients_clients_flights_index` FOREIGN KEY (`clients_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `flights_clients_flights_index` FOREIGN KEY (`flights_id`) REFERENCES `flights` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `users_index` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `flights`
--
ALTER TABLE `flights`
  ADD CONSTRAINT `arr_city_flight_index` FOREIGN KEY (`arrival_city`) REFERENCES `cities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dep_city_flight_index` FOREIGN KEY (`departure_city`) REFERENCES `cities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `planes_flights_index` FOREIGN KEY (`planes_id`) REFERENCES `planes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
