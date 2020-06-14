<?php

//require '../models/db.php';
require '../models/apis/all_apis.php';

$msg = "";
if (isset($_POST['addNewCrop'])) {
    //the path to store the uploaded image
    $target = "../../assets/images/" . basename($_FILES['selectIconImage']['name']);

    //connect to databse
            $db = mysqli_connect("localhost", "root", "", "pds_web");

    //get all the submitted data from the form
    $cropIconImage = $_FILES['selectIconImage']['name'];
    $cropName = $_POST['cropName'];

    $sql = "INSERT INTO landing_page_crops (crop_icon_image, crop_name) VALUES ('$cropIconImage', '$cropName')";
    mysqli_query($db, $sql); //stores the submitted data into the database table : landing_page_crops

    //Move the uploaded image into the folder: assets/images
    if (move_uploaded_file($_FILES['selectIconImage']['tmp_name'], $target)) {
        $msg = "Crop Upladed successfully";
    } else {
        $msg = "Somethings went wrong";
    }
}

$allApis = new AllApis();
$apiName = $allApis->API_NAME;

if (isset($_POST['updateApi'])){
    $apiUrl = $_POST['apiUrl'];

//        $db = mysqli_connect("localhost", "root", "", "pds_web");
    $query = "UPDATE apis SET api_url='$apiUrl' WHERE api_name='$apiName'";

    mysqli_query($db, $query);
}

?>
