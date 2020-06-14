<?php

//require '../models/db.php';

session_start();
$msg = "";
if (isset($_POST['signUpOtpSubmit'])){

    //connect to databse
    $db = mysqli_connect("localhost", "root", "", "pds_web");

    $otpCode = $_POST['otp'];
    $email = $_SESSION['EMAIL'];

//    $sql = "INSERT INTO landing_page_crops (crop_icon_image, crop_name) VALUES ('$cropIconImage', '$cropName')";
    $sql = "SELECT * FROM user WHERE email='$email' AND otp='$otpCode'";
    $result = mysqli_query($db, $sql); //stores the submitted data into the database table : landing_page_crops


    $count = mysqli_num_rows($result);
    if ($count == 1){
        $_SESSION['IS_LOGIN'] = $email;
        mysqli_query($db, "UPDATE user SET verification_status=1 WHERE email='$email'");

        header('Location: ../landing_page.php');
    }else{
        header('Location: login_page.php');
    }
}

?>
