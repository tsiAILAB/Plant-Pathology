package com.tsi.plantdiagnosissystem.ui.configurations.ui;

import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.lifecycle.ViewModelProviders;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.tsi.plantdiagnosissystem.R;
import com.tsi.plantdiagnosissystem.controller.ApiNameController;
import com.tsi.plantdiagnosissystem.data.AppData;
import com.tsi.plantdiagnosissystem.data.model.ApiName;

/**
 * A simple {@link Fragment} subclass.
 * Use the {@link ConfigApiNameFragment#newInstance} factory method to
 * create an instance of this fragment.
 */
public class ConfigApiNameFragment extends Fragment {

    private PageViewModel pageViewModel;

    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";

    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;

    TextView apiNameTextView;
    EditText apiUrlEditText;
    Button updateApiButton;

    public ConfigApiNameFragment() {
        // Required empty public constructor
    }

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param param1 Parameter 1.
     * @param param2 Parameter 2.
     * @return A new instance of fragment ConfigApiNameFragment.
     */
    // TODO: Rename and change types and number of parameters
    public static ConfigApiNameFragment newInstance(String param1, String param2) {
        ConfigApiNameFragment fragment = new ConfigApiNameFragment();
        Bundle args = new Bundle();
        args.putString(ARG_PARAM1, param1);
        args.putString(ARG_PARAM2, param2);
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            mParam1 = getArguments().getString(ARG_PARAM1);
            mParam2 = getArguments().getString(ARG_PARAM2);
        }
        pageViewModel = ViewModelProviders.of(this).get(PageViewModel.class);
        int index = 1;
        if (getArguments() != null) {
            index = getArguments().getInt(ARG_PARAM1);
        }
        pageViewModel.setIndex(index);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_config_api_name, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        apiUrlEditText = view.findViewById(R.id.apiUrlEditText);
        apiNameTextView = view.findViewById(R.id.apiNameTextView);
        updateApiButton = view.findViewById(R.id.updateApiButton);

        updateApiButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String name = AppData.UPLOAD_IMAGE;
                String apiUrl = apiUrlEditText.getText().toString().trim();
                if(!"".equalsIgnoreCase(apiUrl)) {
                    ApiName apiName = new ApiName(name, apiUrl);
                    ApiNameController.saveImageToDatabase(apiName);
                    Toast.makeText(getActivity().getApplicationContext(), "API saving successful!", Toast.LENGTH_LONG).show();
                    resetUi();
                } else {
                    Toast.makeText(getActivity().getApplicationContext(), "API URL cannot be empty!", Toast.LENGTH_LONG).show();
                }
            }
        });
    }

    private void resetUi() {
        apiUrlEditText.setText("");
        apiUrlEditText.setHint("Enter api url");
    }
}
