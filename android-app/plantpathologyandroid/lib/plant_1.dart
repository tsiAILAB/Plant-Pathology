import 'package:flutter/material.dart';

class Plant1 extends StatefulWidget {
  @override
  _Plant1State createState() => _Plant1State();
}

class _Plant1State extends State<Plant1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[200],
      appBar: AppBar(
        title: Text("Plant 1"),
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
