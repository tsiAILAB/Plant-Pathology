package com.tsi.plantdiagnosissystem.ui.forgotpassword;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import androidx.navigation.NavArgument;
import androidx.navigation.fragment.NavHostFragment;

import com.tsi.plantdiagnosissystem.R;
import com.tsi.plantdiagnosissystem.controller.AuthenticationController;
import com.tsi.plantdiagnosissystem.data.model.User;

import java.util.Map;

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

        Map<String, NavArgument> naveBarArgumanes = NavHostFragment.findNavController(ResetPasswordFragment.this)
                .getGraph().findNode(R.id.action_SecondFragment_to_FirstFragment)
                .getArguments();

        user = (User) naveBarArgumanes.values();

        passwordEditText = view.findViewById(R.id.passwordEditText);
        confirmPasswordEditText = view.findViewById(R.id.confirmPasswordEditText);
        resetPasswordSubmitButton = view.findViewById(R.id.resetPasswordSubmitButton);

        resetPasswordSubmitButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                user.setPassword(passwordEditText.getText().toString());

                AuthenticationController.resetPassword(user);
            }
        });


//        view.findViewById(R.id.button_second).setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {
//                NavHostFragment.findNavController(ResetPasswordFragment.this)
//                        .navigate(R.id.action_SecondFragment_to_FirstFragment);
//            }
//        });
    }
}
