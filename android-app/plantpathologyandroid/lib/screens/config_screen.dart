import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutterapp/utils/utils.dart';

class ConfigScreen extends StatefulWidget {
  @override
  _ConfigScreenState createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  File imageFile;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
//      backgroundColor: Colors.amber,
          appBar: AppBar(
            title: Text(
              'Configuration',
            ),
          ),

          body: Column(
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
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      Form(
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              validator: (String inputedApi) {
                                if (inputedApi.isEmpty) {
                                  return 'Please enter your Api.';
                                }
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.art_track),
                                  border: OutlineInputBorder(),
                                  labelText: "Enter your API"),
                            ),
                            SizedBox(height: 15.0,),
                            OutlineButton(
                              onPressed: (){},
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 150.0),
                                child: Text(
                                  ' Submit ',
                                  style: TextStyle(
                                      color: Colors.teal[800],
                                      fontSize: 16.0
                                  ),
                                ),
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
                           color: Colors.teal[800]
                       ),
                    ),
                    SizedBox(height: 15.0,),
                    OutlineButton(
                      onPressed: (){
                        openGallery();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 86.0),
                        child: Text(
                          'Upload crop iconic Image',
                          style: TextStyle(
                              color: Colors.teal[800],
                              fontSize: 16.0
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0,),
                    decideImageView(),

//                    CircleAvatar(
//                     backgroundImage: Image.file(imageFile),
//                      radius: 60,
//                    ),
                    SizedBox(height: 15.0,),
                    Form(
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            validator: (String inputedApi) {
                              if (inputedApi.isEmpty) {
                                return 'Please enter crop name.';
                              }
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.extension),
                                border: OutlineInputBorder(),
                                labelText: "Enter crop name"),
                          ),
                          SizedBox(height: 15.0,),
                          OutlineButton(
                            onPressed: (){},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 150.0),
                              child: Text(
                                  'Submit',
                                style: TextStyle(
                                    color: Colors.teal[800],
                                    fontSize: 16.0
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
//          HealthCheckSection(),
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
//          floatingActionButton: FloatingActionButton.extended(
//            onPressed: () {},
//            backgroundColor: Colors.teal[800],
//            icon: Icon(
//              Icons.camera_alt,
//              color: Colors.white,
//            ),
//            label: Text(
//              'Health Check',
//              style: TextStyle(color: Colors.white),
//            ),
//          ),
        ),
      ),
    );
  }
  openGallery() async {
    var picture = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 150, maxWidth: 400);
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

class PlantTopSection extends StatefulWidget {
  @override
  _PlantTopSectionState createState() => _PlantTopSectionState();
}

class _PlantTopSectionState extends State<PlantTopSection> {
  var plantName = 'Apple';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                plantName,
                style: TextStyle(fontSize: 25.0, color: Colors.white),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 5),
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/fertilizerCalculator.PNG',
                          height: 75,
                          width: 75,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 5, 30, 15),
                          child: Text('Fertilizer Calculator'),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 5),
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/pestsAndDiseases.PNG',
                          height: 75,
                          width: 75,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 5, 30, 15),
                          child: Text('Pests & Diseases'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LocationPermission extends StatefulWidget {
  @override
  _LocationPermissionState createState() => _LocationPermissionState();
}

class _LocationPermissionState extends State<LocationPermission> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Location'),
    );
  }
}

class HealthCheckSection extends StatefulWidget {
  @override
  _HealthCheckSectionState createState() => _HealthCheckSectionState();
}

class _HealthCheckSectionState extends State<HealthCheckSection> {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.9,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/healthCheck2.jpg"),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 35.0, 15.0, 35.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Health Check',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
              Text(
                'Take a picture of your crop to detect diseases and recieve treatment advice.',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 0.0),
                    child: OutlineButton(
                      borderSide: BorderSide(width: 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: Colors.teal[800],
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 35.0),
                        child: Text('Gallery'),
                      ),
                    ),
                  ),
                  RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    color: Colors.teal[900],
                    onPressed: () {},
                    icon: Icon(
                      Icons.add_a_photo,
                      color: Colors.white,
                    ),
                    label: Text(
                      'New Picture',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
