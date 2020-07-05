package com.tsi.plantdiagnosissystem.ui.plantdiagnosis;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;

import android.graphics.PorterDuff;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.os.Bundle;
import android.text.Spannable;
import android.text.SpannableString;
import android.text.style.ForegroundColorSpan;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ImageView;
import android.widget.TextView;

import com.tsi.plantdiagnosissystem.R;
import com.tsi.plantdiagnosissystem.controller.UserController;
import com.tsi.plantdiagnosissystem.data.model.DiagnosisResult;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Map;

public class PlantDiagnosisActivity extends AppCompatActivity {
    TextView diseaseNameTextView;
    ImageView sampleImageImageView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_plant_diagnosis);
        Bundle extras = getIntent().getExtras();
        String imageFileName = extras.getString("file_name");
        String imageUri = extras.getString("image_uri");
        String plantName = extras.getString("plant_name");
//        String diagnosisResult = extras.getString("result");

        ArrayList<DiagnosisResult> diagnosisResults = (ArrayList<DiagnosisResult>) getIntent().getSerializableExtra("diagnosis_results");

        //setActionBar
//        String titleText = "Early Blight";
//        setActionBar(titleText);
//        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
//        getSupportActionBar().setTitle(Html.fromHtml("<font color='#6699CC'>" + titleText + "</font>"));


        diseaseNameTextView = findViewById(R.id.diagnosisResultTextView);
        sampleImageImageView = findViewById(R.id.imageView);
        sampleImageImageView.setImageURI(Uri.parse(imageUri));
//        try {
//            InputStream imageStream = getContentResolver().openInputStream(Uri.parse(imageUri));
//            final Bitmap selectedImage = BitmapFactory.decodeStream(imageStream);
//            sampleImage.setImageBitmap(selectedImage);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        setDummyDiagnosisResult(imageFileName);

        Collections.sort(diagnosisResults);

        //disease, diagnosis
        String diagnosisResult = "";
        for (int i = 0; i < diagnosisResults.size(); i++) {
            diagnosisResult = diagnosisResult + "Disease Name: " + diagnosisResults.get(i).getDiseaseName() +
                    "\nProbability: " + diagnosisResults.get(i).getDiagnosisProbability() + "%\n\n";
        }


        setActionBar(plantName);
        diseaseNameTextView.setText(diagnosisResult);
    }

    private void setDummyDiagnosisResult(String imageFileName) {

        switch (imageFileName) {
            case "early_blight.JPG":
                setActionBar("Early Blight");
                diseaseNameTextView.setText("Disease Found, Probability-92.75%");
                break;
            case "late_blight.JPG":
                setActionBar("Late Blight");
                diseaseNameTextView.setText("Disease Found, Probability-98.12%");
                break;
            case "healthy_leaf.JPG":
                setActionBar("Disease not found");
                diseaseNameTextView.setText("Disease Not Found, Probability-92.75%");
                break;
            default:
                setActionBar("Not a Plant");
                diseaseNameTextView.setText("This is not a Plant!");
                break;
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

        final Drawable upArrow = ContextCompat.getDrawable(this, R.drawable.abc_ic_ab_back_material);
        upArrow.setColorFilter(ContextCompat.getColor(this, R.color.colorBlueGray), PorterDuff.Mode.SRC_ATOP);
        getSupportActionBar().setHomeAsUpIndicator(upArrow);


        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.action_logout:
                UserController.logout(PlantDiagnosisActivity.this);
                return true;
            case android.R.id.home:
                onBackPressed();
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }
}
