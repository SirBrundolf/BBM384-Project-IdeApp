package com.ideapp.ideappservice.model;

public class RegisteredUsersRequest {
    String clubName;
    String subClubName;

    public RegisteredUsersRequest(String clubName, String subClubName) {
        this.clubName = clubName;
        this.subClubName = subClubName;
    }

    public String getSubClubName() {
        return subClubName;
    }

    public String getClubName() {
        return clubName;
    }

    public void setSubClubName(String subClubName) {
        this.subClubName = subClubName;
    }

    public void setClubName(String clubName) {
        this.clubName = clubName;
    }
}
