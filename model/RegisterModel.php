<?php
class RegisterModel
{
    private $database;

    public function __construct($database)
    {
        $this->database = $database;
    }

    public function agregarUsuario($nombre_completo, $fecha_nacimiento, $sexo, $pais, $email, $contraseña, $nombre_usuario, $foto_perfil)
    {
        $sql = "INSERT INTO usuario (nombre_completo, fecha_nacimiento, sexo, pais, email, contraseña, nombre_usuario, foto_perfil) 
                VALUES ('$nombre_completo','$fecha_nacimiento','$sexo', '$pais', '$email', '$contraseña', '$nombre_usuario', '$foto_perfil')";

        $this->database->execute($sql);

        // Consulta para verificar si el usuario fue agregado correctamente
        $sql = "SELECT * FROM usuario WHERE email = '$email'";
        $resultado = $this->database->query($sql);

        // Retornar true si se encontró el usuario, false si no
        return count($resultado) > 0;
    }

}

