<?php

class JugarPartidaModel {
    private $database;

    public function __construct($database) {
        $this->database = $database;
    }

    public function crearPartida($id_usuario) {

    }

    // Obtiene una pregunta aleatoria depende la dificultad
    public function obtenerPreguntaAleatoria($idUsuario) {
        // Obtener el porcentaje de aciertos
        $query = "SELECT porcentaje_respuestas_correctas FROM Estadisticas WHERE id_usuario = :idUsuario";
        $stmt = $this->database->prepare($query);
        $stmt->bindParam(':idUsuario', $idUsuario, PDO::PARAM_INT);
        $stmt->execute();
        $porcentajeAciertos = $stmt->fetchColumn();

        $dificultad = ($porcentajeAciertos >= 70) ? 'facil' : (($porcentajeAciertos < 30) ? 'dificil' : 'media');

        // Elegir una pregunta aleatoria de la dificultad y que el usuario no haya visto
        $query = "
            SELECT * FROM Pregunta 
            WHERE dificultad = :dificultad 
            AND id_pregunta NOT IN (
                SELECT id_pregunta FROM Partida_Pregunta 
                JOIN Partida ON Partida.id_partida = Partida_Pregunta.id_partida
                WHERE Partida.id_usuario = :idUsuario
            ) 
            ORDER BY RAND() LIMIT 1";
        $stmt = $this->database->prepare($query);
        $stmt->bindParam(':dificultad', $dificultad, PDO::PARAM_STR);
        $stmt->bindParam(':idUsuario', $idUsuario, PDO::PARAM_INT);
        $stmt->execute();

        return $stmt->fetch(PDO::FETCH_ASSOC); //Devuelve la pregunta seleccionada
    }

    // Registra la respuesta del usuario y verifica si es correcta
    public function registrarRespuesta($idPartida, $idPregunta, $respuestaUsuario) {
        // Consultar la respuesta correcta
        $query = "SELECT respuesta_correcta FROM Pregunta WHERE id_pregunta = :idPregunta";
        $stmt = $this->database->prepare($query);
        $stmt->bindParam(':idPregunta', $idPregunta, PDO::PARAM_INT);
        $stmt->execute();
        $respuestaCorrecta = $stmt->fetchColumn();

        $esCorrecto = ($respuestaUsuario === $respuestaCorrecta);

        // Guarda la respuesta en Partida_Pregunta
        $query = "INSERT INTO Partida_Pregunta (id_partida, id_pregunta, respuesta_usuario, correcto) 
                  VALUES (:idPartida, :idPregunta, :respuestaUsuario, :correcto)";
        $stmt = $this->database->prepare($query);
        $stmt->bindParam(':idPartida', $idPartida, PDO::PARAM_INT);
        $stmt->bindParam(':idPregunta', $idPregunta, PDO::PARAM_INT);
        $stmt->bindParam(':respuestaUsuario', $respuestaUsuario, PDO::PARAM_STR);
        $stmt->bindParam(':correcto', $esCorrecto, PDO::PARAM_BOOL);
        $stmt->execute();

        return $esCorrecto; // Devuelve si la respuesta fue correcta o no
    }

    // Registrar la partida al finalizar y actualiza el puntaje
    public function finalizarPartida($idPartida, $puntosObtenidos) {
        $query = "UPDATE Partida SET puntos_obtenidos = :puntos, finalizada = 1 WHERE id_partida = :idPartida";
        $stmt = $this->database->prepare($query);
        $stmt->bindParam(':puntos', $puntosObtenidos, PDO::PARAM_INT);
        $stmt->bindParam(':idPartida', $idPartida, PDO::PARAM_INT);
        $stmt->execute();
    }
}

