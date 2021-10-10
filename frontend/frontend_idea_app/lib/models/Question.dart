class Question {
  String question, option1, option2, option3, option4, answer;
  bool answered = false;

  Question(this.question, this.option1, this.option2, this.option3,
      this.option4, this.answer);

  void setQue(String q) {
    this.question = q;
  }

  void setOpt1(String q) {
    this.option1 = q;
  }

  void setOpt2(String q) {
    this.option2 = q;
  }

  void setOpt3(String q) {
    this.option3 = q;
  }

  void setOpt4(String q) {
    this.option4 = q;
  }

  void setAns(String q) {
    this.answer = q;
  }

  Question.fromJson(Map<String, dynamic> json)
      : question = json['text'],
        option1 = json['choose1'],
        option2 = json['choose2'],
        option3 = json["choose3"],
        option4 = json["choose4"],
        answer = json["answer"],
        answered = false;

  Map<String, dynamic> toJson() => {
        'text': this.question,
        'answer': this.answer,
        'choose1': this.option1,
        'choose2': this.option2,
        'choose3': this.option3,
        'choose4': this.option4
      };
}
