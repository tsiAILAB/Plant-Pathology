import 'package:flutter/material.dart';
import 'package:flutter_curved_tab_bar/flutter_curved_tab_bar.dart';
import 'package:flutterapp/planttabs/plant_1.dart';
import 'package:flutterapp/take_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback signOut;
  HomeScreen(this.signOut);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  var value;
  var appbarTitle = "";

  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

//   @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text("Home"),
//        actions: <Widget>[
//           IconButton(
//             onPressed: () {
//               signOut();
//             },
//             icon: Icon(Icons.lock_open),
//           )
//         ],
//      ),
//      body: new Center(
//        child: new Text("Home Page"),
//      ),
//    );
//  }

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
          body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AppBar(
              title: new Text(appbarTitle),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    signOut();
                  },
                  icon: Icon(Icons.power_settings_new),
                )
              ],
            ),
            CurvedTabBar(
                tabsColor: Colors.blue[50],
                tabSelectedColor: Colors.orange,
//                iconSelectedColor: Colors.blue[50],
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
    String plantName = "Potato";
    appbarTitle = "Plant Disease $plantName";
    setState(() {
      appbarTitle = appbarTitle;
    });
    return Container(
      height: MediaQuery.of(context).size.height - 73,
      color: Colors.white,
      child: TakeImage(plantName),
    );
  }

  Widget _screen1() {
    String plantName = "Tomato";
    appbarTitle = "Plant Disease $plantName";
    setState(() {
      appbarTitle = appbarTitle;
    });
    return Container(
      height: MediaQuery.of(context).size.height - 73,
      color: Colors.white,
      child: TakeImage(plantName),
    );
  }

  Widget _screen2() {
    String plantName = "Tomato";
    appbarTitle = "Plant Disease $plantName";
    setState(() {
      appbarTitle = appbarTitle;
    });
    return Container(
      height: MediaQuery.of(context).size.height - 73,
      color: Colors.white,
      child: TakeImage(plantName),
    );
  }

  Widget _screen3() {
    String plantName = "Maize";
    appbarTitle = "Plant Disease $plantName";
    setState(() {
      appbarTitle = appbarTitle;
    });
    return Container(
      height: MediaQuery.of(context).size.height - 73,
      color: Colors.white,
      child: TakeImage(plantName),
    );
  }

  Widget _screen4() {
    String plantName = "Config";
    appbarTitle = "Plant Disease $plantName";
    setState(() {
      appbarTitle = appbarTitle;
    });
    return Container(
      height: MediaQuery.of(context).size.height - 73,
      color: Colors.white,
      child: Plant1(),
    );
  }
}
