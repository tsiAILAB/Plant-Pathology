import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UploadImage extends StatefulWidget {
  @override
  _UploadImageState createState() => _UploadImageState();

  void uploadImage(File imageFile) {
    _UploadImageState _uploadImageState = new _UploadImageState();
    _uploadImageState._upload(imageFile);
  }
}

class _UploadImageState extends State<UploadImage> {
  String uploadImageAPI = "https://localhost:44379/uploadimage";

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void _upload(File imageFileForUpload) {
    if (imageFileForUpload == null) return;
    String base64Image = base64Encode(imageFileForUpload.readAsBytesSync());
    String fileName = imageFileForUpload.path.split("/").last;

    http.post(uploadImageAPI, body: {
      "image": base64Image,
      "name": fileName,
    }).then((res) {
      print(res.statusCode);
    }).catchError((err) {
      print(err);
    });
  }
}
