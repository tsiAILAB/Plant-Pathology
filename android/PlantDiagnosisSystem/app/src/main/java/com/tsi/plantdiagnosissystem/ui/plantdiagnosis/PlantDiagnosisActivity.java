package com.tsi.plantdiagnosissystem.ui.plantdiagnosis;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.graphics.PorterDuff;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.os.Bundle;
import android.text.Html;
import android.text.Spannable;
import android.text.SpannableString;
import android.text.style.ForegroundColorSpan;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ImageView;
import android.widget.TextView;

import com.tsi.plantdiagnosissystem.R;
import com.tsi.plantdiagnosissystem.controller.AuthenticationController;

import java.io.InputStream;

public class PlantDiagnosisActivity extends AppCompatActivity {
    TextView diseaseName;
    ImageView sampleImage;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_plant_diagnosis);
        Bundle extras = getIntent().getExtras();
        String imageFileName = extras.getString("file_name");
        String imageUri = extras.getString("image_uri");

        //setActionBar
//        String titleText = "Early Blight";
//        setActionBar(titleText);
//        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
//        getSupportActionBar().setTitle(Html.fromHtml("<font color='#6699CC'>" + titleText + "</font>"));


        diseaseName = findViewById(R.id.diagnosisResultTextView);
        sampleImage = findViewById(R.id.imageView);
        sampleImage.setImageURI(Uri.parse(imageUri));
//        try {
//            InputStream imageStream = getContentResolver().openInputStream(Uri.parse(imageUri));
//            final Bitmap selectedImage = BitmapFactory.decodeStream(imageStream);
//            sampleImage.setImageBitmap(selectedImage);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
        setDiagnosisResult(imageFileName);


    }

    private void setDiagnosisResult(String imageFileName) {

        switch (imageFileName) {
            case "early_blight.JPG":
                setActionBar("Early Blight");
                diseaseName.setText("Disease Found, Probability-92.75%");
                break;
            case "late_blight.JPG":
                setActionBar("Late Blight");
                diseaseName.setText("Disease Found, Probability-98.12%");
                break;
            case "healthy_leaf.JPG":
                setActionBar("Disease not found");
                diseaseName.setText("Disease Not Found, Probability-92.75%");
                break;
            default:
                setActionBar("Not a Plant");
                diseaseName.setText("This is not a Plant!");
                break;
        }
    }

    //set custom actionBar
    public void setActionBar(String title){
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
                AuthenticationController.logout(PlantDiagnosisActivity.this);
                return true;
            case android.R.id.home:
                onBackPressed();
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }
}
