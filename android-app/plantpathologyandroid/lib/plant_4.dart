import 'package:flutter/material.dart';

class Plant4 extends StatefulWidget {
  @override
  _Plant4State createState() => _Plant4State();
}

class _Plant4State extends State<Plant4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[200],
      appBar: AppBar(
        title: Text("Plant 4"),
      ),
      body: Center(
        child: Text(
          "Under Construction!",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
    );
  }
}
