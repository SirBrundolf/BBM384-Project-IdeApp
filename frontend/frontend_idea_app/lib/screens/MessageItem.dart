import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_idea_app/User.dart';
import 'package:frontend_idea_app/main.dart';
import 'package:frontend_idea_app/screens/MessageScreen.dart';
import 'package:http/http.dart';

class MessageItem extends StatelessWidget {
  final String receiver, sender;
  MessageItem(this.sender, this.receiver);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.only(top: 10.0),
        child: GestureDetector(
          child: Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.only(bottom: 10.0, right: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(width: 15),
                    ProfilePicture(receiver),
                    SizedBox(width: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          receiver + " ",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          " last message + last timestamp",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              color: Colors.blue,
            ),
          ),
          onTap: () => {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => MessageScreen(sender, receiver),
              ),
            )
          },
        ),
      ),
      width: double.infinity,
      height: 100,
    );
  }
}

class ProfilePicture extends StatelessWidget {
  final String username;
  ProfilePicture(this.username);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getImageURL(username),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            height: 60,
            width: 60,
            child: CircleAvatar(
              backgroundImage: NetworkImage(snapshot.data),
            ),
          );
        } else
          return SizedBox(
            height: 60,
            width: 60,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage("assets/images/ideAppLogo.png"),
            ),
          );
      },
    );
  }

  Future<String> getImageURL(String searched) async {
    String url = 'http://' + localhost + ':8080/getuser';
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Access-Control-Allow-Origin': '*'
    };
    String jsonBody = searched;

    // make POST request
    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonBody);
    User user = User.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    return user.imageUrl;
  }
}
