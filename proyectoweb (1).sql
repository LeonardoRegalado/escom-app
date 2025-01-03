-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:5001
-- Tiempo de generación: 03-01-2025 a las 04:36:42
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `proyectoweb`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `areas`
--

CREATE TABLE `areas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `areas`
--

INSERT INTO `areas` (`id`, `nombre`) VALUES
(3, 'Ciberseguridad'),
(1, 'Desarrollo de software'),
(5, 'Fundamentos matematicos'),
(7, 'Ingenieria en Inteligencia Artificial'),
(6, 'Ingenieria en Sistemas Computacionales'),
(2, 'Inteligencia artificial'),
(8, 'Licenciatura en Ciencia de Datos'),
(4, 'Programacion');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `delegaciones`
--

CREATE TABLE `delegaciones` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_area` int(11) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reposicion_tiempo`
--

CREATE TABLE `reposicion_tiempo` (
  `id` int(11) NOT NULL,
  `id_solicitud` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `entrada` time NOT NULL,
  `salida` time NOT NULL,
  `observacion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `nombre`) VALUES
(2, 'Jefe de área'),
(1, 'Profesor'),
(3, 'Subdirector');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudes_corrimiento`
--

CREATE TABLE `solicitudes_corrimiento` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_incidencia` date NOT NULL,
  `horario_original` time NOT NULL,
  `horario_corrido` time NOT NULL,
  `estado` enum('pendiente','aprobado','rechazado') DEFAULT 'pendiente',
  `comentarios` text DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudes_dia_economico`
--

CREATE TABLE `solicitudes_dia_economico` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_incidencia` date NOT NULL,
  `estado` enum('pendiente','aprobado','rechazado') DEFAULT 'pendiente',
  `comentarios` text DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Disparadores `solicitudes_dia_economico`
--
DELIMITER $$
CREATE TRIGGER `verificar_dia_economico` BEFORE INSERT ON `solicitudes_dia_economico` FOR EACH ROW BEGIN
    DECLARE total_usos INT;

    -- Contar cuántas solicitudes de día económico ha hecho el usuario en el año
    SELECT COUNT(*)
    INTO total_usos
    FROM solicitudes_dia_economico
    WHERE id_usuario = NEW.id_usuario
      AND YEAR(fecha_incidencia) = YEAR(NEW.fecha_incidencia);

    -- Verificar si ya excedió el límite
    IF total_usos >= 10 THEN
        SIGNAL SQLSTATE '45000'   -- Notifiar que el limite ha sido alcanzado
        SET MESSAGE_TEXT = 'El usuario ha excedido el límite de 10 Días Económicos en el año.';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudes_pago_tiempo`
--

CREATE TABLE `solicitudes_pago_tiempo` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_incidencia` date NOT NULL,
  `descripcion` text NOT NULL,
  `estado` enum('pendiente','aprobado','rechazado') DEFAULT 'pendiente',
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contraseña` varchar(100) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `id_area` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `email`, `contraseña`, `id_rol`, `id_area`) VALUES
(1, 'Juan Pérez', 'juan.perez@example.com', '$2y$10$QWT5fzlqWvqLgm4XEPZBwOH7d00ClK76RYdX8zmCsv9.B7idNz1kO', 1, NULL),
(2, 'María López', 'maria.lopez@example.com', '$2y$10$QWT5fzlqWvqLgm4XEPZBwOH7d00ClK76RYdX8zmCsv9.B7idNz1kO', 2, 1),
(3, 'Carlos Martínez', 'carlos.martinez@example.com', '$2y$10$QWT5fzlqWvqLgm4XEPZBwOH7d00ClK76RYdX8zmCsv9.B7idNz1kO', 3, NULL),
(4, 'Joel', 'joelgmailcom', '$2y$10$Ogs9XdfJDIY4bzWYxYH2nuV/9Ey9NrbLZd4B.X4vuPtkFH/w.8pIu', 1, NULL),
(5, 'PruebaSinArroba', 'pruebaemailcom', '$2y$10$e0MYzXyjpJS2cOGCxt7tNeFxYAc47pq4OxFoKNq7ZTXY5ukJ9rGcm', 1, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `areas`
--
ALTER TABLE `areas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `delegaciones`
--
ALTER TABLE `delegaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_area` (`id_area`);

--
-- Indices de la tabla `reposicion_tiempo`
--
ALTER TABLE `reposicion_tiempo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_solicitud` (`id_solicitud`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `solicitudes_corrimiento`
--
ALTER TABLE `solicitudes_corrimiento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `solicitudes_dia_economico`
--
ALTER TABLE `solicitudes_dia_economico`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `solicitudes_pago_tiempo`
--
ALTER TABLE `solicitudes_pago_tiempo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `id_rol` (`id_rol`),
  ADD KEY `id_area` (`id_area`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `areas`
--
ALTER TABLE `areas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `delegaciones`
--
ALTER TABLE `delegaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `reposicion_tiempo`
--
ALTER TABLE `reposicion_tiempo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `solicitudes_corrimiento`
--
ALTER TABLE `solicitudes_corrimiento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `solicitudes_dia_economico`
--
ALTER TABLE `solicitudes_dia_economico`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `solicitudes_pago_tiempo`
--
ALTER TABLE `solicitudes_pago_tiempo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `delegaciones`
--
ALTER TABLE `delegaciones`
  ADD CONSTRAINT `delegaciones_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `delegaciones_ibfk_2` FOREIGN KEY (`id_area`) REFERENCES `areas` (`id`);

--
-- Filtros para la tabla `reposicion_tiempo`
--
ALTER TABLE `reposicion_tiempo`
  ADD CONSTRAINT `reposicion_tiempo_ibfk_1` FOREIGN KEY (`id_solicitud`) REFERENCES `solicitudes_pago_tiempo` (`id`);

--
-- Filtros para la tabla `solicitudes_corrimiento`
--
ALTER TABLE `solicitudes_corrimiento`
  ADD CONSTRAINT `solicitudes_corrimiento_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `solicitudes_dia_economico`
--
ALTER TABLE `solicitudes_dia_economico`
  ADD CONSTRAINT `solicitudes_dia_economico_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `solicitudes_pago_tiempo`
--
ALTER TABLE `solicitudes_pago_tiempo`
  ADD CONSTRAINT `solicitudes_pago_tiempo_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id`),
  ADD CONSTRAINT `usuarios_ibfk_2` FOREIGN KEY (`id_area`) REFERENCES `areas` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
