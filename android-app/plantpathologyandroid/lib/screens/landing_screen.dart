import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterapp/models/PlantImage.dart';
import 'package:flutterapp/services/response/plant_image_response.dart';
import 'package:flutterapp/utils/utils.dart';
import 'package:image/image.dart' as ImageLibrary;

import 'home_screen.dart';

class LandingScreen extends StatefulWidget {
  final VoidCallback signOut;

  LandingScreen(this.signOut);

  @override
  _LandingScreenState createState() => _LandingScreenState(this.signOut);
}

class _LandingScreenState extends State<LandingScreen>
    implements PlantImageCallBack {
  final VoidCallback signOut;

  PlantImageResponse _plantImageResponse;

  _LandingScreenState(this.signOut) {
    _plantImageResponse = new PlantImageResponse(this);
  }

  String plantName;
  List<PlantImage> plantImages;

  PlantImage potatoImageObj =
      new PlantImage("Potato", "assets/images/potato.jpg");
  PlantImage tomatoImageObj =
      new PlantImage("Tomato", "assets/images/tomato.jpg");
  PlantImage maizeImageObj = new PlantImage("Maize", "assets/images/maze.jpg");

  @override
  void initState() {
    super.initState();
    getAllPlants();
    getPermission();
  }

  @override
  Widget build(BuildContext context) {
//    for (int i = 0; i < plantImages.length; i++) {
//      PlantImage plantImage = plantImages[i];
//      log(plantImage.plantName);
//      log(plantImage.imageUrl);
//    }

    return Scaffold(
      body: Center(
        child: ListView(
//          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AppBar(
              title: Text('Plant Selection'),
              backgroundColor: Colors.white,
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    signOut();
                  },
                  icon: Icon(Icons.power_settings_new),
                )
              ],
            ),
            Container(
              child: Column(
                children: <Widget>[
//                  Card(
//                    child: Padding(
//                      padding: const EdgeInsets.all(20.0),
//                      child: Row(
////                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
//
//                        ],
//                      ),
//                    ),
//                  ),
                  SizedBox(height: 20),
                  FlatButton(
                    onPressed: () {
                      goToPlantUi(tomatoImageObj);
                    },
                    child: CircleAvatar(
                      backgroundImage: AssetImage('${tomatoImageObj.imageUrl}'),
                      radius: 60,
                    ),
                  ),
                  Text(
                    "Tomato",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      print("I'm Potato");
                      goToPlantUi(potatoImageObj);
                    },
                    child: CircleAvatar(
                      backgroundImage: AssetImage('${potatoImageObj.imageUrl}'),
                      radius: 60,
                    ),
                  ),
                  Text(
                    "Potato",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      print("I'm Maize");
                      goToPlantUi(maizeImageObj);
                    },
                    child: CircleAvatar(
                      backgroundImage: AssetImage('${maizeImageObj.imageUrl}'),
                      radius: 60,
                    ),
                  ),
                  Text(
                    "Maze",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0),
                  ),
                ],
              ),
            ),
            Container(
                child: Column(
              children: loadDynamicUi(),
            )),
          ],
        ),
      ),
    );
  }

  void goToPlantUi(PlantImage plantImage) {
    print("I'm $plantName");
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => HomeScreen(this.signOut, plantImage)),
    );
//                      HomeScreen(signOut);
  }

  loadDynamicUi() {
    if (plantImages != null) {
      List<Widget> listOfPlantsWidget = new List();
      for (int i = 0; i < plantImages.length; i++) {
        PlantImage plantImage = plantImages[i];
        log(plantImage.plantName);
        log(plantImage.imageUrl);
        listOfPlantsWidget.add(
          Column(
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  print("I'm Potato");
                  goToPlantUi(plantImage);
                },
                child: CircleAvatar(
                  backgroundImage: _setImage(plantImage.imageUrl),
                  radius: 60,
                ),
              ),
              Text(
                plantImage.plantName,
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0),
              ),
            ],
          ),
        );
      }
      return listOfPlantsWidget;
    } else {
      return <Widget>[];
    }
  }

  _setImage(String imageUrl) {
//    var directoryPath = getPathDirectory();
    try {
//      Directory tempDir = await getTemporaryDirectory();
      try {
        log("$imageUrl");
        ImageLibrary.Image image =
            ImageLibrary.decodeImage(new File('$imageUrl').readAsBytesSync());
        log('Heidght: ${image.height}');
        log('weidth: ${image.width}');
      } on Exception catch (e) {
        // TODO
      }
      return FileImage(File("$imageUrl"));
    } catch (e) {
      return AssetImage('assets/images/potato.jpg');
    }
  }

  void getAllPlants() async {
    setState(() {
      _plantImageResponse.getAllPlants();
    });
  }

  void getPermission() async {
    await Utils.requestStoragePermission();
  }

  @override
  void onPlantImageError(String error) {
    // TODO: implement onPlantImageError
  }

  @override
  void onPlantImageSuccess(PlantImage plantImage) {
    // TODO: implement onPlantImageSuccess
  }

  @override
  void onPlantImagesSuccess(List<PlantImage> plantImages) {
    // TODO: implement onPlantImagesSuccess
    setState(() {
      this.plantImages = plantImages;
    });
    for (int i = 0; i < plantImages.length; i++) {
      PlantImage plantImage = plantImages[i];
      log(plantImage.plantName);
      log(plantImage.imageUrl);
    }
  }
}
