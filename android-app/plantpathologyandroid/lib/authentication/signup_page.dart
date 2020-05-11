import 'package:flutter/material.dart';
import 'package:flutterapp/models/user.dart';
import 'package:flutterapp/services/emailservice/email_server_smtp.dart';
import 'package:flutterapp/services/request/sign_up_request.dart';
import 'package:flutterapp/services/response/sign_up_response.dart';
import 'package:flutterapp/utils/utils.dart';

//void main() => runApp(SignUpPage());

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> implements SignUpCallBack {
  SignUpResponse _response;

  final scaffoldKey = new GlobalKey<ScaffoldState>();

  _SignUpPageState() {
    _response = new SignUpResponse(this);
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  String _username, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Sign Up Page"),
        backgroundColor: Colors.white,
      ),
      body: Card(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Form(
            key: formKey,
            child: ListView(
//              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  onSaved: (val) => _username = val,
                  validator: (String userName) {
                    if (userName.isEmpty) {
                      return 'Please enter your Email/Gmail.';
                    }
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                      labelText: "Enter your Email/Gmail"),
                ),
                SizedBox(height: 25.0),
                TextFormField(
                  onSaved: (val) => _password = val,
                  obscureText: true,
                  controller: _pass,
                  validator: (val) {
                    if (val.isEmpty) return 'Please Enter a Password.';
                    return null;
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.security),
                      border: OutlineInputBorder(),
                      labelText: "Enter Password"),
                ),
                SizedBox(height: 25.0),
                TextFormField(
                  obscureText: true,
                  controller: _confirmPass,
                  validator: (val) {
                    if (val.isEmpty) return 'Please Enter a Password...!!';
                    if (val != _pass.text) return 'Password did not Match';
                    return null;
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.security),
                      border: OutlineInputBorder(),
                      labelText: "Confirm Password"),
                ),
                OutlineButton(
                  onPressed: _signUp,
                  child: Text(
                    ' Submit ',
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

  void _signUp() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        form.save();
        String _otp = Utils.generateRandomNumberOTP();
        _response.doSignUp(_username, _password, _otp);
      });
    }
  }

  @override
  void onSignUpError(String error) {
    Utils.showSnackBar(
        "This email is already registered. Please go to login.", scaffoldKey);
    setState(() {});
  }

  @override
  void onSignUpSuccess(User user) async {
    if (user != null) {
      if (await Utils.checkInternetConnection()) {
        EmailServerSMTP.sendEmailViaSMTP(user.username, user.otp);
        Utils.showSnackBar("Please check your mail for otp", scaffoldKey);
        verifyOtpAlertDialog(context, user.username);
      } else {
        Utils.showSnackBar(
            "Please check your internet connection and resend otp",
            scaffoldKey);
      }
    } else {
      Utils.showSnackBar("Wrong username or password", scaffoldKey);
      setState(() {});
    }
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
                          Utils.gotoHomeUi(context);
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
