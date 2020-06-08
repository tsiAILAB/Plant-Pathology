package com.tsi.plantdiagnosissystem.data.model;


import java.io.Serializable;

public class PlantImage implements Serializable {
    int id;
    String plantName;
    String imageUrl;

    public PlantImage(String plantName, String imageUrl) {
        this.plantName = plantName;
        this.imageUrl = imageUrl;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPlantName() {
        return plantName;
    }

    public void setPlantName(String plantName) {
        this.plantName = plantName;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}
