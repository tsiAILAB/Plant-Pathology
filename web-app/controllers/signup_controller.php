<?php

//require '../models/db.php';

session_start();
$msg= "";
$emailExistError = "";
if (isset($_POST['signUpSubmit'])){
    $email = $_POST['email'];
    $password = $_POST['password'];
    $confirmPassword = $_POST['confirmPassword'];

        $db = mysqli_connect("localhost", "root", "", "pds_web");

    $check = mysqli_num_rows(mysqli_query($db, "select * from user where email='$email'"));
    if ($check>0){
        $emailExistError = "<p style='color: red; font-size: 14px'>Email already exists.......!!</p>";
//        header('Location: ../authentication/signup_page.php');
    }else{
        if ($password === $confirmPassword){

            $password = md5($password);

            $otp = rand(11111, 99999);

            $sql = "INSERT INTO user (email, password, verification_status, otp, role) VALUES ('$email', '$password', 0, '$otp', 'user_role')";
            mysqli_query($db, $sql);
            $msg = "<p style='color: #1c7430'>Sign Up Successfully</p>";

            $html = "Your Signup email OTP verification code is ".$otp;
            $_SESSION['EMAIL'] =  $email;
            smtp_mailer($email,'PDS - Email OTP Verification', $html);

//                echo "<script>document.getElementById(\"signupFormSubmit\").addEventListener(\"click\", function () {
//                    document.querySelector(\".popup\").style.display = \"flex\";
//                })</script>";

            header("Location:signup_otp_email_verification.php");
//                echo "<script>alert('Sign Up Successfully')</script>";
        }else{
            $msg = "<p style='color: red; font-size: 14px'>Password did not match.........!!</p>";
        }
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
