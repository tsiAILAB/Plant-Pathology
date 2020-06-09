package com.tsi.plantdiagnosissystem.controller.database;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import com.tsi.plantdiagnosissystem.controller.AppData;
import com.tsi.plantdiagnosissystem.ui.login.LoginActivity;

public class DatabaseHelper extends SQLiteOpenHelper {

    //database name
    public static final String DATABASE_NAME = "pds";
    //database version
    public static final int DATABASE_VERSION = 1;
    public static final String LOGIN_TABLE_NAME = "user";
    public static final String PLANT_IMAGE_TABLE_NAME = "plant_image";
    public static final String API_TABLE_NAME = "api_name";

    //loginTable column title
    String userNameColumn = "user_name";
    String passwordColumn = "password";
    String otpColumn = "otp";
    String isVerifiedColumn = "is_verified";
    String roleColumn = "role";

    //plantImage and ApiName
    String nameColumn = "name";
    String urlColumn = "url";

    public static DatabaseHelper instance() {
        return InstanceHolder.INSTANCE;
    }

    public DatabaseHelper(Context context) {
        super(context, DATABASE_NAME, null, DATABASE_VERSION);
    }

    // lazy-loaded singleton (Initialization on Demand Holder)
    private static class InstanceHolder {
        static final DatabaseHelper INSTANCE = new DatabaseHelper(LoginActivity.instance());
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        //creating LOGIN_TABLE
        String query = "CREATE TABLE " + LOGIN_TABLE_NAME + "(ID INTEGER PRIMARY KEY, " + userNameColumn + " TEXT unique, " + passwordColumn + " TEXT,"
                + isVerifiedColumn + " TEXT, " + otpColumn + " TEXT, " + roleColumn + " TEXT)";
        db.execSQL(query);

        //creating table
        String query2 = "CREATE TABLE " + PLANT_IMAGE_TABLE_NAME + "(ID INTEGER PRIMARY KEY, " + nameColumn + " TEXT unique, " + urlColumn + " TEXT)";
        db.execSQL(query2);

        //creating table
        String query3 = "CREATE TABLE " + API_TABLE_NAME + "(ID INTEGER PRIMARY KEY, " + nameColumn + " TEXT unique, " + urlColumn + " TEXT)";
        db.execSQL(query3);

        addDefaultCrops(db);
    }

    private void addDefaultCrops(SQLiteDatabase db) {
        //default api
        db.execSQL("insert into " + API_TABLE_NAME
                + " (ID, " + nameColumn + " , " + urlColumn + ")" + "values(1,'"+AppData.UPLOAD_IMAGE+"','http://testurl.com') ;");

        //PlantImage default data
        db.execSQL("insert into " + PLANT_IMAGE_TABLE_NAME
                + " (ID, " + nameColumn + " , " + urlColumn + ")" + "values(1,'Potato','potato.jpg') ;");
        db.execSQL("insert into " + PLANT_IMAGE_TABLE_NAME
                + " (ID, " + nameColumn + " , " + urlColumn + ")" + "values(2,'Tomato','tomato.jpg') ;");
        db.execSQL("insert into " + PLANT_IMAGE_TABLE_NAME
                + " (ID, " + nameColumn + " , " + urlColumn + ")" + "values(3,'Maize','maze.jpg') ;");

        //admin login
        db.execSQL("insert into " + LOGIN_TABLE_NAME
                + " (ID, " + userNameColumn + " , " + passwordColumn
                +" , " + isVerifiedColumn +" , " + otpColumn +" , " + roleColumn + ")"
                + "values(1,'ADMIN','123456','true','otp', '"+ AppData.ADMIN_ROLE +"') ;");

        db.execSQL("insert into " + LOGIN_TABLE_NAME
                + " (ID, " + userNameColumn + " , " + passwordColumn
                +" , " + isVerifiedColumn +" , " + otpColumn +" , " + roleColumn + ")"
                + "values(2,'adm','123456','true','otp', '"+ AppData.ADMIN_ROLE +"') ;");

        db.execSQL("insert into " + LOGIN_TABLE_NAME
                + " (ID, " + userNameColumn + " , " + passwordColumn
                +" , " + isVerifiedColumn +" , " + otpColumn +" , " + roleColumn + ")"
                + "values(3,'user','123456','true','otp', '"+ AppData.USER_ROLE +"') ;");

    }

    //upgrading database
    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("DROP TABLE IF EXISTS " + LOGIN_TABLE_NAME);
        onCreate(db);
        db.execSQL("DROP TABLE IF EXISTS " + PLANT_IMAGE_TABLE_NAME);
        onCreate(db);
        db.execSQL("DROP TABLE IF EXISTS " + API_TABLE_NAME);
        onCreate(db);
    }
}
