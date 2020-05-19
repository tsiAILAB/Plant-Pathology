import 'package:pds/data/CtrQuery/api_url_ctr.dart';
import 'package:pds/models/ApiUrl.dart';

class ApiUrlRequest {
  ApiUrlCtr con = new ApiUrlCtr();

  Future<ApiUrl> getApiUrl(String apiName) async {
    var result = await con.getApiUrl(apiName);
    return result;
  }

  Future<ApiUrl> saveNewApiUrl(String apiName, String url) async {
    var result = await con.saveNewApiUrl(apiName, url);
    return result;
  }

  Future<ApiUrl> uploadApiUrl(String apiName, String url) async {
    var result = await con.updateApiUrl(apiName, url);
    return result;
  }
}
