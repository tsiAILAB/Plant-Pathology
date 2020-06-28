<?php

//require '../models/db.php';
//
//$tomatoObj = new CropDetails("Tomato", "../assets/images/tomato.jpg");
//$potatoObj = new CropDetails("Potato", "../assets/images/potato.jpg");
//$mazeObj = new CropDetails("Maze", "../assets/images/maze.jpg");

//if (isset($_POST['potato'])){
//    header('Location:plant-diagnosis/take_image_ui.php');
//}

session_start();
function flashMessage ($name, $text = ''){
    if ($name !=null){
        return $name;
    }else{
        $name = $text;
    }
    return '';
}
//function flashMessage ($name, $text = ''){
//    if (isset($_SESSION[$name])){
//        $message = $_SESSION[$name];
//        unset($_SESSION[$name]);
//        return $message;
//    }else{
//        $_SESSION[$name] = $text;
//    }
//    return '';
//}
if (isset($_SESSION['IS_LOGIN_ADMIN']) || isset($_SESSION['IS_LOGIN_USER']) || isset($_SESSION['SIGNUP_SUCCESS'])){

?>

    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta id="Viewport" name="viewport" content="initial-scale=1, maximum-scale=1,
        minimum-scale=1, user-scalable=no">
        <title>Plant Selection</title>
        <link rel="stylesheet" href="../assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="../assets/css/main.css">
        <link rel="stylesheet" href="../assets/css/toastr.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
        <style>
            button:focus{
                outline: none;
            }
        </style>

    </head>
    <body>
    <div class="container col-sm-12 col-md-8 col-lg-8">
        <nav class="d-flex justify-content-between shadow ">
            <h5 class="text-blueGray p-2">Plant Selection</h5>
            <div class="float-right">
                <p class="pt-2 text-blueGray">
                    <?php if (isset($_SESSION['IS_LOGIN_ADMIN']))  {?>
                        <a href="configurations/configurations_ui.php" class="text-blueGray" style="text-decoration: none"><i class="fa fa-cog fa-lg" aria-hidden="true"></i></a>
                    <?php } ?>
                    <span class="text-blueGray">
                        <a href="../controllers/logout_controller.php" class="text-blueGray"><i class="fa fa-power-off fa-lg pr-2 pl-4" aria-hidden="true"></i></a>
                    </span>
                </p>
            </div>
        </nav>
    </div>
    <div class="container d-flex flex-column justify-content-center">
<!--        <a href="plant-diagnosis/take_image_ui.php" id="cropMainA" onclick="getCropDetails()" style="text-decoration: none">-->
<!--            <div class="text-center">-->
<!--                <img src="--><?php //echo $tomatoObj->cropUrl?><!--" id="crop" style="border-radius: 50%; height: 125px; width: 125px">-->
<!--                <p class="text-center text-secondary" id="tomato" style="font-weight: bold">--><?php //echo $tomatoObj->cropName?><!--</p>-->
<!--            </div>-->
<!--        </a>-->
<!--        <div class="text-center">-->
<!--            <form method="post" action="landing_page.php">-->
<!--                <button type="submit" name="potato" style="background-color: transparent; border: none;" class="text-secondary">-->
<!--                    <img src="--><?php //echo $potatoObj->cropUrl?><!--" style="border-radius: 50%; height: 125px; width: 125px">-->
<!--                    <p class="text-center" style="font-weight: bold">--><?php //echo $potatoObj->cropName?><!--</p>-->
<!--                </button>-->
<!--            </form>-->
<!--        </div>-->
<!--        <a href="plant-diagnosis/take_image_ui.php" style="text-decoration: none">-->
<!--            <div class="text-center">-->
<!--                <img src="--><?php //echo $mazeObj->cropUrl?><!--" style="border-radius: 50%; height: 125px; width: 125px">-->
<!--                <p class="text-center text-secondary" style="font-weight: bold">--><?php //echo $mazeObj->cropName?><!--</p>-->
<!--            </div>-->
<!--        </a>-->
        <?php
        $db = mysqli_connect("localhost", "root", "", "pds_web");
        $sql = "SELECT * FROM landing_page_crops";
        $result = mysqli_query($db, $sql);
        while ($row = mysqli_fetch_array($result)) {
            echo "<a href=\"plant-diagnosis/take_image_ui.php?id=".$row['id']."\" style=\"text-decoration: none\">";
            echo " <div class=\"text-center\">";
            echo "<img src='../assets/images/".$row['crop_icon_image']."' style=\"border-radius: 50%; height: 125px; width: 125px\">";
            echo "<p class=\"text-center text-secondary\" style=\"font-weight: bold\">".$row['crop_name']."</p>";
            echo "</div>";
            echo "</a>";
        }
        ?>
    </div>

    <script src="../assets/js/toastr.min.js"></script>
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
        <?php if (isset($_SESSION['IS_LOGIN_ADMIN'])) {?>
        toastr.success("<?php echo flashMessage('Successfully Login as Admin...'); ?>");
        <?php }elseif (isset($_SESSION['IS_LOGIN_USER'])){ ?>
        toastr.success("<?php echo flashMessage('Successfully Login as User...'); ?>");
        <?php }elseif (isset($_SESSION['SIGNUP_SUCCESS'])){ ?>
        toastr.success("<?php echo flashMessage('Sign Up Success and Login as User'); ?>");
        <?php } ?>
    </script>
    <script>
        // $(document.readyState)
        $('#cropMainA').click(function () {
            cropName = document.getElementById('#tomato').innerHTML;
            localStorage.setItem("cropName", cropName);
        })

        // document.querySelector('#selectedImageOne').setAttribute('src', e.target.result);
    </script>
    </body>
    </html>

<?php }else{
    header('Location:../views/authentications/login_page.php');
    die();
}

?>


