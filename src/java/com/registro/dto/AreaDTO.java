package com.registro.dto;

/**
  VARIABLES DE AREA
*/
public class AreaDTO {

    private String Area_ID;
    private String DescripcionArea;

    public AreaDTO() {
    }

    public AreaDTO(String Area_ID, String DescripcionArea) {
        this.Area_ID = Area_ID;
        this.DescripcionArea = DescripcionArea;
    }

    public String getArea_ID() { return Area_ID; }
    public void setArea_ID(String Area_ID) { this.Area_ID = Area_ID; }

    public String getDescripcionArea() { return DescripcionArea; }
    public void setDescripcionArea(String DescripcionArea) { this.DescripcionArea = DescripcionArea; }
}
