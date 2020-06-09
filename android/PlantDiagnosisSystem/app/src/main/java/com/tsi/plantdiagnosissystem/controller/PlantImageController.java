package com.tsi.plantdiagnosissystem.controller;

import android.graphics.Bitmap;
import android.os.Environment;

import com.tsi.plantdiagnosissystem.controller.database.databasecontroller.PlantImageCtr;
import com.tsi.plantdiagnosissystem.data.model.PlantImage;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

public class PlantImageController {

    public static void saveImageToDatabase(PlantImage plantImage) {
        try {
            PlantImageCtr plantImageCtr = new PlantImageCtr();
            plantImageCtr.addPlantImage(plantImage.getPlantName(), plantImage.getImageUrl());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static File saveImageExternalStorage(Bitmap bmp, String cropName) throws IOException {
        String imageName = String.valueOf(System.currentTimeMillis());
        ByteArrayOutputStream bytes = new ByteArrayOutputStream();
        bmp.compress(Bitmap.CompressFormat.JPEG, 60, bytes);
        String filePath = Environment.getExternalStorageDirectory()
                + File.separator + cropName;
        boolean isFileExist = Utils.createDirectoryIfNotExist(filePath);
        File f = new File(filePath + File.separator + imageName + ".jpg");
        f.createNewFile();
        FileOutputStream fo = new FileOutputStream(f);
        fo.write(bytes.toByteArray());
        fo.close();
        return f;
    }
}
