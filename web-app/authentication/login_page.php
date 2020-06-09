<?php
session_start();
$msg = "";
if (isset($_POST['signInSubmit'])){

    //connect to databse
    $db = mysqli_connect("localhost", "root", "", "pds_web");

    $email = $_POST['email'];
    $password = $_POST['password'];

//    $sql = "INSERT INTO landing_page_crops (crop_icon_image, crop_name) VALUES ('$cropIconImage', '$cropName')";
    $sql = "SELECT * FROM user WHERE email='$email' AND password='$password'";
    $result = mysqli_query($db, $sql); //stores the submitted data into the database table : landing_page_crops


    $count = mysqli_num_rows($result);
    if ($count == 1){
        $_SESSION['IS_LOGIN'] = $email;
        header('Location: ../uis/landing_page.php');
    }else{
        echo "<script>alert('Invalid Credintials ....!!');</script>";
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta id="Viewport" name="viewport" content="initial-scale=1, maximum-scale=1,
        minimum-scale=1, user-scalable=no">
    <title>Plant Diagnosis System</title>
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/main.css">
    <link rel="stylesheet" href="../css/material_design_input_field.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/material-design-icons/3.0.1/iconfont/material-icons.min.css">
</head>
<body>
    <div class="container col-sm-12 col-md-8 col-lg-8">
        <nav class="d-flex justify-content-center shadow">
            <h5 class="text-blueGray p-2">Plant Diagnosis System</h5>
        </nav>

        <div class="container col-md-8">
            <form method="post" action="login_page.php" style="margin-top: 27.5%">
                <div class="form-group">
                    <input type="text" name="email" id="emailField" required class="input-area">
                    <label for="emailField" class="label">Email</label>
                    <span class="inputFieldIconStyle"><i class="material-icons text-secondary">email</i></span>
                </div>
                <div class="form-group" style="margin-top: 15px">
                    <input type="text" name="password" id="passwordField" required class="input-area">
                    <label for="passwordField" class="label">Password</label>
                    <span class="inputFieldIconStyle"><i class="material-icons text-secondary">security</i></span>
                </div>
                <p class="text-center text-secondary">Already Registered?</p>
                <div class="text-center">
                    <input type="submit" name="signInSubmit" class="btn text-success w-100" style="font-size: 25px" value="Sign In">
                    <button type="submit" class="btn text-info w-100">Forgot Password?</button>
                    <button type="submit" class="btn text-info w-100">New to Plant Diagnosis System? Sign Up</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>