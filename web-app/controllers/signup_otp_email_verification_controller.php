<?php

session_start();
//require '../models/db.php';
function flashMessage ($name, $text = ''){
    if ($name !=null){
        return $name;
    }else{
        $name = $text;
    }
    return '';
}

$msg = "";
if (isset($_POST['signUpOtpSubmit'])){

    function validate($data){
        $data = trim($data);
        $data = stripslashes($data);
        $data = htmlspecialchars($data);
        return $data;
    }

    //connect to databse
    $db = mysqli_connect("localhost", "root", "", "pds_web");

    $otpCode = validate($_POST['otp']);
    $email = $_SESSION['EMAIL'];

//    $sql = "INSERT INTO landing_page_crops (crop_icon_image, crop_name) VALUES ('$cropIconImage', '$cropName')";
    $sql = "SELECT * FROM user WHERE email='$email' AND otp='$otpCode'";
    $result = mysqli_query($db, $sql); //stores the submitted data into the database table : landing_page_crops


    $count = mysqli_num_rows($result);
    if ($count == 1){
        mysqli_query($db, "UPDATE user SET verification_status=1 WHERE email='$email'");
        $_SESSION['SIGNUP_SUCCESS'] = $email;
        flashMessage("reset_pass_auto_login", "reset_pass_auto_login_done");

        header('Location: ../landing_page.php');
    }else{
//        $_SESSION['PASS_RESET'] = $email;
//        flashMessage("reset_pass", "reset_pass");
        header('Location: login_page.php');
    }
}

?>
