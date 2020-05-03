import 'package:flutter/material.dart';
import 'package:flutter_curved_tab_bar/flutter_curved_tab_bar.dart';
import 'package:flutterapp/plant_1.dart';
import 'package:flutterapp/plant_2.dart';
import 'package:flutterapp/plant_3.dart';
import 'package:flutterapp/plant_4.dart';
import 'package:flutterapp/take_image.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = <Widget>[
      _screen0(),
      _screen1(),
      _screen2(),
      _screen3(),
      _screen4()
    ];

    return SafeArea(
      child: Scaffold(
          body: Center(
        child: Column(
          children: <Widget>[
            CurvedTabBar(
                tabsColor: Colors.blue[50],
                tabSelectedColor: Colors.orange,
                iconSelectedColor: Colors.blue[50],
                iconsColor: Colors.orange,
                numberOfTabs: 5,
                icons: [
                  Icons.ac_unit,
                  Icons.widgets,
                  Icons.bookmark,
                  Icons.adb,
                  Icons.style
                ],
                onTabSelected: (_index) {
                  setState(() {
                    _currentIndex = _index;
                  });
                }),
            _screens[_currentIndex]
          ],
        ),
      )),
    );
  }

  Widget _screen0() {
    return Container(
      height: MediaQuery.of(context).size.height - 73,
      color: Colors.white,
      child: TakeImage(),
    );
  }

  Widget _screen1() {
    return Container(
      height: MediaQuery.of(context).size.height - 73,
      color: Colors.white,
      child: Plant1(),
    );
  }

  Widget _screen2() {
    return Container(
      height: MediaQuery.of(context).size.height - 73,
      color: Colors.white,
      child: Plant2(),
    );
  }

  Widget _screen3() {
    return Container(
      height: MediaQuery.of(context).size.height - 73,
      color: Colors.white,
      child: Plant3(),
    );
  }

  Widget _screen4() {
    return Container(
      height: MediaQuery.of(context).size.height - 73,
      color: Colors.white,
      child: Plant4(),
    );
  }
}
