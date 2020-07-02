import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image/image.dart' as ImageLibrary;
import 'package:image_picker/image_picker.dart';
import 'package:pds/models/PlantImage.dart';
import 'package:pds/models/plant_diagnosis_response.dart';
import 'package:pds/screens/plantdiagnosisscreen/plant_details_screen.dart';
import 'package:pds/services/request/upload_image.dart';
import 'package:pds/utils/utils.dart';

class TakeImageScreen extends StatefulWidget {
  final VoidCallback signOut;
  final PlantImage plantImage;

  TakeImageScreen(this.signOut, this.plantImage);

  @override
  _TakeImageScreenState createState() => _TakeImageScreenState(this.plantImage);
}

class _TakeImageScreenState extends State<TakeImageScreen> {
  File imageFile;
  String plantImageUrl;
  final PlantImage plantImage;
  static int count = 0;
  String plantName;
  String imageType = '';
  int imageHeight = 0, imageWidth = 0, imageSize = 0;

  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  _TakeImageScreenState(this.plantImage) {
    this.plantName = this.plantImage.plantName;
    this.plantImageUrl = this.plantImage.imageUrl;
  }

  String selectedPlantName;
  String selectedPlantImageLink = 'assets/images/maze.jpg';

  UploadImage uploadImage = new UploadImage();

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
      default:
        selectedPlantImageLink = null;
    }
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Plant Diagnosis System',
            style: TextStyle(color: Colors.blueGrey)),
        iconTheme: IconThemeData(color: Colors.blueGrey),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              signOut();
            },
            icon: Icon(Icons.power_settings_new),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Container(
              child: Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      print("I'm Maize");
                    },
                    child: CircleAvatar(
                      backgroundImage: (selectedPlantImageLink != null)
                          ? AssetImage('$selectedPlantImageLink')
                          : FileImage(File("$plantImageUrl")),
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
//                  uploadIcon(),
                ],
              ),
            ),
            SizedBox(height: 20),
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
                  color: Colors.blueGrey,
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
                  color: Colors.blueGrey,
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

  signOut() {
    setState(() {
      widget.signOut();
    });
    Utils.gotoHomeUi(context);
  }

