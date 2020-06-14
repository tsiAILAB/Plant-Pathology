package com.tsi.plantdiagnosissystem.ui.landingpage;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.squareup.picasso.Picasso;
import com.tsi.plantdiagnosissystem.R;
import com.tsi.plantdiagnosissystem.controller.PlantImageController;
import com.tsi.plantdiagnosissystem.data.model.PlantImage;
import com.tsi.plantdiagnosissystem.ui.takepicture.TakePictureActivity;

import java.util.ArrayList;

public class CropRecyclerAdapter extends RecyclerView.Adapter<CropRecyclerAdapter.ImageViewHolder> {

    private static Context context;
    private static ArrayList<PlantImage> plantImages;

    CropRecyclerAdapter(ArrayList<PlantImage> plantImages, Context context) {
        this.plantImages = plantImages;
        this.context = context;
    }

    @NonNull
    @Override
    public ImageViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.crop_list_recyclerview_adapter, parent, false);
        ImageViewHolder imageViewHolder = new ImageViewHolder(view, context, plantImages);
        return imageViewHolder;
    }

    @Override
    public void onBindViewHolder(@NonNull ImageViewHolder holder, int position) {
        PlantImage plantImage = plantImages.get(position);
        String imageUri = plantImage.getImageUrl();
//        holder.cropImageView.setImageResource(R.drawable.potato);
        try {
            holder.cropImageView.setImageURI(Uri.parse(imageUri));

//        Uri jg = Uri.parse(imageUri);
//        Picasso.with(context).load(jg).into(holder.cropImageView);

            holder.cropNameTextView.setText(plantImage.getPlantName());
        }catch (Exception e){
            e.printStackTrace();
        }
        Log.d("Crop: ", "Name: " + plantImage.getPlantName() + " Url: " + plantImage.getImageUrl());
    }

    @Override
    public int getItemCount() {
        if(plantImages == null){
            plantImages = PlantImageController.getPlantImages();
        }
        return plantImages.size();
    }

    public static class ImageViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {

        ImageView cropImageView;
        TextView cropNameTextView;
        Context context;
        ArrayList<PlantImage> plantImages;


        public ImageViewHolder(@NonNull View itemView, Context context, ArrayList<PlantImage> plantImages) {
            super(itemView);
            this.context = context;
            this.plantImages = plantImages;
            cropImageView = itemView.findViewById(R.id.cropImageView);
            cropNameTextView = itemView.findViewById(R.id.cropNameTextView);
            itemView.setOnClickListener(this);
        }

        @Override
        public void onClick(View v) {
            Log.d("ImagePosition", "ImagePosition: "+getAdapterPosition());
            Intent takePicture = new Intent(context, TakePictureActivity.class);
            takePicture.putExtra("plant_image", plantImages.get(getAdapterPosition()));
            context.startActivity(takePicture);

        }
    }
}
