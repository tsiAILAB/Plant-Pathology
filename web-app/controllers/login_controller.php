<?php

//require '../models/db.php';
session_start();

//function flashMessage ($name, $text = ''){
//    if (isset($_SESSION[$name])){
//        $message = $_SESSION[$name];
//        unset($_SESSION[$name]);
//        return $message;
//    }else{
//        $_SESSION[$name] = $text;
//    }
//    return '';
//}
function flashMessage ($name, $text = ''){
    if ($name !=null){
        return $name;
    }else{
        $name = $text;
    }
    return '';
}

//function flashMessage ($name, $text = ''){
//    if (isset($_SESSION[$name])){
//        $message = $_SESSION[$name];
//        unset($_SESSION[$name]);
//        return $message;
//    }else{
//        $_SESSION[$name] = $text;
//    }
//    return '';
//}

//require 'utils/utils.php';

$msg = "";
$emailError = "";
if (isset($_POST['signInSubmit'])){

    //connect to databse
    $db = mysqli_connect("localhost", "root", "", "pds_web");

    $email = $_POST['email'];
    $password = $_POST['password'];
    $password = md5($password);

//    $sql = "INSERT INTO landing_page_crops (crop_icon_image, crop_name) VALUES ('$cropIconImage', '$cropName')";
    $sqlAdmin = "SELECT * FROM user WHERE email='$email' AND password='$password' AND role='admin_role'";
    $sqlUser = "SELECT * FROM user WHERE email='$email' AND password='$password' AND role='user_role'";
    $resultAdmin = mysqli_query($db, $sqlAdmin); //stores the submitted data into the database table : landing_page_crops
    $resultUser = mysqli_query($db, $sqlUser); //stores the submitted data into the database table : landing_page_crops


    $countAdmin = mysqli_num_rows($resultAdmin);
    $countUser = mysqli_num_rows($resultUser);
    if ($countAdmin == 1){
//        $role = mysqli_query($db, "SELECT * FROM user WHERE email='$email' AND role='admin_role'");
//        $roleCount = mysqli_num_rows($role);
//        if ($roleCount == 1){


        $_SESSION['IS_LOGIN_ADMIN'] = $email;
        flashMessage("login_as_admin", "Successfully Login as Admin");
        header('Location: ../landing_page.php');
//        }else{
//            $_SESSION['IS_LOGIN_USER'] = $email;
////            header('Location: ../uis/landing_page.php');
//        }
//            header('Location: ../uis/landing_page.php');
    }elseif ($countUser == 1){
        flashMessage("login_as_user", "Successfully Login as User");
        $_SESSION['IS_LOGIN_USER'] = $email;
        header('Location: ../landing_page.php');
    }else{
        $_SESSION['invalid_credintials'] = $email;
        flashMessage("invalid_credintials", "Invalid Credintials..!!");
        header('Location: login_page.php');
//        $emailError = "<p class='text-danger' style='font-size: 14px'>Invalid Credintials.....!!</p>";
//        echo "<script>toastr.success(flash('$msg'))</script>";
    }

}
?>