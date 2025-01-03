<?php
include("conexion.php"); // Incluye la conexión a la base de datos

// Asegúrate de definir manualmente el valor para pruebas
$usuario = "joel@gmail.com"; // Cambia esto al email que deseas probar
$emailIngresado = trim(strtolower($usuario));

$sql = "SELECT * FROM usuarios WHERE email = ?";
echo "Email enviado a la consulta: {$emailIngresado}<br>";

$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $emailIngresado);
$stmt->execute();
$resultado = $stmt->get_result();

if ($resultado->num_rows > 0) {
    echo "¡Usuario encontrado en la base de datos!<br>";
    $fila = $resultado->fetch_assoc();
    echo "Email en la base de datos: " . $fila['email'] . "<br>";
} else {
    echo "Usuario no encontrado. Por favor verifica los datos ingresados.<br>";
}

$stmt->close();
$conn->close();
?>
