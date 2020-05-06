import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Utils {
  Future<bool> saveImage(File image, String fileName, String imagePath) async {
    try {
      TimeOfDay timeOfDay = TimeOfDay.fromDateTime(DateTime.now());
      var imageName = "$imagePath$timeOfDay";
      // getting a directory path for saving
      var documentDirectory = await getApplicationDocumentsDirectory();
      var firstPath = documentDirectory.path + "/plant_images/$imagePath";
      // copy the file to a new path
      final File newImage = await image.copy('$firstPath/$imageName.png');
    } on Exception catch (_) {
      print("throwing new error");
      throw Exception("Error on server");
    }
    return true;
  }
}
