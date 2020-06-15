package com.tsi.plantdiagnosissystem.controller;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;

import com.tsi.plantdiagnosissystem.controller.database.databasecontroller.UserTableCtr;
import com.tsi.plantdiagnosissystem.data.AppData;
import com.tsi.plantdiagnosissystem.data.model.User;
import com.tsi.plantdiagnosissystem.ui.login.LoginActivity;

public class UserController {

    public static void logout(Context context) {
        SharedPreferences sharedPref = context.getSharedPreferences(AppData.PDS_SHARED_PREFERENCE, Context.MODE_PRIVATE);
        sharedPref.edit().clear().commit();

        Intent loginActivity = new Intent();
        loginActivity.setClass(context, LoginActivity.class);
        loginActivity.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK |Intent.FLAG_ACTIVITY_CLEAR_TOP);

        context.startActivity(loginActivity);
    }

    public static void saveLogInInfo(Context context, User user) {
        SharedPreferences sharedPref = context.getSharedPreferences(AppData.PDS_SHARED_PREFERENCE, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPref.edit();
        editor.putBoolean(AppData.LOGIN_INFO_SHARED_PREFERENCE, true);
        editor.putString(AppData.USER_EMAIL_SHARED_PREFERENCE, user.getUsername());
        editor.putBoolean(AppData.IS_VERIFIED_SHARED_PREFERENCE, true);
        editor.putString(AppData.ROLE_SHARED_PREFERENCE, user.getRole());
        editor.commit();
    }

    public static User getLoginInfo(Context context){
        User user = new User();
        SharedPreferences sharedPref = context.getSharedPreferences(AppData.PDS_SHARED_PREFERENCE, Context.MODE_PRIVATE);
        user.setLoggedIn(sharedPref.getBoolean(AppData.LOGIN_INFO_SHARED_PREFERENCE, false));
        user.setUsername(sharedPref.getString(AppData.USER_EMAIL_SHARED_PREFERENCE, null));
        user.setIsVerified(String.valueOf(sharedPref.getBoolean(AppData.IS_VERIFIED_SHARED_PREFERENCE, false)));
        user.setRole(sharedPref.getString(AppData.ROLE_SHARED_PREFERENCE, null));

        return user;
    }

    //check authentication info
    public static User logInUser(String userEmail, String password) {
        UserTableCtr userTableCtr = new UserTableCtr();
        User user = userTableCtr.getLogin(userEmail, password);
        return user;
    }

    //match otp
    public static User isValidOtp(User user) {
        UserTableCtr userTableCtr = new UserTableCtr();
        user = userTableCtr.isValidOTP(user.getUsername(), user.getOtp());
        return user;
    }

    //updateUserOtp and send otp email
    public static boolean verifyEmailOtpSend(String userEmail) {
        UserTableCtr userTableCtr = new UserTableCtr();
        User user = userTableCtr.getUser(userEmail);
        if (user != null) {
            if ("".equalsIgnoreCase(user.getOtp())) {
                String generateOTP = Utils.generateOtp();
                user = userTableCtr.updateUserOtp(userEmail, generateOTP);
            }
            Utils.sendMail(user.getUsername(), user.getOtp());
            return true;
        } else {
            return false;
        }
    }

    //reset password
    public static boolean resetPassword(User user) {
        UserTableCtr userTableCtr = new UserTableCtr();
        user = userTableCtr.changePassword(user.getUsername(), user.getPassword());
        if (user != null)
            return true;
        else
            return false;
    }

    //signUp
    public static String signUpUser(String userEmail, String password){
        UserTableCtr userTableCtr = new UserTableCtr();
        String generateOTP = Utils.generateOtp();
        String dbOperationStatus = userTableCtr.addUser(userEmail, password, "false", generateOTP, AppData.USER_ROLE);
        if(AppData.SIGN_UP_SUCCESSFUL.equalsIgnoreCase(dbOperationStatus)) {
            Utils.sendMail(userEmail, generateOTP);
        }
        return dbOperationStatus;
    }
}