//  EmailServerSMTP.sendEmailViaSMTP("firozsujan@gmail.com", 33446);
  openGallery() async {
    var picture;
    try {
      picture = await ImagePicker.pickImage(
          source: ImageSource.gallery, maxHeight: 200, maxWidth: 600);
    } catch (e) {
      Utils.showLongToast("Please try again!");
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
      Utils.showLongToast("Please try again!");
    }
    Utils utils = new Utils();
    this.setState(() {
      imageFile = picture;
      var fileName;
      try {
        utils.saveImage(imageFile, fileName, plantName);
      } catch (e) {}
    });
  }

  Widget decideImageView() {
    try {
      if (imageFile != null) {
        getImageDetails(imageFile);
        Utils.showLongToast("Image loading successful!");
//      _showImageUploadSuccessfullyDialog(context);
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.file(imageFile),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Type - $imageType",
                        style: TextStyle(color: Colors.blueGrey)),
                    Text("Size - $imageSize",
                        style: TextStyle(color: Colors.blueGrey)),
                    Text('Height : $imageHeight',
                        style: TextStyle(color: Colors.blueGrey)),
                    Text('Width : $imageWidth',
                        style: TextStyle(color: Colors.blueGrey)),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.cloud_upload,
                  size: 50,
                  color: Colors.blueGrey,
                ),
                tooltip: 'Upload Image to the Server',
                onPressed: () {
                  _showDecisionDialog(context, imageFile, plantName);
                },
              ),
              SizedBox(height: 10),
            ]);
      } else {
        return Text(
          "Pick an image",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        );
      }
    } catch (e) {
      return Text(
        "Pick an image",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 25, color: Colors.blueGrey),
      );
    }
  }

  uploadIcon() {
    if (imageFile != null) {
      return IconButton(
        icon: Icon(Icons.file_upload),
        tooltip: 'Upload Image to the Server',
        onPressed: () {
          _showDecisionDialog(context, imageFile, plantName);
        },
      );
    } else {
      return IconButton(
        icon: Icon(Icons.file_upload),
        onPressed: () {},
      );
    }
  }

  void showLongToast(String text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  void _showSnackBar(String text) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  void getImageDetails(imageFile) {
    try {
      String fileName = imageFile.path.split("/").last;
      String imageType = fileName.split(".").last;
      var imageHeight, imageWidth, imageSize;
      ImageLibrary.Image image =
          ImageLibrary.decodeImage(imageFile.readAsBytesSync());
      imageHeight = image.height;
      imageWidth = image.width;
      imageSize = image.length / 1024;

      log('Height: $imageHeight');
      log('weidth: $imageWidth');

      setState(() {
        this.imageType = imageType;
        this.imageHeight = imageHeight;
        this.imageWidth = imageWidth;
        this.imageSize = imageSize;
      });
    } on Exception catch (e) {
      // TODO
    }
  }

//  getImageSizeByte(fileLength){
//
//      String sizes = { "B", "KB", "MB", "GB" };
//      int order = 0;
//      while (fileLength >= 1024 && order + 1 < sizes.Length) {
//        order++;
//        fileLength = fileLength/1024;
//      }
//      string result = String.Format("{0:0.##} {1}", fileLength, sizes[order]);
//      return result;
//
//  }

  _showDecisionDialog(BuildContext context, File imageFile, String plantName) {
    UploadImage uploadImage = new UploadImage();

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Text('Do you want diagnosis of this Image?',
                style: TextStyle(color: Colors.blueGrey)),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        child: OutlineButton(
                          onPressed: () {
                            if (imageFile != null) {
//                              uploadDummyImage(imageFile, plantName);
                              uploadImage.uploadImage(imageFile, plantName);
                            } else {
                              Utils.showLongToast("Image upload failed!");
                            }
//                            Navigator.pop(context);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Text(
                            'Yes',
                            style: TextStyle(color: Colors.teal[800]),
                          ),
                        ),
                        onTap: () {},
                      ),
                      GestureDetector(
                        child: OutlineButton(
                          onPressed: () {
                            _scaffoldKey.currentState.showSnackBar(new SnackBar(
                              duration: new Duration(seconds: 4),
                              content: new Row(
                                children: <Widget>[
                                  new CircularProgressIndicator(),
                                  new Text("  Uploading...")
                                ],
                              ),
                            ));

                            Utils utils = new Utils();
                            var fileName = imageFile.path.split("/").last;
                            utils
                                .saveImage(imageFile, fileName, imageFile.path)
                                .whenComplete(() => Navigator.pop(context));
                            Utils.showLongToast("Image saved in local storage");
                            Navigator.pop(context);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Text(
                            'No',
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

  void uploadDummyImage(File imageFile, String plantName) {
    PlantDiagnosisResponse plantDiagnosisResponse;
    String fileName = imageFile.path.split("/").last;
    String imageType = fileName.split(".").last;
    String _diseaseName, _diagnosisResponse;

//    if (plantName.toUpperCase() == "POTATO" &&
//        fileName.toUpperCase() == "EARLY_BLIGHT") {
    if (count == 0) {
      _diseaseName = "Early Blight";
      _diagnosisResponse = "Disease Found, Probability-92.75%";

      plantDiagnosisResponse = new PlantDiagnosisResponse(
          plantName, imageFile.path, _diseaseName, _diagnosisResponse);
//    } else if (plantName.toUpperCase() == "POTATO" &&
//        fileName.toUpperCase() == "LATE_BLIGHT") {
    } else if (count == 1) {
      _diseaseName = "Late Blight";
      _diagnosisResponse = "Disease Found, Probability-98.12%";

      plantDiagnosisResponse = new PlantDiagnosisResponse(
          plantName, imageFile.path, _diseaseName, _diagnosisResponse);
//    } else if (plantName.toUpperCase() == "POTATO" &&
//        fileName.toUpperCase() == "HEALTHY_LEAF") {
    } else if (count == 2) {
      _diseaseName = "Diseas not found";
      _diagnosisResponse = "Disease Not Found, Probability-92.75%";

      plantDiagnosisResponse = new PlantDiagnosisResponse(
          plantName, imageFile.path, _diseaseName, _diagnosisResponse);
    } else {
      _diseaseName = "Not a Plant";
      _diagnosisResponse = "This is not a Plant!";

      plantDiagnosisResponse = new PlantDiagnosisResponse(
          plantName, imageFile.path, _diseaseName, _diagnosisResponse);
      count = -1;
    }

    count = count + 1;

    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PlantDetailsScreen(plantDiagnosisResponse)),
    );
  }
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
