package com.tsi.plantdiagnosissystem.ui.takepicture;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Bundle;
import android.text.Html;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.Toast;

import com.tsi.plantdiagnosissystem.R;
import com.tsi.plantdiagnosissystem.controller.PlantImageController;
import com.tsi.plantdiagnosissystem.controller.Utils;
import com.tsi.plantdiagnosissystem.data.model.PlantImage;
import com.tsi.plantdiagnosissystem.ui.plantdiagnosis.PlantDiagnosisActivity;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;

public class TakePictureActivity extends AppCompatActivity {
    private static final int CAMERA_REQUEST = 1888;
    private static final int GALLERY_REQUEST = 1889;
    ImageView pictureImageView;
    Button galleryButton, cameraButton, uploadImageButton;

    Context context;

    PlantImage plantImage = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_take_picture);
        pictureImageView = findViewById(R.id.diseaseImageView);
        galleryButton = findViewById(R.id.galleryButton);
        cameraButton = findViewById(R.id.cameraButton);
        uploadImageButton = findViewById(R.id.uploadImageButton);
        context = this;
        //actonBar
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        getSupportActionBar().setTitle(Html.fromHtml("<font color='#6699CC'>Take Picture</font>"));

        plantImage = (PlantImage) getIntent().getSerializableExtra("plant_image");

        galleryButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                takeImageFromGallery();
            }
        });

        cameraButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                takeImageFromCamera();
            }
        });
    }

    void takeImageFromGallery() {
        Intent photoPickerIntent = new Intent(Intent.ACTION_PICK);
        photoPickerIntent.setType("image/*");
        startActivityForResult(photoPickerIntent, GALLERY_REQUEST);
    }

    void takeImageFromCamera() {
        Intent photoPickerIntent = new Intent(android.provider.MediaStore.ACTION_IMAGE_CAPTURE);
        startActivityForResult(photoPickerIntent, CAMERA_REQUEST);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);


        if (requestCode == GALLERY_REQUEST && resultCode == RESULT_OK) {
            try {
                final Uri imageUri = data.getData();
                final String filename = Utils.getFileName(TakePictureActivity.this, imageUri);
                final InputStream imageStream = getContentResolver().openInputStream(imageUri);
                final Bitmap selectedImage = BitmapFactory.decodeStream(imageStream);
                pictureImageView.setImageBitmap(selectedImage);
                uploadImageButton.setVisibility(View.VISIBLE);
                uploadImageButton.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        new AlertDialog.Builder(context)
                                .setMessage("Do you want diagnosis of this Image?")

                                // Specifying a listener allows you to take an action before dismissing the dialog.
                                // The dialog is automatically dismissed when a dialog button is clicked.
                                .setPositiveButton(android.R.string.yes, new DialogInterface.OnClickListener() {
                                    public void onClick(DialogInterface dialog, int which) {
                                        // Continue with delete operation
                                        Intent plantDiagnosis = new Intent(context, PlantDiagnosisActivity.class);
                                        plantDiagnosis.putExtra("file_name", filename);
                                        plantDiagnosis.putExtra("image_uri", imageUri);
                                        startActivity(plantDiagnosis);
                                    }
                                })

                                // A null listener allows the button to dismiss the dialog and take no further action.
                                .setNegativeButton(android.R.string.no, null)
                                .setIcon(android.R.drawable.ic_dialog_alert)
                                .show();

                    }
                });
            } catch (FileNotFoundException e) {
                e.printStackTrace();
                Toast.makeText(TakePictureActivity.this, "Something went wrong", Toast.LENGTH_LONG).show();
            }
        } else if (requestCode == CAMERA_REQUEST && resultCode == RESULT_OK) {
            //Do stuff with the camara data result

            final Bitmap photo = (Bitmap) data.getExtras().get("data");
            pictureImageView.setImageBitmap(photo);


            uploadImageButton.setVisibility(View.VISIBLE);
            uploadImageButton.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    new AlertDialog.Builder(context)
                            .setMessage("Do you want diagnosis of this Image?")

                            // Specifying a listener allows you to take an action before dismissing the dialog.
                            // The dialog is automatically dismissed when a dialog button is clicked.
                            .setPositiveButton(android.R.string.yes, new DialogInterface.OnClickListener() {
                                public void onClick(DialogInterface dialog, int which) {
                                    // Continue with delete operation
                                    Intent plantDiagnosis = new Intent(context, PlantDiagnosisActivity.class);
                                    startActivity(plantDiagnosis);
                                }
                            })

                            // A null listener allows the button to dismiss the dialog and take no further action.
                            .setNegativeButton(android.R.string.no, new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialog, int which) {
                                    try {
                                        PlantImageController.saveImageExternalStorage(TakePictureActivity.this, photo, plantImage.getPlantName());
                                        Toast.makeText(context, "Image Saved!", Toast.LENGTH_LONG).show();


                                    } catch (FileNotFoundException e) {
                                        e.printStackTrace();
                                        Toast.makeText(TakePictureActivity.this, "Something went wrong", Toast.LENGTH_LONG).show();
                                    } catch (IOException e){
                                        e.printStackTrace();
                                        Toast.makeText(TakePictureActivity.this, "Something went wrong", Toast.LENGTH_LONG).show();

                                    }
                                }
                            })
//                            .setIcon(android.R.drawable.ic_dialog_alert)
                            .show();

                }
            });
        } else {
            Toast.makeText(TakePictureActivity.this, "You haven't picked Image", Toast.LENGTH_LONG).show();
        }
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case android.R.id.home:
                // API 5+ solution
                onBackPressed();
                return true;

            default:
                return super.onOptionsItemSelected(item);
        }
    }
}
