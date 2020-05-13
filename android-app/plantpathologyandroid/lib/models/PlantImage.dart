class PlantImage {
  int _id;
  String _plantName;
  String _imageUrl;

  PlantImage(this._plantName, this._imageUrl);

  PlantImage.fromMap(dynamic obj) {
    this._plantName = obj['plantName'];
    this._imageUrl = obj['imageUrl'];
  }

  String get plantName => _plantName;
  String get imageUrl => _imageUrl;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["plantName"] = _plantName;
    map["imageUrl"] = _imageUrl;

    return map;
  }
}
