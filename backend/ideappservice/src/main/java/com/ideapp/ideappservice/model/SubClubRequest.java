package com.ideapp.ideappservice.model;

public class SubClubRequest {
    String clubName;
    String name;
    String imageUrl;
    String subClubAdmin;
    String description;

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public SubClubRequest(String clubName, String name, String imageUrl) {
        this.clubName = clubName;
        this.name = name;
        this.imageUrl = imageUrl;
    }
    public SubClubRequest(){}

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getSubClubAdmin() {
        return subClubAdmin;
    }

    public void setSubClubAdmin(String subClubAdmin) {
        this.subClubAdmin = subClubAdmin;
    }

    public String getClubName() {
        return clubName;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setClubName(String clubName) {
        this.clubName = clubName;
    }
}
