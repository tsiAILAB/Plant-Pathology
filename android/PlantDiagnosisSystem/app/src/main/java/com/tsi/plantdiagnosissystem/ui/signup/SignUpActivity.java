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
                if (Utils.isInternetAvailable()) {
                    signUp();
                } else {
                    Toast.makeText(SignUpActivity.this, AppData.NO_INTERNET, Toast.LENGTH_LONG).show();
                }
            }
        });

        //if (Utils.isInternetAvailable())
    }

    private void signUp() {

        String userEmail = userEmailEditText.getText().toString();
        String password = passwordEditText.getText().toString();

        user.setUsername(userEmail);
        user.setPassword(password);

        String status = AuthenticationController.signUpUser(userEmail, password);


        callVerifyOtpDialog(SignUpActivity.this);
    }

    private void callVerifyOtpDialog(final Context context) {
        new AlertDialog.Builder(context)
                .setMessage("Do you want diagnosis of this Image?")
//                .setEditText()
                // Specifying a listener allows you to take an action before dismissing the dialog.
                // The dialog is automatically dismissed when a dialog button is clicked.
                .setPositiveButton(android.R.string.yes, new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        // Continue with delete operation
                        User userOtpMatched = AuthenticationController.isValidOtp(user);
                        if (userOtpMatched != null) {
                            AuthenticationController.saveLogInInfo(context, userOtpMatched);
                            Intent home = new Intent(context, LandingPageActivity.class);
                            home.putExtra("USER", userOtpMatched);
                            startActivity(home);
                            finish();
                        } else {
                            Toast.makeText(SignUpActivity.this, AppData.TRY_AGAIN, Toast.LENGTH_LONG).show();
                        }
                    }
                })

                // A null listener allows the button to dismiss the dialog and take no further action.
                .setNegativeButton(android.R.string.no, null)
                .setIcon(android.R.drawable.ic_dialog_alert)
                .show();

    }


    private void verifyOtp() {

    }

}
