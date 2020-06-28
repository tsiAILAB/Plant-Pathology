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
    <link rel="stylesheet" href="../../assets/css/toastr.min.css">
    <link rel="stylesheet" href="../../assets/css/material_design_input_field.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/material-design-icons/3.0.1/iconfont/material-icons.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
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
        "timeOut": "8000",
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
    toastr.success("<?php echo flashMessage('Check Mail for Email OTP Verification'); ?>");
    <?php endif ?>
</script>
</body>
</html>
