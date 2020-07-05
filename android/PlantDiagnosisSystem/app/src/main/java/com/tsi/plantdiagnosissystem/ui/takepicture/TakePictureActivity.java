package com.tsi.plantdiagnosissystem.ui.takepicture;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;

import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.PorterDuff;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.Spannable;
import android.text.SpannableString;
import android.text.style.ForegroundColorSpan;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.tsi.plantdiagnosissystem.R;
import com.tsi.plantdiagnosissystem.controller.UserController;
import com.tsi.plantdiagnosissystem.controller.ImageUploadService;
import com.tsi.plantdiagnosissystem.controller.PlantImageController;
import com.tsi.plantdiagnosissystem.controller.Utils;
import com.tsi.plantdiagnosissystem.data.model.DiagnosisResult;
import com.tsi.plantdiagnosissystem.data.model.PlantImage;
import com.tsi.plantdiagnosissystem.data.model.User;
import com.tsi.plantdiagnosissystem.ui.plantdiagnosis.PlantDiagnosisActivity;

import org.json.JSONObject;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TakePictureActivity extends AppCompatActivity {
    private static final int CAMERA_REQUEST = 1888;
    private static final int GALLERY_REQUEST = 1889;
    ImageView pictureImageView, cropImageView;
    Button galleryButton, cameraButton, uploadImageButton;
    LinearLayout imageDetailsLinearLayout;
    TextView imageTypeTextView, sizeTypeTextView, heightTextView, widthTextView;

    Context context;

    String imageUploadFilePath, uploadImageFileName;
    String imageSize, imageTypeString;
    PlantImage plantImage = null;
    User user;
    Bitmap selectedImageBitmap;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_take_picture);
        cropImageView = findViewById(R.id.plantImageView);
        pictureImageView = findViewById(R.id.diseaseImageView);
        imageDetailsLinearLayout = findViewById(R.id.imageDetailsLinearLayout);

        imageTypeTextView = findViewById(R.id.imageTypeTextView);
        sizeTypeTextView = findViewById(R.id.imageSizeTextView);
        heightTextView = findViewById(R.id.imageHeightTextView);
        widthTextView = findViewById(R.id.imageWidthTextView);

        galleryButton = findViewById(R.id.galleryButton);
        cameraButton = findViewById(R.id.cameraButton);
        uploadImageButton = findViewById(R.id.uploadImageButton);
        context = this;


        //actonBar
        setActionBar("Take Picture");
//        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
//        getSupportActionBar().setTitle(Html.fromHtml("<font color='#6699CC'>Take Picture</font>"));


        //read bundle
        user = UserController.getLoginInfo(this);
        plantImage = (PlantImage) getIntent().getSerializableExtra("plant_image");

        cropImageView.setImageURI(Uri.parse(plantImage.getImageUrl()));

//        Uri jg = Uri.parse(plantImage.getImageUrl());
//        Picasso.with(context).load(jg).into(cropImageView);

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
                imageUploadFilePath = imageUri.getLastPathSegment();
                uploadImageFileName = Utils.getFileName(TakePictureActivity.this, imageUri);


                imageTypeString = uploadImageFileName.substring(uploadImageFileName.lastIndexOf("."));
                final InputStream imageStream = getContentResolver().openInputStream(imageUri);
//                final Bitmap selectedImage = BitmapFactory.decodeStream(imageStream);
//                selectedImageBitmap = selectedImage;
//                if (selectedImageBitmap == null) {
                try {
                    selectedImageBitmap = PlantImageController.getBitmapFromUri(TakePictureActivity.this, imageUri);
                    //save image
                    File file = PlantImageController.saveImageExternalStorage(TakePictureActivity.this, selectedImageBitmap, plantImage.getPlantName());
                    //getFilePath
                    imageUploadFilePath = file.getAbsolutePath();
                } catch (Exception e) {
                }
