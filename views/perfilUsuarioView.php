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
$datos = $database->query("SELECT * FROM usuario");

foreach ($datos as $dato) {
    echo $dato['nombre_completo'] . "<br> " . $dato['nombre_usuario']. "<br> ";
}