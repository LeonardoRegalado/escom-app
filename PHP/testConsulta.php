<?php
include("conexion.php");

$email = 'joel@gmail.com';

$sql = "SELECT * FROM usuarios WHERE email = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $email);
$stmt->execute();
$resultado = $stmt->get_result();

if ($resultado->num_rows > 0) {
    $usuario = $resultado->fetch_assoc();
    echo "Usuario encontrado:<br>";
    echo "Email: " . $usuario['email'] . "<br>";
    echo "Hash de la contraseña: " . $usuario['contraseña'] . "<br>";
    echo "ID del Rol: " . $usuario['id_rol'] . "<br>";
    echo "ID del Área: " . ($usuario['id_area'] ?? "NULL") . "<br>";
} else {
    echo "No se encontró el usuario.";
}

$stmt->close();
$conn->close();
?>
