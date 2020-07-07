<?php

class AllApis {
    public $API_NAME = "UPLOAD_IMAGE";
    public $uploadImageUrl;
//    public $uploadImageUrl = "https://localhost:44379/uploadimage";


    public function __construct(){
        $db = mysqli_connect("localhost", "root", "", "pds_web");
        $query = "SELECT api_url FROM apis WHERE api_name='UPLOAD_IMAGE'";
        $result = mysqli_query($db, $query);
//        $count = mysqli_num_rows($result);

        if ($row= mysqli_fetch_assoc($result)){
            $this->uploadImageUrl = $row['api_url'];
        }
    }

    public function getApiUrl (){
        return $this->uploadImageUrl;
    }

}


?>
