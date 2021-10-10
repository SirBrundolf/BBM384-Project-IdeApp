package com.ideapp.ideappservice.model;

public class PostEditRequest {
    String timestamp;
    String subClubName;
    String clubName;
    String content;

    public PostEditRequest(String timestamp, String subClubName, String clubName, String content) {
        this.timestamp = timestamp;
        this.subClubName = subClubName;
        this.clubName = clubName;
        this.content = content;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public String getSubClubName() {
        return subClubName;
    }

    public void setSubClubName(String subClubName) {
        this.subClubName = subClubName;
    }

    public String getClubName() {
        return clubName;
    }

    public void setClubName(String clubName) {
        this.clubName = clubName;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
