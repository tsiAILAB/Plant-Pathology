import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pds/models/plant_diagnosis_response.dart';
import 'package:pds/screens/plantdiagnosisscreen//plant_details_screen.dart';
import 'package:pds/services/apis/all_apis.dart';
import 'package:pds/utils/utils.dart';

class UploadImage extends StatefulWidget {
  @override
  _UploadImageState createState() => _UploadImageState();

  void uploadImage(File imageFile, String plantName) {
    _UploadImageState _uploadImageState = new _UploadImageState();
    _uploadImageState._upload(imageFile, plantName);
  }

  void uploadDummyImage(File imageFile, String plantName) {
    _UploadImageState _uploadImageState = new _UploadImageState();
  }
}

class _UploadImageState extends State<UploadImage> {
  String uploadImageAPI = AllApis.uploadImageUrl;
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _scaffoldKey,
    );
  }

  void _upload(File imageFileForUpload, String plantName) async {
    if (imageFileForUpload == null) return;
    String base64Image = base64Encode(imageFileForUpload.readAsBytesSync());
    String fileName = imageFileForUpload.path.split("/").last;
    String imageType = fileName.split(".").last;
    Utils utils = new Utils();
    if (imageType.toUpperCase() == 'BMP') {
      Utils.showLongToast("BMP image is not supported!");
    } else if (imageType.toUpperCase() == 'PNG' ||
        imageType.toUpperCase() == 'JPG' ||
        imageType.toUpperCase() == 'JPEG' ||
        imageType.toUpperCase() == 'JPG') {
//      utils.saveImage(imageFileForUpload, fileName, plantName);
      var decodedImage =
          await decodeImageFromList(imageFileForUpload.readAsBytesSync());

      String imageSize =
          decodedImage.width.toString() + "*" + decodedImage.height.toString();
      String platformName = Platform.operatingSystem;

//      _scaffoldKey.currentState.showSnackBar(new SnackBar(
//        duration: new Duration(seconds: 4),
//        content: new Row(
//          children: <Widget>[
//            new CircularProgressIndicator(),
//            new Text("  Uploading...")
//          ],
//        ),
//      ));

      http.post(uploadImageAPI, body: {
//        IMAGE=contains image
//        SIZE=1000
//        SIZE_UNIT='KB'
//        FORMAT='JPG'

        "IMAGE": base64Image,
//        "image_name": fileName,
//        "plant_name": plantName,
        "FORMAT": imageType,
        "SIZE": imageSize,
        "SIZE_UNIT": "KB",
//        "platform": platformName,
//        "no_of_image": '1',
//        "image_contents": 'image file contennts'
      }).then((res) {
        print(res.statusCode);
//      Utils utils = new Utils();
        utils.saveImage(imageFileForUpload, fileName, plantName);
        if (res != null) {
          List<String> diagnosisRes = res.body.split(";");
          for (int i = 0; i < diagnosisRes.length; i++) {
            List<String> responseSplitByHash = diagnosisRes[i].split("#");
            for (int j = 0; j < responseSplitByHash.length; j++) {
              String diseaseName = responseSplitByHash[0].split("=")[1];
              String diagnosis = responseSplitByHash[1].split("=")[1];
              PlantDiagnosisResponse plantDiagnosisResponse =
                  new PlantDiagnosisResponse(
                      plantName, uploadImageAPI, diseaseName, diagnosis);
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        PlantDetailsScreen(plantDiagnosisResponse)),
              );
            }
          }
        }
        Utils.showLongToast("Image upload successful!");
      }).catchError((err) {
        print(err);

        Utils.showLongToast("Image upload failed!");
      });
    } else {
      Utils.showLongToast("$imageType type image is not supported!");
    }
  }
}
