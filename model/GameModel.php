<?php

class GameModel {

    private $database;

    public function __construct($database) {
        $this->database = $database;
    }

    public function crearPartida($id_usuario){
        $sql = 'INSERT INTO `partida` (id_usuario) VALUES (?)';
        $this->database->execute($sql, [$id_usuario]);
        return $this->database->getLastInsertId();
    }

    public function obtenerPartidaActual($id_usuario){
        return $this->database->query("SELECT * FROM partida WHERE id_usuario = ". $id_usuario . " ORDER BY fecha_partida DESC LIMIT 1");
    }

    public function ValidacionRecargaDePagina($idPartida, $idPregunta, $respuestaUsuario) {
        $sql = "SELECT * FROM partida_pregunta WHERE id_partida = ? AND id_pregunta = ? AND respuesta_usuario = ?";
        $respuestas = $this->database->query($sql, [$idPartida, $idPregunta, $respuestaUsuario]);
        if (!empty($respuestas)) {
            return true;
        }
        return false;
    }

}

