import 'package:pds/data/CtrQuery/login_ctr.dart';
import 'package:pds/models/user.dart';

class LoginRequest {
  LoginCtr con = new LoginCtr();

  Future<User> getLogin(String username, String password) async {
    var result = await con.getLogin(username, password);
    return result;
  }
}
