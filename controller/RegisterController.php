<?php
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

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
        $rcontraseña = $_POST['repetir-contraseña'];
        $nombre_usuario = $_POST['nombre_usuario'];
        $img = "";

        if($contraseña!=$rcontraseña){
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

        $estado_cuenta = uniqid();

        $result = $this ->registerModel-> agregarUsuario($nombre_completo, $fecha_nacimiento, $sexo, $pais, $email, $contraseña, $nombre_usuario, $img, $estado_cuenta);

        if(!$result) unlink("public/uploads/" . $img );

        if ($this->enviarMailDeValidacion($email, $nombre_completo, $estado_cuenta)) {
            echo 'Se envió un correo de verificación.';
        } else {
            echo 'ERROR.';
            header('Location:/registro?error=ERROR-EMAIL');
            exit();
        }

        header("location:/login/form");
        exit();
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



