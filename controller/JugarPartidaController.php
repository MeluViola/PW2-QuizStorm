<?php
class JugarPartidaController {
    private $model;
    private $presenter;

    public function __construct($model, $presenter) {
        $this->model = $model;
        $this->presenter = $presenter;
    }

    // Inicia una partida nueva para el usuario
    public function iniciarPartida() {
        $idUsuario = $_SESSION['id_usuario'];

        // Crear una nueva entrada en la tabla Partida
        $idPartida = $this->model->crearPartida($idUsuario);
        $_SESSION['id_partida'] = $idPartida;
        $_SESSION['puntos'] = 0;

        // Muestra la primera pregunta
        $this->mostrarPregunta();
    }

    // pregunta aleatoria según la dificultad del usuario
    public function mostrarPregunta() {
        $idUsuario = $_SESSION['id_usuario'];
        $pregunta = $this->model->obtenerPreguntaAleatoria($idUsuario);

        if ($pregunta) {
            $this->presenter->show("jugarPartida", [
                'pregunta' => $pregunta,
                'puntos' => $_SESSION['puntos']
            ]);
        } else {
            // Si no hay más preguntas, deberia repetir

        }
    }

    // Procesa la respuesta del usuariogit
    public function procesarRespuesta($idPregunta, $respuestaUsuario) {
        $idPartida = $_SESSION['id_partida'];

        // Registrar la respuesta y verificar si es correcta
        $esCorrecto = $this->model->registrarRespuesta($idPartida, $idPregunta, $respuestaUsuario);

        if ($esCorrecto) {
            //Si es correcta, aumentar el puntaje y mostrar otra pregunta
            $_SESSION['puntos']++;
            $this->mostrarPregunta();
        } else {
            //Si es incorrecta, finalizar la partida
            $this->finalizarPartida();
        }
    }

    // Termina la partida y muestra el puntaje obtenido
    public function finalizarPartida() {
        $idPartida = $_SESSION['id_partida'];
        $puntosObtenidos = $_SESSION['puntos'];

        // Actualiza el puntaje en la base de datos
        $this->model->finalizarPartida($idPartida, $puntosObtenidos);

        // Muestra el puntaje final
        $this->presenter->show("jugarPartida", [
            'puntos_finales' => $puntosObtenidos,
            'mensaje' => "¡Juego terminado! Obtuviste $puntosObtenidos puntos."
        ]);

        unset($_SESSION['id_partida']);
        unset($_SESSION['puntos']);
    }

    public function list() {
        $this->presenter->show("jugarPartida", []);
    }
}

