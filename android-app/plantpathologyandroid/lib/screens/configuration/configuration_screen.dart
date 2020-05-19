import 'package:flutter/material.dart';
import 'package:flutter_curved_tab_bar/flutter_curved_tab_bar.dart';
import 'package:pds/screens/configuration/add_api_screen.dart';
import 'package:pds/screens/configuration/add_plant_image_screen.dart';
import 'package:pds/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigurationScreen extends StatefulWidget {
  final VoidCallback signOut;

  ConfigurationScreen(this.signOut);

  @override
  _ConfigurationScreenState createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  int _currentIndex = 0;
  var value;
  var userRole;
  int numberOfTabs;
  var appbarTitle = new Text("");

  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  signOut() {
    setState(() {
      widget.signOut();
    });
    Utils.gotoHomeUi(context);
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
      userRole = preferences.getString("role");
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
    final List<Widget> _screens = <Widget>[_screen0(), _screen3()];
    setState(() {
//      if (userRole == "ADMIN") {
      numberOfTabs = 2;
//      } else {
//        numberOfTabs = 1;
//      }
    });

    return Scaffold(
//      child: Scaffold(
      key: _scaffoldKey,
//        body: SingleChildScrollView(
      body: ListView(
        children: <Widget>[
          AppBar(
            title:
                Text('Configuration', style: TextStyle(color: Colors.blueGrey)),
            iconTheme: IconThemeData(color: Colors.blueGrey),
            backgroundColor: Colors.white,
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
              tabSelectedColor: Colors.blueGrey,
              iconSelectedColor: Colors.white,
              iconsColor: Colors.blueGrey,
              numberOfTabs: numberOfTabs,
              icons: [Icons.phonelink_setup, Icons.image],
              onTabSelected: (_index) {
                setState(() {
                  _currentIndex = _index;
                  appbarTitle = Text("Configuration");
                });
              }),
          _screens[_currentIndex]
        ],
//          ),
      ),
//    ),
    );
  }

  Widget _screen0() {
    setState(() {
      appbarTitle = Text("Configuration");
    });
    return Container(
      height: MediaQuery.of(context).size.height - 73,
      color: Colors.white,
      child: AddApiScreen(),
    );
  }

  Widget _screen3() {
    return Container(
      height: MediaQuery.of(context).size.height - 73,
      color: Colors.white,
      child: AddPlantImageScreen(),
    );
  }
}
