import 'dart:async';

import 'package:pds/data/database_helper.dart';
import 'package:pds/models/ApiUrl.dart';

class ApiUrlCtr {
  DatabaseHelper con = new DatabaseHelper();

//insertion
  Future<int> saveApiUrl(ApiUrl apiUrl) async {
    var dbClient = await con.db;
    int res = await dbClient.insert("ApiUrl", apiUrl.toMap());
    return res;
  }

  //deletion
  Future<int> deleteApiUrl(ApiUrl apiUrl) async {
    var dbClient = await con.db;
    int res = await dbClient.delete("ApiUrl");
    return res;
  }

  Future<ApiUrl> getApiUrl(String apiName) async {
    var dbClient = await con.db;
    var res = await dbClient
        .rawQuery("SELECT * FROM api_url WHERE name = '$apiName'");

    if (res.length > 0) {
      return new ApiUrl.fromMap(res.first);
    }

    return null;
  }

  Future<ApiUrl> saveNewApiUrl(String name, String url) async {
    var dbClient = await con.db;
    try {
      var res =
          await dbClient.rawQuery("SELECT * FROM api_url WHERE name = '$name'");

      if (res.length > 0) {
        var res2 = await dbClient
            .rawUpdate("UPDATE api_url SET url = '$url' WHERE name = '$name'");
      } else {
        var result = await dbClient.rawInsert(
            "INSERT INTO api_url (name, url) VALUES ('$name', '$url')");
      }
    } catch (e) {}

    var res =
        await dbClient.rawQuery("SELECT * FROM api_url WHERE name = '$name'");

    if (res.length > 0) {
      return new ApiUrl.fromMap(res.first);
    }
    return null;
  }

  Future<ApiUrl> updateApiUrl(String name, String url) async {
    var dbClient = await con.db;

    var res = await dbClient
        .rawUpdate("UPDATE api_url SET url = '$url' WHERE name = '$name'");

    var res3 =
        await dbClient.rawQuery("SELECT * FROM api_url WHERE name = '$name'");

    if (res3.length > 0) {
      return new ApiUrl.fromMap(res3.first);
    }

    return null;
  }

  Future<List<ApiUrl>> getAllApiUrl() async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery("SELECT * FROM api_url");

    List<ApiUrl> list =
        res.isNotEmpty ? res.map((c) => ApiUrl.fromMap(c)).toList() : null;

    return list;
  }
}
