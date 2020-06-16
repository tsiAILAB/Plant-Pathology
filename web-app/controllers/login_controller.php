<?php

$emailPasswordEmpty = "";
$emailEmpty = "";
$passwordEmpty ="";
$emailNotRegisteredError = "";
$invalidCredentials = "";

if (isset($_POST['signInSubmit'])){

    function validate($data){
        $data = trim($data);
        $data = stripslashes($data);
        $data = htmlspecialchars($data);
        return $data;
    }

    $email = validate($_POST['email']);
    $password = validate($_POST['password']);
    $password = md5($password);

    if (empty($email) && empty($passwordEmpty)){
        $emailPasswordEmpty = "<p class='text-danger'>This field can not ne empty.!</p>";
    }elseif (empty($email)){
        $emailEmpty = "<p class='text-danger'>Email field can not ne empty.!</p>";
    }elseif (empty($password)){
        $passwordEmpty = "<p class='text-danger'>Password field can not ne empty.!</p>";
    }else{
        $db = mysqli_connect("localhost", "root", "", "pds_web");

        $sqlEmailNotRegistered = "SELECT * FROM user WHERE email='$email'";
        $sqlInvalidCredintial = "SELECT * FROM user WHERE email='$email' AND password !='$password'";
        $sqlAdmin = "SELECT * FROM user WHERE email='$email' AND password='$password' AND role='admin_role'";
        $sqlUser = "SELECT * FROM user WHERE email='$email' AND password='$password' AND role='user_role'";

        $resultEmailNotRegistered = mysqli_query($db, $sqlEmailNotRegistered);
        $resultInvalidCredintial = mysqli_query($db, $sqlInvalidCredintial);
        $resultAdmin = mysqli_query($db, $sqlAdmin);
        $resultUser = mysqli_query($db, $sqlUser);

        $countEmailNotRegistered = mysqli_num_rows($resultEmailNotRegistered);
        $countInvalidCredintial =mysqli_num_rows($resultInvalidCredintial);
        $countAdmin = mysqli_num_rows($resultAdmin);
        $countUser = mysqli_num_rows($resultUser);

        if ($countEmailNotRegistered == 0){
            $emailNotRegisteredError = "<p class='text-danger'>Email not registered.!</p>";
        }elseif ($countInvalidCredintial >= 1){
            $invalidCredentials = "<p class='text-danger'>Invalid credentials.!</p>";
        }elseif ($countAdmin == 1){
            $_SESSION['IS_LOGIN_ADMIN'] = $email;
            flashMessage("login_as_admin", "Successfully Login as Admin");
            header('Location: ../landing_page.php');
        }elseif ($countUser == 1){
            flashMessage("login_as_user", "Successfully Login as User");
            $_SESSION['IS_LOGIN_USER'] = $email;
            header('Location: ../landing_page.php');
        }
    }
}

?>