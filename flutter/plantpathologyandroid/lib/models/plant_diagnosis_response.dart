class PlantDiagnosisResponse {
  int _id;
  String _plantName;
  String _imageUrl;
  String _diseaseName;
  String _diagnosisResponse;

  PlantDiagnosisResponse(this._plantName, this._imageUrl, this._diseaseName,
      this._diagnosisResponse);
//  Response='d1=EarlyBlight#p1=92.07%;d2=EarlyBlight#p2=92.07%'
  PlantDiagnosisResponse.fromMap(dynamic obj) {
    this._plantName = obj['name'];
    this._imageUrl = obj['url'];
    this._diseaseName = obj['disease_name'];
    this._diagnosisResponse = obj['diagnosis_response'];
  }

  String get plantName => _plantName;
  String get imageUrl => _imageUrl;
  String get diseaseName => _diseaseName;
  String get diagnosisResponse => _diagnosisResponse;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = _plantName;
    map["url"] = _imageUrl;
    map["disease_name"] = _diseaseName;
    map["diagnosis_response"] = _diagnosisResponse;

    return map;
  }
}
