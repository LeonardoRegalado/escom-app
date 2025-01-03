<?php
$host = "127.0.0.1";
$usuario = "root";
$contrasena = ""; // Ajusta si tienes una contraseña diferente
$baseDatos = "proyectoweb";
$puerto = 5001; // Este es el puerto configurado en tu MySQL

$conn = new mysqli($host, $usuario, $contrasena, $baseDatos, $puerto);

if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
} else {
    echo "Conexión exitosa a la base de datos 'proyectoWEB'";
}
?>
