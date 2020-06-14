<?php

//require '../models/db.php';

session_start();
$msg = "";
if (isset($_POST['submit'])){

    //connect to databse
    $db = mysqli_connect("localhost", "root", "", "pds_web");

    $password = $_POST['password'];
    $confirmPassword = $_POST['confirmPassword'];
    $email = $_SESSION['EMAIL'];

    if ($password === $confirmPassword){

        $password = md5($password);

        $sql = "UPDATE user SET password='$password' WHERE email='$email'";
        mysqli_query($db, $sql);

        header('Location:login_page.php');
    }else{
        $msg = "<p class='text-danger'>Password did not match</p>";
    }


//    $count = mysqli_num_rows($result);
//    if ($count == 1){
////        $_SESSION['IS_LOGIN'] = $email;
//        mysqli_query($db, "UPDATE user SET verification_status=1 WHERE email='$email'");
//
//        header('Location: ../uis/landing_page.php');
//    }else{
//        header('Location: signup_otp_email_verification.php');
//    }
}

?>
