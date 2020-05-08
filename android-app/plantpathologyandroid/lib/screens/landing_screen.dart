import 'package:flutter/material.dart';


class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Please select a Plant',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  FlatButton(
                    onPressed: (){
                      print("I'm Tomato");
                    },
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/tomato.jpg'),
                      radius: 60,
                    ),
                  ),
                  Text(
                      "Tomato",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: (){
                      print("I'm Potato");
                    },
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/potato.jpg'),
                      radius: 60,
                    ),
                  ),
                  Text(
                      "Potato",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: (){
                      print("I'm Maze");
                    },
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/maze.jpg'),
                      radius: 60,
                    ),
                  ),
                  Text(
                      "Maze",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
