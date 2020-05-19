import 'package:pds/models/ApiUrl.dart';
import 'package:pds/services/request/api_url_request.dart';

abstract class ApiUrlCallBack {
  void onApiUrlSuccess(ApiUrl apiUrl);
  void onApiUrlError(String error);
}

class ApiUrlResponse {
  ApiUrlCallBack _callBack;
  ApiUrlRequest apiUrlRequest = new ApiUrlRequest();
  ApiUrlResponse(this._callBack);

  saveNewApiUrl(String apiName, String url) {
    apiUrlRequest
        .saveNewApiUrl(apiName, url)
        .then((apiUrl) => _callBack.onApiUrlSuccess(apiUrl))
        .catchError((onError) => _callBack.onApiUrlError(onError.toString()));
  }

  uploadApiUrl(String apiName, String url) {
    apiUrlRequest
        .uploadApiUrl(apiName, url)
        .then((apiUrl) => _callBack.onApiUrlSuccess(apiUrl))
        .catchError((onError) => _callBack.onApiUrlError(onError.toString()));
  }

  getApi(String apiName) {
    apiUrlRequest
        .getApiUrl(apiName)
        .then((apiUrl) => _callBack.onApiUrlSuccess(apiUrl))
        .catchError((onError) => _callBack.onApiUrlError(onError.toString()));
  }
}
