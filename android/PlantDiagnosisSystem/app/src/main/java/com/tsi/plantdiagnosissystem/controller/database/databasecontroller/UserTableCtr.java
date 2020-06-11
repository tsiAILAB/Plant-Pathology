package com.tsi.plantdiagnosissystem.controller.database.databasecontroller;

import android.content.ContentValues;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

import com.tsi.plantdiagnosissystem.data.AppData;
import com.tsi.plantdiagnosissystem.controller.database.DatabaseHelper;
import com.tsi.plantdiagnosissystem.data.model.User;

import java.util.ArrayList;

public class UserTableCtr {

    public static final String LOGIN_TABLE_NAME = "user";

    //loginTable column title
    String userNameColumn = "user_name";
    String passwordColumn = "password";
    String otpColumn = "otp";
    String isVerifiedColumn = "is_verified";
    String roleColumn = "role";

    private static SQLiteDatabase getDB() {
        return DatabaseHelper.instance().getWritableDatabase();
    }

    //add the new User
    public String addUser(String userName, String password, String isVerified, String otp, String role) {
        User user = getUser(userName);
        if (user == null) {
            SQLiteDatabase sqLiteDatabase = getDB();
            ContentValues values = new ContentValues();
            values.put(this.userNameColumn, userName);
            values.put(this.passwordColumn, password);
            values.put(this.isVerifiedColumn, isVerified);
            values.put(this.otpColumn, otp);
            values.put(this.roleColumn, role);

            //inserting new row
            sqLiteDatabase.insert(LOGIN_TABLE_NAME, null, values);
            //close database connection
            sqLiteDatabase.close();
            return AppData.SIGN_UP_SUCCESSFUL;
        } else {
            return AppData.USER_ALREADY_EXIST;
        }
    }

    //get the all users
    public User getUser(String userName) {
        User user = null;
        // select query
        String select_query = "SELECT *FROM " + LOGIN_TABLE_NAME + " WHERE " + this.userNameColumn + " = '" + userName + "'";

        SQLiteDatabase db = getDB();
        Cursor cursor = db.rawQuery(select_query, null);

        // looping through all rows and adding to list
        if (cursor.moveToFirst()) {
//            do {
            String userNameDb = cursor.getString(1);
            String password = cursor.getString(2);
            String isVerified = cursor.getString(3);
            String otp = cursor.getString(4);
            String role = cursor.getString(5);
            user = new User(userNameDb, password, isVerified, otp, role);

//            } while (cursor.moveToNext());
        }
        db.close();
        return user;
    }

    //get the all users
    public ArrayList<User> getUsers() {
        ArrayList<User> arrayList = new ArrayList<>();

        // select all query
        String select_query = "SELECT *FROM " + LOGIN_TABLE_NAME;

        SQLiteDatabase db = getDB();
        Cursor cursor = db.rawQuery(select_query, null);

        // looping through all rows and adding to list
        if (cursor.moveToFirst()) {
            do {
                String userName = cursor.getString(1);
                String password = cursor.getString(2);
                String isVerified = cursor.getString(3);
                String otp = cursor.getString(4);
                String role = cursor.getString(5);
                User user = new User(userName, password, isVerified, otp, role);
                arrayList.add(user);
            } while (cursor.moveToNext());
        }
        db.close();
        return arrayList;
    }

    //delete the User
    public void delete(String ID) {
        SQLiteDatabase sqLiteDatabase = getDB();
        //deleting row
        sqLiteDatabase.delete(LOGIN_TABLE_NAME, "ID=" + ID, null);
        sqLiteDatabase.close();
    }

    //update the User
    public void updateUser(String userName, String password, String otp, String isVerified) {
        SQLiteDatabase sqLiteDatabase = getDB();
        ContentValues values = new ContentValues();
        values.put(this.userNameColumn, userName);
        values.put(this.passwordColumn, password);
        values.put(this.isVerifiedColumn, isVerified);
        values.put(this.otpColumn, otp);
        //updating row
        sqLiteDatabase.update(LOGIN_TABLE_NAME, values, this.userNameColumn + "=" + userName, null);
        sqLiteDatabase.close();
    }


    public User getLogin(String userName, String password) {
        User user = null;
        // select all query
        String select_query = "SELECT *FROM " + LOGIN_TABLE_NAME + " WHERE " + userNameColumn
                + " = '" + userName + "' AND " + passwordColumn + "= '" + password + "'";

        SQLiteDatabase db = getDB();
        Cursor cursor = db.rawQuery(select_query, null);

        if (cursor.moveToFirst()) {
            String userNameDb = cursor.getString(1);
            String passwordDb = cursor.getString(2);
            String isVerified = cursor.getString(3);
            String otp = cursor.getString(4);
            String role = cursor.getString(5);
            user = new User(userNameDb, passwordDb, isVerified, otp, role);
            user.setLoggedIn(true);
        }
        cursor.close();
        db.close();
        return user;
    }

