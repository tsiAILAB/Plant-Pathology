<?php
session_start();
$msg = "";
if (isset($_POST['submit'])){

    //connect to databse
    $db = mysqli_connect("localhost", "root", "", "pds_web");

    $email = $_POST['email'];
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

        header('Location:reset_password_otp_email_verification.php');
    }else{
        $msg = "Email is not Exists";
    }
}

function smtp_mailer($to, $subject, $msg){
    require_once ("smtp/class.phpmailer.php");
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

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta id="Viewport" name="viewport" content="initial-scale=1, maximum-scale=1,
        minimum-scale=1, user-scalable=no">
    <title>Recover Password</title>
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/main.css">
    <link rel="stylesheet" href="../css/material_design_input_field.css">
    <link rel="stylesheet" href="../assets/fonts/icons/fontawesome.css">
    <link rel="stylesheet" href="../assets/fonts/icons/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/material-design-icons/3.0.1/iconfont/material-icons.min.css">
</head>
<body>
<div class="container col-sm-12 col-md-8 col-lg-8">
    <nav class="d-flex justify-content-center shadow">
        <h5 class="text-blueGray p-2">Recover Password</h5>
    </nav>

    <div class="container col-md-8">
        <form method="post" action="forgot_password.php" style="margin-top: 40%">
            <p><?php echo $msg?></p>
            <div class="form-group">
                <input type="text" name="email" id="emailField" required class="input-area">
                <label for="emailField" class="label">Enter Registered Email</label>
                <span class="inputFieldIconStyle"><i class="material-icons text-secondary">email</i></span>
            </div>
            <div class="text-center mt-3">
                <input name="submit" type="submit" class="btn rounded-btn text-def w-75" style="border-radius: 20px; font-weight: bold; color: #6B9790; border: 1px solid gray" value="Get Verification Code">
            </div>
        </form>
    </div>
</div>
</body>
</html>