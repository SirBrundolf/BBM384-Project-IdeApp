import 'package:flutter/material.dart';
import 'package:frontend_idea_app/main.dart';
import 'package:frontend_idea_app/screens/EditComment.dart';
import 'package:http/http.dart';

// ignore: must_be_immutable
class CommentWidget extends StatefulWidget {
  final String author,
      content,
      timestamp,
      clubName,
      subClubName,
      username,
      postTimestamp;
  int vote;

  CommentWidget(this.author, this.content, this.timestamp, this.vote,
      this.postTimestamp, this.clubName, this.subClubName, this.username);

  @override
  _CommentWidgetState createState() => _CommentWidgetState(vote);
}

class _CommentWidgetState extends State<CommentWidget> {
  int vote;
  bool votedUp = false;
  bool votedDown = false;
  bool reported = false;
  Color votedUpColor = Colors.black;
  Color votedDownColor = Colors.black;
  Color flagColor = Colors.black;
  bool isExpanded = false;

  _CommentWidgetState(this.vote);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
        color: Colors.white,
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Container(
              padding: EdgeInsets.all(5),
              child: Text(widget.author),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              widget.content,
            ),
          ),
          Container(
            child: Row(
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
                    setVote();
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
                    setVote();
                  },
                ),
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
                widget.username == widget.author
                    ? IconButton(
                        icon: Icon(Icons.edit_outlined),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditComment(
                                widget.clubName,
                                widget.subClubName,
                                widget.timestamp,
                                widget.postTimestamp,
                                widget.content,
                              ),
                            ),
                          );
                        },
                      )
                    : Container(),
                widget.username == widget.author
                    ? IconButton(
                        icon: Icon(Icons.delete_forever),
                        onPressed: () {
                          setState(() {
                            deleteComment();
                            super.setState(() {});
                          });
                          Navigator.pop(context);
                        },
                      )
                    : Container(),
              ],
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
        widget.postTimestamp +
        '","type":"comment"}';

    // make POST request
    await post(Uri.parse(url), headers: headers, body: jsonBody);
  }

  void deleteComment() async {
    String url = 'http://' + localhost + ':8080/deletecomment';
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Access-Control-Allow-Origin': '*'
    };
    String jsonBody = '{"timestamp":"' +
        widget.timestamp +
        '","postTimestamp":"' +
        widget.postTimestamp +
        '","subClubName":"' +
        widget.subClubName +
        '","clubName":"' +
        widget.clubName +
        '","content":""}';

    // make POST request
    await post(Uri.parse(url), headers: headers, body: jsonBody);
  }

  void setVote() async {
    String url = 'http://' + localhost + ':8080/updatecommentvote';
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Access-Control-Allow-Origin': '*'
    };
    String jsonBody = '{"timestamp":"' +
        widget.timestamp +
        '","postTimestamp":"' +
        widget.postTimestamp +
        '","subClubName":"' +
        widget.subClubName +
        '","clubName":"' +
        widget.clubName +
        '","vote":' +
        vote.toString() +
        '}';

    // make POST request
    await post(Uri.parse(url), headers: headers, body: jsonBody);
  }
}
