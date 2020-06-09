package com.tsi.plantdiagnosissystem.controller;


import com.tsi.plantdiagnosissystem.controller.email.EmailSender;

import java.io.File;
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

    public static boolean isInternetAvailable() {
        try {
            InetAddress ipAddr = InetAddress.getByName("google.com");
            //You can replace it with your name
            return !ipAddr.equals("");

        } catch (Exception e) {
            return false;
        }
    }

}
