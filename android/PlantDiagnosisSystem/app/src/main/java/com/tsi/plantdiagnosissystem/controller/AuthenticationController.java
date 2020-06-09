package com.tsi.plantdiagnosissystem.controller;

import android.content.Context;
import android.content.SharedPreferences;

import com.tsi.plantdiagnosissystem.controller.database.databasecontroller.LoginCtr;
import com.tsi.plantdiagnosissystem.data.model.User;

public class AuthenticationController {

    public static void logout(Context context) {
        SharedPreferences sharedPref = context.getSharedPreferences(AppData.PDS_SHARED_PREFERENCE, Context.MODE_PRIVATE);
        sharedPref.edit().clear().commit();
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

    //check authentication info
    public static User logInUser(String userEmail, String password) {
        LoginCtr loginCtr = new LoginCtr();
        User user = loginCtr.getLogin(userEmail, password);
        return user;
    }

    //match otp
    public static User isValidOtp(User user) {
        LoginCtr loginCtr = new LoginCtr();
        user = loginCtr.isValidOTP(user.getUsername(), user.getOtp());
        return user;
    }

    //updateUserOtp and send otp email
    public static boolean recoverPassword(String userEmail) {
        LoginCtr loginCtr = new LoginCtr();
        User user = loginCtr.getUser(userEmail);
        if (user != null) {
            if (user.getOtp() == null) {
                String generateOTP = Utils.generateOtp();
                user = loginCtr.updateUserOtp(userEmail, generateOTP);
            }
            Utils.sendMail(user.getUsername(), user.getOtp());
            return true;
        } else {
            return false;
        }
    }

    //reset password
    public static boolean resetPassword(User user) {
        LoginCtr loginCtr = new LoginCtr();
        user = loginCtr.changePassword(user.getUsername(), user.getPassword());
        if (user != null)
            return true;
        else
            return false;
    }

    //signUp
    public static String signUpUser(String userEmail, String password){
        LoginCtr loginCtr = new LoginCtr();
        String generateOTP = Utils.generateOtp();
        String dbOperationStatus = loginCtr.addUser(userEmail, password, "false", generateOTP, AppData.USER_ROLE);
        Utils.sendMail(userEmail, generateOTP);
        return dbOperationStatus;
    }
}
