import 'dart:convert';

import "package:flutter/material.dart";
import 'package:frontend_idea_app/SharedPref.dart';
import 'package:frontend_idea_app/User.dart';
import 'package:frontend_idea_app/core/AdminPanelNavBar.dart';
import 'package:frontend_idea_app/core/SubClubNavBar.dart';
import 'package:frontend_idea_app/models/Request.dart';
import 'package:frontend_idea_app/core/CoreAll.dart';
import 'package:frontend_idea_app/screens/PostAndComments.dart';
import '../main.dart';
import 'package:http/http.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> with TickerProviderStateMixin {
  TabController _tabController;
  SubClubNavBar navBar;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: new PreferredSize(
            preferredSize: const Size(double.infinity, kToolbarHeight * 2.35),
            child: Column(
              children: [
                AppBar(
                  title: AppLogo(),
                  brightness: Brightness.light,
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                ),
                AdminPanelNavBar(_tabController),
              ],
            ),
          ),
          body: TabBarView(controller: _tabController, children: [
            ClubReq(),
            SubClubReq(),
            BanReq(),
            Candidates(),
          ])),
    );
  }
}

Future<List<RequestClub>> getReqClub() async {
  String url = 'http://' + localhost + ':8080/getclubrequests';
  Map<String, String> headers = {
    "Content-type": "application/json",
    'Access-Control-Allow-Origin': '*'
  };
  String jsonBody = '{}';

  // make POST request
  Response response =
      await post(Uri.parse(url), headers: headers, body: jsonBody);
  Iterable clubListIter = json.decode(utf8.decode(response.bodyBytes));
  List<RequestClub> reqClub = List<RequestClub>.from(
      clubListIter.map((model) => RequestClub.fromJson(model)));
  return reqClub;
}

Future<List<RequestSubClub>> getReqSubClub() async {
  String url = 'http://' + localhost + ':8080/getsubclubrequests';
  Map<String, String> headers = {
    "Content-type": "application/json",
    'Access-Control-Allow-Origin': '*'
  };
  String jsonBody = '{}';

  // make POST request
  Response response =
      await post(Uri.parse(url), headers: headers, body: jsonBody);
  Iterable clubListIter = json.decode(utf8.decode(response.bodyBytes));
  List<RequestSubClub> reqClub = List<RequestSubClub>.from(
      clubListIter.map((model) => RequestSubClub.fromJson(model)));
  return reqClub;
}

Future<List<BanRequest>> getBanReq() async {
  String url = 'http://' + localhost + ':8080/getreports';
  Map<String, String> headers = {
    "Content-type": "application/json",
    'Access-Control-Allow-Origin': '*'
  };
  String jsonBody = '{}';

  // make POST request
  Response response =
      await post(Uri.parse(url), headers: headers, body: jsonBody);
  Iterable clubListIter = json.decode(utf8.decode(response.bodyBytes));
  List<BanRequest> reqClub = List<BanRequest>.from(
      clubListIter.map((model) => BanRequest.fromJson(model)));
  return reqClub;
}

Future<List<CandidateRequest>> getCanReq() async {
  String url = 'http://' + localhost + ':8080/getcandidates';
  Map<String, String> headers = {
    "Content-type": "application/json",
    'Access-Control-Allow-Origin': '*'
  };
  String jsonBody = '{}';

  // make POST request
  Response response =
      await post(Uri.parse(url), headers: headers, body: jsonBody);
  Iterable clubListIter = json.decode(utf8.decode(response.bodyBytes));
  List<CandidateRequest> reqClub = List<CandidateRequest>.from(
      clubListIter.map((model) => CandidateRequest.fromJson(model)));
  return reqClub;
}

class ClubReq extends StatefulWidget {
  @override
  _ClubReqState createState() => _ClubReqState();
}

class _ClubReqState extends State<ClubReq> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getReqClub(),
        builder:
            (BuildContext context, AsyncSnapshot<List<RequestClub>> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.blue.shade50,
                          child: ListTile(
                            leading: Icon(Icons.group_add_outlined),
                            title: Text(snapshot.data[index].name),
                            subtitle: Text(snapshot.data[index].reason),
                            isThreeLine: true,
                            dense: true,
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            );
          } else {
            return Text("No Data");
          }
        },
      ),
    );
  }
}

class SubClubReq extends StatefulWidget {
  @override
  _SubClubReqState createState() => _SubClubReqState();
}

