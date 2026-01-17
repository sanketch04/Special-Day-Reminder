package com.sdr.DTO;

public class FestivalDTO {

    private String name;
    private String imageUrl;

    public FestivalDTO(String name, String imageUrl) {
        this.name = name;
        this.imageUrl = imageUrl;
    }

    public String getName() {
        return name;
    }

    public String getImageUrl() {
        return imageUrl;
    }
}
