import 'package:flutter/material.dart';

class Plant2 extends StatefulWidget {
  @override
  _Plant2State createState() => _Plant2State();
}

class _Plant2State extends State<Plant2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        title: Text("Plant 2"),
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
