import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_idea_app/core/CoreAll.dart';
import 'package:frontend_idea_app/main.dart';
import 'package:frontend_idea_app/models/AllModel.dart';
import 'package:http/http.dart';
import 'package:frontend_idea_app/screens/MainPage.dart';
import 'AppLogo.dart';

List<GlobalKey<FormState>> formKeys = [
  GlobalKey<FormState>(),
  GlobalKey<FormState>(),
  GlobalKey<FormState>(),
  GlobalKey<FormState>(),
  GlobalKey<FormState>(),
  GlobalKey<FormState>(),
  GlobalKey<FormState>(),
  GlobalKey<FormState>(),
  GlobalKey<FormState>(),
  GlobalKey<FormState>(),
];

class SubmitQuestions extends StatefulWidget {
  final String parentClubName, subClubName, imageUrl;

  const SubmitQuestions(this.parentClubName, this.subClubName, this.imageUrl);

  @override
  State<StatefulWidget> createState() {
    return MyAppScreenMode(parentClubName, subClubName, imageUrl);
  }
}

class MyAppScreenMode extends State<SubmitQuestions> {
  final String parentClubName, subClubName, imageUrl;

  MyAppScreenMode(this.parentClubName, this.subClubName, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: BackButton(
              color: Colors.black54,
            ),
            title: AppLogo(),
            brightness: Brightness.light,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          body:
              StepperBody(this.parentClubName, this.subClubName, this.imageUrl),
        ));
  }
}

class StepperBody extends StatefulWidget {
  final String parentClubName, subClubName, imageUrl;
  int glbsts = 200;

  StepperBody(this.parentClubName, this.subClubName, this.imageUrl);

  @override
  _StepperBodyState createState() =>
      _StepperBodyState(this.parentClubName, this.subClubName, this.imageUrl);
}

