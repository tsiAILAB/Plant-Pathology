<?php

session_start();

$API_NAME = "UPLOAD_IMAGE";
$uploadImageUrl = "https://localhost:44379/uploadimage";

function flashMessage ($name, $text = ''){
    if ($name !=null){
        return $name;
    }else{
        $name = $text;
    }
    return '';
}

function validate($data){
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);
    return $data;
}

//Add New Crop Controller Section Start

$emptyCropIconImage = "";
$emptyCropName = "";
$addNewCropSuccess = "";

if (isset($_POST['addNewCrop'])) {

    //the path to store the uploaded image
    $target = "../../assets/images/" . basename($_FILES['selectIconImage']['name']);

    $cropIconImage = $_FILES['selectIconImage']['name'];
    $cropName = validate($_POST['cropName']);

    if (empty($cropIconImage)){
        $emptyCropIconImage = "<p class='text-danger'>Crop icon image can not be null.!</p>";
    }elseif (empty($cropName)){
        $emptyCropName = "<p class='text-danger'>Crop name can not be empty.!</p>";
    }else{

        $db = mysqli_connect("localhost", "root", "", "pds_web");
        $sql = "INSERT INTO landing_page_crops (crop_icon_image, crop_name) VALUES ('$cropIconImage', '$cropName')";
        mysqli_query($db, $sql); //stores the submitted data into the database table : landing_page_crops

        if (move_uploaded_file($_FILES['selectIconImage']['tmp_name'], $target)) {
            $addNewCropSuccess = "<h5 class='text-success'>New Crop added successfully.!</h5>";
        }else{
            $somethingWentWrong = "<p class='text-danger'>Something went wrong.!</p>";
        }
    }
}
//Add New Crop Controller Section End

//Update API Controller Section Start

$apiUpdateSuccessMessage = "" ;
$apiFieldEmptyError = "";

if (isset($_POST['updateApi'])){

    $apiUrl = validate($_POST['apiUrl']);

    if (empty($apiUrl)){
        $apiFieldEmptyError = "<p class='text-danger'>This field can not be empty.!</p>";
    }else{
        $db = mysqli_connect("localhost", "root", "", "pds_web");
        $query = "UPDATE apis SET api_url='$apiUrl' WHERE api_name='$API_NAME'";
        mysqli_query($db, $query);
        $apiUpdateSuccessMessage = "<h5 class='text-success'>API updated Successfully.!</h5>";
    }
}
//Update API Controller Section End

?>
