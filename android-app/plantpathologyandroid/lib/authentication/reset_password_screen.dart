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
  final TextEditingController _newPass = TextEditingController();
  final TextEditingController _newConfirmPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Reset Password"),
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
                  onSaved: (val) => _password = val,
                  controller: _newPass,
                  validator: (val) {
                    if (val.isEmpty) return 'Please Enter new Password.';
                    return null;
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
                  controller: _newConfirmPass,
                  validator: (val) {
                    if (val.isEmpty) return 'Please Enter a Password...!!';
                    if (val != _newPass.text) return 'Password did not Match';
                    return null;
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
