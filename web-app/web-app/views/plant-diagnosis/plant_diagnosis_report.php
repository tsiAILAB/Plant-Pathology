<?php

require '../../models/DiagnosisResult.php';
require '../../models/apis/AllApis.php';

$allApi = new AllApis();
$diagnosisRes = new DiagnosisResult();
//$diagnosisResponse = new DiagnosisResult();

if (isset($_POST['yes'])){

//    $file = $_FILES['imageForDiagnosis'];

    $fileName = $_FILES['imageForDiagnosis']['name'];
    $fileTmpName = $_FILES['imageForDiagnosis']['tmp_name'];
    $fileSize = $_FILES['imageForDiagnosis']['size'];
    $fileType = $_FILES['imageForDiagnosis']['type'];
    $getcontentForBase64image = file_get_contents($fileTmpName);
    $base64image = base64_encode($getcontentForBase64image);


    $size = getimagesize($fileTmpName);
    $sizeWidth = $size[0];
    $sizeHeight = $size[1];

//    echo "fileName : ".$fileName."<br/>";
//    echo "fileTmpName : ".$fileTmpName."<br/>";
//    echo "fileSize : ".$fileSize."<br/>";
//    echo "fileType : ".$fileType;

    $fileExt = explode('.', $fileName);
    $fileActulalExt = strtolower(end($fileExt));

//    echo "fileName : ".$fileName."<br/>";
//    echo "fileTmpName : ".$fileTmpName."<br/>";
//    echo "fileSize : ".$fileSize."<br/>";
//    echo "fileType : ".$fileType."<br/>";
////    echo "fileExt : ".$fileExt;
//    echo "fileActualExt : ".$fileActulalExt."<br/>";
//    echo "fileHeight : ".$sizeHeight."<br/>";
//    echo "fileWidth : ".$sizeWidth."<br/>";
//    echo "base64Result : ".$base64image;


//    $url = 'index.php';
//    post_request_to($url);


    $allowed = array('jpg', 'jpeg', 'png');

    if (in_array($fileActulalExt, $allowed)){
        if ($fileSize < 700000){
            $fileNameNew = uniqid('', true).".".$fileActulalExt;
            $fileDestination = '../../assets/images/diagnosis-images/'.$fileName;
            move_uploaded_file($fileTmpName, $fileDestination);

            $curl = curl_init();
            $url = $allApi->getApiUrl();
//            $url = "http://localhost/GISBL/projects/Plant-Pathology/web-app/web-app/views/plant-diagnosis/plant_diagnosis_report.php";

            $params = array('IMAGE' => $base64image,'FORMAT' => $fileActulalExt, 'SIZE' => $fileSize, 'SIZE_UNIT' => 'KB');
            $buildParam = http_build_query($params);
//            $defaults = array(
//                CURLOPT_URL => $url,
//                CURLOPT_POST => true,
//                CURLOPT_POSTFIELDS => $params,
//            );
            $curl = curl_init();
            curl_setopt($curl, CURLOPT_URL, $url);
            curl_setopt($curl, CURLOPT_POST, true);
            curl_setopt($curl, CURLOPT_POSTFIELDS, $buildParam);
            curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
            $response = curl_exec($curl);
            curl_close($curl);

//Manual Response Report Testing

//            $responseManualPotato = "92.07_98.07_94.07"; //Potato
//            $responseManualMaize = "92.07_98.07_94.07_94.07"; //Maize
//            $responseManualTomato = "92.07_98.07_00.07_94.07_.8"; //Tomato
//            $responseManualNotAPlant = "OK"; //Not a plant

//            $diagnosisRes->setDiagnosisResponse("92.07_98.07_94.07"); //Potato
//            $diagnosisRes->setDiagnosisResponse("92.07_98.07_94.07_94.07"); //Maize
//            $diagnosisRes->setDiagnosisResponse("92.07_98.07_00.07_94.07_.8"); //Tomato
//            $diagnosisRes->setDiagnosisResponse("OK"); //Not a plant


            $diagnosisRes->setDiagnosisResponse($response);


//            $diagnosisResponse->setDiagnosisResponse($response);




//            if (isset($result)){
//                echo "success";
//            }

//            header('Location: plant_diagnosis_report.php');

        }else{
            echo "The image size is too big";
            header('Location: take_image_ui.php');
        }
    }else{
        echo "You cannot upload images of this type !";
        header('Location: take_image_ui.php');
    }

//    header('Location: plant_diagnosis_report.php');

}




