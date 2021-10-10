package com.ideapp.ideappservice.model;

public class JoinedClub {
    String clubName;
    String parentClub;
    String imageUrl;
    String description;

    public JoinedClub(){}
    public JoinedClub(String clubName, String parentClub,String imageUrl, String description) {
        this.clubName = clubName;
        this.parentClub = parentClub;
        this.imageUrl = imageUrl;
        this.description = description;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getClubName() {
        return clubName;
    }

    public void setClubName(String clubName) {
        this.clubName = clubName;
    }

    public String getParentClub() {
        return parentClub;
    }

    public void setParentClub(String parentClub) {
        this.parentClub = parentClub;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
