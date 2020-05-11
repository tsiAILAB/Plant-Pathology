import 'package:flutter/material.dart';
import 'package:flutterapp/models/user.dart';
import 'package:flutterapp/services/emailservice/email_server_smtp.dart';
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
                      return 'Please enter your Email.';
                    }
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                      labelText: "Enter your Email"),
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
        bool isValidOtp =
            await Utils.verifyOtpAlertDialog(context, user.username);
        if (isValidOtp) {
          Utils.gotoHomeUi(context);
        } else {
          Utils.showSnackBar("Wrong OTP!", scaffoldKey);
        }
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
}
