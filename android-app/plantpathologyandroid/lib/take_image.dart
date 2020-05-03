import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/upload_image.dart';
import 'package:image_picker/image_picker.dart';

class TakeImage extends StatefulWidget {
  @override
  _TakeImageState createState() => _TakeImageState();
}

class _TakeImageState extends State<TakeImage> {
  File imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[400],
      appBar: AppBar(
        title: Text("Plant disease"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            decideImageView(),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  padding: const EdgeInsets.all(8.0),
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: Text("Camera"),
                  onPressed: () {
                    openCamera();
                  },
                ),
                SizedBox(width: 30),
                RaisedButton(
                  padding: const EdgeInsets.all(8.0),
                  textColor: Colors.white,
                  color: Colors.blue[800],
                  child: Text("Gallery"),
                  onPressed: () {
                    openGallery();
                  },
                ),
              ],
            ),
            RaisedButton(
              padding: const EdgeInsets.all(8.0),
              textColor: Colors.white,
              color: Colors.green[800],
              child: Text("Upload Image"),
              onPressed: () {
                UploadImage uploadImage = new UploadImage();
                if (imageFile != null)
                  uploadImage.uploadImage(imageFile);
                else {
                  showDialog<void>(
                    context: context,
//                    barrierDismissible: barrierDismissible,
                    // false = user must tap button, true = tap outside dialog
                    builder: (BuildContext dialogContext) {
                      return AlertDialog(
                        backgroundColor: Colors.amber[100],
                        title: Text('Alert!'),
                        content:
                            Text('Please pic an image from Camera or Gallery.'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text(
                              'Ok',
                              style: TextStyle(color: Colors.black),
                            ),
                            color: Colors.amber[200],
                            onPressed: () {
                              Navigator.of(dialogContext)
                                  .pop(); // Dismiss alert dialog
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  openGallery() async {
    var picture = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 200, maxWidth: 600);
    this.setState(() {
      imageFile = picture;
    });
  }

  openCamera() async {
    var picture = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 200, maxWidth: 600);
    this.setState(() {
      imageFile = picture;
    });
  }

  Widget decideImageView() {
    if (imageFile != null)
      return Image.file(imageFile);
    else
      return Text(
        "Please pic an image",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      );
  }
}
