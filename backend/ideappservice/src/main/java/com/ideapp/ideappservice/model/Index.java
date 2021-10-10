package com.ideapp.ideappservice.model;

public class Index {
    String name;
    String ClubName;
    String type;
    public Index(){}

    public Index(String name, String ClubName,String type) {
        this.name = name;
        this.ClubName = ClubName;
        this.type = type;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getClubName() {
        return ClubName;
    }

    public void setClubName(String clubName) {
        ClubName = clubName;
    }
}
