<?php
include_once ("helpers/Mysqldatabase.php");

$config = parse_ini_file("config.ini");
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


