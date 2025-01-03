<?php
include("conexion.php");

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $nombre = $_POST["nombre"];
    $email = $_POST["email"];
    $contraseña = $_POST["contraseña"];
    $rol = $_POST["id_rol"];
    $area = isset($_POST["id_area"]) ? $_POST["id_area"] : NULL;

    // Hashear la contraseña
    $contraseñaHasheada = password_hash($contraseña, PASSWORD_DEFAULT);

    // Insertar en la base de datos
    $sql = "INSERT INTO usuarios (nombre, email, contraseña, id_rol, id_area) VALUES (?, ?, ?, ?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("sssii", $nombre, $email, $contraseñaHasheada, $rol, $area);

    if ($stmt->execute()) {
        echo "Usuario registrado con éxito.";
    } else {
        echo "Error al registrar el usuario: " . $stmt->error;
    }

    $stmt->close();
    $conn->close();
}
?>
