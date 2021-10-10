package com.ideapp.ideappservice.model;

public class Request {
    String name;
    String reason;
    String parentClub;

    public Request(String name, String reason, String parentClub) {
        this.name = name;
        this.reason = reason;
        this.parentClub = parentClub;
    }
    public Request(){}

    public String getName() {
        return name;
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
