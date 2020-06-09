package com.tsi.plantdiagnosissystem.controller;

import android.content.Context;
import android.content.SharedPreferences;

import com.tsi.plantdiagnosissystem.R;
import com.tsi.plantdiagnosissystem.data.model.User;

public class Utils {
    public final static String PDS_SHARED_PREFERENCE = "pdsSharedPreference";

    public void logout(Context context) {
        SharedPreferences sharedPref = context.getSharedPreferences(PDS_SHARED_PREFERENCE, Context.MODE_PRIVATE);
        boolean loginInfo = sharedPref.getBoolean("login_info", false);
    }

    public void logIn(Context context, User user) {
        SharedPreferences sharedPref = context.getSharedPreferences(PDS_SHARED_PREFERENCE, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPref.edit();
        editor.putBoolean("login_info", true);
        editor.putString("userEmail", user.getUsername());
        editor.putString("isVerified", user.getIsVerified());
        editor.commit();
    }
}
