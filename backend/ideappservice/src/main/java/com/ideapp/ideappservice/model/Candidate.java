package com.ideapp.ideappservice.model;

public class Candidate {
    String username;
    String clubName;
    String subClubName;
    String reason;

    public Candidate(String username, String clubName, String subClubName, String reason) {
        this.username = username;
        this.clubName = clubName;
        this.subClubName = subClubName;
        this.reason = reason;
    }
    public Candidate(){}

    public String getClubName() {
        return clubName;
    }

    public String getSubClubName() {
        return subClubName;
    }

    public String getUsername() {
        return username;
    }

    public String getReason() {
        return reason;
    }

    public void setClubName(String clubName) {
        this.clubName = clubName;
    }

    public void setSubClubName(String subClubName) {
        this.subClubName = subClubName;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }
}
