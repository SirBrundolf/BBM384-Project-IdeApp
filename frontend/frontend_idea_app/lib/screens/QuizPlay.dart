import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_idea_app/models/AllModel.dart';
import 'package:frontend_idea_app/core/CoreAll.dart';
import 'package:frontend_idea_app/screens/MainPage.dart';
import 'package:frontend_idea_app/widgets/AllWidgets.dart';
import 'package:frontend_idea_app/SharedPref.dart';
import 'package:http/http.dart';

class QuizPlay extends StatefulWidget {
  final String subClub;
  final String parentClubName;
  final String imageUrl;
  final String description;

  QuizPlay(this.parentClubName, this.subClub, this.imageUrl, this.description);

  @override
  _QuizPlayState createState() =>
      _QuizPlayState(subClub, parentClubName, imageUrl);
}

int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;
int _total = 10;

class _QuizPlayState extends State<QuizPlay> {
  final String subClub;
  final String parentClubName;
  final String imageUrl;
  Future<List<Question>> questions;

  _QuizPlayState(this.subClub, this.parentClubName, this.imageUrl);
  @override
  void initState() {
    super.initState();
    questions = _getQuestions(widget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black54,
        ),
        title: AppLogo(),
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              FutureBuilder(
                future: questions,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Question>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: 10,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (BuildContext context, index) {
                        return QuizPlayTile(
                            Question(
                                snapshot.data[index].question,
                                snapshot.data[index].option1,
                                snapshot.data[index].option2,
                                snapshot.data[index].option3,
                                snapshot.data[index].option4,
                                snapshot.data[index].answer),
                            index);
                      },
                    );
                  } else {
                    return Text("NO DATA");
                  }
                },
              ),
              SizedBox(
                height: 8,
              ),
              Center(
                child: GestureDetector(
                  child: RaisedButton(
                    color: Colors.blue.withOpacity(0.8),
                    shape: StadiumBorder(),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: _submit,
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              )
            ],
          ),
        ),
      ),
    );
  }

  _submit() {
    if (_correct >= 5) {
      final snackBar = SnackBar(
        content: Text('Yay you made it!'),
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 3),
      );
      _joinClub();
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => MainPage()));
    } else {
      final snackBar = SnackBar(
        content: Text('Maybe you should try something else'),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => MainPage()));
    }
  }

  Future _joinClub() async {
    var readedUser = await SharedPref().read("user");
    String url = 'http://127.0.0.1:8080/addjoinedclub';
    //String url = 'http://10.0.2.2:8080/addjoinedclub';
    Map<String, String> headers = {"Content-type": "application/json"};
    String jsonBody = '{"joinedClub":{"clubName":"' +
        widget.subClub +
        '","parentClub":"' +
        widget.parentClubName +
        '","imageUrl":"' +
        widget.imageUrl +
        '","description":"' +
        widget.description +
        '"}, "username":"' +
        readedUser["username"] +
        '"}';

    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonBody);
  }

  Future<List<Question>> _getQuestions(widget) async {
    String url = 'http://127.0.0.1:8080/getquestions';
    //String url = 'http://10.0.2.2:8080/getquestions';
    Map<String, String> headers = {"Content-type": "application/json"};

    String questions = '{"questions" :' +
        '[]' +
        ',"clubName":' +
        '"' +
        widget.parentClubName +
        '"' +
        ',"subClubName" :' +
        '"' +
        widget.subClub +
        '"' +
        '}';
    //print(questions);
    Response response =
        await post(Uri.parse(url), headers: headers, body: questions);
    //print(response.body);
    Iterable clubListIter = json.decode(utf8.decode(response.bodyBytes));
    List<Question> clubList = List<Question>.from(
        clubListIter.map((model) => Question.fromJson(model)));

    return clubList;
  }
}

class QuizPlayTile extends StatefulWidget {
  final Question question;
  final int index;

  const QuizPlayTile(this.question, this.index);
  @override
  _QuizPlayTileState createState() => _QuizPlayTileState(question, index);
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  final Question question;
  final int index;
  String selected = "";

  _QuizPlayTileState(this.question, this.index);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text(
              "Q-${widget.index + 1} ${widget.question.question}",
              style:
                  TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.8)),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.question.answered) {
                if (widget.question.option1 == widget.question.answer) {
                  setState(() {
                    selected = widget.question.option1;
                    widget.question.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted + 1;
                  });
                } else {
                  setState(() {
                    selected = widget.question.option1;
                    widget.question.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                }
              }
            },
            child: OptionTile(
              option: "A",
              text: widget.question.option1,
              correct: widget.question.answer,
              selected: selected,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.question.answered) {
                if (widget.question.option2 == widget.question.answer) {
                  setState(() {
                    selected = widget.question.option2;
                    widget.question.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted + 1;
                  });
                } else {
                  setState(() {
                    selected = widget.question.option2;
                    widget.question.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                }
              }
            },
            child: OptionTile(
              option: "B",
              text: widget.question.option2,
              correct: widget.question.answer,
              selected: selected,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.question.answered) {
                if (widget.question.option3 == widget.question.answer) {
                  setState(() {
                    selected = widget.question.option3;
                    widget.question.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted + 1;
                  });
                } else {
                  setState(() {
                    selected = widget.question.option3;
                    widget.question.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                }
              }
            },
            child: OptionTile(
              option: "C",
              text: widget.question.option3,
              correct: widget.question.answer,
              selected: selected,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.question.answered) {
                if (widget.question.option4 == widget.question.answer) {
                  setState(() {
                    selected = widget.question.option4;
                    widget.question.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted + 1;
                  });
                } else {
                  setState(() {
                    selected = widget.question.option4;
                    widget.question.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                }
              }
            },
            child: OptionTile(
              option: "D",
              text: widget.question.option4,
              correct: widget.question.answer,
              selected: selected,
            ),
          ),
          SizedBox(
            height: 4,
          ),
        ],
      ),
    );
  }
}
