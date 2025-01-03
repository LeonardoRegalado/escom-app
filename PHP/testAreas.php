<?php
include("conexion.php"); // Asegúrate de que este archivo tiene las credenciales correctas

// Consulta para obtener todos los datos de la tabla 'areas'
$sql = "SELECT * FROM areas";
$resultado = $conn->query($sql);

if ($resultado->num_rows > 0) {
    echo "<h1>Datos de la tabla 'areas':</h1>";
    echo "<table border='1'>";
    echo "<tr><th>ID</th><th>Nombre</th></tr>";
    // Mostrar los datos
    while ($fila = $resultado->fetch_assoc()) {
        echo "<tr>";
        echo "<td>" . $fila["id"] . "</td>";
        echo "<td>" . $fila["nombre"] . "</td>";
        echo "</tr>";
    }
    echo "</table>";
} else {
    echo "La tabla 'areas' está vacía o no se pudo realizar la consulta.";
}

$conn->close();
?>
