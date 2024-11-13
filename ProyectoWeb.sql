CREATE DATABASE proyectoWEB;
USE proyectoWEB;

-- Tabla de roles (Define los tipos de usuarios: Profesor, Jefe de Área, Subdirector)
CREATE TABLE roles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL UNIQUE -- 'Profesor', 'Jefe de Área', 'Subdirector'
);

-- Tabla de usuarios (Almacena los datos de los usuarios y su rol)
CREATE TABLE usuarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    contraseña VARCHAR(100) NOT NULL,
    id_rol INT NOT NULL,
    id_area INT DEFAULT NULL, 
    FOREIGN KEY (id_rol) REFERENCES roles(id)
);

-- Tabla de áreas 
CREATE TABLE areas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL UNIQUE
);

-- Tabla para tipos de solicitudes 
CREATE TABLE tipos_solicitudes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL UNIQUE -- : 'Horas Extra', 'Reposición', 'Comodín'
);

-- Tabla principal de solicitudes (Relaciona usuarios con sus solicitudes)
CREATE TABLE solicitudes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL, -- Profesor que realiza la solicitud
    id_tipo_solicitud INT NOT NULL, -- Tipo de solicitud (Horas Extra, Reposición, Comodín)
    fecha DATE NOT NULL, -- Fecha en la que el profesor llegó tarde
    estado ENUM('pendiente', 'aprobado', 'rechazado') DEFAULT 'pendiente',
    comentarios VARCHAR(255) DEFAULT NULL, -- Comentarios opcionales
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
    FOREIGN KEY (id_tipo_solicitud) REFERENCES tipos_solicitudes(id)
);

-- Tabla para seguimiento de aprobaciones (Jefe de Área y Subdirector)
CREATE TABLE aprobaciones (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_solicitud INT NOT NULL,
    id_aprobador INT NOT NULL, -- Jefe de Área o Subdirector
    nivel_aprobacion ENUM('jefe_area', 'subdirector') NOT NULL,
    estado ENUM('pendiente', 'aprobado', 'rechazado') DEFAULT 'pendiente',
    comentarios VARCHAR(255) DEFAULT NULL,
    fecha_aprobacion TIMESTAMP DEFAULT NULL,
    FOREIGN KEY (id_solicitud) REFERENCES solicitudes(id),
    FOREIGN KEY (id_aprobador) REFERENCES usuarios(id)
);
