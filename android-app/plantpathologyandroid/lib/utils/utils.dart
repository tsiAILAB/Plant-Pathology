import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/models/user.dart';
import 'package:flutterapp/services/emailservice/email_server_smtp.dart';
import 'package:flutterapp/services/request/sign_up_request.dart';
import 'package:path_provider/path_provider.dart';
import 'package:random_string/random_string.dart';

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

  static String generateRandomNumberOTP() {
    return randomNumeric(5);
  }

//  static final scaffoldKey = new GlobalKey<ScaffoldState>();
  static void showSnackBar(String text, scaffoldKey) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  static Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        return true;
      }
      return false;
    } on SocketException catch (_) {
      print('not connected');
      return false;
    }
  }

  static Future<bool> verifyOtpAlertDialog(
      BuildContext context, String userName) async {
    String _otp;
    var _forgetPasswordFormKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Verify Email'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Form(
                      key: _forgetPasswordFormKey,
                      child: TextFormField(
                        onSaved: (val) => _otp = val,
                        maxLength: 5,
                        validator: (String verifyCode) {
                          if (verifyCode.isEmpty) {
                            return 'Please enter the Code';
                          }
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Enter Verification Code"),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    child: OutlineButton(
                      onPressed: () async {
//                        setState(() {
//                          _isLoading = true;
                        final form = _forgetPasswordFormKey.currentState;
                        form.save();
//                          _response.doLogin(_username, _password);
//                        });
                        SignUpRequest signUpReq = new SignUpRequest();
                        User user = await signUpReq.isValidOTP(userName, _otp);
                        if (user != null) {
                          Navigator.pop(context);
                          return true;
                        } else {
                          return false;
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.teal[800]),
                      ),
                    ),
                    onTap: () {},
                  ),
                  GestureDetector(
                    child: OutlineButton(
                      onPressed: () async {
                        SignUpRequest signUpReq = new SignUpRequest();
                        User user = await signUpReq.getUser(userName);
                        if (user != null) {
                          EmailServerSMTP.sendEmailViaSMTP(
                              user.username, user.otp);
//                          Navigator.pop(context);
                          return false;
                        } else
                          return false;
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Text(
                        'Re-send OTP',
                        style: TextStyle(color: Colors.teal[800]),
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          );
        });
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("My title"),
      content: Text("This is my message."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void gotoHomeUi(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      SystemNavigator.pop();
    }
  }
}
