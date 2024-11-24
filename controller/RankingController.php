<?php
require_once 'helper/QR.php';

class RankingController
{
    private $presenter;
    private $usersModel;

    public function __construct($presenter, $usersModel)
    {
        $this->presenter = $presenter;
        $this->usersModel = $usersModel;
    }

    public function getRanking()
    {
        // Verificar el rol del usuario
        $roleId = isset($_SESSION['user']) ? $_SESSION['user'][0]['rol'] : null;

        if ($roleId !== 3) {
            // Redirigir a la página de inicio si no tiene el rol adecuado
            header("Location: /Home");
            exit();
        }

        // Obtener el nombre de usuario y ID del usuario actual
        $username = isset($_SESSION['user']) ? $_SESSION['user'][0]['username'] : null;
        $userId = isset($_SESSION['user']) ? $_SESSION['user'][0]['_id'] : null;

        // Obtener puntaje máximo del usuario actual y lista de usuarios del ranking
        $maxScore = $this->usersModel->getMaxScore($userId);
        $topUsers = $this->usersModel->getTopUsers();

        // Generar un código QR para cada usuario del ranking
        foreach ($topUsers as &$user) {
            $profileLink = "/UsuarioPerfil/getProfile?username=" . urlencode($user['USERNAME']);
            $user['QR'] = QRHelper::generarQR($user['USERNAME'], $profileLink);
        }

        // Renderizar la vista con los datos
        $this->presenter->render("view/RankingView.mustache", [
            'username' => $username,
            'maxScore' => $maxScore,
            'topUsers' => $topUsers // Ahora incluye el QR generado
        ]);
    }
}
