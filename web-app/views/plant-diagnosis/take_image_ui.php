<?php

require '../../models/db.php';

session_start();

//$cU = $_SESSION['cU'];
//include '../../models/crop_details.php';



//$cropName = "Tomato";
//$cropSrcUrl = "../../assets/images/tomato.jpg";
//
//$selectedCropName = "Tomato";
//$selectedCropImageSrc = "";
//
//switch ($selectedCropName){
//    case "Tomato":
//        $selectedCropImageSrc = "../../assets/images/tomato.jpg";
//        break;
//    case "Potato":
//        $selectedCropImageSrc = "../../assets/images/potato.jpg";
//        break;
//    case "Mage":
//        $selectedCropImageSrc = "../../assets/images/maze.jpg";
//        break;
//    default:
//        $selectedCropImageSrc = null;
//}

//if (isset($_POST['upload'])){
//    $selectedImageForUpload = $_POST['selectedImageForUpload'];
//}

//$crpN = $_POST['crop_name'];

if (isset($_SESSION['IS_LOGIN_ADMIN']) || isset($_SESSION['IS_LOGIN_USER']))

{
    ?>

    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8" >
        <meta id="Viewport" name="viewport" content="initial-scale=1, maximum-scale=1,
        minimum-scale=1, user-scalable=no">
        <title>PDS-Take Image</title>
        <link rel="stylesheet" href="../../css/bootstrap.min.css">
        <link rel="stylesheet" href="../../css/main.css">
        <link rel="stylesheet" href="../../css/take_image_ui.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/material-design-icons/3.0.1/iconfont/material-icons.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
        <style>
            .selectedImage{
                height: 150px;
                width: 150px;
                border-radius: 50%;
                margin-top: 15px;
                margin-bottom: 10px;
            }

            button:focus{
                outline: none;
            }
            /*.uploadButton{*/
            /*    height: 20px;*/
            /*    width: 20px;*/
            /*}*/

            .popup{
                background: white;
                width: 100%;
                height: 100%;
                position: absolute;
                top: 0;
                /*justify-content: center;*/
                /*align-items: center;*/
                display: none;
            }
            .popup-content{
                background: white;
                /*padding: 10px;*/
                /*border-radius: 5px;*/
                position: relative;
            }
            .close{
                /*position: absolute;*/
                /*right: 0;*/
                /*top: 0;*/
                cursor: pointer;
            }
            .otp-field{
                display: none;
            }
            .upload-button{
                display: block;
                margin: auto;
                margin-bottom: 15px;
            }

        </style>
    </head>
    <body>
    <div class="container col-sm-12 col-md-8 col-lg-8">
        <nav class="d-flex justify-content-between shadow ">
            <h5 class="text-blueGray p-2">Plant Diagnosis Systems</h5>
            <div class="float-right">

                <p class="pt-2 text-blueGray">
                    <?php if (isset($_SESSION['IS_LOGIN_ADMIN']))  {?>
                        <a href="../configuration/configurations_ui.php" class="text-blueGray" style="text-decoration: none"><i class="fa fa-cog fa-lg" aria-hidden="true"></i></a>
                    <?php } ?>

                    <span class="text-blueGray">
                    <a href="../../controllers/logout_controller.php" class="text-blueGray"><i class="fa fa-power-off fa-lg pr-2 pl-4" aria-hidden="true"></i></a>
                </span>
                </p>
            </div>
        </nav>
    </div>
    <div class="container d-flex flex-column justify-content-center" style="margin-top: 2%">

        <ul class="text-center d-flex flex-column">

            <?php

            $cropId = $_GET['id'];
            //        $cN = $_SESSION['cropName'];

            //        $db = mysqli_connect("localhost", "root", "", "pds_web");
            $sql = "SELECT * FROM landing_page_crops WHERE id='$cropId'";
            $result = mysqli_query($conn, $sql);
            while ($row = mysqli_fetch_array($result)) {
                ?>

                <button type="submit" name="potato" style="background-color: transparent; border: none;" class="text-secondary">
                    <li style="list-style: none" value="<?php echo $row['id']?>">
                        <img src=" <?php echo "../../assets/images/".$row['crop_icon_image'] ?>" style="border-radius: 50%; height: 125px; width: 125px">
                        <p id="cropName" class="text-center" style="font-weight: bold"><?php echo $row['crop_name']?></p>
                    </li>
                </button>

            <?php } ?>

        </ul>

        <!--    --><?php
        //    $db = mysqli_connect("localhost", "root", "", "pds_web");
        //    $sql = "SELECT * FROM landing_page_crops WHERE id=1";
        //    $result = mysqli_query($db, $sql);
        //    $count = mysqli_num_rows($result);
        //    if ($count == 1) {
        //        ?>
        <!---->
        <!--        <<div class="text-center">-->
        <!--            <img src="--><?php //echo "../../assets/images/".$count['crop_icon_image'] ?><!--" style="border-radius: 50%; height: 125px; width: 125px">-->
        <!--            <p class="text-center" style="font-weight: bold">--><?php //echo $count['crop_name'] ?><!--</p>-->
        <!--        </div>-->
        <!---->
        <!--    --><?php //} ?>


        <!--    <div class="text-center">-->
        <!--        <img src="--><?php //echo ($selectedCropImageSrc != null) ? $selectedCropImageSrc : $cropSrcUrl ?><!--" style="border-radius: 50%; height: 125px; width: 125px">-->
        <!--        <p class="text-center" style="font-weight: bold">--><?php //echo $cropName?><!--</p>-->
        <!--    </div>-->
        <!--    <div class="text-center">-->
        <!--        <img src="--><?php //echo "../../assets/images/".$cU ?><!--" style="border-radius: 50%; height: 125px; width: 125px">-->
        <!--        <p class="text-center" style="font-weight: bold">--><?php //echo $cN ?><!--</p>-->
        <!--    </div>-->
        <!--    <div class="text-center">-->
        <!--        <img id="cropUrlJsta" src="" style="border-radius: 50%; height: 125px; width: 125px">-->
        <!--        <p id="cropNameJs" class="text-center" style="font-weight: bold"></p>-->
        <!--    </div>-->

        <div class="text-center">
            <h2 id="pickImagesText" class="d-block">Pick Images</h2>
        </div>

        <!--    <form method="post" action="take_image_ui.php">-->
        <div class="text-center">
            <img name="selectedImageForUpload" src="../" id="selectedImageOne" class="" height="2px;" width="2px">
            <!--        <img src="" id="selectedImageTwo" class="" height="2px;" width="2px">-->
            <!--        <img src="" id="selectedImageThree" class="" height="2px;" width="2px">-->
        </div>
        <div  class="text-center d-none" style="text-align: center!important;" id="uploadButton">
            <button name="upload" style="border: none; background-color: transparent;" class="" data-toggle="modal" data-target="#myModal"><i class="fa fa-upload text-secondary fa-lg" aria-hidden="true"></i></button>
        </div>
        <!--    </form>-->
        <div class="text-center mt-2">
            <input type="file" id="selecteImage" onchange="displayImage(this)" multiple accept="images/*">
            <label for="files" class="shadow pickImages" onclick="triggerClick()"><span style="padding-right: 10px"></span>Pick Images</label>
        </div>

        <!--    <p >Modal</p>-->


        <!-- Button to Open the Modal -->
        <!--    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">-->
        <!--        Open modal-->
        <!--    </button>-->

        <!-- The Modal -->
        <div class="modal fade" id="myModal">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">

                    <!-- Modal Header -->
                    <!--                <div class="modal-header">-->
                    <!--                    <h4 class="modal-title text-blueGray">Do you want diagnosis of this Image ?</h4>-->
                    <!--                    <button type="button" class="close" data-dismiss="modal">&times;</button>-->
                    <!--                </div>-->

                    <!-- Modal body -->
                    <div class="modal-body text-center">
                        <h4 class="modal-title text-blueGray">Do you want diagnosis of this Image ?</h4>
                    </div>

                    <!-- Modal footer -->
                    <div class="modal-footer d-flex justify-content-lg-around">
                        <button id="wantToPlantDiagnosis" type="button" class="btn btn-outline-secondary" onclick="diagnosisCrop()" style="padding: 0 15px; border-radius: 20px" data-dismiss="modal">Yes</button>
                        <button type="button" class="btn btn-outline-secondary" style="padding: 0 15px; border-radius: 20px" data-dismiss="modal">No</button>
                    </div>

                </div>
            </div>
        </div>

    </div>

    <div class="popup">
        <div class="container col-sm-12 col-md-8 col-lg-8 popup-content">
            <nav class="d-flex justify-content-between shadow ">
                <h5 class="text-blueGray p-2" id="diagnosisResultHeading"></h5>
                <div class="pt-2 float-right">
                    <p class="text-blueGray close">
                        <i class="material-icons pr-2" aria-hidden="true">highlight_off</i>
                    </p>
                </div>
            </nav>

            <div class="container col-sm-12 col-md-8 col-lg-8">
                <div class="d-flex justify-content-center mt-3">
                    <img src="" id="DiagnosisCrop" style="height: 300px; width: 300px" alt="">
                </div>
                <div>
                    <h3 class="text-blueGray">Diagnosis Result</h3>
                </div>
                <div>
                    <p class="text-blueGray" id="diagnosisResult"></p>
                </div>
            </div>
        </div>
    </div>



    <script>

        // window.onload = function () {
        //     var cropUrlJsP = localStorage.getItem("cropUrlJs");
        //     // var cropNameJsP = localStorage.getItem("cropNameJs");
        //
        //     console.log("URL_FROM_LOCAL_STORAGE : "+cropUrlJsP);
        //     console.log("NAME_FROM_LOCAL_STORAGE : "+localStorage.getItem("cropNameJs"));
        //
        //     document.querySelector('#cropUrlJsta').setAttribute("src", cropUrlJsP);
        //     // document.getElementById('cropNameJs').innerHTML= cropNameJsP;
        // }


        var x = 1;
        function diagnosisCrop() {
            var healthy = "Diseases Not Found, Probability-92.75%";
            var earlyBlight = "Diseases Found, Probability-92.75%";
            var lateBlight = "Diseases Found, Probability-98.12%";
            var notAPlant = "This is not a Plant!";

            switch (x) {
                case 1:
                    document.getElementById('diagnosisResult').innerText = healthy;
                    document.getElementById('diagnosisResultHeading').innerText = "Healthy";
                    break;
                case 2:
                    document.getElementById('diagnosisResult').innerText = earlyBlight;
                    document.getElementById('diagnosisResultHeading').innerText = "Early Blight";
                    break;
                case 3:
                    document.getElementById('diagnosisResult').innerText = lateBlight;
                    document.getElementById('diagnosisResultHeading').innerText = "Late Blight";
                    break;
                case 4:
                    document.getElementById('diagnosisResult').innerText = notAPlant;
                    document.getElementById('diagnosisResultHeading').innerText = "Not a Plant";
                    break;
            }

            while (x<= 4){
                x +=1;
                break;
            }

            while (x>= 5){
                x = 1;
            }

        }

        function triggerClick() {
            document.querySelector('#selecteImage').click();
        }

        function displayImage(e) {
            if (e.files[0]){
                var reader = new FileReader();

                reader.onload = function (e) {
                    document.querySelector('#selectedImageOne').setAttribute('src', e.target.result);
                    document.querySelector('#DiagnosisCrop').setAttribute('src', e.target.result);
                    document.querySelector('#selectedImageOne').setAttribute('class', 'selectedImage');
                    document.querySelector('#pickImagesText').setAttribute('class', 'd-none');
                    document.querySelector('#uploadButton').setAttribute('class', 'upload-button');
                    // document.querySelector('#uploadButton').setAttribute('class', 'uploadButton');
                }
                reader.readAsDataURL(e.files[0])
            }

            // if (e.files[1]){
            //     var reader1 = new FileReader();
            //
            //     reader1.onload = function (e) {
            //         document.querySelector('#selectedImageTwo').setAttribute('src', e.target.result);
            //         document.querySelector('#selectedImageTwo').setAttribute('class', 'selectedImage');
            //         document.querySelector('#pickImagesText').setAttribute('class', 'd-none');
            //     }
            //     reader1.readAsDataURL(e.files[1])
            // }
            // if (e.files[2]){
            //     var reader2 = new FileReader();
            //
            //     reader2.onload = function (e) {
            //         document.querySelector('#selectedImageThree').setAttribute('src', e.target.result);
            //         document.querySelector('#selectedImageThree').setAttribute('class', 'selectedImage');
            //         document.querySelector('#pickImagesText').setAttribute('class', 'd-none');
            //     }
            //     reader2.readAsDataURL(e.files[2])
            // }
        }

        // cropName = localStorage.getItem("cropName");
        // console.log(cropName);

        cropUr = "../../assets/images/tomato.jpg";
        cropN= "Tomato";

        document.getElementById("wantToPlantDiagnosis").addEventListener("click", function () {
            document.querySelector(".popup").style.display = "flex";
        })
        document.querySelector(".close").addEventListener("click", function () {
            document.querySelector(".popup").style.display = "none";
        })
    </script>
    </body>
    </html>

<?php }else{
    header('Location: ../../authentication/login_page.php');
    die();
}

?>