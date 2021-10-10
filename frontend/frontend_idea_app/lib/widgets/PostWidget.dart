import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_idea_app/main.dart';
import 'package:frontend_idea_app/models/Comment.dart';
import 'package:frontend_idea_app/screens/AddComment.dart';
import 'package:frontend_idea_app/screens/EditPost.dart';
import 'package:frontend_idea_app/widgets/CommentWidget.dart';
import 'package:frontend_idea_app/screens/JoinedClubScreen.dart';
import 'package:http/http.dart';

// ignore: must_be_immutable
class PostWidget extends StatefulWidget {
  final String author,
      title,
      content,
      timestamp,
      clubName,
      subClubName,
      username;
  int vote;

  PostWidget(this.author, this.title, this.content, this.vote, this.timestamp,
      this.clubName, this.subClubName, this.username);

  @override
  _PostWidgetState createState() => _PostWidgetState(vote);
}

class _PostWidgetState extends State<PostWidget> {
  int vote;
  bool votedUp = false;
  bool votedDown = false;
  bool reported = false;
  Color votedUpColor = Colors.black;
  Color votedDownColor = Colors.black;
  Color flagColor = Colors.black;
  bool isExpanded = false;

  _PostWidgetState(this.vote);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Column(
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
                    setVote(widget.clubName, widget.subClubName,
                        widget.timestamp, vote);
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
                    setVote(widget.clubName, widget.subClubName,
                        widget.timestamp, vote);
                  },
                ),
                widget.username == widget.author
                    ? IconButton(
                        icon: Icon(Icons.edit_outlined),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditPost(
                                widget.clubName,
                                widget.subClubName,
                                widget.timestamp,
                                widget.content,
                              ),
                            ),
                          );
                        },
                      )
                    : Container(),
                IconButton(
                  icon: Icon(
                    Icons.flag,
                    color: flagColor,
                  ),
                  onPressed: reported
                      ? null
                      : () {
                          setState(() {
                            flagColor = Colors.red;
                            reportUser();
                            reported = true;
                          });
                        },
                ),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.black),
                          left: BorderSide(color: Colors.black),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(widget.author),
                          ConstrainedBox(
                            constraints: isExpanded
                                ? new BoxConstraints()
                                : new BoxConstraints(maxHeight: 45),
                            child: Text(
                              widget.title,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ConstrainedBox(
                      constraints: isExpanded
                          ? new BoxConstraints()
                          : new BoxConstraints(
                              maxHeight: 165,
                              minHeight: 165,
                            ),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(color: Colors.black),
                            bottom: BorderSide(color: Colors.black),
                          ),
                        ),
                        child: Text(
                          widget.content,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ConstrainedBox(
                      constraints: isExpanded
                          ? new BoxConstraints()
                          : new BoxConstraints(maxHeight: 0),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(color: Colors.black),
                          ),
                        ),
                        child: FutureBuilder(
                          future: getComments(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List<Comment>> snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                children: [
                                  widget.username != "" &&
                                          jc.contains(widget.subClubName)
                                      ? Container(
                                          margin: EdgeInsets.all(10),
                                          color: Colors.white,
                                          child: OutlinedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddComment(
                                                    widget.clubName,
                                                    widget.subClubName,
                                                    widget.timestamp,
                                                  ),
                                                ),
                                              );
                                              setState() {}
                                            },
                                            child: Text("Add new comment"),
                                          ),
                                        )
                                      : Container(),
                                  snapshot.data.length != 0
                                      ? ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: snapshot.data.length,
                                          itemBuilder: (context, index) {
                                            return CommentWidget(
                                              snapshot.data[index].author,
                                              snapshot.data[index].content,
                                              snapshot.data[index].timestamp,
                                              snapshot.data[index].vote,
                                              widget.timestamp,
                                              widget.clubName,
                                              widget.subClubName,
                                              widget.username,
                                            );
                                          },
                                        )
                                      : Text("No comments yet."),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void reportUser() async {
    String url = 'http://' + localhost + ':8080/addreports';
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Access-Control-Allow-Origin': '*'
    };
    String jsonBody = '{"username":"' +
        widget.author +
        '","clubName":"' +
        widget.clubName +
        '","subClubName":"' +
        widget.subClubName +
        '","timestamp":"' +
        widget.timestamp +
        '","type":"post"}';

    // make POST request
    await post(Uri.parse(url), headers: headers, body: jsonBody);
  }

  Future<List<Comment>> getComments() async {
    String url = 'http://' + localhost + ':8080/getcomments';
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Access-Control-Allow-Origin': '*'
    };
    String jsonBody = '{"clubName":"' +
        widget.clubName +
        '","subClubName":"' +
        widget.subClubName +
        '","timestamp":"' +
        widget.timestamp +
        '"}';

    // make POST request
    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonBody);
    Iterable commentListIter = json.decode(utf8.decode(response.bodyBytes));
    List<Comment> commentList = List<Comment>.from(
        commentListIter.map((model) => Comment.fromJson(model)));
    return commentList;
  }

  void setVote(
      String clubName, String subClubName, String timestamp, int vote) async {
    String url = 'http://' + localhost + ':8080/updatevote';
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Access-Control-Allow-Origin': '*'
    };
    String jsonBody = '{"clubName":"' +
        clubName +
        '","subClubName":"' +
        subClubName +
        '","timestamp":"' +
        timestamp +
        '","vote":' +
        vote.toString() +
        '}';

    // make POST request
    await post(Uri.parse(url), headers: headers, body: jsonBody);
  }
}
