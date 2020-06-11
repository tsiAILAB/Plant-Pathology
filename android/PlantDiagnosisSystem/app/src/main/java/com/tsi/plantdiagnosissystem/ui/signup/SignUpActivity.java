package com.tsi.plantdiagnosissystem.ui.signup;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;

import android.graphics.PorterDuff;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.text.Spannable;
import android.text.SpannableString;
import android.text.style.ForegroundColorSpan;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.tsi.plantdiagnosissystem.R;
import com.tsi.plantdiagnosissystem.data.AppData;
import com.tsi.plantdiagnosissystem.controller.UserController;
import com.tsi.plantdiagnosissystem.controller.Utils;
import com.tsi.plantdiagnosissystem.data.model.User;

public class SignUpActivity extends AppCompatActivity {

    private EditText userEmailEditText, passwordEditText, confirmPasswordEditText;
    private Button submitButton;
    private static User user;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sign_up);

        //actonBar
        setActionBar("Sign Up");

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

            String signUpStatus = UserController.signUpUser(userEmail, password);

            if (AppData.SIGN_UP_SUCCESSFUL.equalsIgnoreCase(signUpStatus)) {
                Utils.isValidOtpDialog(SignUpActivity.this, user);
            } else {
                Toast.makeText(this, signUpStatus, Toast.LENGTH_LONG).show();
            }
        } else {
            Toast.makeText(this, "Confirm password does not match!", Toast.LENGTH_LONG).show();
        }
    }



    //set custom actionBar
    public void setActionBar(String title) {
        getSupportActionBar().setDisplayShowTitleEnabled(false);
        getSupportActionBar().setDisplayShowTitleEnabled(true);
        getSupportActionBar().setTitle(title);
        Spannable text = new SpannableString(getSupportActionBar().getTitle());
        text.setSpan(new ForegroundColorSpan(ContextCompat.getColor(this, R.color.colorBlueGray)), 0, text.length(), Spannable.SPAN_INCLUSIVE_INCLUSIVE);
        getSupportActionBar().setTitle(text);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_main, menu);

        MenuItem item = menu.findItem(R.id.action_logout);
        item.setVisible(false);

        final Drawable upArrow = ContextCompat.getDrawable(this, R.drawable.abc_ic_ab_back_material);
        upArrow.setColorFilter(ContextCompat.getColor(this, R.color.colorBlueGray), PorterDuff.Mode.SRC_ATOP);
        getSupportActionBar().setHomeAsUpIndicator(upArrow);

        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case android.R.id.home:
                onBackPressed();
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }
}
