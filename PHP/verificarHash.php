<?php
// Hash almacenado en la base de datos
$hash = '$2y$10$$2y$10$QWT5fzlqWvqLgm4XEPZBwOH7d00ClK76RYdX8zmCsv9.B7idNz1kO';

// Contraseña ingresada por el usuario
$contraseñaIngresada = "12345";

// Verificar si la contraseña ingresada coincide con el hash
if (password_verify($contraseñaIngresada, $hash)) {
    echo "¡Contraseña válida!";
} else {
    echo "La contraseña no coincide.";
}
?>
