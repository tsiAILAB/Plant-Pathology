import 'package:flutterapp/data/CtrQuery/plant_image_ctr.dart';
import 'package:flutterapp/models/PlantImage.dart';

class PlantImageRequest {
  PlantImageCtr con = new PlantImageCtr();

  Future<PlantImage> getPlantImage(String apiName) async {
    var result = await con.getPlantImage(apiName);
    return result;
  }

  Future<PlantImage> uploadPlantImage(String plantName, String url) async {
    var result = await con.updatePlantImage(plantName, url);
    return result;
  }

  Future<List<PlantImage>> getAllPlantImage() async {
    var result = await con.getAllPlantImage();
    return result;
  }
}
