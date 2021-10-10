package com.ideapp.ideappservice.model;

public class Question {
    String text;
    String id;
    String answer;
    String choose1;
    String choose2;
    String choose3;
    String choose4;
    public Question(){}

    public Question(String text, String answer, String choose1, String choose2, String choose3,String choose4) {
        this.text = text;
        this.answer = answer;
        this.choose1 = choose1;
        this.choose2 = choose2;
        this.choose3 = choose3;
        this.choose4 = choose4;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public String getChoose1() {
        return choose1;
    }

    public void setChoose1(String choose1) {
        this.choose1 = choose1;
    }

    public String getChoose2() {
        return choose2;
    }

    public void setChoose2(String choose2) {
        this.choose2 = choose2;
    }

    public String getChoose3() {
        return choose3;
    }

    public void setChoose3(String choose3) {
        this.choose3 = choose3;
    }

    public String getChoose4() {
        return choose4;
    }

    public void setChoose4(String choose4) {
        this.choose4 = choose4;
    }
}
