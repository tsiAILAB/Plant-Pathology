<?php
session_start();
unset($_SESSION['IS_LOGIN_ADMIN']);
unset($_SESSION['IS_LOGIN_USER']);
unset($_SESSION['EMAIL']);
header('Location:../views/authentications/login_page.php');
die();
?>