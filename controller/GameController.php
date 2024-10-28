<?php

class GameController
{

    private $GameModel;
    private $presenter;

    public function __construct($GameModel, $presenter)
    {
        $this->GameModel = $GameModel;
        $this->presenter = $presenter;
    }

    public function nuevaPartida()
    {
        if (!isset($_SESSION['email'])) {
            header("location:/");
            exit();
        }

        $this->GameModel->crearPartida($_SESSION['id_usuario']['nombre_usuario']);
    }
    public function list (){
        $this->presenter->show("game", []);

    }
}
