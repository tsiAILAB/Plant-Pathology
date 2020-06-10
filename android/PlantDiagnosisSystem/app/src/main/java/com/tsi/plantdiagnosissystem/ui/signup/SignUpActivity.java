package com.tsi.plantdiagnosissystem.ui.signup;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.text.Html;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.tsi.plantdiagnosissystem.R;
import com.tsi.plantdiagnosissystem.controller.AppData;
import com.tsi.plantdiagnosissystem.controller.AuthenticationController;
import com.tsi.plantdiagnosissystem.controller.Utils;
import com.tsi.plantdiagnosissystem.data.model.User;
import com.tsi.plantdiagnosissystem.ui.landingpage.LandingPageActivity;

public class SignUpActivity extends AppCompatActivity {

    private EditText userEmailEditText, passwordEditText, confirmPasswordEditText;
    private Button submitButton;
    private static User user;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sign_up);

        //actonBar
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        getSupportActionBar().setTitle(Html.fromHtml("<font color='#6699CC'>Sign Up</font>"));

        userEmailEditText = findViewById(R.id.userEmailEditText);
        passwordEditText = findViewById(R.id.passwordEditText);
        confirmPasswordEditText = findViewById(R.id.confirmPasswordEditText);
        submitButton = findViewById(R.id.signUpSubmitButton);

        submitButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
//                if (Utils.isNetworkConnected(SignUpActivity.this)) {
                signUp();
//                } else {
//                    Toast.makeText(SignUpActivity.this, AppData.NO_INTERNET, Toast.LENGTH_LONG).show();
//                }
            }
        });

        //if (Utils.isInternetAvailable())
    }

    private void signUp() {

        user = new User();
        String userEmail = userEmailEditText.getText().toString();
        String password = passwordEditText.getText().toString();
        String confirmPassword = confirmPasswordEditText.getText().toString();

        if (password.equalsIgnoreCase(confirmPassword)) {
            user.setUsername(userEmail);
            user.setPassword(password);

            String signUpStatus = AuthenticationController.signUpUser(userEmail, password);

            if (AppData.SIGN_UP_SUCCESSFUL.equalsIgnoreCase(signUpStatus)) {
                Utils.isValidOtpDialog(SignUpActivity.this, user);
            } else {
                Toast.makeText(this, signUpStatus, Toast.LENGTH_LONG).show();
            }
        } else {
            Toast.makeText(this, "Confirm password does not match!", Toast.LENGTH_LONG).show();
        }
    }
}
