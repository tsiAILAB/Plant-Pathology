import 'dart:async';

import 'package:pds/data/database_helper.dart';
import 'package:pds/models/user.dart';

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

  Future<User> getUser(String user) async {
    var dbClient = await con.db;
    var res =
        await dbClient.rawQuery("SELECT * FROM user WHERE username = '$user'");

    if (res.length > 0) {
      return new User.fromMap(res.first);
    }

    return null;
  }

  Future<User> getLogin(String user, String password) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery(
        "SELECT * FROM user WHERE username = '$user' and password = '$password'");

    if (res.length > 0) {
      return new User.fromMap(res.first);
    }

    return null;
  }

  Future<User> saveNewUserWithOTP(
      String userEmail, String password, String otp) async {
    var dbClient = await con.db;
    var result = await dbClient.rawInsert(
        "INSERT INTO user (username, password, otp, is_verified, role) VALUES ('$userEmail', '$password', '$otp', 'false', 'USER')");

    var res = await dbClient
        .rawQuery("SELECT * FROM user WHERE username = '$userEmail'");

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
//      User savedUser = new User.fromMap(res.first);
      var res2 = await dbClient.rawUpdate(
          "UPDATE user SET is_verified = 'true', otp = '' WHERE username = '$userEmail'");
//      await dbClient.rawUpdate('''
//    UPDATE user
//    SET is_verified = ?, otp = ?
//    WHERE username = ?
//    ''',);
//          ['true', '', '$userEmail']);
      var res3 = await dbClient
          .rawQuery("SELECT * FROM user WHERE username = '$userEmail'");
      var res4 = await dbClient.rawQuery("SELECT * FROM user");

      if (res3.length > 0) {
        return new User.fromMap(res3.first);
      }
    }

    return null;
  }

  Future<User> changePassword(String userEmail, String password) async {
    var dbClient = await con.db;
    var res = await dbClient
        .rawQuery("SELECT * FROM user WHERE username = '$userEmail'");

    if (res.length > 0) {
      User savedUser = new User.fromMap(res.first);
      var res2 = await dbClient.rawUpdate(
          "UPDATE user SET password = '$password' WHERE username = '$userEmail'");

      var res3 = await dbClient
          .rawQuery("SELECT * FROM user WHERE username = '$userEmail'");

      if (res3.length > 0) {
        return new User.fromMap(res3.first);
      }
    }

    return null;
  }

  Future<User> updateUserOtp(String userEmail, String otp) async {
    var dbClient = await con.db;

    var res2 = await dbClient.rawUpdate(
        "UPDATE user SET otp = '$otp' WHERE username = '$userEmail'");

    var res3 = await dbClient
        .rawQuery("SELECT * FROM user WHERE username = '$userEmail'");

    if (res3.length > 0) {
      return new User.fromMap(res3.first);
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
