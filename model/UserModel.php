<?php

class UserModel
{
    private $database;

    public function __construct($database)
    {
        $this->database = $database;
    }
    public function getUserByEmail($email) {
        $sql = "SELECT nombre_usuario FROM usuario WHERE email = :email";
        $query = $this->database->prepare($sql);
        $query->bindParam(':email', $email);
        $query->execute();

        return $query->fetch(PDO::FETCH_ASSOC); // Retorna un array
    }
}