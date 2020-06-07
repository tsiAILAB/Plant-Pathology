package com.tsi.plantdiagnosissystem.controller;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
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
    String userName = "user_name";
    String password = "password";
    String otp = "otp";
    String isVerified = "is_verified";
    String role = "role";

    //plantImage
    String name = "name";
    String url = "url";

    static DatabaseHelper instance() {
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
        String query = "CREATE TABLE " + LOGIN_TABLE_NAME + "(ID INTEGER PRIMARY KEY, " + userName + " TEXT unique, " + password + " TEXT," +
                " " + isVerified + " TEXT, " + otp + " TEXT, " + role + " TEXT)";
        db.execSQL(query);

        //creating table
        String query2 = "CREATE TABLE " + PLANT_IMAGE_TABLE_NAME + "(ID INTEGER PRIMARY KEY, " + name + " TEXT, " + url + " TEXT)";
        db.execSQL(query2);

        //creating table
        String query3 = "CREATE TABLE " + API_TABLE_NAME + "(ID INTEGER PRIMARY KEY, " + name + " TEXT, " + url + " TEXT)";
        db.execSQL(query3);
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
