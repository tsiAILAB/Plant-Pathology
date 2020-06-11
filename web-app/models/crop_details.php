<?php

class CropDetails{
    public $cropUrl = "";
    public $cropName = "";

    public function __construct($cropName, $cropUrl)
    {
        $this->cropUrl = $cropUrl;
        $this->cropName = $cropName;
    }



//    public function cropUrl($url){
//        $this->cropUrl = $url;
//    }
//
//    public function cropName($name){
//        $this->cropUrl = $name;
//    }
}

?>
