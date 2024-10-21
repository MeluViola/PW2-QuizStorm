<?php
// Helpers
include_once(__DIR__ . "/../helpers/IncludeFilePresenter.php");
include_once(__DIR__ . "/../helpers/MustachePresenter.php");
include_once(__DIR__ . "/../helpers/Mysqldatabase.php");
include_once(__DIR__ . "/../helpers/Router.php");

//Controllers
include_once(__DIR__ . "/../controller/LoginController.php");
include_once(__DIR__ . "/../controller/RegisterController.php");
include_once(__DIR__ . "/../controller/HomeController.php");
include_once __DIR__ . "/../controller/UserController.php";

//Models
include_once(__DIR__ . "/../model/LoginModel.php");
include_once(__DIR__ . "/../model/RegisterModel.php");
include_once(__DIR__ . "/../model/HomeModel.php");
include_once(__DIR__ . "/../model/UserModel.php");


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

    public function getUserController(){
        return new UserController($this->getUserModel(), $this->getPresenter());
    }


    // Models
    private function getLoginModel(){
        return new LoginModel($this->getMysqldatabase());
    }

    private function getRegisterModel(){
        return new RegisterModel($this->getMysqldatabase());
    }

    private function getHomeModel() {
        return new HomeModel($this->getMysqldatabase());
    }

    private function getUserModel()
    {
        return new UserModel($this->getMysqldatabase());
    }
    // Helpers
    private function getMysqldatabase()
    {
        $config = parse_ini_file("config.ini");
        $Mysqldatabase = new Mysqldatabase(
            $config["host"],
            $config["username"],
            $config["password"],
            $config["database"]
        );
        return $Mysqldatabase;
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

