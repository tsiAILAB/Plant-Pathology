<?php

//require '../models/db.php';

session_start();

function flashMessage ($name, $text = ''){
    if ($name !=null){
        return $name;
    }else{
        $name = $text;
    }
    return '';
}
$msg = "";
if (isset($_POST['submit'])){

    function validate($data){
        $data = trim($data);
        $data = stripslashes($data);
        $data = htmlspecialchars($data);
        return $data;
    }

    //connect to databse
    $db = mysqli_connect("localhost", "root", "", "pds_web");

    $password = validate($_POST['password']);
    $confirmPassword = validate($_POST['confirmPassword']);
    $email = validate($_SESSION['EMAIL']);

    if ($password === $confirmPassword){

        $password = md5($password);

        $sql = "UPDATE user SET password='$password' WHERE email='$email'";
        mysqli_query($db, $sql);
        $_SESSION['PASSWORD_RESET_SUCCESSFULLY'] = $email;

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
