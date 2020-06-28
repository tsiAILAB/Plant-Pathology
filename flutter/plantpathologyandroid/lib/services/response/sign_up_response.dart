import 'package:pds/models/user.dart';
import 'package:pds/services/request/sign_up_request.dart';

abstract class SignUpCallBack {
  void onSignUpSuccess(User user);
  void onSignUpError(String error);
}

class SignUpResponse {
  SignUpCallBack _callBack;
  SignUpRequest signUpRequest = new SignUpRequest();
  SignUpResponse(this._callBack);

  doSignUp(String username, String password, String otp) {
    signUpRequest
        .saveNewUserWithOTP(username, password, otp)
        .then((user) => _callBack.onSignUpSuccess(user))
        .catchError((onError) => _callBack.onSignUpError(onError.toString()));
  }
}
