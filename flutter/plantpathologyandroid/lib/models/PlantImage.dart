class PlantImage {
  int _id;
  String _plantName;
  String _imageUrl;

  PlantImage(this._plantName, this._imageUrl);

  PlantImage.fromMap(dynamic obj) {
    this._plantName = obj['name'];
    this._imageUrl = obj['url'];
  }

  String get plantName => _plantName;
  String get imageUrl => _imageUrl;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = _plantName;
    map["url"] = _imageUrl;

    return map;
  }
}
