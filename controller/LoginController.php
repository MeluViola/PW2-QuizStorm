<?php
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

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

    public function signOut()
    {
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

    public function enviarMailDeValidacion($email, $nombre, $estado_cuenta)
    {
        $mail = new PHPMailer(true);
        try {
            //Configuracion del servidor SMTP
            $mail->isSMTP();
            $mail->Host = 'smtp.gmail.com';
            $mail->SMTPAuth = true;
            $mail->Username = 'quizStorm.unlam@gmail.com';
            $mail->Password = '123456';
            $mail->Port = 587;

            // Configuración del remitente y destinatario
            $mail->setFrom('quizStorm.unlam@gmail.com', 'QuizStorm');
            $mail->addAddress($email, $nombre);

            //enlace para la validacion
            $enlaceValidacion = 'http://localhost/login/verificarUsuario?estado_cuenta=' . $estado_cuenta . '&email=' . $email;

            // Contenido del correo
            $mail->isHTML(true);
            $mail->Subject = 'Checking PHP mail';
            $mail->Body = '<h1>¡Gracias por registrarte!</h1> <br> <br> <h3>Estimado usuario, haga clic en el siguiente enlace para validar su cuenta: <a href="' . $enlaceValidacion  . '">Verificar cuenta</a> </h3>';
            $mail->send();

        } catch (Exception $e) {
            header('Location:/autenticacion?mail=BAD');
            exit();
}

    }

}

