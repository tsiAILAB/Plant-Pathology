import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pds/services/request/upload_image.dart';

//void main() => runApp(PlantsDetailsPage());

class PlantDetailsScreen extends StatelessWidget {
//  @override
//  _PlantsDetailsPageState createState() => _PlantsDetailsPageState();
//}
//
//class _PlantsDetailsPageState extends State<PlantsDetailsPage> {
  final String imagePath;

  const PlantDetailsScreen({Key key, this.imagePath}) : super(key: key);

//  final GlobalKey _imageKey = GlobalKey();
//  Size imageSize;

//  void initState() {
//    super.initState();
//    WidgetsBinding.instance.addPostFrameCallback((_) => getImageSize());
//  }
//
//  getImageSize() {
//    RenderBox _imageBox = _imageKey.currentContext.findRenderObject();
//    imageSize = _imageBox.size;
//    print(imageSize);
//    setState(() {});
//  }

  @override
  Widget build(BuildContext context) {
    File imageFile = new File(this.imagePath);
    return Scaffold(
      appBar: AppBar(title: Text('Plant Picture')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Card(
                  child: Column(
                    children: <Widget>[
                      Image.file(File(imagePath)),
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
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Disease Name',
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 15.0),
                            OutlineButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text(
                                'About Disease',
                                style: TextStyle(color: Colors.teal[800]),
                              ),
                            ),
                            SizedBox(height: 35.0),
                            Text(
                              'Treat Now',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Recomanded Products',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              'Products Details goes to here',
                              style: TextStyle(
                                fontSize: 17.5,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              'Biological Control',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              'Biological Control details goes here.',
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            SizedBox(height: 60.0),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          UploadImage uploadImage = new UploadImage();
          if (imageFile != null) {
            uploadImage.uploadImage(imageFile, "imagePath");
          }
        },
        backgroundColor: Colors.teal[800],
        icon: Icon(
          Icons.cloud_upload,
          color: Colors.white,
        ),
        label: Text(
          'Upload Image',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
