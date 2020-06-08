package com.tsi.plantdiagnosissystem.ui.landingpage;

import android.net.Uri;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.tsi.plantdiagnosissystem.R;
import com.tsi.plantdiagnosissystem.data.model.PlantImage;

import java.util.ArrayList;

public class CropRecyclerAdapter extends RecyclerView.Adapter<CropRecyclerAdapter.ImageViewHolder> {

    ArrayList<PlantImage> plantImages;

    CropRecyclerAdapter(ArrayList<PlantImage> plantImages) {
        this.plantImages = plantImages;
    }

    @NonNull
    @Override
    public ImageViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.crop_list_recyclerview_adapter, parent, false);
        ImageViewHolder imageViewHolder = new ImageViewHolder(view);
        return imageViewHolder;
    }

    @Override
    public void onBindViewHolder(@NonNull ImageViewHolder holder, int position) {
        PlantImage plantImage = plantImages.get(position);
        String imageUri = plantImage.getImageUrl();
        holder.cropImageView.setImageResource(R.drawable.potato);
//        holder.cropImageView.setImageURI(Uri.parse(imageUri));
        holder.cropNameTextView.setText(plantImage.getPlantName());
        Log.d("Crop: ","Name: "+plantImage.getPlantName()+" Url: "+plantImage.getImageUrl());
    }

    @Override
    public int getItemCount() {
        return plantImages.size();
    }

    public static class ImageViewHolder extends RecyclerView.ViewHolder {

        ImageView cropImageView;
        TextView cropNameTextView;

        public ImageViewHolder(@NonNull View itemView) {
            super(itemView);
            cropImageView = itemView.findViewById(R.id.cropImageView);
            cropNameTextView = itemView.findViewById(R.id.cropNameTextView);
        }
    }
}
