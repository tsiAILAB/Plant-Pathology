import 'package:flutter/material.dart';
import '../screens/landing_screen.dart';


void main() => runApp(SignUpPage());

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[200],
      appBar: AppBar(
        title: Text("Sign Up Page"),
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
                      return 'Please enter your Email/Gmail..!';
                    }
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                      labelText: "Enter your Gmail/Email"
                  ),
                ),
                SizedBox(height: 25.0),
                TextFormField(
                  controller: _pass,
                  validator: (val){
                    if(val.isEmpty)
                      return 'Please Enter a Password...!!';
                    return null;
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.security),
                      border: OutlineInputBorder(),
                      labelText: "Enter Password"
                  ),
                ),
                SizedBox(height: 25.0),
                TextFormField(
                  controller: _confirmPass,
                  validator: (val){
                    if(val.isEmpty)
                      return 'Please Enter a Password...!!';
                    if(val != _pass.text)
                      return 'Password did not Match';
                    return null;
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.security),
                      border: OutlineInputBorder(),
                      labelText: "Confirm Password"
                  ),
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

                FlatButton(
                  onPressed: (){
//                    Navigator.push(context,
//                      MaterialPageRoute(builder: (context)=>LandingScreen()),
//                    );
                    setState(() {
                      if (_formKey.currentState.validate()){
                        print('Sign Up Completed...');
                      }
                    });
                  },
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                        color: Colors.teal[800]
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
