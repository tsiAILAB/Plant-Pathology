package com.tsi.plantdiagnosissystem.ui.configurations.ui;

import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.Toast;

import com.tsi.plantdiagnosissystem.R;
import com.tsi.plantdiagnosissystem.controller.PlantImageController;
import com.tsi.plantdiagnosissystem.controller.Utils;
import com.tsi.plantdiagnosissystem.data.model.PlantImage;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;

import static android.app.Activity.RESULT_OK;


/**
 * A simple {@link Fragment} subclass.
 * Use the {@link ConfigPlantImageFragment#newInstance} factory method to
 * create an instance of this fragment.
 */
public class ConfigPlantImageFragment extends Fragment {

    private PageViewModel pageViewModel;

    private static final int GALLERY_REQUEST = 1889;

    EditText cropNameEditText;
    Button addNewCropButton;
    Button imageFromGalleryButton;
    ImageView cropImageView;
    String savedImageUri;

    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";

    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;

    public ConfigPlantImageFragment() {
        // Required empty public constructor
    }

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param param1 Parameter 1.
     * @param param2 Parameter 2.
     * @return A new instance of fragment ConfigPlantImageFragment.
     */
    // TODO: Rename and change types and number of parameters
    public static ConfigPlantImageFragment newInstance(String param1, String param2) {
        ConfigPlantImageFragment fragment = new ConfigPlantImageFragment();
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
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_config_plant_image, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        cropNameEditText = view.findViewById(R.id.cropNameEditText);
        addNewCropButton = view.findViewById(R.id.addNewCropButton);
        imageFromGalleryButton = view.findViewById(R.id.cropImageGalleryButton);
        cropImageView = view.findViewById(R.id.cropImageView);

        imageFromGalleryButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                takeImageFromGallery();
            }
        });

        addNewCropButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String name = cropNameEditText.getText().toString().trim();
                String imageUri = savedImageUri;
                if(!"".equalsIgnoreCase(name) && imageUri != null && !"".equalsIgnoreCase(imageUri)) {
                    PlantImage plantImage = new PlantImage(name, imageUri);
                    PlantImageController.saveImageToDatabase(plantImage);
                    Toast.makeText(getActivity().getApplicationContext(), name+" saving successful!", Toast.LENGTH_LONG).show();
                    resetUi();
                } else {
                    Toast.makeText(getActivity().getApplicationContext(), "Crop name or image cannot be empty!", Toast.LENGTH_LONG).show();
                }
            }
        });
    }

    private void resetUi() {
        cropNameEditText.setText("");
        cropNameEditText.setHint("Enter crop name");
        cropImageView.setImageResource(R.drawable.no_image_selected);
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);


        if (requestCode == GALLERY_REQUEST && resultCode == RESULT_OK) {
            try {
                final Uri imageUri = data.getData();
                String imageFilePath = imageUri.getPath();
                String imageFileName = Utils.getFileName(getActivity(), imageUri);
                final InputStream imageStream = getActivity().getContentResolver().openInputStream(imageUri);
                final Bitmap selectedImage = PlantImageController.getBitmapFromUri(getActivity().getApplicationContext(), imageUri);
                //BitmapFactory.decodeStream(imageStream);
//                pictureImageView.setVisibility(View.VISIBLE);
                File savedFile = PlantImageController.saveImageExternalStorage(getActivity().getApplicationContext(), selectedImage, "");
                savedImageUri = savedFile.getAbsolutePath();
                cropImageView.setImageBitmap(selectedImage);
            } catch (FileNotFoundException e) {
                e.printStackTrace();
                Toast.makeText(getActivity(), "Something went wrong", Toast.LENGTH_LONG).show();
            } catch (IOException e){
                Toast.makeText(getActivity(), "Something went wrong", Toast.LENGTH_LONG).show();
            }
        }
    }

        void takeImageFromGallery() {
            Intent photoPickerIntent = new Intent(Intent.ACTION_PICK);
            photoPickerIntent.setType("image/*");
            startActivityForResult(photoPickerIntent, GALLERY_REQUEST);
        }
}
