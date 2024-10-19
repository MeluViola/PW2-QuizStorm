<?php

class LoginController
{
    private $model;

    public function __construct($model)
    {
        $this->model = $model;
    }

    public function signIn()
    {
        $email = $_POST["email"];
        $contraseña = $_POST["contraseña"];

        $result = $this->model->signIn($email, $contraseña);
        if (count($result) > 0) {
            session_start();
            $_SESSION['id_usuario'] = $result[0]['id_usuario'];
            $_SESSION['id_partida'] = null;
            header("location:/");
        } else header("location:/"); //tendria que ir a registrarse
        exit();
    }

    public function signOut(){
        session_start();
        $_SESSION['id_usuario'] = null;
        $_SESSION['id_partida'] = null;
        header("location:/");
        exit();
    }
}