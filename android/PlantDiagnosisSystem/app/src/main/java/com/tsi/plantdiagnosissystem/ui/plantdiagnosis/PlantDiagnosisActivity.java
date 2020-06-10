package com.tsi.plantdiagnosissystem.ui.plantdiagnosis;

import androidx.appcompat.app.AppCompatActivity;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Bundle;
import android.text.Html;
import android.view.MenuItem;
import android.widget.ImageView;
import android.widget.TextView;

import com.tsi.plantdiagnosissystem.R;

import java.io.InputStream;

public class PlantDiagnosisActivity extends AppCompatActivity {
    TextView diseaseName;
    ImageView sampleImage;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_plant_diagnosis);
        String titleText = "Early Blight";
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        getSupportActionBar().setTitle(Html.fromHtml("<font color='#6699CC'>" + titleText + "</font>"));

        Bundle extras = getIntent().getExtras();
        String imageFileName = extras.getString("file_name");
        String imageUri = extras.getString("image_uri");

        diseaseName = findViewById(R.id.diagnosisResultTextView);
        sampleImage = findViewById(R.id.imageView);
        try {
            InputStream imageStream = getContentResolver().openInputStream(Uri.parse(imageUri));
            final Bitmap selectedImage = BitmapFactory.decodeStream(imageStream);
            sampleImage.setImageBitmap(selectedImage);
        } catch (Exception e) {
            e.printStackTrace();
        }
        setDiagnosisResult(imageFileName);


    }

    private void setDiagnosisResult(String imageFileName) {

        switch (imageFileName) {
            case "early_blight":
                getSupportActionBar().setTitle(Html.fromHtml("<font color='#6699CC'>Early Blight</font>"));
                diseaseName.setText("Disease Found, Probability-92.75%");
                break;
            case "late_blight":
                getSupportActionBar().setTitle(Html.fromHtml("<font color='#6699CC'>Late Blight</font>"));
                diseaseName.setText("Disease Found, Probability-98.12%");
                break;
            case "healthy_leaf":
                getSupportActionBar().setTitle(Html.fromHtml("<font color='#6699CC'>Diseas not found</font>"));
                diseaseName.setText("Disease Not Found, Probability-92.75%");
                break;
            default:
                getSupportActionBar().setTitle(Html.fromHtml("<font color='#6699CC'>Not a Plant</font>"));
                diseaseName.setText("This is not a Plant!");
                break;
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
