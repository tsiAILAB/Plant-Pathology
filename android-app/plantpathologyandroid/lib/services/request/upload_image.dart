import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterapp/services/apis/all_apis.dart';
import 'package:flutterapp/utils/utils.dart';
import 'package:http/http.dart' as http;

class UploadImage extends StatefulWidget {
  @override
  _UploadImageState createState() => _UploadImageState();

  void uploadImage(File imageFile, String plantName) {
    _UploadImageState _uploadImageState = new _UploadImageState();
    _uploadImageState._upload(imageFile, plantName);
  }
}

class _UploadImageState extends State<UploadImage> {
  String uploadImageAPI = AllApis.uploadImageUrl;
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: scaffoldKey,
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

      http.post(uploadImageAPI, body: {
        "image": base64Image,
        "image_name": fileName,
        "plant_name": plantName,
        "image_type": imageType,
        "image_size": imageSize,
        "platform": platformName,
        "no_of_image": '1',
        "image_contents": 'image file contennts'
      }).then((res) {
        print(res.statusCode);
//      Utils utils = new Utils();
        utils.saveImage(imageFileForUpload, fileName, plantName);
        Utils.showLongToast("Image upload sucessful!");
      }).catchError((err) {
        print(err);
      });
    } else {
      Utils.showLongToast("$imageType type image is not supported!");
    }
  }
}
