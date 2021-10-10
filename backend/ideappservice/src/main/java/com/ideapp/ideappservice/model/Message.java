package com.ideapp.ideappservice.model;

import java.util.HashMap;
import java.util.Map;

public class Message {
    String text;
    String timestamp;
    Map<String, Boolean> visibility;
    String whoSent;
    public Message(){}

    public Message(String text, String timestamp, Map<String, Boolean> visibility,String whoSent) {
        this.text = text;
        this.timestamp = timestamp;
        this.visibility = visibility;
        this.whoSent = whoSent;
    }

    public String getWhoSent() {
        return whoSent;
    }

    public void setWhoSent(String whoSent) {
        this.whoSent = whoSent;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public Map<String, Boolean> getVisibility() {
        return visibility;
    }

    public void setVisibility(HashMap<String, Boolean> visibility) {
        this.visibility = visibility;
    }
}
