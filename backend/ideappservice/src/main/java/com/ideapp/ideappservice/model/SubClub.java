package com.ideapp.ideappservice.model;

public class SubClub {
    String name ;
    String clubName;
    String imageUrl;
    String subClubAdmin;
    String description;

    int vote;
    public SubClub(String name, String clubName,String imageUrl) {
        this.clubName = clubName;
        this.name = name;
        this.imageUrl = imageUrl;
    }
    public SubClub(){}

    public int getVote() {
        return vote;
    }
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setVote(int vote) {
        this.vote = vote;
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

    public String getSubClubAdmin() {
        return subClubAdmin;
    }

    public void setSubClubAdmin(String subClubAdmin) {
        this.subClubAdmin = subClubAdmin;
    }

    public void setClubName(String clubName) {
        this.clubName = clubName;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

}
