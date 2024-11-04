<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;

require 'vendor/PHPMailer-master/src/PHPMailer.php';
require 'vendor/PHPMailer-master/src/SMTP.php';
require 'vendor/PHPMailer-master/src/Exception.php';

class RegisterController{

    private $registerModel;
    private $presenter;


    public function __construct($registerModel, $presenter)
    {
        $this->registerModel = $registerModel;
        $this->presenter = $presenter;
    }

    public function registrarse(){
        $nombre_completo = $_POST['nombre_completo'];
        $fecha_nacimiento = $_POST['fecha_nacimiento'];
        $sexo = $_POST['sexo'];
        $pais = $_POST['pais'];
        $email = $_POST['email'];
        $contraseña = $_POST['contraseña'];
        $contraseña_repetida = $_POST['repetir-contraseña'];
        $nombre_usuario = $_POST['nombre_usuario'];
        $img = "";

        if($contraseña!=$contraseña_repetida){
            header("location:/");
            exit();
        }

        if($_FILES["foto_perfil"]["error"] == 0){
            $nuevoNombre = time();
            $extension = pathinfo($_FILES["foto_perfil"]["name"], PATHINFO_EXTENSION);
            $destino = "public/uploads/" . $nuevoNombre . "." . $extension;
            move_uploaded_file($_FILES["foto_perfil"]["tmp_name"],$destino);
            $img="$nuevoNombre.$extension";
        }

        $token = uniqid();

        $result = $this ->registerModel-> agregarUsuario($nombre_completo, $fecha_nacimiento, $sexo, $pais, $email, $contraseña, $nombre_usuario, $img, $token);

        if(!$result) unlink("public/uploads/" . $img );

        if ($this->enviarMailDeValidacion($email, $nombre_completo, $token)) {
            echo 'Se envió un correo de verificación.';
        } else {
            echo 'ERROR.';
            header('Location:/registro?error=ERROR-EMAIL');
            exit();
        }

        header("location:/login");
        exit();
    }

    public function enviarMailDeValidacion($email, $nombre, $token)
    {
        $mail = new PHPMailer(true);
        try {
            //Configuracion del servidor SMTP
            $mail->isSMTP();
            $mail->Host = 'smtp.gmail.com';
            $mail->SMTPAuth = true;
            $mail->Username = 'quizstormunlam@gmail.com';
            $mail->Password = 'preguntados1';
            $mail->Port = 587;
            $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;

            // Configuración del remitente y destinatario
            $mail->setFrom('quizstormunlam@gmail.com', 'QuizStorm');
            $mail->addAddress($email, $nombre);

            //enlace para la validacion
            $enlaceValidacion = 'http://localhost/login/verificarUsuario?token=' . $token . '&email=' . $email;

            // Contenido del correo
            $mail->isHTML(true);
            $mail->Subject = 'Checking PHP mail';
            $mail->Body = '<h1>¡Gracias por registrarte!</h1> <br> <br> <h3>Estimado usuario, haga clic en el siguiente enlace para validar su cuenta: <a href="' . $enlaceValidacion  . '">Verificar cuenta</a> </h3>';
            $mail->send();

        } catch (Exception $e) {
            echo "Error al enviar el correo: {$mail->ErrorInfo}";
            //header('Location:/autenticacion?mail=BAD');
            exit();
        }

    }

    public function list (){
        $this->presenter->show("register", []);

    }
}



