package com.ideapp.ideappservice.model;

public class Club {
    String name;
    String imageUrl;
    int vote;
    String description;

    public Club(String name,String imageUrl){
        this.name = name;
        this.imageUrl = imageUrl;

    }

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

    public String getName() {
        return name;
    }
    public Club(){}

    public void setName(String name) {
        this.name = name;
    }
}
