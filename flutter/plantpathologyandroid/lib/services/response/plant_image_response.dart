import 'package:pds/models/PlantImage.dart';
import 'package:pds/services/request/plant_image_request.dart';

abstract class PlantImageCallBack {
  void onPlantImageSuccess(PlantImage plantImage);
  void onPlantImagesSuccess(List<PlantImage> plantImage);
  void onPlantImageError(String error);
}

class PlantImageResponse {
  PlantImageCallBack _callBack;
  PlantImageRequest plantImageRequest = new PlantImageRequest();
  PlantImageResponse(this._callBack);

  saveNewPlantImage(String plantName, String url) {
    plantImageRequest
        .saveNewPlantImage(plantName, url)
        .then((plantImage) => _callBack.onPlantImageSuccess(plantImage))
        .catchError(
            (onError) => _callBack.onPlantImageError(onError.toString()));
  }

  uploadNewPlant(String plantName, String url) {
    plantImageRequest
        .uploadPlantImage(plantName, url)
        .then((plantImage) => _callBack.onPlantImageSuccess(plantImage))
        .catchError(
            (onError) => _callBack.onPlantImageError(onError.toString()));
  }

  getPlant(String plantName) {
    plantImageRequest
        .getPlantImage(plantName)
        .then((plantImage) => _callBack.onPlantImageSuccess(plantImage))
        .catchError(
            (onError) => _callBack.onPlantImageError(onError.toString()));
  }

  getAllPlants() {
    plantImageRequest
        .getAllPlantImages()
        .then((plantImages) => _callBack.onPlantImagesSuccess(plantImages))
        .catchError(
            (onError) => _callBack.onPlantImageError(onError.toString()));
  }
}