//                }


                imageSize = String.valueOf(selectedImageBitmap.getByteCount() / 1024);

                imageDetailsLinearLayout.setVisibility(View.VISIBLE);
                imageTypeTextView.setText("Type: " + imageTypeString);
                sizeTypeTextView.setText("Size: " + imageSize);
                heightTextView.setText("Height: " + selectedImageBitmap.getHeight());
                widthTextView.setText("Width: " + selectedImageBitmap.getWidth());


                pictureImageView.setImageBitmap(selectedImageBitmap);
                uploadImageButton.setVisibility(View.VISIBLE);
                uploadImageButton.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        if (!imageTypeString.equalsIgnoreCase(".bmp")) {
                            new AlertDialog.Builder(context)
                                    .setMessage("Do you want diagnosis of this Image?")

                                    // Specifying a listener allows you to take an action before dismissing the dialog.
                                    // The dialog is automatically dismissed when a dialog button is clicked.
                                    .setPositiveButton("Yes", new DialogInterface.OnClickListener() {
                                        public void onClick(DialogInterface dialog, int which) {
                                            //go to plantDiagnosis
//                                            goToPlantDiagnosis(uploadImageFileName, imageUploadFilePath);

                                            //upload image to the server
                                            new UploadToServerAsyncTask().execute();

                                        }
                                    })

                                    // A null listener allows the button to dismiss the dialog and take no further action.
                                    .setNegativeButton("No", null)
//                                .setIcon(android.R.drawable.ic_dialog_alert)
                                    .show();
                        } else {

                            Toast.makeText(TakePictureActivity.this, "Image type not supported", Toast.LENGTH_LONG).show();
                        }
                    }
                });
            } catch (FileNotFoundException e) {
                e.printStackTrace();
                Toast.makeText(TakePictureActivity.this, "Something went wrong", Toast.LENGTH_LONG).show();
            }
        } else if (requestCode == CAMERA_REQUEST && resultCode == RESULT_OK) {
            //Do stuff with the camara data result


            final Bitmap photo = (Bitmap) data.getExtras().get("data");
//            pictureImageView.setVisibility(View.VISIBLE);
            selectedImageBitmap = photo;

            pictureImageView.setImageBitmap(photo);

            File file;
            String filename;
            Uri imageUri;
            try {
                //save image
                file = PlantImageController.saveImageExternalStorage(TakePictureActivity.this, photo, plantImage.getPlantName());
                //getFilePath
                imageUploadFilePath = file.getAbsolutePath();
                imageUri = Uri.parse(imageUploadFilePath);
                uploadImageFileName = Utils.getFileName(TakePictureActivity.this, imageUri);

            } catch (IOException e) {
                e.printStackTrace();
            }

            imageTypeString = uploadImageFileName.substring(uploadImageFileName.lastIndexOf("."));

            imageSize = String.valueOf(selectedImageBitmap.getByteCount() / 1024);

            imageDetailsLinearLayout.setVisibility(View.VISIBLE);
            imageTypeTextView.setText("Type: " + imageTypeString);
            sizeTypeTextView.setText("Size: " + imageSize);
            heightTextView.setText("Height: " + selectedImageBitmap.getHeight());
            widthTextView.setText("Width: " + selectedImageBitmap.getWidth());

            imageDetailsLinearLayout.setVisibility(View.VISIBLE);

            uploadImageButton.setVisibility(View.VISIBLE);
            uploadImageButton.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    new AlertDialog.Builder(context)
                            .setMessage("Do you want diagnosis of this Image?")

                            // Specifying a listener allows you to take an action before dismissing the dialog.
                            // The dialog is automatically dismissed when a dialog button is clicked.
                            .setPositiveButton("Yes", new DialogInterface.OnClickListener() {
                                public void onClick(DialogInterface dialog, int which) {
                                    //go to plantDiagnosis
//                                    goToPlantDiagnosis(uploadImageFileName, imageUploadFilePath);

                                    //upload image to the server
                                    new UploadToServerAsyncTask().execute();
                                }
                            })

                            // A null listener allows the button to dismiss the dialog and take no further action.
                            .setNegativeButton("No", new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialog, int which) {
                                    try {
                                        PlantImageController.saveImageExternalStorage(TakePictureActivity.this, photo, plantImage.getPlantName());
                                        Toast.makeText(context, "Image Saved!", Toast.LENGTH_LONG).show();
                                    } catch (FileNotFoundException e) {
                                        e.printStackTrace();
                                        Toast.makeText(TakePictureActivity.this, "Something went wrong", Toast.LENGTH_LONG).show();
                                    } catch (IOException e) {
                                        e.printStackTrace();
                                        Toast.makeText(TakePictureActivity.this, "Something went wrong", Toast.LENGTH_LONG).show();

                                    }
                                }
                            })
                            .show();

                }
            });
        } else {
            Toast.makeText(TakePictureActivity.this, "You haven't picked Image", Toast.LENGTH_LONG).show();
        }
    }

    //start plant Diagnosis activity
    private void goToPlantDiagnosis(String filename, String imageUri) {
        Intent plantDiagnosis = new Intent(context, PlantDiagnosisActivity.class);
        plantDiagnosis.putExtra("file_name", filename);
        plantDiagnosis.putExtra("image_uri", imageUri);
        plantDiagnosis.putExtra("plant_name", plantImage.getPlantName());

        ArrayList<DiagnosisResult> diagnosisResults = new ArrayList<>();
        DiagnosisResult diagnosisResult = new DiagnosisResult();
        diagnosisResult.setDiseaseName("This is not a Plant!");
        diagnosisResult.setDiagnosisProbability("100");
        diagnosisResults.add(diagnosisResult);

        plantDiagnosis.putExtra("diagnosis_results", diagnosisResults);
        startActivity(plantDiagnosis);
    }

    //start plant Diagnosis activity
    private void goToPlantDiagnosis(String filename, String imageUri, ArrayList<DiagnosisResult> diagnosisResults) {
        Intent plantDiagnosis = new Intent(context, PlantDiagnosisActivity.class);
        plantDiagnosis.putExtra("file_name", filename);
        plantDiagnosis.putExtra("image_uri", imageUri);
        plantDiagnosis.putExtra("plant_name", plantImage.getPlantName());
        plantDiagnosis.putExtra("diagnosis_results", diagnosisResults);

//        plantDiagnosis.putExtra("cropName", plantImage.getPlantName());
        startActivity(plantDiagnosis);
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

        final Drawable upArrow = ContextCompat.getDrawable(this, R.drawable.abc_ic_ab_back_material);
        upArrow.setColorFilter(ContextCompat.getColor(this, R.color.colorBlueGray), PorterDuff.Mode.SRC_ATOP);
        getSupportActionBar().setHomeAsUpIndicator(upArrow);

        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.action_logout:
                UserController.logout(TakePictureActivity.this);
                return true;
            case android.R.id.home:
                onBackPressed();
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }

    /*Array of Diseases. Crops: Potato, Maize, Tomato*/
    String[] potatoDisease = {"Early Blight", "Late Blight", "Healthy"};
    String[] maizeDisease = {"Common Rust", "Gray Leaf Spot", "Northern Leaf Blight", "Healthy"};
    String[] tomatoDisease = {"Early Blight", "Late Blight", "Leaf Curl", "Leaf Mold", "Healthy"};

    //imageUpload AsyncTask
    public class UploadToServerAsyncTask extends AsyncTask<Void, Void, String> {

        private ProgressDialog pd = new ProgressDialog(TakePictureActivity.this);

        protected void onPreExecute() {
            super.onPreExecute();
            pd.setMessage("Wait image uploading!");
            pd.show();
        }

        @Override
        protected String doInBackground(Void... params) {
            if (Utils.isInternetAvailable()) {
                File imageFile = new File(imageUploadFilePath);
                String imageSizeUnit = "KB";
                return ImageUploadService.uploadImage(user, imageFile, uploadImageFileName, imageSize, imageSizeUnit,
                        imageTypeString, (plantImage.getPlantName()).toUpperCase());
            } else {
                Toast.makeText(TakePictureActivity.this, "Please check internet connection and try again!", Toast.LENGTH_LONG).show();
                return null;
            }
        }

        protected void onPostExecute(String result) {
            super.onPostExecute(result);
//            Response='d1=EarlyBlight#p1=92.07%;d2=EarlyBlight#p2=92.07%'
            if (result != null && !"".equalsIgnoreCase(result) && !"NO".equalsIgnoreCase(result)) {
                String[] responseArray = result.split("_");
                if (plantImage.getPlantName().equalsIgnoreCase("potato")) {
                    parseResponse(responseArray, potatoDisease);
                } else if (plantImage.getPlantName().equalsIgnoreCase("tomato")) {
                    parseResponse(responseArray, tomatoDisease);
                } else if (plantImage.getPlantName().equalsIgnoreCase("maize")) {
                    parseResponse(responseArray, maizeDisease);
                }
            } else {
                goToPlantDiagnosis(uploadImageFileName, imageUploadFilePath);
            }

            pd.hide();
            pd.dismiss();
        }

        /**
         * Prepare Diagnosis Result with Disease name
         *
         * @param responseArray
         * @param cropDisease
         */
        private void parseResponse(String[] responseArray, String[] cropDisease) {
            ArrayList<DiagnosisResult> diagnosisResults = new ArrayList<>();
            DiagnosisResult diagnosisResult;
            for (int i = 0; i < responseArray.length; i++) {
                diagnosisResult = new DiagnosisResult();
                String diseaseName = cropDisease[i];
                String diagnosisProbability = responseArray[i];
                diagnosisResult.setDiseaseName(diseaseName);
                diagnosisResult.setDiagnosisProbability(diagnosisProbability);
                diagnosisResults.add(diagnosisResult);
            }
            goToPlantDiagnosis(uploadImageFileName, imageUploadFilePath, diagnosisResults);
        }
    }
}
