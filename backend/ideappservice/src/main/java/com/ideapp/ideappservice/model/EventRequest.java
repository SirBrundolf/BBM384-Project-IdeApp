package com.ideapp.ideappservice.model;

public class EventRequest {
    Event event;
    String clubName;
    String subClubName;

    public EventRequest(Event event, String clubName, String subClubName) {
        this.event = event;
        this.clubName = clubName;
        this.subClubName = subClubName;
    }
    public EventRequest(){}

    public Event getEvent() {
        return event;
    }

    public void setEvent(Event event) {
        this.event = event;
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
