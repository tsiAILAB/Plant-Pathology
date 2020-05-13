import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class TakeImage extends StatefulWidget {
  final String plantName;

  TakeImage(this.plantName);

  @override
  _TakeImageState createState() => _TakeImageState(plantName);
}

class _TakeImageState extends State<TakeImage> {
  File imageFile;
  String plantName;

  final scaffoldKey = new GlobalKey<ScaffoldState>();

  _TakeImageState(this.plantName);

  String selectedPlantName;
  String selectedPlantImageLink = 'assets/images/maze.jpg';

  @override
  Widget build(BuildContext context) {
    selectedPlantName = this.plantName;
    switch (selectedPlantName) {
      case "Potato":
        selectedPlantImageLink = 'assets/images/potato.jpg';
        break;
      case "Tomato":
        selectedPlantImageLink = 'assets/images/tomato.jpg';
        break;
      case "Maize":
        selectedPlantImageLink = 'assets/images/maze.jpg';
        break;
    }
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
//      appBar: AppBar(
//        title: Text("Plant disease"),
//      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Container(
              child: Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      print("I'm Maze");
                    },
                    child: CircleAvatar(
                      backgroundImage: AssetImage('$selectedPlantImageLink'),
                      radius: 40,
                    ),
                  ),
                  Text(
                    "$selectedPlantName",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Card(
              child: Column(
                children: <Widget>[
                  decideImageView(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                      children: <Widget>[
//                        Text("Size - 100.0"),
//                        Text('Height : 200.0'),
//                        Text('Width : 400.0'),
//                      ],
//                    ),
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
//            RaisedButton.icon(
//              shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(20.0)),
//              icon: Icon(
//                Icons.cloud_upload,
//                color: Colors.white,
//              ),
//              color: Colors.teal[900],
//              textColor: Colors.white,
//              label: Text("Upload Image"),
//              onPressed: () {
//                UploadImage uploadImage = new UploadImage();
//                if (imageFile != null) {
//                  uploadImage.uploadImage(imageFile, this.plantName);
//                } else {
//                  showDialog<void>(
//                    context: context,
////                    barrierDismissible: barrierDismissible,
//                    // false = user must tap button, true = tap outside dialog
//                    builder: (BuildContext dialogContext) {
//                      return AlertDialog(
//                        backgroundColor: Colors.amber[100],
//                        title: Text('Alert!'),
//                        content:
//                            Text('Please pic an image from Camera or Gallery.'),
//                        actions: <Widget>[
//                          FlatButton(
//                            child: Text(
//                              'Ok',
//                              style: TextStyle(color: Colors.black),
//                            ),
//                            color: Colors.amber[200],
//                            onPressed: () {
//                              Navigator.of(dialogContext)
//                                  .pop(); // Dismiss alert dialog
//                            },
//                          ),
//                        ],
//                      );
//                    },
//                  );
//                }
//              },
//            ),
//            RaisedButton.icon(
//              shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(20.0)),
//              onPressed: () {
//                openHighResolutionsCamera();
//              },
//              icon: Icon(
//                Icons.add_a_photo,
//                color: Colors.white,
//              ),
//              color: Colors.teal[900],
//              textColor: Colors.white,
//              label: Text(
//                'High Resulation Picture',
//                style: TextStyle(color: Colors.white),
//              ),
//            ),
//            FlatButton(
//              onPressed: () {
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(builder: (context) => LandingScreen()),
//                );
//              },
//              child: Text('Landing Screen'),
//            ),
//            FlatButton(
//              onPressed: () {
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(builder: (context) => SignUpPage()),
//                );
//              },
//              child: Text('Sign Up Screen'),
//            )
          ],
        ),
      ),
    );
  }

  openHighResolutionsCamera() async {
    // Obtain a list of the available cameras on the device.
//    final cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
//    final firstCamera = cameras.first;
//    Navigator.push(
//      context,
//      MaterialPageRoute(
//          builder: (context) => TakePictureScreen(
//                camera: firstCamera,
//              )),
//    );
  }

//  EmailServerSMTP.sendEmailViaSMTP("firozsujan@gmail.com", 33446);
  openGallery() async {
    var picture;
    try {
      picture = await ImagePicker.pickImage(
          source: ImageSource.gallery, maxHeight: 200, maxWidth: 600);
    } catch (e) {
      Utils.showSnackBar("Please try again!", scaffoldKey);
    }
    this.setState(() {
      imageFile = picture;
    });
  }

  openCamera() async {
    var picture;
    try {
      picture = await ImagePicker.pickImage(
          source: ImageSource.camera, maxHeight: 200, maxWidth: 600);
    } catch (e) {
      Utils.showSnackBar("Please try again!", scaffoldKey);
    }
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

Future<void> _showDecisionDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text('Do you want to Diagnosis of this Image ?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      child: OutlineButton(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Text(
                          'Ok',
                          style: TextStyle(color: Colors.teal[800]),
                        ),
                      ),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: OutlineButton(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.teal[800]),
                        ),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}

Future<void> _showImageUploadSuccessfullyDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text(
            'Image Uploaded Successfully',
            style: TextStyle(color: Colors.green),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.check_circle,
                      size: 50.0,
                      color: Colors.green,
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
