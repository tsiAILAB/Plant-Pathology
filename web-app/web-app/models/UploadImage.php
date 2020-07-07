<?php

require 'apis/AllApis.php';

class UploadImage {

    public $allApis;

    public function getApi (){
        $this->allApis = new AllApis();
        $uploadImageAPI = $this->allApis->uploadImageUrl;
        return $uploadImageAPI;
    }

    public function upload($imageFileForUpload, $plantName) {
        if ($imageFileForUpload == null){
            return;
        }
        $base64Image = base64_encode($imageFileForUpload);

        //tutorial

        if (isset($_POST['submit'])){
            $file = $_FILES['file'];

            $fileName = $_FILES['file']['name'];
            $fileTmpName = $_FILES['file']['tmp_name'];
            $fileSize = $_FILES['file']['size'];
            $fileError = ['file']['error'];
            $fileType = $_FILES['file']['type'];

            $fileExt = explode('.', $fileName);
            $fileActulalExt = strtolower(end($fileExt));

            $allowed = array('jpg', 'jpeg', 'png');

            if (in_array($fileActulalExt, $allowed)){
                if ($fileError === 0){
                    if ($fileSize < 7000){
                        $fileNameNew = uniqid('', true).".".$fileActulalExt;
                        $fileDestination = '../assets/images/'.$fileNameNew;
                        move_uploaded_file($fileTmpName, $fileDestination);
                        header('Location: ../views/plant_diagnosis_report.php');
                    }else{
                        echo "The image size is too big";
                    }
                }else{
                    echo "There was an error uploading your image!";
                }
            }else{
                echo "You cannot upload images of this type !";
            }
        }
    }
}
