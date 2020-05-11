import 'package:flutter/material.dart';
import 'package:flutterapp/data/CtrQuery/login_ctr.dart';
import 'package:flutterapp/models/user.dart';
import 'package:flutterapp/services/emailservice/email_server_smtp.dart';
import 'package:flutterapp/utils/utils.dart';

import 'reset_password_screen.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  var formKey = GlobalKey<FormState>();
  var _forgetPasswordFormKey = GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _userEmail;

  Future<void> _showVerificationDialog(BuildContext context) {
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
                        onSaved: (val) => _userEmail = val,
                        maxLength: 5,
                        validator: (String verifyCode) {
                          if (verifyCode.isEmpty) {
                            return 'Please enter the Code';
                          }
//                          return "";
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
                      onPressed: () {
                        setState(() {
                          if (_forgetPasswordFormKey.currentState.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ResetPassword(_userEmail)),
                            );
//                            return "";
                          } else {
                            return 'Please enter the code';
                          }
                        });
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
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Verify that it's you"),
        backgroundColor: Colors.white,
      ),
      body: Card(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  onSaved: (val) => _userEmail = val,
                  validator: (String userName) {
                    if (userName.isEmpty) {
                      return 'Enter your Email address';
                    }
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.settings_cell),
                      border: OutlineInputBorder(),
                      labelText: "Enter your Email"),
                ),
                SizedBox(
                  height: 20,
                ),
                OutlineButton(
                  onPressed: () async {
                    if (await Utils.checkInternetConnection()) {
                      String _otp = Utils.generateRandomNumberOTP();
                      LoginCtr con = new LoginCtr();

                      User userFromDb =
                          await con.updateUserOtp(_userEmail, _otp);

                      if (userFromDb != null) {
                        EmailServerSMTP.sendEmailViaSMTP(
                            userFromDb.username, userFromDb.otp);
                        Utils.showSnackBar(
                            "Please check your mail for otp", scaffoldKey);
                        bool isValidOtp = await Utils.verifyOtpAlertDialog(
                            context, _userEmail);
                        if (isValidOtp) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ResetPassword(_userEmail)),
                          );
                        } else {
                          Utils.showSnackBar(
                              "Wrong verification code!", scaffoldKey);
                        }
                      } else {
                        Utils.showSnackBar(
                            "Invalid Email address!", scaffoldKey);
                      }
                    } else {
                      Utils.showSnackBar(
                          "Please check internet connection!", scaffoldKey);
                    }

                    setState(() {});
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Text(
                    'Get verification Code',
                    style: TextStyle(color: Colors.teal[800]),
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
