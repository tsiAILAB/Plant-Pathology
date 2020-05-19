import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pds/models/plant_diagnosis_response.dart';

class PlantDetailsScreen extends StatelessWidget {
  final PlantDiagnosisResponse plantDiagnosisResponse;
//  String plantName, diagnosisResult, diagnosisImage, diseaseName;

  PlantDetailsScreen(this.plantDiagnosisResponse);
//  {
//    this.plantName = plantDiagnosisResponse.plantName;
//    this.diagnosisResult = plantDiagnosisResponse.diagnosisResponse;
//    this.diseaseName = plantDiagnosisResponse.diseaseName;
//    this.diagnosisImage = plantDiagnosisResponse.imageUrl;
//  }

//  final diagnosisResult = 'Diseases Found, Probability-98.12%. ';
//  final diagnosisImage = 'assets/images/diseases.JPG';
//  final diseaseName = '';

  @override
  Widget build(BuildContext context) {
//    File imageFile = new File(this.imagePath);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('${plantDiagnosisResponse.diseaseName}',
            style: TextStyle(color: Colors.blueGrey)),
        iconTheme: IconThemeData(color: Colors.blueGrey),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Image.file(File('${plantDiagnosisResponse.imageUrl}')),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Diagnosis Result ',
                              style: TextStyle(
                                  fontSize: 25.0, color: Colors.blueGrey),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              '${plantDiagnosisResponse.diagnosisResponse}',
                              style: TextStyle(
                                  fontSize: 17.5, color: Colors.blueGrey),
                            ),
                            SizedBox(height: 15.0),
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
    );
  }
}
