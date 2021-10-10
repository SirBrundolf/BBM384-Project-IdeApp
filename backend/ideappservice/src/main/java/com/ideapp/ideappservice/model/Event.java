package com.ideapp.ideappservice.model;

public class Event {
    String name;
    String timestamp;
    String date;

    public Event(String name,String timestamp,String date){
        this.name = name;
        this.timestamp = timestamp;
        this.date = date;
    }
    public Event(){}

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getName() {
        return name;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setName(String eventName) {
        this.name = eventName;
    }

    public void setTimestamp(String time) {
        this.timestamp = time;
    }
}
