import 'package:flutter/material.dart';
import 'package:flutterapp/models/user.dart';
import 'package:flutterapp/services/response/change_password_response.dart';
import 'package:flutterapp/utils/utils.dart';

class ResetPassword extends StatefulWidget {
  static String userEmail;
  ResetPassword(String userMail) {
    userEmail = userMail;
  }
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword>
    implements ChangePasswordCallBack {
  _ResetPasswordState() {
    _response = new ChangePasswordResponse(this);
  }

  String _password;
  ChangePasswordResponse _response;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.amber[200],
      appBar: AppBar(
        title: Text("Reset Password"),
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
                  onSaved: (val) => _password = val,
                  validator: (String newPassword) {
                    if (newPassword.isEmpty) {
                      return 'please enter your new password';
                    }
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.security),
                      border: OutlineInputBorder(),
                      labelText: "New password"),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (String confirmPassword) {
                    if (confirmPassword.isEmpty) {
                      return 'Please enter confirm password';
                    }
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.security),
                      border: OutlineInputBorder(),
                      labelText: "Confirm password"),
                ),
                SizedBox(height: 20.0),
                OutlineButton(
                  onPressed: _updatePassword,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Text(
                    'Set New Password',
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

  void _updatePassword() {
    final form = formKey.currentState;

//    if (form.validate()) {
    setState(() {
      form.save();
      _response.doChangePassword(ResetPassword.userEmail, _password);
    });
//    }
  }

  @override
  void onChangePasswordError(String error) {
    Utils.showSnackBar("error $error", scaffoldKey);
    setState(() {});
  }

  @override
  void onChangePasswordSuccess(User user) async {
    if (user != null) {
      Utils.showSnackBar("Password changed!", scaffoldKey);
      setState(() {});
    } else {
      Utils.showSnackBar("Password not changed!", scaffoldKey);
      setState(() {});
    }
  }
}
