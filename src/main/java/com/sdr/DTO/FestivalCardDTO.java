package com.sdr.DTO;

public class FestivalCardDTO {

    private String image;
    private String title;

    public FestivalCardDTO(String image, String title) {
        this.image = image;
        this.title = title;
    }

    public String getImage() { return image; }
    public String getTitle() { return title; }
}

