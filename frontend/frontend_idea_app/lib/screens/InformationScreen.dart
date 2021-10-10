import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_idea_app/main.dart';
import 'package:frontend_idea_app/models/AllModel.dart';
import 'package:http/http.dart';

class InformationScreen extends StatefulWidget {
  String clubName, subClubName, description;
  int vote;

  InformationScreen(
      this.clubName, this.subClubName, this.vote, this.description);

  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  int vote;
  bool votedUp = false;
  bool votedDown = false;
  Color votedUpColor = Colors.black;
  Color votedDownColor = Colors.black;

  @override
  void initState() {
    widget.vote != null ? vote = widget.vote : vote = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getInformation(),
      builder: (BuildContext context, AsyncSnapshot<SubClub> snapshot) {
        if (snapshot.hasData) {
          return Container(
            color: Color(0xFFDADADA),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    //height: 200,
                    //width: super.context.size.width,
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(snapshot.data.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_circle_up,
                            color: votedUpColor,
                          ),
                          onPressed: () {
                            if (!votedUp && !votedDown) {
                              vote++;
                              votedUp = true;
                              votedUpColor = Colors.red;
                            } else if (votedUp) {
                              vote--;
                              votedUp = false;
                              votedUpColor = Colors.black;
                            } else if (votedDown) {
                              vote += 2;
                              votedDown = false;
                              votedUp = true;
                              votedUpColor = Colors.red;
                              votedDownColor = Colors.black;
                            }
                            setState(() {
                              vote += 0;
                            });
                            setVote(vote);
                          },
                        ),
                        Text("$vote"),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_circle_down,
                            color: votedDownColor,
                          ),
                          onPressed: () {
                            if (!votedUp && !votedDown) {
                              vote--;
                              votedDown = true;
                              votedDownColor = Colors.red;
                            } else if (votedDown) {
                              vote++;
                              votedDown = false;
                              votedDownColor = Colors.black;
                            } else if (votedUp) {
                              vote -= 2;
                              votedDown = true;
                              votedUp = false;
                              votedDownColor = Colors.red;
                              votedUpColor = Colors.black;
                            }
                            setState(() {
                              vote += 0;
                            });
                            setVote(vote);
                          },
                        ),
                      ],
                    ),
                    Expanded(
                      //width: super.context.size.width * 0.8,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Text(snapshot.data.description),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else
          return Container();
      },
    );
  }

  void setVote(int vote) async {
    String url = 'http://' + localhost + ':8080/updatesubclubvote';
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Access-Control-Allow-Origin': '*'
    };
    String jsonBody = '{"clubName":"' +
        widget.clubName +
        '","subClubName":"' +
        widget.subClubName +
        '","vote":' +
        vote.toString() +
        '}';

    // make POST request
    await post(Uri.parse(url), headers: headers, body: jsonBody);
  }

  Future<SubClub> getInformation() async {
    String url = 'http://' + localhost + ':8080/getsubclub';
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Access-Control-Allow-Origin': '*'
    };
    String jsonBody = '{"clubName":"' +
        this.widget.clubName +
        '","subClubName":"' +
        this.widget.subClubName +
        '"}';

    // make POST request
    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonBody);
    SubClub subclub =
        SubClub.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    return subclub;
  }
}
