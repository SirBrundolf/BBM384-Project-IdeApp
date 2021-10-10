import 'package:flutter/material.dart';
import 'package:frontend_idea_app/main.dart';
import 'package:http/http.dart';
import 'package:frontend_idea_app/SharedPref.dart';
import 'package:frontend_idea_app/User.dart';
import 'package:frontend_idea_app/models/AllModel.dart';
import 'package:frontend_idea_app/widgets/EventWidget.dart';
import 'package:frontend_idea_app/screens/JoinedClubScreen.dart';
import 'package:frontend_idea_app/screens/AddEvent.dart';
import 'dart:convert';
import 'dart:async';

class EventScreen extends StatefulWidget {
  String clubName, subClubName;
  EventScreen(this.clubName, this.subClubName);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  User user;
  SubClub subClubAdmin;

  @override
  void initState() async {
    SharedPref()
        .read("user")
        .then((value) => user = value == null ? null : User.fromJson(value));
    subClubAdmin = await getSubClubAdmin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: null,
      body: Container(
        color: const Color(0xFFDADADA),
        child: FutureBuilder(
          future: getEvents(),
          builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  user != null && jc.contains(widget.subClubName) &&
                    user.username == subClubAdmin.subClubAdmin
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
                                  builder: (context) => AddEvent(
                                      widget.clubName, widget.subClubName),
                                ),
                              );
                              // ignore: unused_element
                              setState() {}
                            },
                            child: Text("Add new event"),
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
                          
                            
                              return EventWidget(
                                snapshot.data[index].name,
                                snapshot.data[index].date,
                                
                                snapshot.data[index].timestamp,
                                
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

  Future<List<Event>> getEvents() async {
    String url = 'http://' + localhost + ':8080/getevents';
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Access-Control-Allow-Origin': '*'
    };
    String jsonBody = '{"clubName":"' +
        this.widget.clubName +
        '","subClubName":"' +
        this.widget.clubName +
        '"}';

    // make POST request
    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonBody);
    Iterable l = json.decode(utf8.decode(response.bodyBytes));
    List<Event> events =
        List<Event>.from(l.map((model) => Event.fromJson(model)));
    return events;
  }

  Future<SubClub> getSubClubAdmin() async {
    String url = 'http://' + localhost + ':8080/getsubclub';
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Access-Control-Allow-Origin': '*'
    };
    String jsonBody = '{"subClubName":"' +
        this.widget.subClubName +
        '","clubName":"' +
        this.widget.clubName +
        '"}';

    // make POST request
    Response response =
    await post(Uri.parse(url), headers: headers, body: jsonBody);
    return SubClub.fromJson(json.decode(response.body));
  }
}
