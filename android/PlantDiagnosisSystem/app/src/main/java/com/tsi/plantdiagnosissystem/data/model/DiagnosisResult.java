package com.tsi.plantdiagnosissystem.data.model;

import java.io.Serializable;

public class DiagnosisResult implements Comparable, Serializable {
    private String diseaseName;
    private String diagnosisProbability;

    public String getDiseaseName() {
        return diseaseName;
    }

    public void setDiseaseName(String diseaseName) {
        this.diseaseName = diseaseName;
    }

    public String getDiagnosisProbability() {
        return diagnosisProbability;
    }

    public void setDiagnosisProbability(String diagnosisProbability) {
        this.diagnosisProbability = diagnosisProbability;
    }

    @Override
    public int compareTo(Object diagnosisResult) {
        Double compareProb = Double.parseDouble(((DiagnosisResult) diagnosisResult).getDiagnosisProbability());
        /* For Descending order*/
        Double result = compareProb - Double.parseDouble(this.diagnosisProbability);
        return result.intValue();
    }
}
