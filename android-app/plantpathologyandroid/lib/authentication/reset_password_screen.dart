import 'package:flutter/material.dart';

void main() => runApp(ResetPassword());

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[200],
      appBar: AppBar(
        title: Text("Reset Password"),
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
                  validator: (String newPassword){
                    if(newPassword.isEmpty){
                      return 'please enter your new password';
                    }
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.security),
                      border: OutlineInputBorder(),
                      labelText: "New password"
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  validator: (String confirmPassword){
                    if(confirmPassword.isEmpty){
                      return 'Please enter confirm password';
                    }
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.security),
                      border: OutlineInputBorder(),
                      labelText: "Confirm password"
                  ),
                ),
                SizedBox(height: 20.0),
                OutlineButton(
                  onPressed: (){
                    setState(() {

                    });
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: Text(
                    'Set New Password',
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
