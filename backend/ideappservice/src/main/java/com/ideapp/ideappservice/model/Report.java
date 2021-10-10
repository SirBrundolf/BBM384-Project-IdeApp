package com.ideapp.ideappservice.model;

public class Report {
    String username;
    String clubName;
    String subClubName;
    String timestamp;
    String type;

    public Report(String username, String clubName, String subClubName, String timestamp, String type) {
        this.username = username;
        this.clubName = clubName;
        this.subClubName = subClubName;
        this.timestamp = timestamp;
        this.type = type;
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

    Report(){}
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }


    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }



    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
