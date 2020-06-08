package com.tsi.plantdiagnosissystem.ui.landingpage;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.os.Bundle;
import android.widget.Toast;

import com.tsi.plantdiagnosissystem.R;
import com.tsi.plantdiagnosissystem.controller.database.databasecontroller.PlantImageCtr;
import com.tsi.plantdiagnosissystem.controller.email.EmailSender;
import com.tsi.plantdiagnosissystem.data.model.PlantImage;

import java.util.ArrayList;

public class LandingPage extends AppCompatActivity {

    private RecyclerView cropListRecyclerView;
    private RecyclerView.LayoutManager layoutManager;
    private CropRecyclerAdapter cropRecyclerAdapter;
    private ArrayList<PlantImage> plantImages;
    private PlantImageCtr plantImageCtr;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_landing_page);
//        sendMail();
        plantImageCtr = new PlantImageCtr();
        plantImages = plantImageCtr.getPlantImages();

        Toast.makeText(getApplicationContext(), "IsMailSent: ", Toast.LENGTH_LONG).show();

        cropListRecyclerView = findViewById(R.id.cropListRecyclerView);

        // use a linear layout manager
        layoutManager = new LinearLayoutManager(this);
        cropListRecyclerView.setLayoutManager(layoutManager);
        cropListRecyclerView.setHasFixedSize(true);

        // use CropRecyclerAdapter
        cropRecyclerAdapter = new CropRecyclerAdapter(plantImages, this);
        cropListRecyclerView.setAdapter(cropRecyclerAdapter);

//        Intent home = new Intent();
//        home.setClass(LandingPage.this, TakePicture.class);
//        startActivity(home);
    }

    void sendMail(){
        Thread thread = new Thread(new Runnable() {

            @Override
            public void run() {
                try  {
                    EmailSender.sendEmail("firozsujan@gmail.com", "PDS", "wdK31");
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        });

        thread.start();
    }
}
