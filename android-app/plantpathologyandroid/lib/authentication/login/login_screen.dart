import 'package:flutter/material.dart';
import 'package:flutterapp/authentication/forget_password_screen.dart';
import 'package:flutterapp/authentication/signup_page_screen.dart';
import 'package:flutterapp/models/user.dart';
import 'package:flutterapp/screens/landing_screen.dart';
import 'package:flutterapp/services/response/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../screens/home_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginPageState extends State<LoginPage> implements LoginCallBack {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  bool rememberMeValue = false;

  String _username, _password;

  LoginResponse _response;

  _LoginPageState() {
    _response = new LoginResponse(this);
  }

  void _submit() {
    final form = formKey.currentState;

//    if (form.validate()) {
    setState(() {
      _isLoading = true;
      form.save();
      _response.doLogin(_username, _password);
    });
//    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  var value;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return loginUiTwo();
        break;
      case LoginStatus.signIn:
        return LandingScreen(signOut);
//        return MyHomePage(signOut);
        break;
      default:
        return loginUiTwo();
    }
  }

  savePref(int value, String user, String pass) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("user", user);
      preferences.setString("pass", pass);
      preferences.commit();
    });
  }

  @override
  void onLoginError(String error) {
    _showSnackBar("error $error");
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(User user) async {
    if (user != null) {
      savePref(1, user.username, user.password);
      _loginStatus = LoginStatus.signIn;
    } else {
      _showSnackBar("Wrong username or password");
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget loginUi() {
    _ctx = context;
    var loginBtn = new RaisedButton(
      onPressed: _submit,
      child: new Text("Login"),
      color: Colors.green,
    );
    var loginForm = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _username = val,
                  decoration: new InputDecoration(labelText: "Username"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _password = val,
                  decoration: new InputDecoration(labelText: "Password"),
                ),
              )
            ],
          ),
        ),
        loginBtn
      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Login Page"),
      ),
      key: scaffoldKey,
      body: new Container(
        child: new Center(
          child: loginForm,
        ),
      ),
    );
  }

  Widget loginUiTwo() {
    _ctx = context;
    return Scrollbar(
        child: Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.amber[200],
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Card(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  onSaved: (val) => _username = val,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_circle),
                      border: OutlineInputBorder(),
                      labelText: "Enter your name"),
                  validator: (String value) {
                    if (value.trim().isEmpty) {
                      return 'User name is required';
                    }
                    return "";
                  },
                ),
                SizedBox(height: 25.0),
                TextFormField(
                  obscureText: true,
                  onSaved: (val) => _password = val,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone_android),
                      border: OutlineInputBorder(),
                      labelText: "password"),
                  validator: (String value) {
                    if (value.trim().isEmpty) {
                      return 'Password is required';
                    }
                    return "";
                  },
                ),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    Checkbox(
//                        value: rememberMeValue,
//                        onChanged: (bool value) {
//                          print(value);
//                          setState(() {
//                            rememberMeValue = value;
//                          });
//                        }),
//                    Text('Remember me')
//                  ],
//                ),
                SizedBox(height: 15.0),
                Text('Already have an App Account?'),
                FlatButton(
                  onPressed: _submit,
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgetPassword()),
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) => SocialMediaLogin()),
                    );
                  },
                  child: Text(
                    'Forget password? Get a new.',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                SizedBox(height: 15.0),
                Text('Want to join?'),
                FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
