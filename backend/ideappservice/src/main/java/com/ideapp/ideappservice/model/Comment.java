package com.ideapp.ideappservice.model;

public class Comment {
    String content;
    String author;
    String timestamp;
    int vote;

    public Comment(){}

    public Comment(String content, String author, String timestamp,int vote) {
        this.content = content;
        this.vote = vote;
        this.author = author;
        this.timestamp = timestamp;
    }

    public String getContent() {
        return content;
    }
    

    public void setComment(String content) {
        this.content = content;
    }

    public int getVote() {
        return vote;
    }
    

    public void setVote(int vote) {
        this.vote = vote;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }
}
