import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pds/models/ApiUrl.dart';
import 'package:pds/services/apis/all_apis.dart';
import 'package:pds/services/response/api_url_response.dart';
import 'package:pds/utils/utils.dart';

class AddApiScreen extends StatefulWidget {
  @override
  _AddApiScreenState createState() => _AddApiScreenState();
}

class _AddApiScreenState extends State<AddApiScreen> implements ApiUrlCallBack {
  ApiUrlResponse _apiUrlResponse;
  _AddApiScreenState() {
    _apiUrlResponse = new ApiUrlResponse(this);
  }

  File imageFile;
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final apiConfigFormKey = new GlobalKey<FormState>();
  final TextEditingController _apiUrlTextController =
      new TextEditingController();
  String _apiUrl;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.white,
          body: Column(
            children: <Widget>[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text('Update API',
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Api Name: ${AllApis.API_NAME}",
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.teal[800],
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Form(
                        key: apiConfigFormKey,
                        child: Column(
                          children: <Widget>[
//                            TextFormField(
//                              onSaved: (val) => _apiName = val,
//                              validator: (String value) {
//                                if (value.trim().isEmpty) {
//                                  return 'API Name is required';
//                                }
//                              },
//                              decoration: InputDecoration(
//                                  prefixIcon: Icon(Icons.art_track),
//                                  border: OutlineInputBorder(),
//                                  labelText: "API Name"),
//                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            TextFormField(
                              controller: _apiUrlTextController,
                              onSaved: (val) => _apiUrl = val,
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'API Url is required';
                                }
                                return "";
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.border_color,
                                    color: Colors.blueGrey,
                                  ),
                                  border: OutlineInputBorder(),
                                  labelText: "API URL"),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            OutlineButton(
                              onPressed: _saveApi,
                              child: Text(
                                'Update',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 16.0),
                              ),
                            ),

                            SizedBox(height: 40.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onApiUrlError(String error) {
    // TODO: implement onApiUrlError
    Utils.showLongToast("Api alredy exist!");
  }

  @override
  void onApiUrlSuccess(ApiUrl apiUrl) {
    // TODO: implement onApiUrlSuccess
    Utils.showLongToast("Api Saved");
    setState(() {
      _apiUrlTextController.clear();
    });
    log(apiUrl.apiName);
    log(apiUrl.apiUrl);
  }

  void _saveApi() async {
    final form = apiConfigFormKey.currentState;
    Utils utils = new Utils();
    setState(() {
      form.save();
      AllApis.uploadImageUrl = _apiUrl;
      if (_apiUrl != null && _apiUrl != "") {
        _apiUrlResponse.saveNewApiUrl(AllApis.API_NAME, _apiUrl);
      } else {
        Utils.showLongToast("Api URL cannot be empty!");
      }
    });
//    _apiUrlResponse.getApi("a");
  }
}
