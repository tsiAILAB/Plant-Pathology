package com.tsi.plantdiagnosissystem.controller;


import android.content.Context;
import android.content.Intent;
import android.content.res.AssetManager;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.ConnectivityManager;
import android.net.Uri;
import android.os.Environment;
import android.provider.OpenableColumns;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import androidx.appcompat.app.AlertDialog;

import com.tsi.plantdiagnosissystem.R;
import com.tsi.plantdiagnosissystem.controller.email.EmailSender;
import com.tsi.plantdiagnosissystem.data.AppData;
import com.tsi.plantdiagnosissystem.data.model.User;
import com.tsi.plantdiagnosissystem.ui.landingpage.LandingPageActivity;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.InetAddress;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

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

    public static void copyAssetToSdCard(Context context, String filename) {
        AssetManager assetManager = context.getAssets();

        InputStream in = null;
        OutputStream out = null;
        try {
            in = assetManager.open(filename);
//            String newFileName = "/data/data/" + context.getPackageName() + "/" + filename;

            String filePath = Environment.getExternalStorageDirectory() + context.getPackageName();
            boolean isFileExist = Utils.createDirectoryIfNotExist(filePath);

            String newFileName = filePath + File.separator + filename;
            out = new FileOutputStream(newFileName);

            byte[] buffer = new byte[1024];
            int read;
            while ((read = in.read(buffer)) != -1) {
                out.write(buffer, 0, read);
            }
            in.close();
            in = null;
            out.flush();
            out.close();
            out = null;
        } catch (Exception e) {
            Log.e("tag", e.getMessage());
        }
    }


    public static void copyAssets(Context context) {
        AssetManager assetManager = context.getAssets();
        String[] files = null;
        try {
            files = assetManager.list("");
        } catch (IOException e) {
            Log.e("tag", "Failed to get asset file list.", e);
        }
        if (files != null) for (String filename : files) {
            InputStream in = null;
            OutputStream out = null;
            try {
                Log.d("FileName: ", "" + filename);
                if (!"pds.db".equalsIgnoreCase(filename)) {
                    in = assetManager.open(filename);
                    File outFile = new File("/data/data/" + context.getPackageName(), filename);
                    out = new FileOutputStream(outFile);
                    copyFile(in, out);
                }
            } catch (IOException e) {
                Log.e("tag", "Failed to copy asset file: " + filename, e);
            } finally {
                if (in != null) {
                    try {
                        in.close();
                    } catch (IOException e) {
                        // NOOP
                    }
                }
                if (out != null) {
                    try {
                        out.close();
                    } catch (IOException e) {
                        // NOOP
                    }
                }
            }
        }
    }

    private static void copyFile(InputStream in, OutputStream out) throws IOException {
        byte[] buffer = new byte[1024];
        int read;
        while ((read = in.read(buffer)) != -1) {
            out.write(buffer, 0, read);
        }
    }

    //load image from directory
    public static Bitmap loadImageFileFromDirectory(String filePath) {
        File imgFile = new File(filePath);

        if (imgFile.exists()) {
            return BitmapFactory.decodeFile(imgFile.getAbsolutePath());
        }
        return null;
    }

    //getImageSize
    public static String calculateFileSize(String filepath) {
        File file = new File(filepath);
        // Get length of file in bytes
        long fileSizeInBytes = file.length();

        float fileSizeInKB = fileSizeInBytes / 1024;
        // Convert the KB to MegaBytes (1 MB = 1024 KBytes)
        float fileSizeInMB = fileSizeInKB / 1024;

        String calString = Float.toString(fileSizeInMB);
        return calString;
    }

    //getFileName from URI
    public static String getFileName(Context context, Uri uri) {
        String result = null;
        try {
            if (uri.getScheme() != null && uri.getScheme().equals("content")) {
                Cursor cursor = context.getContentResolver().query(uri, null, null, null, null);
                try {
                    if (cursor != null && cursor.moveToFirst()) {
                        result = cursor.getString(cursor.getColumnIndex(OpenableColumns.DISPLAY_NAME));
                    }
                } finally {
                    cursor.close();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (result == null) {
            result = uri.getPath();
            int cut = result.lastIndexOf('/');
            if (cut != -1) {
                result = result.substring(cut + 1);
            }
        }
        return result;
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
        Button buttonResendOtp;
        final EditText editTextConfirmOtp;
        //Creating a LayoutInflater object for the dialog box
        LayoutInflater li = LayoutInflater.from(context);
        //Creating a view to get the dialog box
        View confirmDialog = li.inflate(R.layout.dialog_verify_otp, null);

        //Initializing confirm button fo dialog box and editText of dialog box
        buttonConfirm = (Button) confirmDialog.findViewById(R.id.buttonConfirm);
        buttonResendOtp = (Button) confirmDialog.findViewById(R.id.buttonResendOtp);
        editTextConfirmOtp = (EditText) confirmDialog.findViewById(R.id.editTextOtp);

        //Creating an alertDialog builder
        AlertDialog.Builder alert = new AlertDialog.Builder(context);

        //Adding our dialog box to the view of alert dialog
        alert.setView(confirmDialog);

        //adding title
        alert.setTitle("OTP Verification!");

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
//                final ProgressDialog loading = ProgressDialog.show(context, "Authenticating",
//                        "Please wait while we check the entered code", false, false);

                //Getting the user entered otp from editText
                final String otp = editTextConfirmOtp.getText().toString().trim();
                user.setOtp(otp);
                //Creating an string request
                User userOtpMatched = UserController.isValidOtp(user);

                if (userOtpMatched != null) {
//                    loading.dismiss();
                    Toast.makeText(context, "Otp Matched!", Toast.LENGTH_LONG).show();
                    UserController.saveLogInInfo(context, userOtpMatched);
                    goToHome(context);

                } else {
//                    loading.dismiss();
                    isValidOtpDialog(context, user);
                }
            }
        });
        buttonResendOtp.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                UserController.verifyEmailOtpSend(user.getUsername());
            }
        });
    }

    public static void goToHome(Context context) {
        Intent home = new Intent();
        home.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
        home.setClass(context, LandingPageActivity.class);
        context.startActivity(home);
    }

    public static String saveFromDrawable(Context context, int imageDrawable, String imageName) {
        try {
            File root = new File(Environment.getExternalStorageDirectory() + File.separator + context.getPackageName(), "IMAGES");


            if (!root.exists()) {
                root.mkdirs();
            }

            final Bitmap bitmap = BitmapFactory.decodeResource(context.getResources(), imageDrawable);
//            int height = (bitmap.getHeight() * 512 / bitmap.getWidth());
//            Bitmap scale = Bitmap.createScaledBitmap(bitmap, 512, height, true);
            String imageFilePath = root + File.separator + imageName;

            File file = new File(imageFilePath);
            Log.e("Path", "" + file);
            file.createNewFile();

            FileOutputStream fos = new FileOutputStream(file);
            bitmap.compress(Bitmap.CompressFormat.JPEG, 100, fos);
            fos.flush();
            fos.close();
            return imageFilePath;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


}