class _StepperBodyState extends State<StepperBody> {
  final String parentClubName, subClubName, imageUrl;
  static TextEditingController _qu1 = TextEditingController();
  static TextEditingController _o11 = TextEditingController();
  static TextEditingController _o21 = TextEditingController();
  static TextEditingController _o31 = TextEditingController();
  static TextEditingController _o41 = TextEditingController();
  static TextEditingController _ans1 = TextEditingController();
///////////////////////////////////////
  static TextEditingController _qu2 = TextEditingController();
  static TextEditingController _o12 = TextEditingController();
  static TextEditingController _o22 = TextEditingController();
  static TextEditingController _o32 = TextEditingController();
  static TextEditingController _o42 = TextEditingController();
  static TextEditingController _ans2 = TextEditingController();
///////////////////////////////////////
  static TextEditingController _qu3 = TextEditingController();
  static TextEditingController _o13 = TextEditingController();
  static TextEditingController _o23 = TextEditingController();
  static TextEditingController _o33 = TextEditingController();
  static TextEditingController _o43 = TextEditingController();
  static TextEditingController _ans3 = TextEditingController();
///////////////////////////////////////
  static TextEditingController _qu4 = TextEditingController();
  static TextEditingController _o14 = TextEditingController();
  static TextEditingController _o24 = TextEditingController();
  static TextEditingController _o34 = TextEditingController();
  static TextEditingController _o44 = TextEditingController();
  static TextEditingController _ans4 = TextEditingController();
///////////////////////////////////////
  static TextEditingController _qu5 = TextEditingController();
  static TextEditingController _o15 = TextEditingController();
  static TextEditingController _o25 = TextEditingController();
  static TextEditingController _o35 = TextEditingController();
  static TextEditingController _o45 = TextEditingController();
  static TextEditingController _ans5 = TextEditingController();
///////////////////////////////////////
  static TextEditingController _qu6 = TextEditingController();
  static TextEditingController _o16 = TextEditingController();
  static TextEditingController _o26 = TextEditingController();
  static TextEditingController _o36 = TextEditingController();
  static TextEditingController _o46 = TextEditingController();
  static TextEditingController _ans6 = TextEditingController();
///////////////////////////////////////
  static TextEditingController _qu7 = TextEditingController();
  static TextEditingController _o17 = TextEditingController();
  static TextEditingController _o27 = TextEditingController();
  static TextEditingController _o37 = TextEditingController();
  static TextEditingController _o47 = TextEditingController();
  static TextEditingController _ans7 = TextEditingController();
///////////////////////////////////////
  static TextEditingController _qu8 = TextEditingController();
  static TextEditingController _o18 = TextEditingController();
  static TextEditingController _o28 = TextEditingController();
  static TextEditingController _o38 = TextEditingController();
  static TextEditingController _o48 = TextEditingController();
  static TextEditingController _ans8 = TextEditingController();
///////////////////////////////////////
  static TextEditingController _qu9 = TextEditingController();
  static TextEditingController _o19 = TextEditingController();
  static TextEditingController _o29 = TextEditingController();
  static TextEditingController _o39 = TextEditingController();
  static TextEditingController _o49 = TextEditingController();
  static TextEditingController _ans9 = TextEditingController();
///////////////////////////////////////
  static TextEditingController _qu0 = TextEditingController();
  static TextEditingController _o10 = TextEditingController();
  static TextEditingController _o20 = TextEditingController();
  static TextEditingController _o30 = TextEditingController();
  static TextEditingController _o40 = TextEditingController();
  static TextEditingController _ans0 = TextEditingController();
  int currStep = 0;
  static var _focusNode = FocusNode();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _StepperBodyState(this.parentClubName, this.subClubName, this.imageUrl);

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
      print('Has focus: $_focusNode.hasFocus');
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  var alert = AlertDialog(
    title: Text("Details"),
    content: SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          Text("Q1"),
          Text("Q2"),
          Text("Q3"),
          Text("Q4"),
          Text("Q5"),
          Text("Q6"),
        ],
      ),
    ),
    actions: <Widget>[
      FlatButton(
        child: Text('OK'),
        onPressed: () {
          // TODO: Connection to database
          //Navigator.of(context).pop();
        },
      ),
    ],
  );

  List<Step> steps = [
    Step(
        title: const Text('Question 1'),
        isActive: true,
        state: StepState.indexed,
        content: Form(
          key: formKeys[0],
          child: Column(
            children: <Widget>[
              TextFormField(
                focusNode: _focusNode,
                keyboardType: TextInputType.text,
                autocorrect: false,
                controller: _qu1,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter question';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter your question',
                    hintText: 'Enter a question',
                    icon: const Icon(Icons.question_answer),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _o11,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter first choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the first choice',
                    hintText: 'Enter the first choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _o21,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the second choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the second choice',
                    hintText: 'Enter the second choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _o31,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the third choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the third choice',
                    hintText: 'Enter the third choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _o41,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the fourth choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the fourth choice',
                    hintText: 'Enter the fourth choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                autocorrect: false,
                controller: _ans1,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the answer';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the answer',
                    hintText: 'Enter the answer',
                    icon: const Icon(Icons.done_all_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              )
            ],
          ),
        )),
    Step(
        title: const Text('Question 2'),
        isActive: true,
        state: StepState.indexed,
        content: Form(
          key: formKeys[1],
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _qu2,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter question';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter your question',
                    hintText: 'Enter a question',
                    icon: const Icon(Icons.question_answer_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _o12,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter first choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the first choice',
                    hintText: 'Enter the first choice',
                    icon: const Icon(Icons.grain),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _o22,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the second choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the second choice',
                    hintText: 'Enter the second choice',
                    icon: const Icon(Icons.grain),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _o32,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the third choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the third choice',
                    hintText: 'Enter the third choice',
                    icon: const Icon(Icons.grain),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _o42,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the fourth choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the fourth choice',
                    hintText: 'Enter the fourth choice',
                    icon: const Icon(Icons.grain),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _ans2,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the answer';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the answer',
                    hintText: 'Enter the answer',
                    icon: const Icon(Icons.done_all_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              )
            ],
          ),
        )),
    Step(
        title: const Text('Question 3'),
        isActive: true,
        state: StepState.indexed,
        content: Form(
          key: formKeys[2],
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                controller: _qu3,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter question';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter your question',
                    hintText: 'Enter a question',
                    icon: const Icon(Icons.question_answer_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _o13,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter first choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the first choice',
                    hintText: 'Enter the first choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _o23,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the second choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the second choice',
                    hintText: 'Enter the second choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _o33,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the third choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the third choice',
                    hintText: 'Enter the third choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _o43,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the fourth choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the fourth choice',
                    hintText: 'Enter the fourth choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _ans3,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the answer';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the answer',
                    hintText: 'Enter the answer',
                    icon: const Icon(Icons.done_all_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              )
            ],
          ),
        )),
    Step(
        title: const Text('Question 4'),
        isActive: true,
        state: StepState.indexed,
        content: Form(
          key: formKeys[3],
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _qu4,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter question';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter your question',
                    hintText: 'Enter a question',
                    icon: const Icon(Icons.question_answer_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _o14,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter first choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the first choice',
                    hintText: 'Enter the first choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _o24,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the second choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the second choice',
                    hintText: 'Enter the second choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _o34,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the third choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the third choice',
                    hintText: 'Enter the third choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _o44,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the fourth choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the fourth choice',
                    hintText: 'Enter the fourth choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _ans4,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the answer';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the answer',
                    hintText: 'Enter the answer',
                    icon: const Icon(Icons.done_all_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              )
            ],
          ),
        )),
    Step(
        title: const Text('Question 5'),
        isActive: true,
        state: StepState.indexed,
        content: Form(
          key: formKeys[4],
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _qu5,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter question';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter your question',
                    hintText: 'Enter a question',
                    icon: const Icon(Icons.question_answer_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _o15,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter first choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the first choice',
                    hintText: 'Enter the first choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _o25,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the second choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the second choice',
                    hintText: 'Enter the second choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _o35,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the third choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the third choice',
                    hintText: 'Enter the third choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _o45,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the fourth choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the fourth choice',
                    hintText: 'Enter the fourth choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _ans5,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the answer';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the answer',
                    hintText: 'Enter the answer',
                    icon: const Icon(Icons.done_all_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              )
            ],
          ),
        )),
    Step(
        title: const Text('Question 6'),
        isActive: true,
        state: StepState.indexed,
        content: Form(
          key: formKeys[5],
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _qu6,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter question';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter your question',
                    hintText: 'Enter a question',
                    icon: const Icon(Icons.question_answer_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _o16,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter first choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the first choice',
                    hintText: 'Enter the first choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _o26,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the second choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the second choice',
                    hintText: 'Enter the second choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _o36,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the third choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the third choice',
                    hintText: 'Enter the third choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _o46,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the fourth choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the fourth choice',
                    hintText: 'Enter the fourth choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _ans6,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the answer';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the answer',
                    hintText: 'Enter the answer',
                    icon: const Icon(Icons.done_all_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              )
            ],
          ),
        )),
    Step(
        title: const Text('Question 7'),
        isActive: true,
        state: StepState.indexed,
        content: Form(
          key: formKeys[6],
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _qu7,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter question';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter your question',
                    hintText: 'Enter a question',
                    icon: const Icon(Icons.question_answer_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _o17,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter first choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the first choice',
                    hintText: 'Enter the first choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _o27,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the second choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the second choice',
                    hintText: 'Enter the second choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _o37,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the third choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the third choice',
                    hintText: 'Enter the third choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _o47,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the fourth choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the fourth choice',
                    hintText: 'Enter the fourth choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _ans7,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the answer';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the answer',
                    hintText: 'Enter the answer',
                    icon: const Icon(Icons.done_all_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              )
            ],
          ),
        )),
    Step(
        title: const Text('Question 8'),
        isActive: true,
        state: StepState.indexed,
        content: Form(
          key: formKeys[7],
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _qu8,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter question';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter your question',
                    hintText: 'Enter a question',
                    icon: const Icon(Icons.question_answer_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _o18,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter first choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the first choice',
                    hintText: 'Enter the first choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _o28,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the second choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the second choice',
                    hintText: 'Enter the second choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _o38,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the third choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the third choice',
                    hintText: 'Enter the third choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _o48,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the fourth choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the fourth choice',
                    hintText: 'Enter the fourth choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _ans8,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the answer';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the answer',
                    hintText: 'Enter the answer',
                    icon: const Icon(Icons.done_all_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              )
            ],
          ),
        )),
    Step(
        title: const Text('Question 9'),
        isActive: true,
        state: StepState.indexed,
        content: Form(
          key: formKeys[8],
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _qu9,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter question';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter your question',
                    hintText: 'Enter a question',
                    icon: const Icon(Icons.question_answer_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _o19,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter first choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the first choice',
                    hintText: 'Enter the first choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _o29,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the second choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the second choice',
                    hintText: 'Enter the second choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _o39,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the third choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the third choice',
                    hintText: 'Enter the third choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _o49,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the fourth choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the fourth choice',
                    hintText: 'Enter the fourth choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _ans9,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the answer';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the answer',
                    hintText: 'Enter the answer',
                    icon: const Icon(Icons.done_all_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              )
            ],
          ),
        )),
    Step(
        title: const Text('Question 10'),
        isActive: true,
        state: StepState.indexed,
        content: Form(
          key: formKeys[9],
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _qu0,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter question';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter your question',
                    hintText: 'Enter a question',
                    icon: const Icon(Icons.question_answer_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _o10,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter first choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the first choice',
                    hintText: 'Enter the first choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _o20,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the second choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the second choice',
                    hintText: 'Enter the second choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                  controller: _o30,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  onSaved: (String value) {},
                  maxLines: 1,
                  validator: (value) {
                    if (value.isEmpty || value.length < 1) {
                      return 'Please enter the third choice';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Enter the third choice',
                      hintText: 'Enter the third choice',
                      icon: const Icon(Icons.grain_outlined),
                      labelStyle: TextStyle(
                          decorationStyle: TextDecorationStyle.solid))),
              TextFormField(
                controller: _o40,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the fourth choice';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the fourth choice',
                    hintText: 'Enter the fourth choice',
                    icon: const Icon(Icons.grain_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              ),
              TextFormField(
                controller: _ans0,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {},
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter the answer';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Enter the answer',
                    hintText: 'Enter the answer',
                    icon: const Icon(Icons.done_all_outlined),
                    labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
              )
            ],
          ),
        )),
  ];

  @override
  Widget build(BuildContext context) {
    void showSnackBarMessage(String message, MaterialColor color) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: color,
      ));
    }

    void submitQue() {
      bool valid = true;
      for (int i = 0; i < formKeys.length; i++) {
        valid = valid && formKeys[i].currentState.validate();
      }
      final FormState formState = _formKey.currentState;
      print(formState);

      if (!valid) {
        MaterialColor color = Colors.blue;
        showSnackBarMessage('Please enter correct data', color);
      } else {
        print("controller: " + _qu1.text);
        postQuestionAndSubClub(widget);
      }
    }

    return Container(
        child: Form(
      key: _formKey,
      child: ListView(scrollDirection: Axis.vertical, children: <Widget>[
        Stepper(
          physics: ClampingScrollPhysics(),
          steps: steps,
          type: StepperType.vertical,
          currentStep: this.currStep,
          onStepContinue: () {
            setState(() {
              if (formKeys[currStep].currentState.validate()) {
                if (currStep < steps.length - 1) {
                  currStep = currStep + 1;
                } else {
                  currStep = 0;
                }
              }
            });
          },
          onStepCancel: () {
            setState(() {
              if (currStep > 0) {
                currStep = currStep - 1;
              } else {
                currStep = 0;
              }
            });
          },
          onStepTapped: (step) {
            setState(() {
              currStep = step;
            });
          },
        ),
        SizedBox(
          height: 5,
        ),
        Center(
          child: GestureDetector(
            child: RaisedButton(
              color: Colors.blue,
              shape: StadiumBorder(),
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 30,
              ),
              onPressed: submitQue,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ]),
    ));
  }

  void postQuestionAndSubClub(widget) async {
    var sc = postSubClub(widget);
    List<Question> ques = [];
    var qu = [_qu1, _qu2, _qu3, _qu4, _qu5, _qu6, _qu7, _qu8, _qu9, _qu0];
    var op1 = [_o11, _o12, _o13, _o14, _o15, _o16, _o17, _o18, _o19, _o10];
    var op2 = [_o21, _o22, _o23, _o24, _o25, _o26, _o27, _o28, _o29, _o20];
    var op3 = [_o31, _o32, _o33, _o34, _o35, _o36, _o37, _o38, _o39, _o30];
    var op4 = [_o41, _o42, _o43, _o44, _o45, _o46, _o47, _o48, _o49, _o40];
    var ans = [
      _ans1,
      _ans2,
      _ans3,
      _ans4,
      _ans5,
      _ans6,
      _ans7,
      _ans8,
      _ans9,
      _ans0
    ];
    for (int i = 0; i < 10; i++) {
      Question q = new Question(qu[i].text, ans[i].text, op1[i].text,
          op2[i].text, op3[i].text, op4[i].text);
      q.question = qu[i].text;
      q.option1 = op1[i].text;
      q.option2 = op2[i].text;
      q.option3 = op3[i].text;
      q.option4 = op4[i].text;
      q.answer = ans[i].text;
      ques.add(q);
    }
    postQuestion(sc, ques, widget);
    if (widget.glbsts == 200) {
      final snackBar = SnackBar(
        content: Text('Questions are saved to our database'),
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text('An error occured when saving process'),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => MainPage()));
  }
}

Future<SubClub> postSubClub(widget) async {
  String url = 'http://' + localhost + ':8080/addsubclub';
  Map<String, String> headers = {"Content-type": "application/json"};
  String jsonBody = '{"clubName":' +
      '"' +
      widget.parentClubName +
      '"' +
      ', "name":' +
      '"' +
      widget.subClubName +
      '",' +
      '"imageUrl":' +
      '"' +
      widget.imageUrl +
      '"' +
      '}';
  // make POST request
  Response response =
      await post(Uri.parse(url), headers: headers, body: jsonBody);

  SubClub subClub = SubClub.fromJson(json.decode(response.body)[1]);

  return subClub;
}

void postQuestion(sc, ques, widget) async {
  String url = 'http://' + localhost + ':8080/addquestion';
  Map<String, String> headers = {"Content-type": "application/json"};
  String questions = jsonEncode(ques);
  questions = '{"questions" :' +
      questions +
      ',"clubName":' +
      '"' +
      widget.parentClubName +
      '"' +
      ',"subClubName" :' +
      '"' +
      widget.subClubName +
      '"' +
      '}';
  Response response =
      await post(Uri.parse(url), headers: headers, body: questions);
  widget.glbsts = response.statusCode;
}
