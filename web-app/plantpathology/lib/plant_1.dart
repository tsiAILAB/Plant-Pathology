
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutterapp/plants_details_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/upload_image.dart';
import 'login_page.dart';

class Plant1 extends StatefulWidget {
  @override
  _Plant1State createState() => _Plant1State();
}

class _Plant1State extends State<Plant1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.amber,

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          healthCheckSection()
        ],
      ),
//      body: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              "Under Construction!",
//              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
//            ),
//            RaisedButton(
//              onPressed: (){
//                Navigator.push(context,
//                MaterialPageRoute(builder: (context)=>LoginPage()),
//                );
//              },
//              child: Text('Login Page'),
//            )
//          ],
//        ),
//      ),
//    floatingActionButton: FloatingActionButton.extended(
//      onPressed: (){},
//      backgroundColor: Colors.teal[800],
//      icon: Icon(
//        Icons.camera_alt,
//        color: Colors.white,
//      ),
//      label: Text('Health Check', style: TextStyle(
//        color: Colors.white
//      ),),
//    ),
    );
  }
}

//class plantTopSection extends StatefulWidget {
//  @override
//  _plantTopSectionState createState() => _plantTopSectionState();
//}
//
//class _plantTopSectionState extends State<plantTopSection> {
//
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
//              child: Text(plantName, style: TextStyle(
//                fontSize: 25.0,
//                color: Colors.white
//              ),),
//            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                Card(
//                  child: Padding(
//                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
//                    child: Column(
//                      children: <Widget>[
//                        Image.asset('assets/images/fertilizerCalculator.PNG', height: 75, width: 75,),
//                        Padding(
//                          padding: const EdgeInsets.fromLTRB(30,5,30,15),
//                          child: Text('Fertilizer Calculator'),
//                        ),
//                      ],
//                    ),
//                  ),
//
//                ),
//                Card(
//                  child: Padding(
//                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
//                    child: Column(
//                      children: <Widget>[
//                        Image.asset('assets/images/pestsAndDiseases.PNG', height: 75, width: 75,),
//                        Padding(
//                          padding: const EdgeInsets.fromLTRB(30,5,30,15),
//                          child: Text('Pests & Diseases'),
//                        ),
//                      ],
//                    ),
//                  ),
//
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
//class locationPermission extends StatefulWidget {
//  @override
//  _locationPermissionState createState() => _locationPermissionState();
//}
//
//class _locationPermissionState extends State<locationPermission> {
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: Text('Location'),
//    );
//  }
//}

class healthCheckSection extends StatefulWidget {
  @override
  _healthCheckSectionState createState() => _healthCheckSectionState();
}

class _healthCheckSectionState extends State<healthCheckSection> {

  File imageFile;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.9,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/healthCheck2.jpg"),
            fit: BoxFit.cover
          )
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 35.0, 15.0, 35.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Health Check', style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 40),
              decideImageView(),
//              Text('Take a picture of your crop to detect diseases and recieve treatment advice.', style: TextStyle(
//                color: Colors.black,
//                fontWeight: FontWeight.normal,
//                fontSize: 20.0,
//              ),),
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                    child: OutlineButton(
                      borderSide: BorderSide(width: 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: Colors.teal[800],
                      onPressed: (){},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 35.0),
                        child: Text('Gallery'),
                      ),
                    ),
                  ),
                  RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    color: Colors.teal[900],
                    onPressed: (){
                      openCamera();
                    },
                    icon: Icon(Icons.add_a_photo, color: Colors.white,),
                    label: Text('New Picture', style: TextStyle(
                      color: Colors.white
                    ),),
                  )
                ],
              )
            ],
          ),
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
      return FlatButton(
        child: Image.file(imageFile),
        onPressed: (){
          Navigator.push(context,
            MaterialPageRoute(builder: (context)=>PlantsDetailsPage()),
          );
        },
      );
    else
      return Text(
        "Take a picture of your crop to detect diseases and recieve treatment advice.",
        style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20,
          color: Colors.black,
        ),
      );
  }
}



