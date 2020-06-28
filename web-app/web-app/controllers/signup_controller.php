<?php

session_start();

function flashMessage ($name, $text = ''){
    if ($name !=null){
        return $name;
    }else{
        $name = $text;
    }
    return '';
}

$emptyEmail = "";
$emptyPassword = "";
$emptyConfirmPassword = "";
$emailExists = "";
$unmatchedPassword = "";

if (isset($_POST['signUpSubmit'])){

    function validate($data){
        $data = trim($data);
        $data = stripslashes($data);
        $data = htmlspecialchars($data);
        return $data;
    }

    $email = $_POST['email'];

    if (filter_var($email, FILTER_VALIDATE_EMAIL == true)){
        $email = validate($email);
    }

    $password = validate($_POST['password']);
    $confirmPassword = validate($_POST['confirmPassword']);

    if (empty($email)){
        $emptyEmail = "<p class='text-danger'>Email field cant not be empty.!</p>";
    }elseif (empty($password)){
        $emptyPassword = "<p class='text-danger'>Password cant not be empty.!</p>";
    }elseif (empty($confirmPassword)){
        $emptyConfirmPassword = "<p class='text-danger'>Confirm Password can not be empty.!</p>";
    }else {
        $db = mysqli_connect("localhost", "root", "", "pds_web");
        $check = mysqli_num_rows(mysqli_query($db, "select * from user where email='$email'"));

        if ($check> 0){
            $emailExists = "<p style='color: red; font-size: 14px'>Email already exists try a new one..!</p>";
        }elseif ($password != $confirmPassword){
            $unmatchedPassword = "<p style='color: red; font-size: 14px'>Password did not match.!</p>";
        }elseif ($password === $confirmPassword){
            $password = md5($password);

            $otp = rand(11111, 99999);

            $sql = "INSERT INTO user (email, password, verification_status, otp, role) VALUES ('$email', '$password', 0, '$otp', 'user_role')";
            mysqli_query($db, $sql);
            $msg = "<p style='color: #1c7430'>Sign Up Successfully</p>";

            $html = "Your Signup email OTP verification code is ".$otp;
            $_SESSION['EMAIL'] =  $email;
            flashMessage("check_otp", "check_otp");
            smtp_mailer($email,'PDS - Email OTP Verification', $html);
            header("Location:signup_otp_email_verification.php");
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
