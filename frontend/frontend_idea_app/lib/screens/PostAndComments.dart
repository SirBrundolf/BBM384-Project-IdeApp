import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_idea_app/SharedPref.dart';
import 'package:frontend_idea_app/User.dart';
import 'package:frontend_idea_app/main.dart';
import 'package:frontend_idea_app/models/AllModel.dart';
import 'package:frontend_idea_app/screens/AddPost.dart';
import 'package:frontend_idea_app/widgets/PostWidget.dart';
import 'package:frontend_idea_app/screens/JoinedClubScreen.dart';
import 'package:http/http.dart';

class PostAndComments extends StatefulWidget {
  final String clubName, subClubName, timestamp;
  PostAndComments(this.clubName, this.subClubName, this.timestamp);

  @override
  _PostAndCommentsState createState() => _PostAndCommentsState();
}

class _PostAndCommentsState extends State<PostAndComments> {
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
    return Scaffold(
      appBar: widget.timestamp != "" ? AppBar() : null,
      body: Container(
        color: const Color(0xFFDADADA),
        child: FutureBuilder(
          future: getPosts(widget.clubName, widget.subClubName),
          builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  user != null &&
                          jc.contains(widget.subClubName) &&
                          widget.timestamp == ""
                      ? Container(
                          margin: EdgeInsets.all(10),
                          child: OutlinedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddPost(
                                      widget.clubName, widget.subClubName),
                                ),
                              );
                              // ignore: unused_element
                              setState() {}
                            },
                            child: Text("Add new post"),
                          ),
                        )
                      : Container(),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if (widget.timestamp != "") {
                            if (snapshot.data[index].timestamp ==
                                widget.timestamp)
                              return PostWidget(
                                snapshot.data[index].author,
                                snapshot.data[index].title,
                                snapshot.data[index].content,
                                snapshot.data[index].vote,
                                snapshot.data[index].timestamp,
                                widget.clubName,
                                widget.subClubName,
                                user != null ? user.username : "",
                              );
                            else
                              return Container();
                          } else
                            return PostWidget(
                              snapshot.data[index].author,
                              snapshot.data[index].title,
                              snapshot.data[index].content,
                              snapshot.data[index].vote,
                              snapshot.data[index].timestamp,
                              widget.clubName,
                              widget.subClubName,
                              user != null ? user.username : "",
                            );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: snapshot.data.length,
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Future<List<Post>> getPosts(String clubName, String subClubName) async {
    String url = 'http://' + localhost + ':8080/getposts';
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Access-Control-Allow-Origin': '*'
    };
    String jsonBody =
        '{"clubName":"' + clubName + '","subClubName":"' + subClubName + '"}';

    // make POST request
    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonBody);
    Iterable postListIter = json.decode(utf8.decode(response.bodyBytes));
    List<Post> postList =
        List<Post>.from(postListIter.map((model) => Post.fromJson(model)));
    return postList;
  }
}
