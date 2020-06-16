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

    $email = validate($_POST['email']);
//    $email = $_SESSION['EMAIL'];

//    $sql = "INSERT INTO landing_page_crops (crop_icon_image, crop_name) VALUES ('$cropIconImage', '$cropName')";
    $sql = "SELECT * FROM user WHERE email='$email'";
    $result = mysqli_query($db, $sql); //stores the submitted data into the database table : landing_page_crops


    $count = mysqli_num_rows($result);
    if ($count == 1){

        $otp = rand(11111, 99999);

        mysqli_query($db, "UPDATE user SET otp='$otp',verification_status=0 WHERE email='$email'");

        $html = "OTP verification code is ".$otp;
        $_SESSION['EMAIL'] =  $email;
        smtp_mailer($email,'PDS - Email OTP Verification', $html);

//        $updateOTPsql = "UPDATE user SET opt='$otp' WHERE email='$email'";

//        $_SESSION['IS_LOGIN'] = $email;
        flashMessage("recover_pass", "recover_pass");

        header('Location:reset_password_otp_email_verification.php');
    }else{
        $_SESSION['EMAIL_NOT_REGISTERED'] =  $email;
        flashMessage("invalid_email", "invalid_email_address");
//        header('Location:forgot_password.php');
//        $msg = "Email is not Exists";
    }
}

function smtp_mailer($to, $subject, $msg){
    require_once("smtp/class.phpmailer.php");
    $mail = new PHPMailer();
    $mail->IsSMTP();
    $mail->SMTPDebug = 1;
    $mail->SMTPAuth = true;
    $mail->SMTPSecure = 'tls';
    $mail->Host = "smtp.gmail.com";
    $mail->Port = 587;
    $mail->IsHTML(true);
    $mail->CharSet = 'UTF-8';
    $mail->Username = "plant.diagnosis.system.web@gmail.com";
    $mail->Password = "QWErty123@";
    $mail->SetFrom("plant.diagnosis.system.web@gmail.com");
    $mail->Subject = $subject;
    $mail->Body = $msg;
    $mail->AddAddress($to);
    if (!$mail->Send()){
        return 0;
    }else{
        return 1;
    }
}

?>