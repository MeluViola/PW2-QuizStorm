<?php

class LoginController
{
    private $LoginModel;
    private $presenter;


    public function __construct($LoginModel, $presenter)
    {
        $this->LoginModel = $LoginModel;
        $this->presenter = $presenter;
    }

    public function signIn()
    {
        $email = $_POST["email"];
        $contraseña = $_POST["contraseña"];

        $result = $this->LoginModel->signIn($email, $contraseña);
        if (count($result) > 0) {
            session_start();
            $_SESSION['id_usuario'] = $result[0]['id_usuario'];
            $_SESSION['id_partida'] = null;
            header("location:/TP-Final-QuizStorm/lobby");
        } else header("location:/TP-Final-QuizStorm/register"); //tendria que ir a registrarse
        exit();
    }

    public function signOut()
    {
        session_destroy();
        header("location:/home");
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
            $usuarioVerificado = $this->LoginModel->verificarUsuario($estado_cuenta, $email);
            if ($usuarioVerificado) {
                header('Location: /login?EXITO=1');;
            } else {
                header('Location:/error?codError=333');
            }
            exit();
        }
    }

    public function list()
    {
        $data = [
            'formTitle' => 'Iniciar sesión',
            'formAction' => '/TP-Final-QuizStorm/login/signIn',
            'submitButtonText' => 'Ingresar',
            "mensaje" => $_SESSION["success"] ?? null,
            "error" => $_SESSION["error"] ?? null,
        ];
        unset($_SESSION["error"]);
        $this->presenter->show("login", $data);
    }
    
    //para que el perfil tenga el nombre de cada usuario (por ahora)
    public function obtenerPerfilUsuario()
    {
        if (isset($_SESSION['email'])) {
            $nombreJugador = $this->LoginModel->getNombreJugadorByEmail($_SESSION['email']);
            return $nombreJugador; // Retorna los datos del usuario
        }
        return null;
    }

}

