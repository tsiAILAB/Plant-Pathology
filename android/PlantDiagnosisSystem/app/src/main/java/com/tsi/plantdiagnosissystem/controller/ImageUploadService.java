package com.tsi.plantdiagnosissystem.controller;

import android.util.Log;

import com.tsi.plantdiagnosissystem.data.model.User;

import org.json.JSONObject;

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

    public static JSONObject uploadImage(User user, File file, String imageFileName) {
//        "image": base64Image,
//        "image_name": fileName,
//        "plant_name": plantName,
//        "platform": platformName,
//        "image_type": imageType,
//        "image_size": imageSize,
//        Utils.showLongToast("Image upload successful!");
//        Utils.showLongToast("Image upload failed!");
//        Utils.showLongToast("$imageType type image is not supported!");
        try {
            String API_URL = ApiNameController.getImageUploadApi().getApiUrl();
            final MediaType MEDIA_TYPE_PNG = MediaType.parse("image/png");

            RequestBody req = new MultipartBody.Builder().setType(MultipartBody.FORM).addFormDataPart("user_name", user.getUsername())
                    .addFormDataPart("image_name",imageFileName, RequestBody.create(MEDIA_TYPE_PNG, file)).build();

            Request request = new Request.Builder()
                    .url(API_URL)
                    .post(req)
                    .build();

            OkHttpClient client = new OkHttpClient();
            Response response = client.newCall(request).execute();

            Log.d("response", "uploadImage:"+response.body().string());
//            "Image upload successful!"
            return new JSONObject(response.body().string());

        } catch (UnknownHostException | UnsupportedEncodingException e) {
            Log.e(TAG, "Error: " + e.getLocalizedMessage());
        } catch (Exception e) {
            Log.e(TAG, "Other Error: " + e.getLocalizedMessage());
        }
        return null;
    }
}
