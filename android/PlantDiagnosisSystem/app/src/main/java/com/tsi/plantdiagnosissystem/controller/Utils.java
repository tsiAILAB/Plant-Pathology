package com.tsi.plantdiagnosissystem.controller;


import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import androidx.appcompat.app.AlertDialog;

import com.tsi.plantdiagnosissystem.R;
import com.tsi.plantdiagnosissystem.controller.email.EmailSender;
import com.tsi.plantdiagnosissystem.data.model.User;
import com.tsi.plantdiagnosissystem.ui.landingpage.LandingPageActivity;

import java.io.File;
import java.net.InetAddress;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.Map;

public class Utils {

    public static boolean createDirectoryIfNotExist(String filePath) {
        File folder = new File(filePath);
        boolean success = true;
        if (!folder.exists()) {
            success = folder.mkdirs();
        }
        if (success) {
            // Do something on success
        } else {
            // Do something else on failure
        }
        return success;
    }

    public static void sendMail(final String userEmail, final String otp) {

        Thread thread = new Thread(new Runnable() {

            @Override
            public void run() {
                try {
                    EmailSender.sendEmail(userEmail, AppData.EMAIL_SUBJECT, otp);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        });

        thread.start();
    }

    public static String generateOtp() {

        StringBuilder generatedToken = new StringBuilder();
        int size = 5;
        try {
            SecureRandom number = SecureRandom.getInstance("SHA1PRNG");
            // Generate 20 integers 0..20
            for (int i = 0; i < size; i++) {
                generatedToken.append(number.nextInt(9));
            }
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        return generatedToken.toString();
    }
    public static boolean isNetworkConnected(Context context) {
        ConnectivityManager cm = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);

        return cm.getActiveNetworkInfo() != null && cm.getActiveNetworkInfo().isConnected();
    }
    public static boolean isInternetAvailable() {
        try {
            InetAddress ipAddr = InetAddress.getByName("www.google.com");
            //You can replace it with your name
            return !ipAddr.equals("");

        } catch (Exception e) {
            return false;
        }
    }

    //This method would confirm the otp
    public static void isValidOtpDialog(final Context context, final User user) {
        Button buttonConfirm;
        final EditText editTextConfirmOtp;
        //Creating a LayoutInflater object for the dialog box
        LayoutInflater li = LayoutInflater.from(context);
        //Creating a view to get the dialog box
        View confirmDialog = li.inflate(R.layout.dialog_verify_otp, null);

        //Initializing confirm button fo dialog box and editText of dialog box
        buttonConfirm = (Button) confirmDialog.findViewById(R.id.buttonConfirm);
        editTextConfirmOtp = (EditText) confirmDialog.findViewById(R.id.editTextOtp);

        //Creating an alertDialog builder
        AlertDialog.Builder alert = new AlertDialog.Builder(context);

        //Adding our dialog box to the view of alert dialog
        alert.setView(confirmDialog);

        //Creating an alert dialog
        final AlertDialog alertDialog = alert.create();

        //Displaying the alert dialog
        alertDialog.show();

        //On the click of the confirm button from alert dialog
        buttonConfirm.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //Hiding the alert dialog
                alertDialog.dismiss();

                //Displaying a progressbar
                final ProgressDialog loading = ProgressDialog.show(context, "Authenticating",
                        "Please wait while we check the entered code", false,false);

                //Getting the user entered otp from editText
                final String otp = editTextConfirmOtp.getText().toString().trim();
                user.setOtp(otp);
                //Creating an string request
                User userOtpMatched = AuthenticationController.isValidOtp(user);

                if(userOtpMatched != null){
                    loading.dismiss();
                    Toast.makeText(context, "Otp Matched!", Toast.LENGTH_LONG).show();
                    AuthenticationController.saveLogInInfo(context, userOtpMatched);
                    goToHome(context);
                }else {
                    loading.dismiss();
                    isValidOtpDialog(context, user);
                }


            }
        });
    }

    public static void goToHome(Context context){
        Intent home = new Intent();
        home.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        home.setClass(context, LandingPageActivity.class);
        context.startActivity(home);
    }


}
