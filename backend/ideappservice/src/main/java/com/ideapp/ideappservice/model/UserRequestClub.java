package com.ideapp.ideappservice.model;

public class UserRequestClub {
    String name;
    String reason;
    String admin;


    public UserRequestClub(String name, String reason) {
        this.name = name;
        this.reason = reason;

    }
    public UserRequestClub(){}

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

}
