package com.tsi.plantdiagnosissystem.ui.login;

import android.app.Activity;

import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProviders;

import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Bundle;

import androidx.annotation.Nullable;
import androidx.annotation.StringRes;
import androidx.appcompat.app.AppCompatActivity;

import android.text.Editable;
import android.text.Html;
import android.text.TextWatcher;
import android.view.KeyEvent;
import android.view.View;
import android.view.inputmethod.EditorInfo;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.tsi.plantdiagnosissystem.R;
import com.tsi.plantdiagnosissystem.controller.UserController;
import com.tsi.plantdiagnosissystem.controller.Utils;
import com.tsi.plantdiagnosissystem.data.model.User;
import com.tsi.plantdiagnosissystem.ui.forgotpassword.ForgotPasswordActivity;
import com.tsi.plantdiagnosissystem.ui.landingpage.LandingPageActivity;
import com.tsi.plantdiagnosissystem.ui.signup.SignUpActivity;

public class LoginActivity extends AppCompatActivity {


    private static final int PERMISSION_REQUEST_CODE = 200;

    private static Context CONTEXT;

    private LoginViewModel loginViewModel;
    private static Context instance;
    private User user;

    public static Context instance() {
        return instance;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        instance = getApplication().getApplicationContext();//LoginActivity.this;

        getSupportActionBar().setTitle(Html.fromHtml("<font color='#6699CC'>Plant Diagnosis System </font>"));

        loginViewModel = ViewModelProviders.of(this, new LoginViewModelFactory())
                .get(LoginViewModel.class);

        CONTEXT = this;
        requestPermission();

        User user = UserController.getLoginInfo(CONTEXT);

        if (!user.isLoggedIn()) {
            final EditText usernameEditText = findViewById(R.id.username);
            final EditText passwordEditText = findViewById(R.id.password);
            final Button loginButton = findViewById(R.id.login);
            final Button forgotPasswordButton = findViewById(R.id.forgotPasswordButton);
            final Button signUpButton = findViewById(R.id.signUpButton);

            loginViewModel.getLoginFormState().observe(this, new Observer<LoginFormState>() {
                @Override
                public void onChanged(@Nullable LoginFormState loginFormState) {
                    if (loginFormState == null) {
                        return;
                    }
                    loginButton.setEnabled(loginFormState.isDataValid());
                    if (loginFormState.getUsernameError() != null) {
                        usernameEditText.setError(getString(loginFormState.getUsernameError()));
                    }
                    if (loginFormState.getPasswordError() != null) {
                        passwordEditText.setError(getString(loginFormState.getPasswordError()));
                    }
                }
            });

            loginViewModel.getLoginResult().observe(this, new Observer<LoginResult>() {
                @Override
                public void onChanged(@Nullable LoginResult loginResult) {
                    if (loginResult == null) {
                        return;
                    }
                    if (loginResult.getError() != null) {
                        showLoginFailed(loginResult.getError());
                    }
                    if (loginResult.getSuccess() != null) {
                        updateUiWithUser(loginResult.getSuccess());
                    }
                    setResult(Activity.RESULT_OK);

                    //Complete and destroy login activity once successful
//                finish();
                }
            });

            TextWatcher afterTextChangedListener = new TextWatcher() {
                @Override
                public void beforeTextChanged(CharSequence s, int start, int count, int after) {
                    // ignore
                }

                @Override
                public void onTextChanged(CharSequence s, int start, int before, int count) {
                    // ignore
                }

                @Override
                public void afterTextChanged(Editable s) {
                    loginViewModel.loginDataChanged(usernameEditText.getText().toString(),
                            passwordEditText.getText().toString());
                }
            };
            usernameEditText.addTextChangedListener(afterTextChangedListener);
            passwordEditText.addTextChangedListener(afterTextChangedListener);
            passwordEditText.setOnEditorActionListener(new TextView.OnEditorActionListener() {

                @Override
                public boolean onEditorAction(TextView v, int actionId, KeyEvent event) {
                    if (actionId == EditorInfo.IME_ACTION_DONE) {
                        loginViewModel.login(usernameEditText.getText().toString(),
                                passwordEditText.getText().toString());
                    }
                    return false;
                }
            });

            loginButton.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    loginViewModel.login(usernameEditText.getText().toString(),
                            passwordEditText.getText().toString());


                }
            });

            forgotPasswordButton.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Intent forgetPasswordActivity = new Intent();
                    forgetPasswordActivity.setClass(LoginActivity.this, ForgotPasswordActivity.class);
                    startActivity(forgetPasswordActivity);
                }
            });

            signUpButton.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Intent signUpActivity = new Intent();
                    signUpActivity.setClass(LoginActivity.this, SignUpActivity.class);
                    startActivity(signUpActivity);
                }
            });
        } else {
            String welcome = getString(R.string.welcome);
            // TODO : initiate successful logged in experience
            Toast.makeText(getApplicationContext(), welcome, Toast.LENGTH_LONG).show();
            Intent home = new Intent();
            home.setClass(LoginActivity.this, LandingPageActivity.class);
            startActivity(home);
            finish();
        }
    }

    private void updateUiWithUser(LoggedInUserView loggedInUserView) {

        user = loggedInUserView.getUser();

        //saveLoginInfo
        UserController.saveLogInInfo(LoginActivity.this, user);

        String welcome = getString(R.string.welcome);
        // TODO : initiate successful logged in experience
        Toast.makeText(getApplicationContext(), welcome, Toast.LENGTH_LONG).show();
        Intent home = new Intent();
        home.setClass(LoginActivity.this, LandingPageActivity.class);
        startActivity(home);
        finish();
    }

    private void showLoginFailed(@StringRes Integer errorString) {
        Toast.makeText(getApplicationContext(), errorString, Toast.LENGTH_SHORT).show();
    }


    public void requestPermission() {
        String[] perms = {"android.permission.ACCESS_NETWORK_STATE", "android.permission.CAMERA", "android.permission.INTERNET",
                "android.permission.READ_EXTERNAL_STORAGE", "android.permission.WRITE_EXTERNAL_STORAGE"};

        int permsRequestCode = 200;
        requestPermissions(perms, permsRequestCode);
    }

    @Override
    public void onRequestPermissionsResult(int permsRequestCode, String[] permissions, int[] grantResults) {

        switch (permsRequestCode) {

            case 200:

                boolean networkState = grantResults[0] == PackageManager.PERMISSION_GRANTED;
                boolean cameraAccepted = grantResults[1] == PackageManager.PERMISSION_GRANTED;
                boolean internet = grantResults[2] == PackageManager.PERMISSION_GRANTED;
                boolean readExternalStorage = grantResults[3] == PackageManager.PERMISSION_GRANTED;
                boolean writeExternalStorage = grantResults[4] == PackageManager.PERMISSION_GRANTED;


                //copyAsset
                String[] assetImageNames = {"early_blight.JPG", "healthy_leaf.JPG", "late_blight.JPG", "pillow.JPG",
                        "maze.jpg", "potato.jpg", "tomato.jpg"};
                int[] assetImageResource = {R.drawable.early_blight, R.drawable.healthy_leaf, R.drawable.late_blight,
                        R.drawable.pillow, R.drawable.maze, R.drawable.potato, R.drawable.tomato};
                for (int i = 0; i < assetImageNames.length; i++) {
                    Utils.saveFromDrawable(this, assetImageResource[i], assetImageNames[i]);
                }

                break;

        }

    }
}
