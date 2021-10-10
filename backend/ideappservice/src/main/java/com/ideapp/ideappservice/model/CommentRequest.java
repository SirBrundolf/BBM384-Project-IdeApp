package com.ideapp.ideappservice.model;

public class CommentRequest {
    Comment comment;
    String clubName;
    String subClubName;
    String timestamp;


    public CommentRequest(Comment comment, String timestamp,String subClubName,String clubName) {
        this.comment = comment;
        this.timestamp = timestamp;
        this.subClubName = subClubName;
        this.clubName = clubName;
    }

    public Comment getComment() {
        return comment;
    }

    public void setComment(Comment comment) {
        this.comment = comment;
    }

    public String getClubName() {
        return clubName;
    }

    public String getSubClubName() {
        return subClubName;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setSubClubName(String subClubName) {
        this.subClubName = subClubName;
    }

    public void setClubName(String clubName) {
        this.clubName = clubName;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }
}
