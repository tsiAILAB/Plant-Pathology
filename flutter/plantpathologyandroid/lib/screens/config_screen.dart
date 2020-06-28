import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pds/models/ApiUrl.dart';
import 'package:pds/models/PlantImage.dart';
import 'package:pds/services/apis/all_apis.dart';
import 'package:pds/services/response/api_url_response.dart';
import 'package:pds/services/response/plant_image_response.dart';
import 'package:pds/utils/utils.dart';

class ConfigScreen extends StatefulWidget {
  @override
  _ConfigScreenState createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen>
    implements ApiUrlCallBack, PlantImageCallBack {
  ApiUrlResponse _apiUrlResponse;
  PlantImageResponse _plantImageResponse;
  _ConfigScreenState() {
    _apiUrlResponse = new ApiUrlResponse(this);
    _plantImageResponse = new PlantImageResponse(this);
  }

  File imageFile;
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final apiConfigFormKey = new GlobalKey<FormState>();
  final cropFormKey = new GlobalKey<FormState>();
  String _apiUrl, _plantName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      child: SafeArea(
//      child: Scaffold(
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
                    'Update API',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.teal[800],
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Form(
                    key: apiConfigFormKey,
                    child: Column(
                      children: <Widget>[
                        Text("Api Name: ${AllApis.API_NAME}"),
//                            TextFormField(
//                              onSaved: (val) => _apiName = val,
//                              validator: (String value) {
//                                if (value.trim().isEmpty) {
//                                  return 'API Name is required';
//                                }
//                              },
//                              decoration: InputDecoration(
//                                  prefixIcon: Icon(Icons.art_track),
//                                  border: OutlineInputBorder(),
//                                  labelText: "API Name"),
//                            ),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          onSaved: (val) => _apiUrl = val,
                          validator: (String value) {
                            if (value.trim().isEmpty) {
                              return 'API Url is required';
                            }
                            return "";
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.border_color),
                              border: OutlineInputBorder(),
                              labelText: "API URL"),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        OutlineButton(
                          onPressed: _saveApi,
                          child: Text(
                            ' Update API ',
                            style: TextStyle(
                                color: Colors.teal[800], fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'Add new Crop',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[800]),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  OutlineButton(
                    onPressed: () {
                      openGallery();
                    },
                    child: Text(
                      'Upload image icon',
                      style: TextStyle(color: Colors.teal[800], fontSize: 16.0),
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
//      ),
//      ),
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

  @override
  void onApiUrlError(String error) {
    // TODO: implement onApiUrlError
    Utils.showLongToast("Api alredy exist!");
  }

  @override
  void onApiUrlSuccess(ApiUrl apiUrl) {
    // TODO: implement onApiUrlSuccess
    Utils.showLongToast("Api Saved");
    log(apiUrl.apiName);
    log(apiUrl.apiUrl);
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

  void _saveApi() async {
    final form = apiConfigFormKey.currentState;
    Utils utils = new Utils();
    setState(() {
      form.save();
      AllApis.uploadImageUrl = _apiUrl;
      if (_apiUrl != null && _apiUrl != "") {
        _apiUrlResponse.saveNewApiUrl(AllApis.API_NAME, _apiUrl);
      } else {
        Utils.showLongToast("Api URL cannot be empty!");
      }
    });
//    _apiUrlResponse.getApi("a");
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
}

//class PlantTopSection extends StatefulWidget {
//  @override
//  _PlantTopSectionState createState() => _PlantTopSectionState();
//}
//
//class _PlantTopSectionState extends State<PlantTopSection> {
//  var plantName = 'Apple';
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      decoration: BoxDecoration(
//        color: Colors.orange,
//      ),
//      child: Padding(
//        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Padding(
//              padding: const EdgeInsets.all(12.0),
//              child: Text(
//                plantName,
//                style: TextStyle(fontSize: 25.0, color: Colors.white),
//              ),
//            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                Card(
//                  child: Padding(
//                    padding: const EdgeInsets.symmetric(
//                        vertical: 10.0, horizontal: 5),
//                    child: Column(
//                      children: <Widget>[
//                        Image.asset(
//                          'assets/images/fertilizerCalculator.PNG',
//                          height: 75,
//                          width: 75,
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.fromLTRB(30, 5, 30, 15),
//                          child: Text('Fertilizer Calculator'),
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//                Card(
//                  child: Padding(
//                    padding: const EdgeInsets.symmetric(
//                        vertical: 10.0, horizontal: 5),
//                    child: Column(
//                      children: <Widget>[
//                        Image.asset(
//                          'assets/images/pestsAndDiseases.PNG',
//                          height: 75,
//                          width: 75,
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.fromLTRB(30, 5, 30, 15),
//                          child: Text('Pests & Diseases'),
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//              ],
//            )
//          ],
//        ),
//      ),
//    );
//  }
//}
//
//class LocationPermission extends StatefulWidget {
//  @override
//  _LocationPermissionState createState() => _LocationPermissionState();
//}
//
//class _LocationPermissionState extends State<LocationPermission> {
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: Text('Location'),
//    );
//  }
//}
//
//class HealthCheckSection extends StatefulWidget {
//  @override
//  _HealthCheckSectionState createState() => _HealthCheckSectionState();
//}
//
//class _HealthCheckSectionState extends State<HealthCheckSection> {
//  @override
//  Widget build(BuildContext context) {
//    return Opacity(
//      opacity: 0.9,
//      child: Container(
//        decoration: BoxDecoration(
//            image: DecorationImage(
//                image: AssetImage("assets/images/healthCheck2.jpg"),
//                fit: BoxFit.cover)),
//        child: Padding(
//          padding: const EdgeInsets.fromLTRB(15.0, 35.0, 15.0, 35.0),
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              Text(
//                'Health Check',
//                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
//              ),
//              Text(
//                'Take a picture of your crop to detect diseases and recieve treatment advice.',
//                style: TextStyle(
//                  color: Colors.black,
//                  fontWeight: FontWeight.normal,
//                  fontSize: 20.0,
//                ),
//              ),
//              SizedBox(
//                height: 50,
//              ),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                children: <Widget>[
//                  Padding(
//                    padding: const EdgeInsets.symmetric(
//                        vertical: 0.0, horizontal: 0.0),
//                    child: OutlineButton(
//                      borderSide: BorderSide(width: 1.0),
//                      shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(20.0),
//                      ),
//                      color: Colors.teal[800],
//                      onPressed: () {},
//                      child: Padding(
//                        padding: const EdgeInsets.symmetric(
//                            vertical: 5.0, horizontal: 35.0),
//                        child: Text('Gallery'),
//                      ),
//                    ),
//                  ),
//                  RaisedButton.icon(
//                    shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(20.0)),
//                    color: Colors.teal[900],
//                    onPressed: () {},
//                    icon: Icon(
//                      Icons.add_a_photo,
//                      color: Colors.white,
//                    ),
//                    label: Text(
//                      'New Picture',
//                      style: TextStyle(color: Colors.white),
//                    ),
//                  )
//                ],
//              )
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}
