import 'dart:convert';

import "package:flutter/material.dart";
import 'package:frontend_idea_app/core/AddClubForm.dart';
import 'package:frontend_idea_app/core/CoreAll.dart';
import 'package:frontend_idea_app/main.dart';
import 'package:frontend_idea_app/models/AllModel.dart';
import 'package:frontend_idea_app/SharedPref.dart';
import 'package:frontend_idea_app/screens/MemberPage.dart';
import 'package:frontend_idea_app/widgets/BrowseItem.dart';
import 'package:http/http.dart';
import 'package:frontend_idea_app/screens/SubClubPage.dart';
import 'dart:async';
import "package:frontend_idea_app/User.dart";

class BrowseScreen extends StatefulWidget {
  @override
  _BrowseScreenState createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  User user;
  @override
  void initState() {
    SharedPref().read("user").then((value) => {
          if (value != null) {user = User.fromJson(value)}
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          FutureBuilder<List<Index>>(
              future: getAllIndex(),
              builder: (context, snapshot) {
                return Row(children: [
                  Text("Browse", style: TextStyle(fontSize: 24)),
                  Spacer(),
                  user != null
                      ? user.isAdmin == 1
                          ? IconButton(
                              icon: Icon(Icons.add_box_outlined),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddClubForm(),
                                  ),
                                );
                              },
                            )
                          : IconButton(
                              icon: Icon(Icons.emoji_objects_outlined),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ClubRequestForm(),
                                  ),
                                );
                              },
                            )
                      : Container(),
                  IconButton(
                      icon: Icon(Icons.search),
                      tooltip: 'Search',
                      onPressed: !snapshot.hasData
                          ? () {}
                          : () {
                              showSearch(
                                context: context,
                                delegate: Search(snapshot.data,
                                    user != null ? user.username : ''),
                              );
                            })
                ]);
              }),
          FutureBuilder(
            future: getAllClubs(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Club>> snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: GridView.builder(
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
                        snapshot.data[index].name,
                        '',
                        snapshot.data[index].imageUrl,
                        false,
                        snapshot.data[index].vote,
                        false,
                        snapshot.data[index].description,
                      );
                    },
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }

  Future<List<Club>> getAllClubs() async {
    String url = 'http://' + localhost + ':8080/getallclubs';
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Access-Control-Allow-Origin': '*'
    };
    String jsonBody = '{}';

    // make POST request
    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonBody);
    Iterable clubListIter = json.decode(utf8.decode(response.bodyBytes));
    List<Club> clubList =
        List<Club>.from(clubListIter.map((model) => Club.fromJson(model)));
    return clubList;
  }

  Future<List<Index>> getAllIndex() async {
    String url = 'http://' + localhost + ':8080/index';
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Access-Control-Allow-Origin': '*'
    };
    String jsonBody = '{}';

    // make POST request
    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonBody);
    Iterable indexListIter = json.decode(utf8.decode(response.bodyBytes));
    List<Index> indexList =
        List<Index>.from(indexListIter.map((model) => Index.fromJson(model)));
    return indexList;
  }
}

class Search extends SearchDelegate {
  Index selectedResult;
  final List<Index> listExample;
  List<Index> recentList = [];
  final String username;

  Search(this.listExample, this.username);

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text("hey"),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Index> suggestionListClub = [];
    List<Index> suggestionListSubClub = [];
    List<Index> suggestionListUsername = [];
    query.isEmpty
        ? suggestionListClub = recentList
        : suggestionListClub.addAll(listExample.where(
            (element) =>
                element.name.startsWith(query) && element.type == 'club',
          ));
    query.isEmpty
        ? suggestionListSubClub = recentList
        : suggestionListSubClub.addAll(listExample.where(
            (element) =>
                element.name.startsWith(query) && element.type == 'subclub',
          ));

    query.isEmpty
        ? suggestionListUsername = recentList
        : suggestionListUsername.addAll(listExample.where(
            (element) =>
                element.name.startsWith(query) && element.type == 'username',
          ));

    return Column(
      children: [
        Text("Clubs", style: TextStyle(fontSize: 24)),
        Expanded(
          child: ListView.builder(
            itemCount: suggestionListClub.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  suggestionListClub[index].name,
                ),
                leading: query.isEmpty ? Icon(Icons.access_time) : SizedBox(),
                onTap: () {
                  selectedResult = suggestionListClub[index];
                  //showResults(context);
                },
              );
            },
          ),
        ),
        Text("SubClubs", style: TextStyle(fontSize: 24)),
        Expanded(
          child: ListView.builder(
            itemCount: suggestionListSubClub.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  suggestionListSubClub[index].name,
                ),
                leading: query.isEmpty ? Icon(Icons.access_time) : SizedBox(),
                onTap: () {
                  selectedResult = suggestionListSubClub[index];
                  //showResults(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SubClubPage(
                        selectedResult.clubName,
                        selectedResult.name,
                        selectedResult.vote,
                        selectedResult.description,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        Text("Users", style: TextStyle(fontSize: 24)),
        username != ''
            ? Expanded(
                child: ListView.builder(
                  itemCount: suggestionListUsername.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        suggestionListUsername[index].name,
                      ),
                      leading:
                          query.isEmpty ? Icon(Icons.access_time) : SizedBox(),
                      onTap: () {
                        selectedResult = suggestionListUsername[index];
                        showResults(context);
                        Navigator.pushReplacement(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => MemberPage(
                                    suggestionListUsername[index].name)));
                      },
                    );
                  },
                ),
              )
            : Text("visitors cannot search members"),
      ],
    );
  }
}
