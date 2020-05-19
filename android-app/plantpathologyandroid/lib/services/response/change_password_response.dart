import 'package:pds/models/user.dart';
import 'package:pds/services/request/change_password_request.dart';

abstract class ChangePasswordCallBack {
  void onChangePasswordSuccess(User user);
  void onChangePasswordError(String error);
}

class ChangePasswordResponse {
  ChangePasswordCallBack _callBack;
  ChangePasswordRequest loginRequest = new ChangePasswordRequest();
  ChangePasswordResponse(this._callBack);

  doChangePassword(String username, String password) {
    loginRequest
        .getChangePassword(username, password)
        .then((user) => _callBack.onChangePasswordSuccess(user))
        .catchError(
            (onError) => _callBack.onChangePasswordError(onError.toString()));
  }
}
