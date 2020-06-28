class User {
  int _id;
  String _username;
  String _password;
  String _isVerified;
  String _otp;
  String _role;

//  User(this._username, this._password);
//  User(this._username, this._password, this._isVerified);
//  User(this._username, this._password, this._otp);
  User(this._username, this._password, this._isVerified, this._otp, _role);

  User.fromMap(dynamic obj) {
    this._username = obj['username'];
    this._password = obj['password'];
    this._otp = obj['otp'];
    this._isVerified = obj['is_verified'];
    this._role = obj['role'];
  }

  String get username => _username;
  String get password => _password;
  String get otp => _otp;
  String get isVerified => _isVerified;
  String get role => _role;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = _username;
    map["password"] = _password;
    map["otp"] = _otp;
    map["is_verified"] = _isVerified;
    map["role"] = _role;

    return map;
  }
}
