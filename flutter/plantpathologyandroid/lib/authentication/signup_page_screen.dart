import 'package:flutter/material.dart';
import 'package:pds/models/user.dart';
import 'package:pds/screens/landing_screen.dart';
import 'package:pds/services/emailservice/email_server_smtp.dart';
import 'package:pds/services/request/sign_up_request.dart';
import 'package:pds/services/response/sign_up_response.dart';
import 'package:pds/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

//void main() => runApp(SignUpPage());

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

enum LoginStatus { notSignIn, signIn }

class _SignUpPageState extends State<SignUpPage> implements SignUpCallBack {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
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
        title: Text("Sign Up", style: TextStyle(color: Colors.blueGrey)),
        iconTheme: IconThemeData(color: Colors.blueGrey),
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
                      labelText: "Email"),
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
                      labelText: "Password"),
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
                SizedBox(
                  height: 10.0,
                ),
                OutlineButton(
                  onPressed: _signUp,
                  child: Text(
                    ' Submit ',
                    style: TextStyle(color: Colors.teal[800], fontSize: 16.0),
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

//  signOut() async {
//    SharedPreferences preferences = await SharedPreferences.getInstance();
//    setState(() {
//      preferences.setInt("value", null);
//      preferences.commit();
//      _loginStatus = LoginStatus.notSignIn;
//    });
//  }

  savePref(int value, String user, String pass, String role) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("user", user);
      preferences.setString("pass", pass);
      preferences.setString("role", role);
      preferences.commit();
    });
  }

  void verifyOtpAlertDialog(BuildContext context, String userName) async {
    String _otp;
    var _forgetPasswordFormKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:
                Text('Verify Email', style: TextStyle(color: Colors.blueGrey)),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Form(
                      key: _forgetPasswordFormKey,
                      child: TextFormField(
                        onSaved: (val) => _otp = val,
                        keyboardType: TextInputType.number,
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
                          if (user.isVerified == "true") {
                            savePref(
                                1, user.username, user.password, user.role);
                            _loginStatus = LoginStatus.signIn;

//                            Navigator.of(context).pushReplacement(
//                                new MaterialPageRoute(
//                                    builder: (BuildContext context) =>
//                                        LandingScreen(signOut)));

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LandingScreen(null)),
                              (Route<dynamic> route) => false,
                            );
                          }
                        } else {
                          Utils.showLongToast("Wrong OTP!");
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

  @override
  void onSignUpError(String error) {
    Utils.showLongToast(
        "This email is already registered. Please go to login.");
    setState(() {});
  }

  @override
  void onSignUpSuccess(User user) async {
    if (user != null) {
      if (await Utils.checkInternetConnection()) {
        EmailServerSMTP.sendEmailViaSMTP(user.username, user.otp);
        Utils.showLongToast("Please check your mail for otp");
        verifyOtpAlertDialog(context, user.username);
      } else {
        Utils.showLongToast(
            "Please check your internet connection and resend otp");
      }
    } else {
      Utils.showLongToast("Wrong username or password");
      setState(() {});
    }
  }
}
