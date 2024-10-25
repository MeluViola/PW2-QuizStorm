<?php

class GameController
{

    private $model;
    private $presenter;

    public function __construct($model, $presenter)
    {
        $this->model = $model;
        $this->presenter = $presenter;
    }

    public function nuevaPartida()
    {
        if (!isset($_SESSION['email'])) {
            header("location: /");
            exit();
        }

        $this->model->crearPartida($_SESSION['id_usuario']['nombre_usuario']);
    }
}
