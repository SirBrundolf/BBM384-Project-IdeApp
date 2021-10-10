package com.ideapp.ideappservice.model;

public class AddClubRequest {
    String imageUrl;
    String name;
    String description;
    public AddClubRequest(String name,String imageUrl) {
        this.imageUrl = imageUrl;
        this.name = name;
    }
    public AddClubRequest(){
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageurl) {
        this.imageUrl = imageurl;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
