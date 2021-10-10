package com.ideapp.ideappservice.model;

public class SubClubPostRequest {
    String clubName;
    String subClubName;
    String imageUrl;

    public SubClubPostRequest(){}

    public SubClubPostRequest(String clubName, String subClubName){
        this.clubName = clubName;
        this.subClubName = subClubName;
    }

    public String getSubClubName() {
        return subClubName;
    }

    public void setSubClubName(String subClubName) {
        this.subClubName = subClubName;
    }

    public void setClubName(String clubName) {
        this.clubName = clubName;
    }

    public String getClubName() {
        return clubName;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}
