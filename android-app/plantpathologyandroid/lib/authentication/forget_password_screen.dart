import 'package:flutter/material.dart';
import 'package:flutterapp/data/CtrQuery/login_ctr.dart';
import 'package:flutterapp/models/user.dart';
import 'package:flutterapp/services/emailservice/email_server_smtp.dart';
import 'package:flutterapp/services/request/sign_up_request.dart';
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
            ),
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
        title: Text(
            "Verify that it's you",
        ),
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
                      return 'Enter your Email/Gmail address';
                    }
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                      labelText: "Enter your verified Email/Gmail"),
                ),
                SizedBox(
                  height: 20,
                ),
                OutlineButton(
                  onPressed: () async {
                    if (await Utils.checkInternetConnection()) {
                      String _otp = Utils.generateRandomNumberOTP();
                      LoginCtr con = new LoginCtr();

                      final form = formKey.currentState;
                      setState(() {
                        form.save();
                      });

                      User userFromDb =
                          await con.updateUserOtp(_userEmail, _otp);

                      if (userFromDb != null) {
                        EmailServerSMTP.sendEmailViaSMTP(
                            userFromDb.username, userFromDb.otp);
                        Utils.showSnackBar(
                            "Please check your mail for otp", scaffoldKey);
                        verifyOtpAlertDialog(context, _userEmail);
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
                    style: TextStyle(
                        color: Colors.teal[800],
                        fontSize: 16.0
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

  void verifyOtpAlertDialog(BuildContext context, String userName) async {
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ResetPassword(_userEmail)),
                          );
                        } else {
                          Utils.showSnackBar("Wrong OTP!", scaffoldKey);
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
}
