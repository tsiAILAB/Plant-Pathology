package com.tsi.plantdiagnosissystem.ui.forgotpassword;

import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import androidx.navigation.NavController;
import androidx.navigation.Navigation;

import com.tsi.plantdiagnosissystem.R;
import com.tsi.plantdiagnosissystem.controller.AuthenticationController;
import com.tsi.plantdiagnosissystem.data.model.User;

public class ResetPasswordFragment extends Fragment {

    User user;
    EditText passwordEditText, confirmPasswordEditText;
    Button resetPasswordSubmitButton;

    @Override
    public View onCreateView(
            LayoutInflater inflater, ViewGroup container,
            Bundle savedInstanceState
    ) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_reset_password, container, false);
    }

    public void onViewCreated(@NonNull View view, Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        Log.d("user_email", "user_email: " + getArguments().getBoolean("user_email"));

        //read from arguments
        String userName = getArguments().getString("user_email");

        user = new User();
        user.setUsername(userName);

        passwordEditText = view.findViewById(R.id.passwordEditText);
        confirmPasswordEditText = view.findViewById(R.id.confirmPasswordEditText);
        resetPasswordSubmitButton = view.findViewById(R.id.resetPasswordSubmitButton);

        resetPasswordSubmitButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                String password = passwordEditText.getText().toString();
                String confirmPassword = confirmPasswordEditText.getText().toString();
                if (password.equalsIgnoreCase(confirmPassword)) {
                    user.setPassword(password);
                    //updatePassword
                    AuthenticationController.resetPassword(user);
                } else {
                    Toast.makeText(getActivity().getApplicationContext(), "Confirm password does not match!", Toast.LENGTH_LONG).show();
                }
            }
        });
    }
}
