<?php
require '../../controllers/forgot_password_controller.php';

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta id="Viewport" name="viewport" content="initial-scale=1, maximum-scale=1,
        minimum-scale=1, user-scalable=no">
    <title>Recover Password</title>
    <link rel="stylesheet" href="../../assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="../../assets/css/main.css">
    <link rel="stylesheet" href="../../assets/css/material_design_input_field.css">
    <link rel="stylesheet" href="../../assets/fonts/icons/fontawesome.css">
    <link rel="stylesheet" href="../../assets/fonts/icons/all.min.css">
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