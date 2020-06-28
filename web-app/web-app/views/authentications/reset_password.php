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
    <link rel="stylesheet" href="../../assets/css/toastr.min.css">
    <link rel="stylesheet" href="../../assets/css/material_design_input_field.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/material-design-icons/3.0.1/iconfont/material-icons.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
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
                <input type="password" name="password" id="newPassword" required class="input-area">
                <label for="newPassword" class="label">Password</label>
                <span class="inputFieldIconStyle"><i class="material-icons text-secondary">security</i></span>
                <p style="display: block"><?php echo $msg?></p>
            </div>
            <div class="form-group" style="margin-top: 15px">
                <input type="password" name="confirmPassword" id="confirmpassword" required class="input-area">
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

<script src="../../assets/js/toastr.min.js"></script>
<script>
    toastr.options = {
        "closeButton": false,
        "debug": false,
        "newestOnTop": false,
        "progressBar": false,
        "positionClass": "toast-bottom-center",
        "preventDuplicates": false,
        "onclick": null,
        // "showDuration": "300",
        "showDuration": "300",
        // "hideDuration": "1000",
        "hideDuration": "1000",
        // "timeOut": "5000",
        "timeOut": "16000",
        // "extendedTimeOut": "1000",
        "extendedTimeOut": "1000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
    }
</script>
<script>
    <?php if (isset($_SESSION['EMAIL'])) : ?>
    toastr.warning("<?php echo flashMessage('Reset your Password..!!'); ?>");
    <?php endif?>

</script>
</body>
</html>