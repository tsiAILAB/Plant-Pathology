package com.tsi.plantdiagnosissystem.ui.landingpage;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.os.Bundle;
import android.text.Html;
import android.view.MenuItem;
import android.widget.Toast;

import com.tsi.plantdiagnosissystem.R;
import com.tsi.plantdiagnosissystem.controller.PlantImageController;
import com.tsi.plantdiagnosissystem.controller.Utils;
import com.tsi.plantdiagnosissystem.controller.database.databasecontroller.PlantImageCtr;
import com.tsi.plantdiagnosissystem.controller.email.EmailSender;
import com.tsi.plantdiagnosissystem.data.model.PlantImage;

import java.util.ArrayList;

public class LandingPageActivity extends AppCompatActivity {

    private RecyclerView cropListRecyclerView;
    private RecyclerView.LayoutManager layoutManager;
    private CropRecyclerAdapter cropRecyclerAdapter;
    private ArrayList<PlantImage> plantImages;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_landing_page);
//        sendMail();

        //actonBar
        getSupportActionBar().setTitle(Html.fromHtml("<font color='#6699CC'>Select Crop</font>"));

        //copyAsset

        String[] assetImageNames = {"early_blight.JPG", "healthy_leaf.JPG", "late_blight.JPG", "pillow.JPG",
                "maze.jpg", "potato.jpg", "tomato.jpg"};
        for (int i = 0; i < assetImageNames.length; i++) {
            Utils.copyAssetToSdCard(this, assetImageNames[i]);
        }


        plantImages = PlantImageController.getPlantImages();

//        Toast.makeText(getApplicationContext(), "IsMailSent: ", Toast.LENGTH_LONG).show();

        cropListRecyclerView = findViewById(R.id.cropListRecyclerView);

        // use CropRecyclerAdapter
        cropRecyclerAdapter = new CropRecyclerAdapter(plantImages, this);
        cropListRecyclerView.setAdapter(cropRecyclerAdapter);

        // use a linear layout manager
        layoutManager = new LinearLayoutManager(this);
        cropListRecyclerView.setLayoutManager(layoutManager);
        //cropListRecyclerView.setHasFixedSize(true);
        cropListRecyclerView.invalidate();

//        Intent home = new Intent();
//        home.setClass(LandingPageActivity.this, TakePictureActivity.class);
//        startActivity(home);
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
