import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_curved_tab_bar/flutter_curved_tab_bar.dart';
import 'package:pds/models/ApiUrl.dart';
import 'package:pds/models/PlantImage.dart';
import 'package:pds/screens/config_screen.dart';
import 'package:pds/screens/plantdiagnosisscreen/take_image_screen.dart';
import 'package:pds/services/apis/all_apis.dart';
import 'package:pds/services/response/api_url_response.dart';
import 'package:pds/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback signOut;
  final PlantImage plantImage;

  HomeScreen(this.signOut, this.plantImage);

  @override
  _HomeScreenState createState() => _HomeScreenState(this.plantImage);
}

class _HomeScreenState extends State<HomeScreen> implements ApiUrlCallBack {
  PlantImage plantImage;

  String plantName;
  String plantImageUrl;
  ApiUrlResponse _apiUrlResponse;
//  _HomeScreenState(this.plantName);
  _HomeScreenState(plantImage) {
    this.plantImage = plantImage;
    this.plantName = this.plantImage.plantName;
    this.plantImageUrl = this.plantImage.imageUrl;
    _apiUrlResponse = new ApiUrlResponse(this);
  }
  int _currentIndex = 0;
  var value;
  var userRole;
  int numberOfTabs;
  var appbarTitle = new Text("");
  var appbarTitleList = ["Potato", "Tomato", "Maize", "Config"];

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

  getApi() async {
    String apiName = "uploadImageApi";
    ApiUrl apiUrl = await _apiUrlResponse.getApi(apiName);
    setState(() {
      AllApis.uploadImageUrl = apiUrl.apiUrl;
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
//      _screen1(),
//      _screen2(),
      _screen3()
    ];
    setState(() {
      if (userRole == "ADMIN") {
        numberOfTabs = 2;
      } else {
        numberOfTabs = 1;
      }
    });
//      _screen4()
//    ];
//    var plantName = appbarTitleList[0];

    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                AppBar(
                  title: Text("Plant Diagnosis System"),
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
                    tabSelectedColor: Colors.orange,
//                iconSelectedColor: Colors.blue[50],
                    iconsColor: Colors.orange,
                    numberOfTabs: numberOfTabs,
                    icons: [
                      Icons.ac_unit,
                      Icons.widgets
//                  Icons.bookmark,
//                  Icons.adb
//                  Icons.style
                    ],
                    onTabSelected: (_index) {
                      setState(() {
                        _currentIndex = _index;

                        var plantNameText = this.plantName;
                        appbarTitle = Text("Diagnosis");
                        log('plantName: $plantNameText');
                        log('appbarTitle: $plantNameText');
                      });
                    }),
                _screens[_currentIndex]
              ],
            ),
          )),
    );
  }

  Widget _screen0() {
    var plantNameText = this.plantName;
    setState(() {
      appbarTitle = Text("Diagnosis");
    });
    return Container(
      height: MediaQuery.of(context).size.height - 73,
      color: Colors.white,
      child: TakeImageScreen(signOut, this.plantImage),
    );
  }

  Widget _screen1() {
    String plantNameText = this.plantName;
    appbarTitle = Text("Diagnosis");
    return Container(
      height: MediaQuery.of(context).size.height - 73,
      color: Colors.white,
      child: TakeImageScreen(signOut, this.plantImage),
    );
  }

  Widget _screen2() {
//    String plantName = "Maize";
//    appbarTitle = "Plant Disease $plantName";
    return Container(
      height: MediaQuery.of(context).size.height - 73,
      color: Colors.white,
      child: TakeImageScreen(signOut, this.plantImage),
    );
  }

  Widget _screen3() {
    setState(() {
//      appbarTitle = Text("Configuration");
    });

//    String plantName = "Config";
//    appbarTitle = "Plant Disease $plantName";
    return Container(
      height: MediaQuery.of(context).size.height - 73,
      color: Colors.white,
      child: ConfigScreen(),
    );
  }

  @override
  void onApiUrlError(String error) {
    Utils.showLongToast("Api update failed");
    setState(() {});
  }

  @override
  void onApiUrlSuccess(ApiUrl apiUri) async {
    if (apiUri != null) {
      Utils.showLongToast("Api Updated");
    } else {
      Utils.showLongToast("Api update failed");
      setState(() {});
    }
  }
//  Widget _screen4() {
//    String plantName = "Tomato";
//    appbarTitle = "Plant Disease $plantName";
//    return Container(
//      height: MediaQuery.of(context).size.height - 73,
//      color: Colors.white,
//      child: TakeImage(plantName),
//    );
//  }
}
