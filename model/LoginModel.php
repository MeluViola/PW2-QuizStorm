<?php

class LoginModel
{
    private $database;

    public function __construct($database)
    {
        $this->database = $database;
    }

    public function signIn($email, $contraseña)
    {
        return $this->database->query("SELECT * FROM usuario WHERE email = '$email' AND contraseña = '$contraseña' AND estado_cuenta = 'activo'");
    }

    public function verificarUsuario($estado_cuenta, $email)
    {
        // Primero, obtenemos el estado actual de la cuenta del usuario
        $sql = "SELECT estado_cuenta FROM usuario WHERE email = :email";
        $query = $this->database->prepare($sql);
        $query->bindParam(':email', $email);
        $query->execute();

        $estado_cuentaDB = $query->fetch();

        if ($estado_cuentaDB && $estado_cuentaDB['estado_cuenta'] === $estado_cuenta) {
            // Si el estado es el esperado, actualizamos el estado de la cuenta
            $updateSQL = "UPDATE usuario SET estado_cuenta = 'activo' WHERE email = :email";
            $updateQuery = $this->database->prepare($updateSQL);
            $updateQuery->bindParam(':email', $email);
            $updateQuery->execute();

            return true;
        } else {
            return false;
        }
    }

    //Obtener el nombre del jugador
    public function getNombreJugadorByEmail($email)
    {
        $sql = "SELECT nombre FROM usuario WHERE email = :email";
        $query = $this->database->prepare($sql);
        $query->bindParam(':email', $email);
        $query->execute();

        return $query->fetch(PDO::FETCH_ASSOC);
    }
}
?>
