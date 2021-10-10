package com.ideapp.ideappservice.model;

public class MessageDeleteRequest {
    MessageSendRequest messageSendRequest;
    String timestamp;
    String sender;
    String receiver;
    public MessageDeleteRequest(){

    }

    public MessageDeleteRequest(MessageSendRequest messageSendRequest, String timestamp) {
        this.messageSendRequest = messageSendRequest;
        this.timestamp = timestamp;
    }

    public MessageSendRequest getMessageSendRequest() {
        return messageSendRequest;
    }

    public void setMessageSendRequest(MessageSendRequest messageSendRequest) {
        this.messageSendRequest = messageSendRequest;
    }

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
