import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend_idea_app/core/CoreAll.dart';
import 'package:frontend_idea_app/main.dart';
import 'package:frontend_idea_app/widgets/SubClubCarousel.dart';
import 'package:http/http.dart';

import '../SharedPref.dart';
import '../User.dart';

class ClubDetail extends StatefulWidget {
  final String clubName, imageUrl, description;
  final int vote;
  ClubDetail(this.clubName, this.imageUrl, this.vote, this.description);
  @override
  _ClubDetailState createState() => _ClubDetailState();
}

class _ClubDetailState extends State<ClubDetail> {
  User user;

  int _isSelected = 0;
  int vote;
  bool votedUp = false;
  bool votedDown = false;
  Color votedUpColor = Colors.black;
  Color votedDownColor = Colors.black;

  @override
  void initState() {
    SharedPref().read("user").then((value) => user = User.fromJson(value));
    vote = widget.vote;
    super.initState();
  }

  Widget _buildPlusIcon() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = 1;
        });
        user.isAdmin == 1
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddSubClubForm(widget.clubName),
                ),
              )
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubClubRequestForm(widget.clubName),
                ),
              );
        // TODO: Color change will be added
        setState(() {
          _isSelected = 0;
        });
      },
      child: Container(
          height: 60.0,
          width: 60.0,
          decoration: BoxDecoration(
              color: _isSelected == 0 ? Colors.blue : Colors.cyan,
              borderRadius: BorderRadius.circular(30.0)),
          child: Icon(
            FontAwesomeIcons.plus,
            size: 25.0,
            color: Colors.white,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    var topMargin = AppBar().preferredSize.height;
    return Scaffold(
      backgroundColor: const Color(0xFFDADADA),
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                title: Text(
                  widget.clubName,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                backgroundColor:
                    Colors.blue, // F58634 A603F2 C05050 turuncu-kırmızı-mor
                pinned: true,
                expandedHeight: 300,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.fromLTRB(0, topMargin, 0, 0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDADADA),
                      image: DecorationImage(
                        image: NetworkImage(widget.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: ListView(
            children: <Widget>[
              SubClubCarousel(topMargin, widget.clubName),
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Details of the club',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        _buildPlusIcon(),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Row(
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
                        ),
                        Container(
                          child: Text(widget.description),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setVote(int vote) async {
    String url = 'http://' + localhost + ':8080/updateclubvote';
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Access-Control-Allow-Origin': '*'
    };
    String jsonBody =
        '{"clubName":"' + widget.clubName + '","vote":' + vote.toString() + '}';

    // make POST request
    await post(Uri.parse(url), headers: headers, body: jsonBody);
  }
}
