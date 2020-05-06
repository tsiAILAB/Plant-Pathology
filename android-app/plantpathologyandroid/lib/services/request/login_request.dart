import 'package:flutterapp/data/CtrQuery/login_ctr.dart';
import 'package:flutterapp/models/user.dart';

class LoginRequest {
  LoginCtr con = new LoginCtr();

  Future<User> getLogin(String username, String password) {
    var result = con.getLogin(username, password);
    return result;
  }
}
