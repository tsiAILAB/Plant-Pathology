import 'package:flutter/material.dart';

import 'file:///D:/Firoz/Android%20Studio/tsiFlutter/plant-pathology/android-app/plantpathologyandroid/lib/authentication/socicon_icons.dart';

void main() => runApp(SignUpPage());

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var _formKey = GlobalKey<FormState>();
  bool rememberMeValue = false;
  var _onPresedjk;
  bool _signInButtonEnable = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[200],
      appBar: AppBar(
        title: Text("SignUp Page"),
      ),
      body: Card(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton.icon(
                  color: Colors.blue[900],
                  onPressed: () {},
                  icon: Icon(
                    Socicon.facebook,
                    color: Colors.white,
                  ),
                  label: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 40.0, 0),
                    child: Text(
                      'SIGN UP WITH FACEBOOK',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                RaisedButton.icon(
                  color: Colors.white,
                  elevation: 2,
                  onPressed: () {},
                  icon: Icon(
                    Socicon.google,
                    color: Colors.green[800],
                  ),
                  label: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 57.0, 0),
                    child: Text('SIGN UP WITH GOOGLE'),
                  ),
                ),
                RaisedButton.icon(
                  color: Colors.teal[800],
                  onPressed: () {},
                  icon: Icon(
                    Icons.phone_android,
                    color: Colors.white,
                  ),
                  label: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 5.0, 0),
                    child: Text(
                      'SIGN UP WITH PHONE NUMBER',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                RaisedButton.icon(
                  color: Colors.white,
                  onPressed: () {},
                  icon: Icon(
                    Icons.email,
                    color: Colors.red[900],
                  ),
                  label: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 75.0, 0),
                    child: Text('SIGN IN WITH EMAIL'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[],
                ),
//                SizedBox(height: 8.0),
//                Text(
//                  "You'll receive an SMS shortly with the verification code.",
//                  style: TextStyle(
//                      fontSize: 12.0
//                  ),
//                ),
//                SizedBox(height: 15.0),
//                RaisedButton(
//                  onPressed: (){},
//                  child: Text(
//                    'Send verification code',
//                    style: TextStyle(color: Colors.white),
//                  ),
//                  shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(20),
//                  ),
//                ),
//                SizedBox(height: 15.0),
                Text('New at Plantix?'),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      if (_formKey.currentState.validate()) {
                        print('Sign Up Completed...');
                      }
                    });
                  },
                  child: Text(
                    'Sign Up',
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
