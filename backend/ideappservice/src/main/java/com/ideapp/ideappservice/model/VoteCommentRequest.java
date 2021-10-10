package com.ideapp.ideappservice.model;

public class VoteCommentRequest {
    String timestamp;
    String subClubName;
    String clubName;
    int vote;
    String postTimestamp;
    public VoteCommentRequest(String timestamp,String postTimestamp, String subClubName, String clubName, int vote) {
        this.timestamp = timestamp;
        this.postTimestamp = postTimestamp;
        this.subClubName = subClubName;
        this.clubName = clubName;
        this.vote = vote;
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

    public int getVote() {
        return vote;
    }

    public void setVote(int vote) {
        this.vote = vote;
    }
}
