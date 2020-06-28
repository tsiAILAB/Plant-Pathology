<?php

require '../../controllers/signup_controller.php';

?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta id="Viewport" name="viewport" content="initial-scale=1, maximum-scale=1,
        minimum-scale=1, user-scalable=no">
    <title>Sign Up</title>
    <link rel="stylesheet" href="../../assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="../../assets/css/main.css">
    <link rel="stylesheet" href="../../assets/css/material_design_input_field.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/material-design-icons/3.0.1/iconfont/material-icons.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
    <style>
        .popup{
            background: rgba(0, 0, 0, 0.6);
            width: 100%;
            height: 100%;
            position: absolute;
            top: 0;
            justify-content: center;
            align-items: center;
            display: none;
        }
        .popup-content{
            height: 200px;
            width: 300px;
            background: white;
            padding: 10px;
            border-radius: 5px;
            position: relative;
        }
        .close{
            position: absolute;
            right: 0;
            top: 0;
            cursor: pointer;
        }
        .otp-field{
            display: none;
        }
    </style>
</head>
<body>
<div class="container col-sm-12 col-md-8 col-lg-8">
    <nav class="d-flex justify-content-center shadow">
        <h5 class="text-blueGray p-2">Sign Up</h5>
    </nav>

    <div class="container col-md-8">
        <form method="post" action="signup_page.php" style="margin-top: 35%">
            <div class="form-group signup-field">
                <input name="email" type="text" id="emailField" class="input-area">
                <label for="emailField" class="label">Email</label>
                <span class="inputFieldIconStyle"><i class="material-icons text-secondary">email</i></span>
                <span style="display: block"><?php echo $emptyEmail, $emailExists?></span>
            </div>
            <div class="form-group signup-field" style="margin-top: 15px">
                <input name="password" type="password" id="passwordField" class="input-area">
                <label for="passwordField" class="label">Password</label>
                <span class="inputFieldIconStyle"><i class="material-icons text-secondary">security</i></span>
                <span style="display: block"><?php echo $emptyPassword, $unmatchedPassword ?></span>
            </div>
            <div class="form-group signup-field" style="margin-top: 15px">
                <input name="confirmPassword" type="password" id="confirmPasswordField" class="input-area">
                <label for="confirmPasswordField" class="label">Confirm Password</label>
                <span class="inputFieldIconStyle"><i class="material-icons text-secondary">security</i></span>
                <span style="display: block"><?php echo $emptyConfirmPassword, $unmatchedPassword ?></span>
            </div>
            <div class="text-center mt-3 signup-field">
                <input type="submit" name="signUpSubmit" id="signupFormSubmit" class="btn rounded-btn text-def w-100" style="border: 1px solid gray; color: #6B9790; font-weight: bold" value="Submit">
            </div>
        </form>
    </div>
</div>
</body>
</html>