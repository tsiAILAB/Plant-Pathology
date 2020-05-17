import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/models/PlantImage.dart';
import 'package:flutterapp/services/response/plant_image_response.dart';
import 'package:flutterapp/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class AddPlantImageScreen extends StatefulWidget {
  @override
  _AddPlantImageScreenState createState() => _AddPlantImageScreenState();
}

class _AddPlantImageScreenState extends State<AddPlantImageScreen>
    implements PlantImageCallBack {
  PlantImageResponse _plantImageResponse;
  _AddPlantImageScreenState() {
    _plantImageResponse = new PlantImageResponse(this);
  }

  File imageFile;
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final cropFormKey = new GlobalKey<FormState>();
  String _plantName;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.white,
          body: ListView(
            children: <Widget>[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Add New Crop',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      OutlineButton(
                        onPressed: () {
                          openGallery();
                        },
                        child: Text(
                          'Upload Image Icon',
                          style: TextStyle(
                              color: Colors.teal[800], fontSize: 16.0),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      decideImageView(),

//                    CircleAvatar(
//                     backgroundImage: Image.file(imageFile),
//                      radius: 60,
//                    ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Form(
                        key: cropFormKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              onSaved: (val) => _plantName = val,
                              validator: (String inputedApi) {
                                if (inputedApi.isEmpty) {
                                  return 'Enter crop name.';
                                }
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.border_color),
                                  border: OutlineInputBorder(),
                                  labelText: "Enter crop name"),
                            ),
                            SizedBox(height: 15.0),
                            OutlineButton(
                              onPressed: _saveCrop,
                              child: Text(
                                'Add New Crop',
                                style: TextStyle(
                                    color: Colors.teal[800], fontSize: 16.0),
                              ),
                            ),
                            SizedBox(height: 50.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  openGallery() async {
    var picture;
    try {
      picture = await ImagePicker.pickImage(
          source: ImageSource.gallery, maxHeight: 150, maxWidth: 400);
      Utils.showLongToast("Image loaded");
//      Utils.showSnackBar("Image Loaded", _scaffoldKey);
    } catch (e) {
      Utils.showLongToast("Please try again!");
//      Utils.showSnackBar("Please try again!", _scaffoldKey);
    }
    this.setState(() {
      imageFile = picture;
    });
  }

  Widget decideImageView() {
    try {
      if (imageFile != null) {
        return Image.file(imageFile);
      } else {
        return Text(
          "No crop icon selected!",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
        );
      }
    } catch (e) {
      return Text(
        "Pick an image",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      );
    }
  }

  void _saveCrop() async {
    final form = cropFormKey.currentState;

    Utils utils = new Utils();
    String fileName = imageFile.path.split("/").last;
    String imageUrl = imageFile.path;

    setState(() {
      form.save();
    });
    if (_plantName != null && _plantName != "") {
      await _plantImageResponse.saveNewPlantImage(_plantName, "$imageUrl");
    } else {
      Utils.showLongToast("Crop name cannot be empty!");
    }
    await _plantImageResponse.getAllPlants();
  }

  @override
  void onPlantImageError(String error) {
    // TODO: implement onPlantImageError
  }

  @override
  void onPlantImageSuccess(PlantImage plantImage) {
    // TODO: implement onPlantImageSuccess
    Utils.showLongToast("Plant Saved");
    log(plantImage.plantName);
    log(plantImage.imageUrl);
  }

  @override
  void onPlantImagesSuccess(List<PlantImage> plantImages) {
    // TODO: implement onPlantImagesSuccess
    for (PlantImage plant in plantImages) {
      log(plant.plantName);
      log(plant.imageUrl);
    }
  }
}
