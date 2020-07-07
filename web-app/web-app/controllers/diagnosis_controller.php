<?php
//
//
////echo "hi";
//
//$allApi = new AllApis();
////$diagnosisResponse = new DiagnosisResult();
//
//if (isset($_POST['yes'])){
//
////    $file = $_FILES['imageForDiagnosis'];
//
//    $fileName = $_FILES['imageForDiagnosis']['name'];
//    $fileTmpName = $_FILES['imageForDiagnosis']['tmp_name'];
//    $fileSize = $_FILES['imageForDiagnosis']['size'];
//    $fileType = $_FILES['imageForDiagnosis']['type'];
//    $getcontentForBase64image = file_get_contents($fileTmpName);
//    $base64image = base64_encode($getcontentForBase64image);
//
//
//   $size = getimagesize($fileTmpName);
//   $sizeWidth = $size[0];
//   $sizeHeight = $size[1];
//
////    echo "fileName : ".$fileName."<br/>";
////    echo "fileTmpName : ".$fileTmpName."<br/>";
////    echo "fileSize : ".$fileSize."<br/>";
////    echo "fileType : ".$fileType;
//
//    $fileExt = explode('.', $fileName);
//    $fileActulalExt = strtolower(end($fileExt));
//
//    echo "fileName : ".$fileName."<br/>";
//    echo "fileTmpName : ".$fileTmpName."<br/>";
//    echo "fileSize : ".$fileSize."<br/>";
//    echo "fileType : ".$fileType."<br/>";
////    echo "fileExt : ".$fileExt;
//    echo "fileActualExt : ".$fileActulalExt."<br/>";
//    echo "fileHeight : ".$sizeHeight."<br/>";
//    echo "fileWidth : ".$sizeWidth."<br/>";
////    echo "base64Result : ".$base64image;
//
//
////    $url = 'index.php';
////    post_request_to($url);
//
//
//    $allowed = array('jpg', 'jpeg', 'png');
//
//    if (in_array($fileActulalExt, $allowed)){
//        if ($fileSize < 700000){
//            $fileNameNew = uniqid('', true).".".$fileActulalExt;
//            $fileDestination = '../../assets/images/diagnosis-images/'.$fileName;
//            move_uploaded_file($fileTmpName, $fileDestination);
//
//            $curl = curl_init();
//            $url = $allApi->getApiUrl();
////            $url = "http://localhost/GISBL/projects/Plant-Pathology/web-app/web-app/views/plant-diagnosis/plant_diagnosis_report.php";
//
//            $params = array('IMAGE' => $base64image,'FORMAT' => $fileActulalExt, 'SIZE' => $fileSize, 'SIZE_UNIT' => 'KB');
//            $buildParam = http_build_query($params);
////            $defaults = array(
////                CURLOPT_URL => $url,
////                CURLOPT_POST => true,
////                CURLOPT_POSTFIELDS => $params,
////            );
//            $curl = curl_init();
//            curl_setopt($curl, CURLOPT_URL, $url);
//            curl_setopt($curl, CURLOPT_POST, true);
//            curl_setopt($curl, CURLOPT_POSTFIELDS, $buildParam);
//            curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
//            $response = curl_exec($curl);
//            curl_close($curl);
//
//
////            $diagnosisResponse->setDiagnosisResponse($response);
//
//
//
//
////            if (isset($result)){
////                echo "success";
////            }
//
//            header('Location: plant_diagnosis_report.php');
//
//        }else{
//            echo "The image size is too big";
//        }
//    }else{
//        echo "You cannot upload images of this type !";
//    }
//
////    header('Location: plant_diagnosis_report.php');
//
//}