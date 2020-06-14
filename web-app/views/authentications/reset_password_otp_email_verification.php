<?php
require '../../controllers/reset_password_otp_email_verification_controller.php';
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta id="Viewport" name="viewport" content="initial-scale=1, maximum-scale=1,
        minimum-scale=1, user-scalable=no">
    <title>OTP Verification</title>
    <link rel="stylesheet" href="../../assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="../../assets/css/main.css">
    <link rel="stylesheet" href="../../assets/css/material_design_input_field.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/material-design-icons/3.0.1/iconfont/material-icons.min.css">
</head>
<body>
<div class="container col-sm-12 col-md-8 col-lg-8">
    <nav class="d-flex justify-content-center shadow">
        <h5 class="text-blueGray p-2">OTP Verification</h5>
    </nav>

    <div class="container col-md-8">
        <form method="post" action="reset_password_otp_email_verification.php" style="margin-top: 35%">
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
