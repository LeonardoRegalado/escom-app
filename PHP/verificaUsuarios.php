<?php
include("conexion.php"); // Incluye la conexión a la base de datos

$emailIngresado = 'joel@gmail.com';
$sql = "SELECT * FROM usuarios WHERE email = ?";
$stmt = $conn->prepare($sql); // Usa la conexión ($conn)
$stmt->bind_param("s", $emailIngresado);
$stmt->execute();
$resultado = $stmt->get_result();

if ($resultado->num_rows > 0) {
    echo "¡Usuario encontrado!";
} else {
    echo "Usuario no encontrado.";
}

$stmt->close(); // Cierra la consulta preparada
$conn->close(); // Cierra la conexión a la base de datos
?>
