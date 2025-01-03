<?php
session_start();

// Verificar si el usuario está autenticado
if (!isset($_SESSION["usuario"])) {
    header("Location: login.php");
    exit();
}

// Información del usuario desde la sesión
$nombreUsuario = $_SESSION["usuario"];

// Conexión a la base de datos
include("conexion.php");

// Consultar estadísticas rápidas
$sqlTotalCorrimiento = "SELECT COUNT(*) AS total FROM solicitudes_corrimiento";
$resultCorrimiento = $conn->query($sqlTotalCorrimiento);
$totalCorrimiento = $resultCorrimiento->fetch_assoc()['total'];

$sqlTotalDiaEconomico = "SELECT COUNT(*) AS total FROM solicitudes_dia_economico";
$resultDiaEconomico = $conn->query($sqlTotalDiaEconomico);
$totalDiaEconomico = $resultDiaEconomico->fetch_assoc()['total'];

$sqlTotalPagoTiempo = "SELECT COUNT(*) AS total FROM solicitudes_pago_tiempo";
$resultPagoTiempo = $conn->query($sqlTotalPagoTiempo);
$totalPagoTiempo = $resultPagoTiempo->fetch_assoc()['total'];

// Total de incidencias
$totalIncidencias = $totalCorrimiento + $totalDiaEconomico + $totalPagoTiempo;

// Consultar pendientes
$sqlPendientesCorrimiento = "SELECT COUNT(*) AS pendientes FROM solicitudes_corrimiento WHERE estado = 'pendiente'";
$resultPendientesCorrimiento = $conn->query($sqlPendientesCorrimiento);
$pendientesCorrimiento = $resultPendientesCorrimiento->fetch_assoc()['pendientes'];

$sqlPendientesDiaEconomico = "SELECT COUNT(*) AS pendientes FROM solicitudes_dia_economico WHERE estado = 'pendiente'";
$resultPendientesDiaEconomico = $conn->query($sqlPendientesDiaEconomico);
$pendientesDiaEconomico = $resultPendientesDiaEconomico->fetch_assoc()['pendientes'];

$sqlPendientesPagoTiempo = "SELECT COUNT(*) AS pendientes FROM solicitudes_pago_tiempo WHERE estado = 'pendiente'";
$resultPendientesPagoTiempo = $conn->query($sqlPendientesPagoTiempo);
$pendientesPagoTiempo = $resultPendientesPagoTiempo->fetch_assoc()['pendientes'];

// Total de pendientes
$totalPendientes = $pendientesCorrimiento + $pendientesDiaEconomico + $pendientesPagoTiempo;

?>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link href="../CSS/CopiaCSS.css" rel="stylesheet">
    <link href="../CSS/BarraNav.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Segoe+UI:wght@400&display=swap" rel="stylesheet">
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
            <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
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

    <!-- Contenido del Dashboard -->
    <div class="container mt-4">
        <div class="dashboard-content">
            <h1 class="text-center">¡Bienvenido, <?php echo htmlspecialchars($nombreUsuario); ?>!</h1>
            <p class="text-center">Administra tus horarios, incidencias y más con facilidad.</p>
            
            <!-- Botones principales -->
            <div class="row text-center mt-4">
                <div class="col-12 col-sm-12 col-md-4 mb-3">
                    <a href="registrar_incidencia.php" class="btn btn-primary btn-block">Registrar Incidencia</a>
                </div>
                <div class="col-12 col-sm-12 col-md-4 mb-3">
                    <a href="ver_historial.php" class="btn btn-secondary btn-block">Historial de Incidencias</a>
                </div>
                <div class="col-12 col-sm-12 col-md-4 mb-3">
                    <a href="gestionar_horarios.php" class="btn btn-info btn-block">Gestionar Horarios</a>
                </div>
            </div>


            <!-- Secciones adicionales -->
            <div class="row mt-5">
                <div class="col-12 col-md-6">
                    <div class="card">
                        <div class="card-header bg-primary text-white">Estadísticas Rápidas</div>
                        <div class="card-body">
                            <p>Total de incidencias registradas: <strong><?php echo $totalIncidencias; ?></strong></p>
                            <p>Incidencias pendientes: <strong><?php echo $totalPendientes; ?></strong></p>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-6">
                    <div class="card">
                        <div class="card-header bg-secondary text-white">Notificaciones</div>
                        <div class="card-body">
                            <ul>
                                <li>Revisión de horario solicitada por el jefe de área.</li>
                                <li>Actualización en el sistema.</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

</html>
