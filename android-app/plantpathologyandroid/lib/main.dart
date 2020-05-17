import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'authentication/login/login_screen.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
//  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
//  final firstCamera = cameras.first;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

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
        primarySwatch: Colors.blueGrey,
      ),
      routes: routes,
//      home: MyHomePage(),
    );
  }
}
