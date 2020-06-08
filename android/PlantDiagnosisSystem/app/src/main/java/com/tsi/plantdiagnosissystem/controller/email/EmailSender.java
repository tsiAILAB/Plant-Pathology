package com.tsi.plantdiagnosissystem.controller.email;

import android.util.Log;

public class EmailSender {
    final public static String SMTP_SERVER = "smtp.gmail.com";
    final public static String USER_EMAIL = "plant.diagnosis.system@gmail.com";
    final public static String EMAIL_PASSWORD = "lostmypassword";

    public static boolean sendEmail(String userEmail, String subject, String otp) {
        EmailService emailService = new EmailService(USER_EMAIL, userEmail, subject, otp, "<h1>"+otp+"</h1>");
        try {
            emailService.sendAuthenticated();
            return true;
        } catch (Exception e) {
            Log.e("SendEmail!", "Failed sending email.", e);
            return false;
        }
    }
}
