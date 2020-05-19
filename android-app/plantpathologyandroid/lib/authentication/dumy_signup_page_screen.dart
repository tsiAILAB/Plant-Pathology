import 'package:flutter/material.dart';

void main() => runApp(SignUpSocialMediaPage());

class SignUpSocialMediaPage extends StatefulWidget {
  @override
  _SignUpSocialMediaPageState createState() => _SignUpSocialMediaPageState();
}

class _SignUpSocialMediaPageState extends State<SignUpSocialMediaPage> {
  var _formKey = GlobalKey<FormState>();
  bool rememberMeValue = false;
  bool _signInButtonEnable = false;
  @override
  Widget build(BuildContext context) {
    String _username;
    String _password;
    return Scaffold(
      backgroundColor: Colors.amber[200],
      appBar: AppBar(
        title: Text("SignUp Page", style: TextStyle(color: Colors.blueGrey)),
        iconTheme: IconThemeData(color: Colors.blueGrey),
      ),
      body: Card(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  onSaved: (val) => _username = val,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_circle),
                      border: OutlineInputBorder(),
                      labelText: "Enter your name"),
                  validator: (String value) {
                    if (value.trim().isEmpty) {
                      return 'User name is required';
                    }
                    return "";
                  },
                ),
                SizedBox(height: 25.0),
                TextFormField(
                  obscureText: true,
                  onSaved: (val) => _password = val,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone_android),
                      border: OutlineInputBorder(),
                      labelText: "password"),
                  validator: (String value) {
                    if (value.trim().isEmpty) {
                      return 'Password is required';
                    }
                    return "";
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[],
                ),
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
