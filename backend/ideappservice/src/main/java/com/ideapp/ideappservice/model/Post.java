package com.ideapp.ideappservice.model;

public class Post {
    String author;
    String content;
    String title;
    int vote;
    String timestamp;

    public Post(String author, String content, String title, int vote, String timestamp) {
        this.author = author;
        this.timestamp = timestamp;
        this.title = title;
        this.content = content;
        this.vote = vote;
    }
    public Post(){}

    public String getTitle() {
        return title;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public String getAuthor() {
        return author;
    }

    public String getContent() {
        return content;
    }

    public int getVote() {
        return vote;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setVote(int vote) {
        this.vote = vote;
    }
}

