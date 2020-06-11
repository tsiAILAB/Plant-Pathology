<?php
    session_start();
    $msg= "";
    if (isset($_POST['submit'])){
        $email = $_POST['email'];
        $password = $_POST['password'];
        $confirmPassword = $_POST['confirmPassword'];

        $con = mysqli_connect("localhost", "root", "", "pds_web");

        $check = mysqli_num_rows(mysqli_query($con, "select * from user where email='$email'"));
        if ($check>0){
            $msg = "<p style='color: red;'>Email already exists</p>";
        }else{
            if ($password === $confirmPassword){

                $otp = rand(11111, 99999);

                $sql = "INSERT INTO user (email, password, verification_status, otp, role) VALUES ('$email', '$password', 0, '$otp', 'user_role')";
                mysqli_query($con, $sql);
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
                $msg = "<p style='color: red'>Password did not match</p>";
            }
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
    <title>Sign Up</title>
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/main.css">
    <link rel="stylesheet" href="../css/material_design_input_field.css">
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
            <div class="text-center">
                <h2><?php echo $msg?></h2>
            </div>
            <div class="form-group signup-field">
                <input name="email" type="text" id="emailField" required class="input-area">
                <label for="emailField" class="label">Email</label>
                <span class="inputFieldIconStyle"><i class="material-icons text-secondary">email</i></span>
            </div>
            <div class="form-group signup-field" style="margin-top: 15px">
                <input name="password" type="text" id="passwordField" required class="input-area">
                <label for="passwordField" class="label">Password</label>
                <span class="inputFieldIconStyle"><i class="material-icons text-secondary">security</i></span>
            </div>
            <div class="form-group signup-field" style="margin-top: 15px">
                <input name="confirmPassword" type="text" id="confirmPasswordField" required class="input-area">
                <label for="confirmPasswordField" class="label">Confirm Password</label>
                <span class="inputFieldIconStyle"><i class="material-icons text-secondary">security</i></span>
            </div>
            <div class="text-center mt-3 signup-field">
                <input type="submit" name="submit" id="signupFormSubmit" class="btn rounded-btn text-def w-100" style="border: 1px solid gray; color: #6B9790; font-weight: bold" value="Submit">
            </div>

<!--            OTP Verification section-->
            <div class="form-group otp-field" style="margin-top: 15px">
                <input name="otp" type="text" id="otpField" class="input-area">
                <label for="otp" class="label">OTP</label>
                <span class="inputFieldIconStyle"><i class="material-icons text-secondary">border_color</i></span>
            </div>
            <div class="text-center mt-3 otp-field">
                <input type="submit" name="otpSubmit" id="otpSubmit" class="btn rounded-btn text-def w-100" style="border: 1px solid gray; color: #6B9790; font-weight: bold" value="Submit">
            </div>
        </form>
    </div>
</div>



<!--<div class="popup">-->
<!--    <div class="popup-content">-->
<!--        <div class="close">-->
<!--            <i class="material-icons text-secondary">highlight_off</i>-->
<!--        </div>-->
<!--        <div class="text-center">-->
<!--            <h4 class="text-blueGray">OTP Verification</h4>-->
<!--            <hr/>-->
<!--        </div>-->
<!--        <form action="">-->
<!--            <div class="form-group">-->
<!--                <input name="email" type="text" id="emailField" required class="input-area">-->
<!--                <label for="emailField" class="label">OTP</label>-->
<!--                <span class="inputFieldIconStyle"><i class="material-icons text-secondary">border_color</i></span>-->
<!--            </div>-->
<!--            <div class="text-center mt-3">-->
<!--                <input type="submit" name="otpSubmit" id="signupFormSubmit" class="btn rounded-btn text-def w-100" style="border: 1px solid gray; color: #6B9790; font-weight: bold" value="Submit">-->
<!--            </div>-->
<!--        </form>-->
<!--    </div>-->
<!--</div>-->

<script>

    // function send_otp() {
    //     var email = jQery('#email').val();
    //     jQery.ajax({
    //         url: 'send_otp.php',
    //         type: 'post',
    //         data: 'email='+email,
    //         success:function (result) {
    //             if (result === yes){
    //                 jQuery('.otp-field').show();
    //                 jQuery('.signup-field').hide();
    //             }else{
    //                 console.log("Something Went Wrong JK");
    //             }
    //         }
    //     })
    // }

    // document.getElementById("signupFormSubmit").addEventListener("click", function () {
    //     document.querySelector(".popup").style.display = "flex";
    // })
    // document.querySelector(".close").addEventListener("click", function () {
    //     document.querySelector(".popup").style.display = "none";
    // })
</script>
</body>
</html>