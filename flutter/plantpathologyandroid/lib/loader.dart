import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              height: 150.0,
              width: 150.0,
              child: CircularProgressIndicator(
                strokeWidth: 5.0,
                backgroundColor: Colors.lightBlueAccent,
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
            ),
            Container(
                height: 150.0,
                width: 150.0,
                alignment: Alignment.center,
                child: Text(
                    'Loading...',
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
