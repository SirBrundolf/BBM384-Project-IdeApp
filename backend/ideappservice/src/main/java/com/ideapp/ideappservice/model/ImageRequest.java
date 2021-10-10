package com.ideapp.ideappservice.model;

public class ImageRequest {
    String username;
    String imageUrl;

    public ImageRequest(String username, String imageUrl) {
        this.username = username;
        this.imageUrl = imageUrl;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public String getUsername() {
        return username;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}
