import 'package:pds/data/CtrQuery/login_ctr.dart';
import 'package:pds/models/user.dart';

class SignUpRequest {
  LoginCtr con = new LoginCtr();

  Future<User> isValidOTP(String username, String otp) async {
    var result = await con.isValidOTP(username, otp);
    return result;
  }

  Future<User> getUser(String username) async {
    var result = await con.getUser(username);
    return result;
  }

  Future<User> saveNewUserWithOTP(
      String username, String password, String otp) {
    var result = con.saveNewUserWithOTP(username, password, otp);
    return result;
  }
}
