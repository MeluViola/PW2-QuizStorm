<?php
// Helpers
include_once(__DIR__ . "/../helpers/IncludeFilePresenter.php");
include_once(__DIR__ . "/../helpers/MustachePresenter.php");
include_once(__DIR__ . "/../helpers/Mysqldatabase.php");
include_once(__DIR__ . "/../helpers/Router.php");

//Models
include_once(__DIR__ . "/../model/LoginModel.php");
include_once(__DIR__ . "/../model/RegisterModel.php");

//Controllers
include_once(__DIR__ . "/../controller/LoginController.php");
include_once(__DIR__ . "/../controller/RegisterController.php");
include_once(__DIR__ . "/../controller/HomeController.php");

//Vendor
include_once(__DIR__ . '/../vendor/mustache/src/Mustache/Autoloader.php');


class Configuration
{
    private $configFile = 'config/config.ini';

    public function __construct() {
    }


    // Controllers
    public function getLoginController() {
        return new LoginController($this->getLoginModel(), $this->getPresenter());
    }

    public function getRegisterController() {
        return new RegistrerController($this->getRegisterModel(), $this->getPresenter());
    }

    public function getHomeController(){
        return new HomeController($this->getHomeModel(), $this->getPresenter());
    }


    // Models
    private function getLoginModel(){
        return new LoginModel($this->getDatabase());
    }

    private function getRegisterModel(){
        return new RegisterModel($this->getDatabase());
    }

    // Helpers
    private function getDatabase()
    {
        $config = parse_ini_file("config.ini");
        $database = new Database(
            $config["host"],
            $config["user"],
            $config["password"],
            $config["database"]
        );
        return $database;
    }

    private function getPresenter()
    {
        return new MustachePresenter("./view");
    }

    public function getRouter()
    {
        return new Router($this, "getHomeController", "list");
    }
}

