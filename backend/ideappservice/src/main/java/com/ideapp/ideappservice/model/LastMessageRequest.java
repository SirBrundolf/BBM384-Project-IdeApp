package com.ideapp.ideappservice.model;

public class LastMessageRequest {
    String timestamp;
    String sender;
    String receiver;
   // String firstTimestamp;

    public LastMessageRequest(String timestamp, String sender, String receiver) {
        this.timestamp = timestamp;
        this.sender = sender;
        this.receiver = receiver;
    }

//    public String getFirstTimestamp() {
//        return firstTimestamp;
//    }
//
//    public void setFirstTimestamp(String firstTimestamp) {
//        this.firstTimestamp = firstTimestamp;
//    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public String getReceiver() {
        return receiver;
    }

    public void setReceiver(String receiver) {
        this.receiver = receiver;
    }
}
