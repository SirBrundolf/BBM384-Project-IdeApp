package com.ideapp.ideappservice.model;

public class GetCommentRequest {
    String clubName;
    String subClubName;
    String timestamp;

    public GetCommentRequest(String clubName, String subClubName, String timestamp) {
        this.clubName = clubName;
        this.subClubName = subClubName;
        this.timestamp = timestamp;
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

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }
}
