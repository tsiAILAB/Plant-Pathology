package com.tsi.plantdiagnosissystem.controller.database.databasecontroller;

import android.content.ContentValues;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

import com.tsi.plantdiagnosissystem.controller.database.DatabaseHelper;
import com.tsi.plantdiagnosissystem.data.model.PlantImage;

import java.util.ArrayList;

public class PlantImageCtr {

    public static final String PLANT_IMAGE_TABLE_NAME = "plant_image";

    //plantImage
    String nameColumn = "name";
    String urlColumn = "url";


    private static SQLiteDatabase getDB() {
        return DatabaseHelper.instance().getWritableDatabase();
    }

    //add the new PlantImage
    public void addPlantImage(String name, String url) {
        PlantImage plantImage = getPlantImage(name);
        if (plantImage == null) {
            SQLiteDatabase sqLiteDatabase = getDB();
            ContentValues values = new ContentValues();
            values.put(this.nameColumn, name);
            values.put(this.urlColumn, url);

            //inserting new row
            sqLiteDatabase.insert(PLANT_IMAGE_TABLE_NAME, null, values);
            //close database connection
            sqLiteDatabase.close();
        } else {
            updatePlantImage(plantImage.getPlantName(), url);
        }
    }

    //delete the PlantImage
    public void delete(String ID) {
        SQLiteDatabase sqLiteDatabase = getDB();
        //deleting row
        sqLiteDatabase.delete(PLANT_IMAGE_TABLE_NAME, "ID=" + ID, null);
        sqLiteDatabase.close();
    }

    public PlantImage getPlantImage(String plantName) {
        PlantImage plantImage = null;

        // select all query
        String select_query = "SELECT * FROM " + PLANT_IMAGE_TABLE_NAME + " WHERE " + nameColumn + " = '" + plantName + "'";

        SQLiteDatabase db = getDB();
        Cursor cursor = db.rawQuery(select_query, null);

        // looping through all rows and adding to list
        if (cursor.moveToFirst()) {
            String name = cursor.getString(1);
            String url = cursor.getString(2);
            plantImage = new PlantImage(name, url);
        }
        cursor.close();
        db.close();
        return plantImage;
    }

    public PlantImage updatePlantImage(String name, String url) {

        SQLiteDatabase sqLiteDatabase = getDB();
        ContentValues values = new ContentValues();
        values.put(this.nameColumn, name);
        values.put(this.urlColumn, url);
        //updating row
        sqLiteDatabase.update(PLANT_IMAGE_TABLE_NAME, values, this.nameColumn + "='" + name + "'", null);
        sqLiteDatabase.close();

        return getPlantImage(name);
    }

    //get the all users
    public ArrayList<PlantImage> getPlantImages() {
        ArrayList<PlantImage> arrayList = new ArrayList<>();

        // select all query
        String select_query = "SELECT * FROM " + PLANT_IMAGE_TABLE_NAME;

        SQLiteDatabase db = getDB();
        Cursor cursor = db.rawQuery(select_query, null);

        // looping through all rows and adding to list
        if (cursor.moveToFirst()) {
            do {
                String name = cursor.getString(1);
                String url = cursor.getString(2);
                PlantImage user = new PlantImage(name, url);
                arrayList.add(user);
            } while (cursor.moveToNext());
        }

        cursor.close();
        db.close();
        return arrayList;
    }
}
