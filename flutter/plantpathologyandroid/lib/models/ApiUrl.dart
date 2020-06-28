class ApiUrl {
  int _id;
  String _apiName;
  String _apiUrl;

  ApiUrl(this._apiName, this._apiUrl);

  ApiUrl.fromMap(dynamic obj) {
    this._apiName = obj['name'];
    this._apiUrl = obj['url'];
  }

  String get apiName => _apiName;

  String get apiUrl => _apiUrl;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = _apiName;
    map["url"] = _apiUrl;

    return map;
  }
}
