package com.tsi.plantdiagnosissystem.controller;

import com.tsi.plantdiagnosissystem.controller.database.databasecontroller.ApiNameCtr;
import com.tsi.plantdiagnosissystem.data.model.ApiName;

public class ApiNameController {


    public static void saveImageToDatabase(ApiName apiName) {
        try {
            ApiNameCtr apiNameCtr = new ApiNameCtr();
            apiNameCtr.addApiName(apiName.getApiName(), apiName.getApiUrl());
        } catch (Exception e){
            e.printStackTrace();
        }
    }
}
