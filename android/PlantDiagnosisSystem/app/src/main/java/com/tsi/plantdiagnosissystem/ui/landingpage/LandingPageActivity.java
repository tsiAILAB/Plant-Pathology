package com.tsi.plantdiagnosissystem.ui.landingpage;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.text.Spannable;
import android.text.SpannableString;
import android.text.style.ForegroundColorSpan;
import android.view.Menu;
import android.view.MenuItem;

import com.tsi.plantdiagnosissystem.R;
import com.tsi.plantdiagnosissystem.data.AppData;
import com.tsi.plantdiagnosissystem.controller.UserController;
import com.tsi.plantdiagnosissystem.controller.PlantImageController;
import com.tsi.plantdiagnosissystem.data.model.PlantImage;
import com.tsi.plantdiagnosissystem.data.model.User;
import com.tsi.plantdiagnosissystem.ui.configurations.ConfigurationsActivity;

import java.util.ArrayList;

public class LandingPageActivity extends AppCompatActivity {

    private RecyclerView cropListRecyclerView;
    private RecyclerView.LayoutManager layoutManager;
    private CropRecyclerAdapter cropRecyclerAdapter;
    private ArrayList<PlantImage> plantImages;
    private User loggedInUser;
    private static Context instance;

    public static Context instance() {
        return instance;
    }
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_landing_page);
//        sendMail();
        loggedInUser = UserController.getLoginInfo(this);
        //actonBar
//        getSupportActionBar().setTitle(Html.fromHtml("<font color='#6699CC'>Select Crop</font>"));

        setActionBar("Select Crop");

        try {
            plantImages = PlantImageController.getPlantImages();
        }catch (Exception e){}
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
    public void onResume() {
        super.onResume();
        try {
            plantImages = PlantImageController.getPlantImages();
        }catch (Exception e){}
    }

    //set custom actionBar
    public void setActionBar(String title) {
        getSupportActionBar().setDisplayShowTitleEnabled(false);
        getSupportActionBar().setDisplayShowTitleEnabled(true);
        getSupportActionBar().setTitle(title);
        Spannable text = new SpannableString(getSupportActionBar().getTitle());
        text.setSpan(new ForegroundColorSpan(ContextCompat.getColor(this, R.color.colorBlueGray)), 0, text.length(), Spannable.SPAN_INCLUSIVE_INCLUSIVE);
        getSupportActionBar().setTitle(text);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_main, menu);
        if (AppData.ADMIN_ROLE.equalsIgnoreCase(loggedInUser.getRole())) {
            MenuItem item = menu.findItem(R.id.action_settings);
            item.setVisible(true);
        }
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.action_settings:
                Intent forgetPasswordActivity = new Intent();
                forgetPasswordActivity.setClass(LandingPageActivity.this, ConfigurationsActivity.class);
                startActivity(forgetPasswordActivity);
                return true;
            case R.id.action_logout:
                UserController.logout(LandingPageActivity.this);
                return true;

            default:
                return super.onOptionsItemSelected(item);
        }
    }
}
