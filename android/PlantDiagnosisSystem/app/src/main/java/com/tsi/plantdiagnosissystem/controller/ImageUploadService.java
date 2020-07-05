package com.tsi.plantdiagnosissystem.controller;

import android.util.Log;

import com.tsi.plantdiagnosissystem.data.model.User;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.UnknownHostException;

import okhttp3.MediaType;
import okhttp3.MultipartBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

import static androidx.constraintlayout.widget.Constraints.TAG;

public class ImageUploadService {

    public static String uploadImage(User user, File file, String imageFileName, String imageSize,
                                     String imageSizeUnit, String imageTypeString, String cropName) {
        try {
            String API_URL = ApiNameController.getImageUploadApi().getApiUrl();
            final MediaType MEDIA_TYPE_JPEG = MediaType.parse("image/jpeg");

            RequestBody req = new MultipartBody.Builder().setType(MultipartBody.FORM)
                    .addFormDataPart("CROP_NAME", cropName)
                    .addFormDataPart("SIZE", imageSize)
                    .addFormDataPart("SIZE_UNIT", imageSizeUnit)
                    .addFormDataPart("FORMAT", imageTypeString)
                    .addFormDataPart("IMAGE", imageFileName, RequestBody.create(MEDIA_TYPE_JPEG, file)).build();

            Request request = new Request.Builder()
                    .url(API_URL)
                    .post(req)
                    .build();

            OkHttpClient client = new OkHttpClient();
            Response response = client.newCall(request).execute();

//            Log.d("response", "uploadImage:" + response.body().string());
//            "Image upload successful!"
            return response.body().string();

            /*test responses*/
            //Maize: CLASSES={'CommonRust':0, 'Gray Leaf Spot':1, 'Northern Leaf Blight':2, 'Healthy':3}
            //Tomato: CLASSES={'Early Blight':0, 'Late Blight':1, 'Leaf Curl':2, 'Leaf Mold':3, 'Healthy':4}
            //Potato: CLASSES = [b'EarlyBlight', b'LateBlight', b'Healthy']
//            return "92.07_98.07_94.07_94.07";//Maize
//            return "92.07_98.07_00.07_94.07_.8";//Tomato
//            return "92.07_98.07_94.07";//potato

        } catch (UnknownHostException | UnsupportedEncodingException e) {
            Log.e(TAG, "Error: " + e.getLocalizedMessage());
        } catch (Exception e) {
            Log.e(TAG, "Other Error: " + e.getLocalizedMessage());
        }
        return null;
    }
}
