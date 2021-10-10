import 'package:flutter/material.dart';
import 'package:frontend_idea_app/main.dart';
import 'package:http/http.dart';
import 'package:frontend_idea_app/models/AllModel.dart';
import 'package:frontend_idea_app/SharedPref.dart';
import "package:frontend_idea_app/User.dart";
import 'package:frontend_idea_app/widgets/BrowseItem.dart';
import 'dart:convert';

List<String> jc = [];

class JoinedClubScreen extends StatefulWidget {
  @override
  _JoinedClubState createState() => _JoinedClubState();
}

class _JoinedClubState extends State<JoinedClubScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getJoinedClubs(),
        builder:
            (BuildContext context, AsyncSnapshot<List<JoinedClub>> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              primary: false,
              padding: const EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: 2,
              ),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, index) {
                return BrowseItem(
                  snapshot.data[index].parentClub,
                  snapshot.data[index].clubName,
                  snapshot.data[index].imageUrl,
                  true,
                  snapshot.data[index].vote,
                  false,
                  snapshot.data[index].description,
                );
              },
            );
          } else {
            return Container();
          }
        });
  }

  Future<List<JoinedClub>> getJoinedClubs() async {
    String url = 'http://' + localhost + ':8080/getjoinedclubs';
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Access-Control-Allow-Origin': '*'
    };
    User user = User.fromJson(await SharedPref().read("user"));
    String jsonBody = user.username;

    // make POST request
    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonBody);
    Iterable l = json.decode(utf8.decode(response.bodyBytes));
    List<JoinedClub> joinedClubs =
        List<JoinedClub>.from(l.map((model) => JoinedClub.fromJson(model)));
    for (JoinedClub i in joinedClubs) {
      jc.add(i.clubName);
    }
    return joinedClubs;
  }
}
