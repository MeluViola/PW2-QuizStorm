<?php
include_once(__DIR__ . "/../helpers/Mysqldatabase.php");

$config = parse_ini_file(__DIR__ . "/../config.ini"); //se usa para acceder a los archivos entre carpetas

$database = new Mysqldatabase(
    $config ['host'],
    $config ['username'],
    $config ['password'],
    $config ['database']
);

//Verificacion temporal de la bdd
/*$datos = $database->query("SELECT * FROM usuario");

foreach ($datos as $dato) {
    echo $dato['nombre_completo'] . "<br> " . $dato['nombre_usuario']. "<br> ";
}*/
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Perfil de Usuario - Quiz Storm</title>
    <link rel="stylesheet" href="/TP-Final-QuizStorm/views/css/perfilUsuario.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
</head>
<body>
<header>
    <div class="logo">
        <i class="fas fa-cloud"></i> Quiz Storm
    </div>
    <nav>
        <a href="#">Inicio</a>
        <a href="#">Historial</a>
        <a href="#">Ranking</a>
    </nav>
    <div class="logout">
        <a href="#">Cerrar Sesión <i class="fas fa-sign-out-alt"></i></a>
    </div>
</header>

<main>
    <section class="profile-container">
        <div class="avatar-section">
            <div class="avatar">
                <i class="fas fa-user"></i>
                <div class="edit-icon">
                    <i class="fas fa-pen"></i>
                </div>
            </div>
            <h2>Jugador Jugador #0000</h2>
            <p class="weekly-position">
                <i class="fas fa-medal"></i> #1 Posición Semanal
            </p>
        </div>

        <div class="stats-section">
            <p><strong>Categoría favorita:</strong> Entretenimiento</p>
            <p><strong>Preguntas respondidas:</strong> 288</p>
            <p><strong>Partidas jugadas:</strong> 24</p>
            <p><strong>Porcentaje de Victorias:</strong> 70.83%</p>
            <p><strong>Total de puntos:</strong> 12.568</p>
        </div>

        <div class="lorem-section">
            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vel egestas dolor, nec dignissim metus...</p>
        </div>
    </section>
</main>
</body>
</html>
