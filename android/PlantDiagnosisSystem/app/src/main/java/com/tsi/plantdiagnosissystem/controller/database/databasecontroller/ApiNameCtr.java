package com.tsi.plantdiagnosissystem.controller.database.databasecontroller;

import android.content.ContentValues;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

import com.tsi.plantdiagnosissystem.controller.database.DatabaseHelper;
import com.tsi.plantdiagnosissystem.data.model.ApiName;

import java.util.ArrayList;

public class ApiNameCtr {
    public static final String API_TABLE_NAME = "api_name";

    //apiName
    String nameColumn = "name";
    String urlColumn = "url";


    private static SQLiteDatabase getDB() {
        return DatabaseHelper.instance().getWritableDatabase();
    }

    //add the new ApiName
    public void addApiName(String name, String url) {
        ApiName apiName = getApiName(name);
        if (apiName == null) {
            SQLiteDatabase sqLiteDatabase = getDB();
            ContentValues values = new ContentValues();
            values.put(this.nameColumn, name);
            values.put(this.urlColumn, url);

            //inserting new row
            sqLiteDatabase.insert(API_TABLE_NAME, null, values);
            //close database connection
            sqLiteDatabase.close();
        } else {
            updateApiName(apiName.getApiName(), url);
        }
    }

    //delete the ApiName
    public void delete(String ID) {
        SQLiteDatabase sqLiteDatabase = getDB();
        //deleting row
        sqLiteDatabase.delete(API_TABLE_NAME, "ID=" + ID, null);
        sqLiteDatabase.close();
    }

    public ApiName getApiName(String name) {
        ApiName apiName = null;

        // select all query
        String select_query = "SELECT * FROM " + API_TABLE_NAME + " WHERE " + nameColumn + " = '" + name + "'";

        SQLiteDatabase db = getDB();
        Cursor cursor = db.rawQuery(select_query, null);

        // looping through all rows and adding to list
        if (cursor.moveToFirst()) {
            String nameDb = cursor.getString(1);
            String url = cursor.getString(2);
            apiName = new ApiName(nameDb, url);
        }
        cursor.close();
        db.close();
        return apiName;
    }

    public ApiName updateApiName(String name, String url) {

        SQLiteDatabase sqLiteDatabase = getDB();
        ContentValues values = new ContentValues();
        values.put(this.nameColumn, name);
        values.put(this.urlColumn, url);
        //updating row
        sqLiteDatabase.update(API_TABLE_NAME, values, this.nameColumn + "='" + name + "'", null);
        sqLiteDatabase.close();

        return getApiName(name);
    }

    //get the all users
    public ArrayList<ApiName> getApiNames() {
        ArrayList<ApiName> arrayList = new ArrayList<>();

        // select all query
        String select_query = "SELECT * FROM " + API_TABLE_NAME;

        SQLiteDatabase db = getDB();
        Cursor cursor = db.rawQuery(select_query, null);

        // looping through all rows and adding to list
        if (cursor.moveToFirst()) {
            do {
                String name = cursor.getString(1);
                String url = cursor.getString(2);
                ApiName user = new ApiName(name, url);
                arrayList.add(user);
            } while (cursor.moveToNext());
        }
        cursor.close();
        db.close();
        return arrayList;
    }
}
