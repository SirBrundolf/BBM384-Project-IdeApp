import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_idea_app/main.dart';
import 'package:frontend_idea_app/models/Conversations.dart';
import 'package:http/http.dart';

import 'package:frontend_idea_app/SharedPref.dart';
import 'package:frontend_idea_app/User.dart';
import 'MessageItem.dart';

class DirectMessage extends StatefulWidget {
  @override
  _DirectMessageState createState() => _DirectMessageState();
}

class _DirectMessageState extends State<DirectMessage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getConversations(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Conversations>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, count) {
                return MessageItem(
                    snapshot.data[count].sender, snapshot.data[count].receiver);
              },
              itemCount: snapshot.data.length,
            );
          } else {
            return Container();
          }
        });
  }

  Future<List<Conversations>> getConversations() async {
    User user = User.fromJson(await SharedPref().read("user"));
    String url = 'http://' + localhost + ':8080/getconversations';
    Map<String, String> headers = {"Content-type": "application/json"};
    String jsonBody = '"' + user.username + '"';

    // make POST request
    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonBody);

    // check the status code for the result
    int statusCode = response.statusCode;

    String body;
    if (statusCode == 200) {
      body = response.body;
      if (json.decode(body) != null) {
        Iterable l = json.decode(body);
        List<Conversations> conversations = List<Conversations>.from(
            l.map((model) => Conversations.fromJson(model)));
        return conversations;
      }
    }
    return null;
  }
}
