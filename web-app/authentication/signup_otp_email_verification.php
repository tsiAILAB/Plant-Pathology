<?php
session_start();
$msg = "";
if (isset($_POST['otpSubmit'])){

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

       header('Location: ../uis/landing_page.php');
   }else{
       header('Location: signup_otp_email_verification.php');
   }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta id="Viewport" name="viewport" content="initial-scale=1, maximum-scale=1,
        minimum-scale=1, user-scalable=no">
    <title>OTP Verification</title>
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/main.css">
    <link rel="stylesheet" href="../css/material_design_input_field.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/material-design-icons/3.0.1/iconfont/material-icons.min.css">
</head>
<body>
<div class="container col-sm-12 col-md-8 col-lg-8">
    <nav class="d-flex justify-content-center shadow">
        <h5 class="text-blueGray p-2">OTP Verification</h5>
    </nav>

    <div class="container col-md-8">
        <form method="post" action="signup_otp_email_verification.php" style="margin-top: 35%">
            <div class="form-group">
                <input name="otp" type="text" id="otpField" required class="input-area">
                <label for="otpField" class="label">OTP</label>
                <span class="inputFieldIconStyle"><i class="material-icons text-secondary">border_color</i></span>
            </div>
            <div class="text-center mt-3">
                <input type="submit" name="otpSubmit" class="btn rounded-btn text-def w-100" style="border: 1px solid gray; color: #6B9790; font-weight: bold" value="Submit">
            </div>
        </form>
    </div>
</div>
</body>
</html>