class _SubClubReqState extends State<SubClubReq> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getReqSubClub(),
        builder: (BuildContext context,
            AsyncSnapshot<List<RequestSubClub>> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.blue.shade50,
                          child: ListTile(
                            leading: Icon(Icons.loyalty_outlined),
                            title: Text(snapshot.data[index].name),
                            subtitle: Text(snapshot.data[index].reason +
                                "\n#" +
                                snapshot.data[index].parentClub),
                            isThreeLine: true,
                            dense: true,
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            );
          } else {
            return Text("No Data");
          }
        },
      ),
    );
  }
}

class BanReq extends StatefulWidget {
  @override
  _BanReqState createState() => _BanReqState();
}

class _BanReqState extends State<BanReq> {
  String username, clubName, timestamp, subClubName, type;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getBanReq(),
        builder:
            (BuildContext context, AsyncSnapshot<List<BanRequest>> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.blue.shade50,
                          child: ListTile(
                            leading: Icon(Icons.do_not_disturb),
                            title: Text(
                                snapshot.data[index].username),
                            subtitle: Text(snapshot.data[index].subClubName +
                                "\nType:" +
                                snapshot.data[index].type),
                            isThreeLine: true,
                            dense: true,
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    Icons.delete_forever,
                                    size: 20.0,
                                    color: Colors.brown[900],
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Container(
                                            height: MediaQuery.of(context).size.height / 5,
                                            width: MediaQuery.of(context).size.width / 1.5,
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 25,
                                                ),
                                                Text(
                                                    "Are you sure you want to delete this user?"),
                                                SizedBox(
                                                  height: 50,
                                                ),
                                                RaisedButton(
                                                  onPressed: () {
                                                    username = snapshot.data[index].username;
                                                    clubName = snapshot.data[index].clubName;
                                                    subClubName = snapshot.data[index].subClubName;
                                                    timestamp = snapshot.data[index].timestamp;
                                                    type = snapshot.data[index].type;
                                                    print(username);
                                                    postRequestBanUser();
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Yes"),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => PostAndComments(
                                    snapshot.data[index].clubName,
                                    snapshot.data[index].subClubName,
                                    snapshot.data[index].timestamp,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            );
          } else {
            return Text("No Data");
          }
        },
      ),
    );
  }

  Future<void> postRequestBanUser() async {
    String url = 'http://' + localhost + ':8080/banuser';
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Access-Control-Allow-Origin': '*'
    };
    String json = ' {"username" :"' +
        this.username +
        '","clubName" :"' +
        this.clubName +
        '","subClubName" :"' +
        this.subClubName +
        '","timestamp" :"' +
        this.timestamp +
        '","type" :"' +
        this.type +
        '"}';

    // make POST request
    await post(Uri.parse(url), headers: headers, body: json);
  }
}

class Candidates extends StatefulWidget {
  @override
  _CandidatesState createState() => _CandidatesState();
}

class _CandidatesState extends State<Candidates> {
  String username, clubName, subClubName, reason;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getCanReq(),
        builder: (BuildContext context,
            AsyncSnapshot<List<CandidateRequest>> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.blue.shade50,
                          child: ListTile(
                            leading: Icon(Icons.how_to_vote_outlined),
                            title: Text("Candidate: " +
                                snapshot.data[index].username +
                                " for " +
                                snapshot.data[index].subClubName),
                            subtitle: Text(snapshot.data[index].reason +
                                "\n#" +
                                snapshot.data[index].clubName),
                            isThreeLine: true,
                            dense: true,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Container(
                                      height: MediaQuery.of(context).size.height / 5,
                                      width: MediaQuery.of(context).size.width / 1.5,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 25,
                                          ),
                                          Text(
                                              "Are you sure you want to make this user an admin?"),
                                          SizedBox(
                                            height: 50,
                                          ),
                                          RaisedButton(
                                            onPressed: () {
                                              username = snapshot.data[index].username;
                                              clubName = snapshot.data[index].clubName;
                                              subClubName = snapshot.data[index].subClubName;
                                              reason = snapshot.data[index].reason;
                                              postRequestSetSubClubAdmin();
                                              Navigator.pop(context);
                                            },
                                            child: Text("Yes"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            );
          } else {
            return Text("No Data");
          }
        },
      ),
    );
  }

  Future<void> postRequestSetSubClubAdmin() async {
    String url = 'http://' + localhost + ':8080/setsubclubadmin';
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Access-Control-Allow-Origin': '*'
    };
    String json = ' {"username" :"' +
        this.username +
        '","clubName" :"' +
        this.clubName +
        '","subClubName" :"' +
        this.subClubName +
        '","reason" :"' +
        this.reason +
        '"}';

    // make POST request
    await post(Uri.parse(url), headers: headers, body: json);
  }
}
