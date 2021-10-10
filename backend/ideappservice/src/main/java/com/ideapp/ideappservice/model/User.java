package com.ideapp.ideappservice.model;

public class User {
    String username;
    String mailAddress;
    String imageUrl;
    int isAdmin;
    String surname;
    String name;
    long id;
    int signStatus;
    boolean isVerified;
    public User(String username, String mailAddress, String imageUrl, int isAdmin, String name, String surname){
        this.isAdmin = isAdmin;
        this.imageUrl = imageUrl;
        this.mailAddress = mailAddress;
        this.username = username;
        this.name = name;
        this.surname = surname;
    }
    public User(){}

    public String getUsername() {
        return username;
    }

    public int getIsAdmin() {
        return isAdmin;
    }

    public String getImageUrl() { return imageUrl; }

    public long getId() {
        return id;
    }

    public void setSignStatus(int signStatus) {
        this.signStatus = signStatus;
    }

    public String getName() {
        return name;
    }

    public String getSurname() {
        return surname;
    }

    public void setId(long id) {
        this.id = id;
    }

    public int getSignStatus() {
        return signStatus;
    }

    public void setVerified(boolean verified) {
        isVerified = verified;
    }

    public boolean isVerified() {
        return isVerified;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getMailAddress() {
        return mailAddress;
    }

    public void setMailAddress(String mailAddress) {
        this.mailAddress = mailAddress;
    }

    public void setIsAdmin(int isAdmin) {
        this.isAdmin = isAdmin;
    }

    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public void setName(String name) {
        this.name = name;
    }
}
