import 'package:flutter/material.dart';

import 'file:///D:/Firoz/Android%20Studio/tsiFlutter/plant-pathology/android-app/plantpathologyandroid/lib/authentication/signup_page.dart';

import '../authentication/login_page.dart';

class Plant4 extends StatefulWidget {
  @override
  _Plant4State createState() => _Plant4State();
}

class _Plant4State extends State<Plant4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[200],
//      appBar: AppBar(
//        title: Text("Plant 4"),
//      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Under Construction!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Login Page'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: Text('SignUp Page'),
            )
          ],
        ),
      ),
    );
  }
}
