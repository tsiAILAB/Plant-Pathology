package com.tsi.plantdiagnosissystem.data.model;

import java.io.Serializable;

public class ApiName implements Serializable {
    int id;
    String apiName;
    String apiUrl;

    public ApiName(String apiName, String apiUrl) {
        this.apiName = apiName;
        this.apiUrl = apiUrl;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getApiName() {
        return apiName;
    }

    public void setApiName(String apiName) {
        this.apiName = apiName;
    }

    public String getApiUrl() {
        return apiUrl;
    }

    public void setApiUrl(String apiUrl) {
        this.apiUrl = apiUrl;
    }
}
