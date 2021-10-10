package com.ideapp.ideappservice.model;

public class GetEventRequest {
    String clubName;
    String subClubName;

    public GetEventRequest(String clubName, String subClubName) {
        this.clubName = clubName;
        this.subClubName = subClubName;
    }

    public String getClubName() {
        return clubName;
    }

    public void setClubName(String clubName) {
        this.clubName = clubName;
    }

    public String getSubClubName() {
        return subClubName;
    }

    public void setSubClubName(String subClubName) {
        this.subClubName = subClubName;
    }
}
