package com.tsi.plantdiagnosissystem.ui.forgotpassword;

import android.content.Context;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AlertDialog;
import androidx.fragment.app.Fragment;
import androidx.navigation.NavController;
import androidx.navigation.Navigation;

import com.tsi.plantdiagnosissystem.R;
import com.tsi.plantdiagnosissystem.controller.UserController;
import com.tsi.plantdiagnosissystem.data.model.User;

public class RecoverPasswordFragment extends Fragment {

    EditText emailEditText;
    Button getVerificationCodeButton;
    Context context;
    User user;

    @Override
    public View onCreateView(
            LayoutInflater inflater, ViewGroup container,
            Bundle savedInstanceState
    ) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_recover_password, container, false);
    }

    public void onViewCreated(@NonNull View view, Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        context = getContext();

        emailEditText = view.findViewById(R.id.emailEditText);
        getVerificationCodeButton = view.findViewById(R.id.getVerificationCodeButton);

        getVerificationCodeButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String userName = emailEditText.getText().toString().trim();

                if (userName != null && userName != ""){
                    user = new User();
                user.setUsername(userName);
                UserController.verifyEmailOtpSend(user.getUsername());

                //call alertDialog
                isValidOtpDialog();
            }else {
                    Toast.makeText(context, "User name cannot be empty!", Toast.LENGTH_LONG).show();
                }
            }
        });

//        view.findViewById(R.id.button_first).setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {
//                NavHostFragment.findNavController(RecoverPasswordFragment.this)
//                        .navigate(R.id.action_FirstFragment_to_SecondFragment);
//            }
//        });
    }

    private void isValidOtpDialog() {

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

                //Getting the user entered otp from editText
                final String otp = editTextConfirmOtp.getText().toString().trim();
                user.setOtp(otp);
                //Creating an string request
                User userOtpMatched = UserController.isValidOtp(user);

                if (userOtpMatched != null) {
                    Toast.makeText(context, "Otp Matched!", Toast.LENGTH_LONG).show();

                    final Bundle bundle = new Bundle();
                    bundle.putString("user_email", user.getUsername());

                    final NavController navController = Navigation.findNavController(getActivity(), R.id.nav_host_fragment);
                    navController.navigate(R.id.action_RecoverPasswordFragment_to_ResetPasswordFragment, bundle);

                } else {
                    Toast.makeText(context, "Wrong OTP!", Toast.LENGTH_LONG).show();
                    isValidOtpDialog();
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
}
