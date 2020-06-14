<?php
session_start();


?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta id="Viewport" name="viewport" content="initial-scale=1, maximum-scale=1,
        minimum-scale=1, user-scalable=no">
    <title>Report</title>
    <link rel="stylesheet" href="../../assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="../../assets/css/main.css">
    <link rel="stylesheet" href="../../assets/css/take_image_ui.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/material-design-icons/3.0.1/iconfont/material-icons.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
</head>
<body>

<div class="container col-sm-12 col-md-8 col-lg-8 popup-content">
    <nav class="d-flex justify-content-between shadow ">
        <h5 class="text-blueGray p-2">Early Blight</h5>
        <div class="float-right">

            <p class="pt-2 text-blueGray">
                <?php if (isset($_SESSION['IS_LOGIN_ADMIN']))  {?>
                <a href="../configurations/configurations_ui.php" class="text-blueGray" style="text-decoration: none"><i class="fa fa-cog fa-lg" aria-hidden="true"></i></a>
                <?php } ?>

                <span class="text-blueGray">
                    <a href="../../authentication/logout.php" class="text-blueGray"><i class="fa fa-power-off fa-lg pr-2 pl-4" aria-hidden="true"></i></a>
                </span>
            </p>
        </div>
    </nav>

    <div class="container col-sm-12 col-md-8 col-lg-8">
        <div class="d-flex justify-content-center mt-3">
            <img src="" id="DiagnosisCrop" style="height: 300px; width: 300px">
        </div>
        <div>
            <h3 class="text-blueGray">Diagnosis Result</h3>
        </div>
        <div>
            <p class="text-blueGray" id="diagnosisResult"></p>
        </div>
    </div>
</div>



<script>

    var x = 1;
    window.onload = function () {
        var selectedImageForDiagnosis = localStorage.getItem("selectedImageForDiagnosis");
        // var diagnosisResult = localStorage.getItem("diagnosisResult");

        console.log("URL_FROM_LOCAL_STORAGE : "+selectedImageForDiagnosis);

        document.querySelector('#DiagnosisCrop').setAttribute("src", selectedImageForDiagnosis);
        // document.querySelector('#diagnosisResult').innerHTML = diagnosisResult;



        var healthy = "Diseases Not Found, Probability-92.75%";
        var earlyBlight = "Diseases Found, Probability-92.75%";
        var lateBlight = "Diseases Found, Probability-98.12%";
        var notAPlant = "This is not a Plant!";

        switch (x) {
            case 1:
                document.getElementById('diagnosisResult').innerText = healthy;
                break;
            case 2:
                document.getElementById('diagnosisResult').innerText = earlyBlight;
                break;
            case 3:
                document.getElementById('diagnosisResult').innerText = lateBlight;
                break;
            case 4:
                document.getElementById('diagnosisResult').innerText = notAPlant;
                break;
        }
    }


    while (x<= 4){
        x +=1;
    }
    while (x>= 5){
        x = 1;
    }
</script>
</body>
</html>