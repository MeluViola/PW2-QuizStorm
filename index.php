<?php
session_start();
include_once ('configuration/configuration.php');
$configuration = new configuration();
$router = $configuration->getRouter();

$action = isset($_GET['action']) ? $_GET['action'] : '';
$page = isset($_GET['page']) ? $_GET['page'] : '';

$router->route($page, $action);
