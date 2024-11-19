CREATE DATABASE proyectoWEB;
USE proyectoWEB;

-- Tabla de roles : Profesor, Jefe de Área, Subdirector
CREATE TABLE roles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL UNIQUE -- 'Profesor', 'Jefe de Área', 'Subdirector'
);


-- Tabla de áreas académicas
CREATE TABLE areas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_academia varchar(8) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL UNIQUE
);

-- Tabla de usuarios (Almacena datos básicos y el rol)
CREATE TABLE usuarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    contraseña VARCHAR(100) NOT NULL,
    id_rol INT NOT NULL,
    id_area INT DEFAULT NULL, --  solo para Jefes de Área
    FOREIGN KEY (id_rol) REFERENCES roles(id),
    FOREIGN KEY (id_area) REFERENCES areas(id)
);

-- Tabla de solicitudes de Pago de Tiempo
CREATE TABLE solicitudes_pago_tiempo (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    fecha_incidencia DATE NOT NULL,
    descripcion TEXT NOT NULL, -- Detalle de la incidencia
    estado ENUM('pendiente', 'aprobado', 'rechazado') DEFAULT 'pendiente',
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

-- Tabla de detalles de reposición de tiempo
CREATE TABLE reposicion_tiempo (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_solicitud INT NOT NULL,
    fecha DATE NOT NULL,
    entrada TIME NOT NULL,
    salida TIME NOT NULL,
    observacion VARCHAR(255),
    FOREIGN KEY (id_solicitud) REFERENCES solicitudes_pago_tiempo(id)
);

-- Tabla de solicitudes de Corrimiento de Horario
CREATE TABLE solicitudes_corrimiento (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    fecha_incidencia DATE NOT NULL,
    horario_original TIME NOT NULL,
    horario_corrido TIME NOT NULL,
    estado ENUM('pendiente', 'aprobado', 'rechazado') DEFAULT 'pendiente',
    comentarios TEXT DEFAULT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

-- Tabla de solicitudes de Día Económico
CREATE TABLE solicitudes_dia_economico (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    fecha_incidencia DATE NOT NULL,
    estado ENUM('pendiente', 'aprobado', 'rechazado') DEFAULT 'pendiente',
    comentarios TEXT DEFAULT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

 -- Tabla para delegaciones de cargo temporales por si no se encuentrra disponible un jefe de area
CREATE TABLE delegaciones (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL, -- Subdirector que se delega
    id_area INT NOT NULL, -- Área que atenderá
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
    FOREIGN KEY (id_area) REFERENCES areas(id)
);

DELIMITER $$
CREATE TRIGGER verificar_dia_economico
BEFORE INSERT ON solicitudes_dia_economico
FOR EACH ROW
BEGIN
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
END$$

DELIMITER ;

explain areas;