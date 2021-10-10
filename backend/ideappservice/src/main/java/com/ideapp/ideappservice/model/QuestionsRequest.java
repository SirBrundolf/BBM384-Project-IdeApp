package com.ideapp.ideappservice.model;

public class QuestionsRequest {
    Question[] questions;
    String clubName;
    String subClubName;

    public QuestionsRequest(Question[] questions, String clubName, String subClubName) {
        this.questions = questions;
        this.clubName = clubName;
        this.subClubName = subClubName;
    }

    public String getSubClubName() {
        return subClubName;
    }

    public String getClubName() {
        return clubName;
    }

    public Question[] getQuestions() {
        return questions;
    }
}