$getResponse = $diagnosisRes->getDiagnosisResponse();

$result = explode('_', $getResponse);

switch (count($result)){
    case 3:
        $plantName = "Potato";
        $DisesArray = array(
            $diseaseName = array("Early Blight", "Late Blight", "Healthy"),
            $diseaseProbability = $result
        );
        $combinedArrays = array_combine($diseaseName, $diseaseProbability);
        break;
    case 4:
        $plantName = "Maize";
        $DisesArray = array(
            $diseaseName = array("Common Rust", "Gray Leaf Spot", "Northern Leaf Blight", "Healthy"),
            $diseaseProbability = $result
        );
        $combinedArrays = array_combine($diseaseName, $diseaseProbability);
        break;
    case 5:
        $plantName = "Tomato";
        $DisesArray = array(
            $diseaseName = array("Early Blight", "Late Blight", "Leaf Curl", "Leaf Mold", "Healthy"),
            $diseaseProbability = $result
        );
        $combinedArrays = array_combine($diseaseName, $diseaseProbability);
        break;
    default:
        $plantName = "Not a Plant";
        $DisesArray = array(
            $diseaseName = array("This is not a plant"),
            $diseaseProbability = array("100%")
        );
        $combinedArrays = array_combine($diseaseName, $diseaseProbability);
}

//function sort_arry ($a, $subkey){
//    foreach ($a as $k=>$v){
//        $b[$k] = strtolower($v[$subkey]);
//    }
//    asort($b);
//    foreach ($b as $key=>$val){
//        $c[] = $a[$key];
//    }
//    return $c;
//}
//
//sort_arry($DisesArray, $result);

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


        <h5 class="text-blueGray p-2">
            <?php
            echo $plantName;
            ?>
        </h5>
        <div class="float-right">

            <p class="pt-2 text-blueGray">
                <?php if (isset($_SESSION['IS_LOGIN_ADMIN']))  {?>
                <a href="../configurations/configurations_ui.php" class="text-blueGray" style="text-decoration: none"><i class="fa fa-cog fa-lg" aria-hidden="true"></i></a>
                <?php } ?>

                <span class="text-blueGray">
                    <a href="../../controllers/logout_controller.php" class="text-blueGray"><i class="fa fa-power-off fa-lg pr-2 pl-4" aria-hidden="true"></i></a>
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
            <p class="text-blueGray" id="diagnosisResult">
                <?php

//                print_r($combinedArrays);
                arsort($combinedArrays);

                foreach ($combinedArrays as $disease => $probability){
//                    arsort($combinedArrays);
                    echo 'Desease Name : '.$disease.'</br>';
                    echo 'Probability : '.$probability.'</br>'.'</br>';
                }

//                for ($i=0; $i<count($DisesArray[1]); $i++){
//                    ksort($DisesArray[1]);
//                    echo 'Disease Name : '.$DisesArray[0][$i].'</br>';
//                    echo 'Probability : '.$DisesArray[1][$i].'</br>'.'</br>';
//                }

                ?>
            </p>
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



        // var healthy     = "Diseases Not Found, Probability-92.75%";
        // var earlyBlight = "Diseases Found, Probability-92.75%";
        // var lateBlight  = "Diseases Found, Probability-98.12%";
        // var notAPlant   = "This is not a Plant!";
        //
        // switch (x) {
        //     case 1:
        //         document.getElementById('diagnosisResult').innerText = healthy;
        //         break;
        //     case 2:
        //         document.getElementById('diagnosisResult').innerText = earlyBlight;
        //         break;
        //     case 3:
        //         document.getElementById('diagnosisResult').innerText = lateBlight;
        //         break;
        //     case 4:
        //         document.getElementById('diagnosisResult').innerText = notAPlant;
        //         break;
        // }
    }


    // while (x<= 4){
    //     x +=1;
    // }
    // while (x>= 5){
    //     x = 1;
    // }
</script>

<?php

$potatoDisease = array("Early Blight", "Late Blight", "Healthy");
$maizeDisease = array("Common Rust", "Gray Leaf Spot", "Northern Leaf Blight", "Healthy");
$tomatoDisease = array("Early Blight", "Late Blight", "Leaf Curl", "Leaf Mold", "Healthy");




//
//foreach ($DisesArray as $index => $value){
//    echo 'Probability: '.$value.'%'.'</br>';
//}

//echo $DisesArray[1][1];


//echo "<pre>";
//print_r($DisesArray);

?>
</body>
</html>