import 'package:flutter/material.dart';

import 'authentication/login/login_screen.dart';

void main() => runApp(MyApp());
final routes = {
  '/login': (BuildContext context) => new LoginPage(),
  '/': (BuildContext context) => new LoginPage(),
};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      routes: routes,
//      home: MyHomePage(),
    );
  }
}
