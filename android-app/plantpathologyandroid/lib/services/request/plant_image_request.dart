import 'package:pds/data/CtrQuery/plant_image_ctr.dart';
import 'package:pds/models/PlantImage.dart';

class PlantImageRequest {
  PlantImageCtr con = new PlantImageCtr();

  Future<PlantImage> getPlantImage(String apiName) async {
    var result = await con.getPlantImage(apiName);
    return result;
  }

  Future<PlantImage> saveNewPlantImage(String plantName, String url) async {
    var result = await con.saveNewPlantImage(plantName, url);
    return result;
  }

  Future<PlantImage> uploadPlantImage(String plantName, String url) async {
    var result = await con.updatePlantImage(plantName, url);
    return result;
  }

  Future<List<PlantImage>> getAllPlantImages() async {
    var result = await con.getAllPlantImages();
    return result;
  }
}
