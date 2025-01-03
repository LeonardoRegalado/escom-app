<?php
session_start();
include("conexion.php");

$error = ""; // Variable para almacenar el mensaje de error

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $usuario = $_POST["usuario"];
    $contrasena = $_POST["contrasena"];

    $sql = "SELECT * FROM usuarios WHERE email = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $usuario);
    $stmt->execute();
    $resultado = $stmt->get_result();

    if ($resultado->num_rows > 0) {
        $fila = $resultado->fetch_assoc();
        $hashAlmacenado = $fila["contraseña"];

        // Verificar la contraseña
        if (password_verify($contrasena, $hashAlmacenado)) {
            $_SESSION["usuario"] = $fila["nombre"];
            $_SESSION["rol"] = $fila["id_rol"];
            // Redirigir al dashboard
            header("Location: dashboard.php"); 
            exit();
        } else {
            $error = "La contraseña es incorrecta.";
        }
    } else {
        $error = "El usuario no existe.";
    }

    $stmt->close();
    $conn->close();
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link href="../CSS/CopiaCSS.css" rel="stylesheet">
    <link href="../CSS/BarraNav.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <!-- Barra de Navegación -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Portal Educativo</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="https://www.escom.ipn.mx/" target="_blank">ESCOM</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="https://www.saes.escom.ipn.mx/" target="_blank">SAES</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="https://www.ipn.mx/" target="_blank">IPN</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="https://www.biblioteca.ipn.mx/" target="_blank">Biblioteca IPN</a>
                    </li>
                </ul>
                <a class="LogoEscom" href="https://www.escom.ipn.mx/" target="_blank">
                    <img src="../IMAGES/LogoESCOM.png" alt="Logo" class="navbar-logo">
                </a>
            </div>
        </div>
    </nav>

    <!-- Recuadro para guardar el registro de los usuarios -->
    <div class="container-fluid">
        <div class="row">
            <div class="col-12 col-lg-4 login-container">
                <div class="mensaje">
                    <p>¡Bienvenido al sistema de gestión docente!</p>
                    <p>Administra tus horarios, incidencias y más con facilidad.</p>
                </div>
                <div class="login">
                    <form method="POST" action="login.php">
                        <h1>¡Bienvenido!</h1>
                        <?php if (!empty($error)): ?>
                            <div class="alert alert-danger">
                                <?php echo $error; ?>
                            </div>
                        <?php endif; ?>
                        <label>Usuario</label>
                        <input type="email" name="usuario" required>
                        <label>Contraseña</label>
                        <input type="password" name="contrasena" required>
                        <button class="btn-redondeado" type="submit">Entrar</button>
                    </form>
                </div>
            </div>
            <div class="col-12 col-md-8 image-container"></div>
        </div>
    </div>
</body>
</html>
