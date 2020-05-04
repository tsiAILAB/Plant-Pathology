import 'package:flutter/material.dart';
import 'reset_password.dart';

void main() => runApp(ForgetPassword());

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  var _formKey = GlobalKey<FormState>();
  var _forgetPasswordFormKey = GlobalKey<FormState>();

  Future<void> _showVerificationDialog(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Verify Email/Phone'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Form(
                  key: _forgetPasswordFormKey,
                  child: TextFormField(
                    maxLength: 5,
                    validator: (String verifyCode){
                      if(verifyCode.isEmpty){
                        return 'Please enter the Code';
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Enter Verification Code"
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                child: OutlineButton(
                  onPressed: (){
                    setState(() {
                      if (_forgetPasswordFormKey.currentState.validate()){
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>ResetPassword()),
                        );
                      }else{
                        return 'Please enter the code';
                      }
                    });
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.teal[800]
                    ),
                  ),
                ),
                onTap: (){

                },
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[200],
      appBar: AppBar(
        title: Text("Verify that it's you"),
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
                      prefixIcon: Icon(Icons.settings_cell),
                      border: OutlineInputBorder(),
                      labelText: "Enter your Phone or Email"
                  ),
                ),
                SizedBox(height: 20,),
                OutlineButton(
                  onPressed: (){
                    _showVerificationDialog(context);
                    setState(() {

                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: Text(
                    'Get verification Code',
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
