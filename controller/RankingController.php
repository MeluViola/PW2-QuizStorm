<?php
class RankingController
{
    private $RankingModel;
    private $presenter;


    public function __construct($RankingModel, $presenter)
    {
        $this->RankingModel = $RankingModel;
        $this->presenter = $presenter;
    }

    public function list (){
        $data = $this->RankingModel->getRanking();
        $this->presenter->show("ranking", $data);
    }
}
