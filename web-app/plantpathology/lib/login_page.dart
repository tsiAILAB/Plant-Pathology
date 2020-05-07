import 'package:flutter/material.dart';
import 'forget_password.dart';
import 'main.dart';
import 'reset_password.dart';

void main() => runApp(LoginPage());

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var _formKey = GlobalKey<FormState>();
  bool rememberMeValue = false;
  var _onPresedjk;
  bool _signInButtonEnable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[200],
      appBar: AppBar(
        title: Text("Login Page"),
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
                  validator: (String userName){
                    if(userName.isEmpty){
                      return 'Please enter your Name..!';
                    }
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_circle),
                      border: OutlineInputBorder(),
                      labelText: "Enter your name"
                  ),
                ),
                SizedBox(height: 25.0),
                TextFormField(
                  validator: (String userPhone){
                    if(userPhone.isEmpty){
                      return 'Please enter your Phone number..!';
                    }
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone_android),
                      border: OutlineInputBorder(),
                      labelText: "Enter your phone number"
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Checkbox(
                      value: rememberMeValue,
                      onChanged: (bool value){
                        print(value);
                        setState(() {
                          rememberMeValue = value;
                        });
                      }
                    ),
                    Text(
                      'Remember me'
                    )
                  ],
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
                Text(
                    'Already have an App Account?'
                ),
                FlatButton(
                  onPressed: (){
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>MyHomePage()),
                    );
                    setState(() {
                      if (_formKey.currentState.validate()){
                        print('Sign In Completed...');
                      }
                    });
                  },
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                        color: Colors.teal[800]
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: (){
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>ForgetPassword()),
                    );
                  },
                  child: Text(
                    'Forget password..? Get a new.',
                    style: TextStyle(
                        color: Colors.blue
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
}
