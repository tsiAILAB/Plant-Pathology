import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/screens/camerascreen/take_picture_screen.dart';
import 'package:flutterapp/services/request/upload_image.dart';
import 'package:image_picker/image_picker.dart';

class TakeImage extends StatefulWidget {
  final String plantName;

  TakeImage(this.plantName);

  @override
  _TakeImageState createState() => _TakeImageState(plantName);
}

class _TakeImageState extends State<TakeImage> {
  File imageFile;
  final String plantName;

  _TakeImageState(this.plantName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[400],
//      appBar: AppBar(
//        title: Text("Plant disease"),
//      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Card(
              child: Column(
                children: <Widget>[
                  decideImageView(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("Size - 100.0"),
                        Text('Height : 200.0'),
                        Text('Widtht : 400.0'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  icon: Icon(
                    Icons.camera,
                    color: Colors.white,
                  ),
                  color: Colors.teal[900],
                  textColor: Colors.white,
                  label: Text("Camera"),
                  onPressed: () {
                    openCamera();
                  },
                ),
                SizedBox(width: 30),
                RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  icon: Icon(
                    Icons.image,
                    color: Colors.white,
                  ),
                  color: Colors.teal[900],
                  textColor: Colors.white,
                  label: Text("Gallery"),
                  onPressed: () {
                    openGallery();
                  },
                ),
              ],
            ),
            RaisedButton.icon(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              icon: Icon(
                Icons.cloud_upload,
                color: Colors.white,
              ),
              color: Colors.teal[900],
              textColor: Colors.white,
              label: Text("Upload Image"),
              onPressed: () {
                UploadImage uploadImage = new UploadImage();
                if (imageFile != null) {
                  uploadImage.uploadImage(imageFile, this.plantName);
                } else {
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
            RaisedButton.icon(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: () {
                openHighResolutionsCamera();
              },
              icon: Icon(
                Icons.add_a_photo,
                color: Colors.white,
              ),
              color: Colors.teal[900],
              textColor: Colors.white,
              label: Text(
                'High Resulation Picture',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  openHighResolutionsCamera() async {
    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    final firstCamera = cameras.first;
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TakePictureScreen(
                camera: firstCamera,
              )),
    );
  }

  openGallery() async {
    var picture = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 800, maxWidth: 600);
    this.setState(() {
      imageFile = picture;
    });
  }

  openCamera() async {
    var picture = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 800, maxWidth: 600);
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