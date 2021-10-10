import 'package:flutter/material.dart';
import 'package:frontend_idea_app/main.dart';
import 'package:frontend_idea_app/screens/EMailVerification.dart';
import 'package:frontend_idea_app/core/AppLogo.dart';
import 'package:frontend_idea_app/SharedPref.dart';
import 'package:frontend_idea_app/User.dart';
import 'package:http/http.dart';

class Candidate extends StatefulWidget {
  String clubName, subClubName;

  Candidate(this.clubName, this.subClubName);

  @override
  _CandidateState createState() => _CandidateState();
}

class _CandidateState extends State<Candidate> {
  final verificationController = TextEditingController();
  final reasonController = TextEditingController();
  final validator = GlobalKey<FormState>();
  User user;
  @override
  initState() {
    SharedPref().read("user").then((value) => {user = User.fromJson(value)});
    super.initState();
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
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 100, 20, 10),
        child: Form(
          key: validator,
          child: Column(
            children: [
              TextFormField(
                controller: reasonController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFFFFFFF),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.grey,
                      size: 30,
                    ),
                    hintText: "Enter your reason:",
                    hintStyle: TextStyle(fontWeight: FontWeight.bold),
                    contentPadding: EdgeInsets.all(15)),
                validator: (String password) {
                  if (password == null || password.isEmpty) {
                    return "This field cannot be empty";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 80,
              ),
              RaisedButton(
                onPressed: () async {
                  if (validator.currentState.validate()) {
                    addCandidate();
                    Navigator.pop(context);
                  }
                },
                child: Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addCandidate() async {
    String url = 'http://' + localhost + ':8080/addcandidate';
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Access-Control-Allow-Origin': '*'
    };
    String jsonBody = ' {"username" :"' +
        user.username +
        '","clubName" :"' +
        widget.clubName +
        '","subClubName" :"' +
        widget.subClubName +
        '","reason" :"' +
        reasonController.text +
        '"}';

    // make POST request
    await post(Uri.parse(url), headers: headers, body: jsonBody);
  }
}
