import 'dart:async';

import 'package:pds/data/database_helper.dart';
import 'package:pds/models/PlantImage.dart';

class PlantImageCtr {
  DatabaseHelper con = new DatabaseHelper();

//insertion
  Future<int> savePlantImage(PlantImage plantImage) async {
    var dbClient = await con.db;
    int res = await dbClient.insert("PlantImage", plantImage.toMap());
    return res;
  }

  //deletion
  Future<int> deletePlantImage(PlantImage plantImage) async {
    var dbClient = await con.db;
    int res = await dbClient.delete("PlantImage");
    return res;
  }

  Future<PlantImage> getPlantImage(String plantName) async {
    var dbClient = await con.db;
    var res = await dbClient
        .rawQuery("SELECT * FROM plant_image WHERE name = '$plantName'");

    if (res.length > 0) {
      return new PlantImage.fromMap(res.first);
    }

    return null;
  }

  Future<PlantImage> saveNewPlantImage(String name, String url) async {
    var dbClient = await con.db;
    var result = await dbClient.rawInsert(
        "INSERT INTO plant_image (name, url) VALUES ('$name', '$url')");

    var res = await dbClient
        .rawQuery("SELECT * FROM plant_image WHERE name = '$name'");

    if (res.length > 0) {
      return new PlantImage.fromMap(res.first);
    }
    return null;
  }

  Future<PlantImage> updatePlantImage(String name, String url) async {
    var dbClient = await con.db;

    var res = await dbClient
        .rawUpdate("UPDATE plant_image SET url = '$url' WHERE name = '$name'");

    var res3 = await dbClient
        .rawQuery("SELECT * FROM plant_image WHERE name = '$name'");

    if (res3.length > 0) {
      return new PlantImage.fromMap(res3.first);
    }

    return null;
  }

  Future<List<PlantImage>> getAllPlantImages() async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery("SELECT * FROM plant_image");

    List<PlantImage> list =
        res.isNotEmpty ? res.map((c) => PlantImage.fromMap(c)).toList() : null;

    return list;
  }

//  var dbClient = await con.db;
//  var res = await dbClient.rawQuery("SELECT * FROM plant_image");
//
//  List<PlantImage> list;
//  if (res.length > 0) {
//  list = res.map((c) => PlantImage.fromMap(c)).toList();
//  } else
//  list = null;
//  return list;

}
