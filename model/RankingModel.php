<?php
class RankingModel
{
    private $database;

    public function __construct($database)
    {
        $this->database = $database;
    }

    public function getRanking() {
        $sql = "SELECT u.id_usuario as userId, u.nombre_usuario as userName, r.puntos_acumulados 
            FROM ranking as r
            JOIN usuarios as u ON u.id_usuario = r.id_usuario 
            ORDER BY r.puntos_acumulados DESC 
            LIMIT 10;";
        $ranking = $this->database->query($sql);

        foreach ($ranking as $i => &$user) {
            $user['i'] = $i + 1;
        }

        $data['ranking'] = $ranking;

        return $data;
    }

}