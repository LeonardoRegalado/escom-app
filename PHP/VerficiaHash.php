<?php
$hash = '$2y$10$QWT5fzlqWvqLgm4XEPZBwOH7d00ClK76RYdX8zmCsv9.B7idNz1kO';
$contraseñaIngresada = '12345';

if (password_verify($contraseñaIngresada, $hash)) {
    echo "¡Contraseña válida!";
} else {
    echo "La contraseña no coincide.";
}
?>
