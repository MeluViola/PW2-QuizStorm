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
        session_destroy();
        header("location:/");
        exit();
    }

    public function verificarUsuario()
    {
        $estado_cuentaCod = $_GET['estado_cuenta'];
        $emailCod = $_GET['email'];
        $estado_cuenta = $estado_cuentaCod;
        $email = $emailCod;

        if (empty($estado_cuenta) || empty($email)) {
            header('Location:/error?codError=333');
            exit();
        } else {
            $usuarioVerificado = $this->model->verificarUsuario($estado_cuenta, $email);
            if ($usuarioVerificado) {

                header('Location: /login?EXITO=1');;
            } else {
                header('Location:/error?codError=333');
            }
            exit();
        }
    }
}