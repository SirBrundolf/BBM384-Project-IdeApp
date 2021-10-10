package com.ideapp.ideappservice.model;

public class PostRequest {
    Post post;
    String clubName;
    String subClubName;

    public PostRequest(Post post, String clubName, String subClubName) {
        this.post = post;
        this.clubName = clubName;
        this.subClubName = subClubName;
    }

    public Post getPost() {
        return post;
    }

    public void setPost(Post post) {
        this.post = post;
    }

    public String getClubName() {
        return clubName;
    }

    public void setClubName(String clubName) {
        this.clubName = clubName;
    }

    public String getSubClubName() {
        return subClubName;
    }

    public void setSubClubName(String subClubName) {
        this.subClubName = subClubName;
    }
}
