package com.ideapp.ideappservice.model;

public class JoinedClubRequest {
    JoinedClub joinedClub;
    String username;
    String description;

    public JoinedClubRequest(JoinedClub joinedClub, String username, String description) {
        this.joinedClub = joinedClub;
        this.username = username;
        this.description = description;
    }

    public String getUsername() {
        return username;
    }

    public JoinedClub getJoinedClub() {
        return joinedClub;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setJoinedClub(JoinedClub joinedClub) {
        this.joinedClub = joinedClub;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
