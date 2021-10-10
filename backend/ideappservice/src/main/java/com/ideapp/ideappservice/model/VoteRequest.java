package com.ideapp.ideappservice.model;

public class VoteRequest {
    String timestamp;
    String subClubName;
    String clubName;
    int vote;

    public VoteRequest(String timestamp, String subClubName, String clubName, int vote) {
        this.timestamp = timestamp;
        this.subClubName = subClubName;
        this.clubName = clubName;
        this.vote = vote;
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

    public int getVote() {
        return vote;
    }

    public void setVote(int vote) {
        this.vote = vote;
    }
}
