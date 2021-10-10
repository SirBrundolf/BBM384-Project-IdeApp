import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_idea_app/SharedPref.dart';
import 'package:frontend_idea_app/User.dart';
import 'package:frontend_idea_app/main.dart';
import 'package:frontend_idea_app/screens/Candidate.dart';
import 'package:frontend_idea_app/screens/MemberPage.dart';
import 'package:frontend_idea_app/screens/MessageScreen.dart';
import 'package:frontend_idea_app/screens/SignIn.dart';
import 'package:http/http.dart';

class Members extends StatefulWidget {
  final String clubName, subClubName;
  Members(this.clubName, this.subClubName);

  @override
  _MembersState createState() => _MembersState();
}

class _MembersState extends State<Members> {
  User user;
  @override
  void initState() {
    SharedPref()
        .read("user")
        .then((value) => user = value == null ? null : User.fromJson(value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getMembers(),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Candidate(widget.clubName, widget.subClubName),
                      ),
                    );
                    // ignore: unused_element
                    setState() {}
                  },
                  child: Text("Request to be SubClub Admin"),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 50,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(5),
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(snapshot.data[index]),
                          snapshot.data[index] == user.username
                              ? Container()
                              : IconButton(
                                  icon: Icon(Icons.message),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MessageScreen(
                                          user.username,
                                          snapshot.data[index],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                          snapshot.data[index] == user.username
                              ? Container()
                              : IconButton(
                                  icon: Icon(Icons.account_circle_rounded),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MemberPage(snapshot.data[index]),
                                      ),
                                    );
                                  },
                                ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  Future<List<String>> getMembers() async {
    String url = 'http://' + localhost + ':8080/getregisteredusers';
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Access-Control-Allow-Origin': '*'
    };
    String jsonBody = '{"clubName":"' +
        widget.clubName +
        '","subClubName":"' +
        widget.subClubName +
        '"}';

    // make POST request
    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonBody);
    Iterable memberListIter = json.decode(utf8.decode(response.bodyBytes));
    List<String> memberList = List<String>.from(memberListIter);
    return memberList;
  }
}
