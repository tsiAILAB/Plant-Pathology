import 'package:pds/data/CtrQuery/login_ctr.dart';
import 'package:pds/models/user.dart';

class ChangePasswordRequest {
  LoginCtr con = new LoginCtr();

  Future<User> getChangePassword(String username, String password) async {
    var result = await con.changePassword(username, password);
    return result;
  }
}
