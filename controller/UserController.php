<?php

class UserController
{
    private $UserModel;
    private $presenter;

    public function __construct($UserModel, $presenter)
    {
        $this->UserModel = $UserModel;
        $this->presenter = $presenter;
    }

    public function list()
        {
            $this->presenter->show("perfilUsuario", []);
        }

    public function showProfile($email) {
        // Obtiene el usuario desde la base de datos
        $user = $this->userModel->getUserByEmail($email);

        // Verifica si se encontró el usuario
        if ($user) {
            $data = [
                'nombre_usuario' => $user['nombre_usuario'] // Aquí se asigna el nombre recuperado
            ];
            $mustache = new Mustache_Engine();
            $template = file_get_contents('view/perfilUsuarioView.mustache');
            echo $mustache->render($template, $data);
        } else {
            echo "Usuario no encontrado.";
        }
    }
}