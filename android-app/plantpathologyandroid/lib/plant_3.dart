import 'package:flutter/material.dart';

class Plant3 extends StatefulWidget {
  @override
  _Plant3State createState() => _Plant3State();
}

class _Plant3State extends State<Plant3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        title: Text("Plant 3"),
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
