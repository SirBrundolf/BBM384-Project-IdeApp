package com.ideapp.ideappservice.model;

public class UserRequestSubClub {
    String name;
    String reason;
    String parentClub;
    String admin;

    public UserRequestSubClub(String name, String reason, String parentClub) {
        this.name = name;
        this.reason = reason;
        this.parentClub = parentClub;
    }
    public UserRequestSubClub(){}

    public String getName() {
        return name;
    }

    public String getAdmin() {
        return admin;
    }

    public void setAdmin(String admin) {
        this.admin = admin;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getParentClub() {
        return parentClub;
    }

    public void setParentClub(String parentClub) {
        this.parentClub = parentClub;
    }
}
