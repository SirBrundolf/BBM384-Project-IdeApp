package com.ideapp.ideappservice.model;

public class CommentEditRequest {
    String timestamp;
    String subClubName;
    String clubName;
    String content;
    String postTimestamp;
    public CommentEditRequest(String timestamp,String postTimestamp, String subClubName, String clubName, String content) {
        this.timestamp = timestamp;
        this.postTimestamp = postTimestamp;
        this.subClubName = subClubName;
        this.clubName = clubName;
        this.content = content;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public String getPostTimestamp() {
        return postTimestamp;
    }

    public void setPostTimestamp(String postTimestamp) {
        this.postTimestamp = postTimestamp;
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
