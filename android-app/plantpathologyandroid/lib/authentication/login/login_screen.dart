import 'package:flutter/material.dart';
import 'package:pds/authentication/forget_password_screen.dart';
import 'package:pds/authentication/signup_page_screen.dart';
import 'package:pds/models/user.dart';
import 'package:pds/screens/landing_screen.dart';
import 'package:pds/services/response/login_response.dart';
import 'package:pds/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
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
      if (_username != null &&
          _username != "" &&
          _password != null &&
          _password != "") {
        _scaffoldKey.currentState.showSnackBar(new SnackBar(
          duration: new Duration(seconds: 4),
          content: new Row(
            children: <Widget>[
              new CircularProgressIndicator(),
              new Text("  Signing-In...")
            ],
          ),
        ));
        _response
            .doLogin(_username, _password)
            .whenComplete(() => Navigator.pop(context));

        //_response.doLogin(_username, _password);
      } else {
        //Navigator.of(context).pushNamed("/Home"));
        Utils.showLongToast("Username and password cannot be empty!");
      }
    });
//    }
  }

  void _showSnackBar(String text) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
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

  void getPermission() async {
    await Utils.requestStoragePermission();
  }

  @override
  void initState() {
    super.initState();
    getPref();
    getPermission();
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

  savePref(int value, String user, String pass, String role) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("user", user);
      preferences.setString("pass", pass);
      preferences.setString("role", role);
      preferences.commit();
    });
  }

  @override
  void onLoginError(String error) {
    Utils.showLongToast("error $error");
    Utils.showLongToast("Invalid username or password");
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(User user) async {
    if (user != null) {
      if (user.isVerified == "true") {
        savePref(1, user.username, user.password, user.role);
        _loginStatus = LoginStatus.signIn;
      } else {
        if (await Utils.verifyOtpAlertDialog(context, user.username)) {
          savePref(1, user.username, user.password, user.role);
          _loginStatus = LoginStatus.signIn;
        } else {
          Utils.showLongToast("Re enter OTP");
          setState(() {
            _isLoading = false;
          });
        }
      }
    } else {
      Utils.showLongToast("Invalid username or password");
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
      key: _scaffoldKey,
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
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Plant Diagnosis System",
            style: TextStyle(color: Colors.blueGrey)),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Card(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  onSaved: (val) => _username = val,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail),
                      border: OutlineInputBorder(),
                      labelText: "Email"),
                  validator: (String value) {
                    if (value.trim().isEmpty) {
                      return 'Email is required';
                    }
                    return "";
                  },
                ),
                SizedBox(height: 25.0),
                TextFormField(
                  obscureText: true,
                  onSaved: (val) => _password = val,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.security),
                      border: OutlineInputBorder(),
                      labelText: "Password"),
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
                Text(
                  'Already Registered?',
                ),
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
                    'Forgot Password?',
                    style: TextStyle(color: Colors.blue, fontSize: 15.0),
                  ),
                ),
                SizedBox(height: 10.0),
                FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  child: Text(
                    'New to Plan Diagnosis System?Sign Up',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue, fontSize: 15.0),
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
