import 'dart:async';

import 'package:flutterapp/data/database_helper.dart';
import 'package:flutterapp/models/user.dart';

class LoginCtr {
  DatabaseHelper con = new DatabaseHelper();

//insertion
  Future<int> saveUser(User user) async {
    var dbClient = await con.db;
    int res = await dbClient.insert("User", user.toMap());
    return res;
  }

  //deletion
  Future<int> deleteUser(User user) async {
    var dbClient = await con.db;
    int res = await dbClient.delete("User");
    return res;
  }

  Future<User> getLogin(String user, String password) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery(
        "SELECT * FROM user WHERE username = '$user' and password = '$password' and is_verified = 'true'");

    if (res.length > 0) {
      return new User.fromMap(res.first);
    }

    return null;
  }

  Future<User> saveNewUserWithOTP(
      String userEmail, String password, String otp) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery(
        "INSERT INTO user (username, password, otp, is_verified) VALUES ('$userEmail', '$password', '$otp', 'false'");

    if (res.length > 0) {
      return new User.fromMap(res.first);
    }

    return null;
  }

  Future<User> isValidOTP(String userEmail, String otp) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery(
        "SELECT * FROM user WHERE username = '$userEmail' and otp = '$otp'");

    if (res.length > 0) {
      User savedUser = new User.fromMap(res.first);
      var res2 = await dbClient.rawQuery(
          "UPDATE user SET is_valid = 'true' WHERE username = '$userEmail' and otp = '$otp'");
      if (res2.length > 0) {
        return new User.fromMap(res2.first);
      }
    }

    return null;
  }

  Future<User> changePassword(
      String userEmail, String password, String otp) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery(
        "SELECT * FROM user WHERE username = '$userEmail' and otp = '$otp'");

    if (res.length > 0) {
      User savedUser = new User.fromMap(res.first);
      var res2 = await dbClient.rawQuery(
          "UPDATE user SET password = '$password' WHERE username = '$userEmail' and otp = '$otp'");
      if (res2.length > 0) {
        return new User.fromMap(res2.first);
      }
    }

    return null;
  }

  Future<List<User>> getAllUser() async {
    var dbClient = await con.db;
    var res = await dbClient.query("user");

    List<User> list =
        res.isNotEmpty ? res.map((c) => User.fromMap(c)).toList() : null;

    return list;
  }
}