    public User saveNewUserWithOTP(String userEmail, String password, String otp) {

        String isVerified = "false";
        String role = "USER";

        SQLiteDatabase sqLiteDatabase = getDB();
        ContentValues values = new ContentValues();
        values.put(this.userNameColumn, userEmail);
        values.put(this.passwordColumn, password);
        values.put(this.isVerifiedColumn, isVerified);
        values.put(this.otpColumn, otp);
        values.put(this.roleColumn, role);

        //inserting new row
        sqLiteDatabase.insert(LOGIN_TABLE_NAME, null, values);
        //close database connection
        sqLiteDatabase.close();
        User user = null;
        // select all query
        String select_query = "SELECT *FROM " + LOGIN_TABLE_NAME + " WHERE " + userNameColumn
                + " = '" + userEmail + "'";

        SQLiteDatabase db = getDB();
        Cursor cursor = db.rawQuery(select_query, null);

        if (cursor.moveToFirst()) {
            String userNameDb = cursor.getString(1);
            String passwordDb = cursor.getString(2);
            String isVerifiedDb = cursor.getString(3);
            String otpDb = cursor.getString(4);
            String roleDb = cursor.getString(5);
            user = new User(userNameDb, passwordDb, isVerifiedDb, otpDb, roleDb);
        }
        cursor.close();
        db.close();
        return user;
    }


    public User isValidOTP(String userEmail, String otp) {
        User user = null;
        // select all query
        String select_query = "SELECT *FROM " + LOGIN_TABLE_NAME + " WHERE " + userNameColumn
                + " = '" + userEmail + "' AND " + otpColumn + "='" + otp + "'";

        SQLiteDatabase db = getDB();
        Cursor cursor = db.rawQuery(select_query, null);

        if (cursor.moveToFirst()) {
            String userNameDb = cursor.getString(1);
            String passwordDb = cursor.getString(2);
            String isVerifiedDb = cursor.getString(3);
            String otpDb = cursor.getString(4);
            String roleDb = cursor.getString(5);
            user = new User(userNameDb, passwordDb, isVerifiedDb, otpDb, roleDb);
        }
        cursor.close();
        db.close();
        if (user != null) {
            SQLiteDatabase sqLiteDatabase = getDB();
            ContentValues values = new ContentValues();
            values.put(this.otpColumn, "");
            sqLiteDatabase.update(LOGIN_TABLE_NAME,
                    values,
                    this.userNameColumn + " = ?", new String[]{userEmail});

            sqLiteDatabase.close();


            String select_query2 = "SELECT *FROM " + LOGIN_TABLE_NAME + " WHERE " + userNameColumn
                    + " = '" + userEmail + "'";

            SQLiteDatabase db2 = getDB();
            Cursor cursor2 = db2.rawQuery(select_query2, null);

            if (cursor2.moveToFirst()) {
                String userNameDb = cursor2.getString(1);
                String passwordDb = cursor2.getString(2);
                String isVerifiedDb = cursor2.getString(3);
                String otpDb = cursor2.getString(4);
                String roleDb = cursor2.getString(5);
                user = new User(userNameDb, passwordDb, isVerifiedDb, otpDb, roleDb);
            }
            cursor2.close();
            db2.close();
        }
        return user;
    }

    public User changePassword(String userEmail, String password) {


        User user = null;
        // select all query
        String select_query = "SELECT *FROM " + LOGIN_TABLE_NAME + " WHERE " + userNameColumn
                + " = '" + userEmail + "'";

        SQLiteDatabase db = getDB();
        Cursor cursor = db.rawQuery(select_query, null);

        if (cursor.moveToFirst()) {
            String userNameDb = cursor.getString(1);
            String passwordDb = cursor.getString(2);
            String isVerifiedDb = cursor.getString(3);
            String otpDb = cursor.getString(4);
            String roleDb = cursor.getString(5);
            user = new User(userNameDb, passwordDb, isVerifiedDb, otpDb, roleDb);
        }
        cursor.close();
        db.close();
        if (user != null) {
            SQLiteDatabase sqLiteDatabase = getDB();
            ContentValues values = new ContentValues();
            values.put(this.passwordColumn, password);
            sqLiteDatabase.update(LOGIN_TABLE_NAME,
                    values,
                    this.userNameColumn + " = ?", new String[]{userEmail});

            sqLiteDatabase.close();
        }

        String select_query2 = "SELECT *FROM " + LOGIN_TABLE_NAME + " WHERE " + userNameColumn
                + " = '" + userEmail + "'";

        SQLiteDatabase db2 = getDB();
        Cursor cursor2 = db2.rawQuery(select_query2, null);

        if (cursor2.moveToFirst()) {
            String userNameDb = cursor2.getString(1);
            String passwordDb = cursor2.getString(2);
            String isVerifiedDb = cursor2.getString(3);
            String otpDb = cursor2.getString(4);
            String roleDb = cursor2.getString(5);
            user = new User(userNameDb, passwordDb, isVerifiedDb, otpDb, roleDb);
        }
        cursor2.close();
        db2.close();

        return user;
    }

    public User updateUserOtp(String userEmail, String otp) {
        User user = null;
        SQLiteDatabase sqLiteDatabase = getDB();
        ContentValues values = new ContentValues();
        values.put(this.otpColumn, otp);
        sqLiteDatabase.update(LOGIN_TABLE_NAME,
                values,
                this.userNameColumn + " = ?", new String[]{userEmail});

        sqLiteDatabase.close();

        String select_query2 = "SELECT *FROM " + LOGIN_TABLE_NAME + " WHERE " + userNameColumn
                + " = '" + userEmail + "'";

        SQLiteDatabase db2 = getDB();
        Cursor cursor2 = db2.rawQuery(select_query2, null);

        if (cursor2.moveToFirst()) {
            String userNameDb = cursor2.getString(1);
            String passwordDb = cursor2.getString(2);
            String isVerifiedDb = cursor2.getString(3);
            String otpDb = cursor2.getString(4);
            String roleDb = cursor2.getString(5);
            user = new User(userNameDb, passwordDb, isVerifiedDb, otpDb, roleDb);
        }
        cursor2.close();
        db2.close();

        return user;
    }
}
