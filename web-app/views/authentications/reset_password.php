<?php

require '../../controllers/reset_password_controller.php';

?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta id="Viewport" name="viewport" content="initial-scale=1, maximum-scale=1,
        minimum-scale=1, user-scalable=no">
    <title>Reset Password</title>
    <link rel="stylesheet" href="../../assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="../../assets/css/main.css">
    <link rel="stylesheet" href="../../assets/css/material_design_input_field.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/material-design-icons/3.0.1/iconfont/material-icons.min.css">
    <style>
        input[type="text"]:focus{
            border: none;
        }
    </style>
</head>
<body>
<div class="container col-sm-12 col-md-8 col-lg-8">
    <nav class="d-flex justify-content-center shadow">
        <h5 class="text-blueGray p-2">Reset Password</h5>
    </nav>

    <div class="container" style="margin-top: 22.5%">
        <form method="post" action="reset_password.php">
            <div class="form-group">
                <input type="text" name="password" id="newPassword" required class="input-area">
                <label for="newPassword" class="label">Password</label>
                <span class="inputFieldIconStyle"><i class="material-icons text-secondary">security</i></span>
                <p style="display: block"><?php echo $msg?></p>
            </div>
            <div class="form-group" style="margin-top: 15px">
                <input type="text" name="confirmPassword" id="confirmpassword" required class="input-area">
                <label for="confirmpassword" class="label">New Password</label>
                <span class="inputFieldIconStyle"><i class="material-icons text-secondary">security</i></span>
                <p style="display: block"><?php echo $msg?></p>
            </div>
<!--            <input type="email" id="newPassword" class="w-100" style="height: 45px; padding-left: 15px" placeholder="New Password">-->
<!--            <label for="newPassword" class="label1 position-relative" style="bottom: 34px; left: 16px">Email</label>-->
<!--            <input type="text" id="newConfirmPassword" class="w-100 mt-3" style="height: 45px; padding-left: 15px" placeholder="Confirm Password">-->
<!--            <label for="newConfirmPassword" class="label">Email</label>-->
            <div class="text-center mt-3">
                <input type="submit" name="submit" class="btn rounded-btn text-blueGray w-25" style="border: 1px solid lightslategray; font-weight: bold" value="Submit">
            </div>
        </form>
    </div>
</div>
</body>
</html>