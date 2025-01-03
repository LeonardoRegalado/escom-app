<?php
include("conexion.php");

if ($conn) {
    echo "Conexión exitosa a la base de datos: " . $baseDatos;
} else {
    echo "Error al conectar a la base de datos.";
}

$conn->close(); // Cierra la conexión

?>
