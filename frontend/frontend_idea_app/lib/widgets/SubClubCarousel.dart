import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_idea_app/main.dart';
import 'package:frontend_idea_app/models/AllModel.dart';
import 'package:frontend_idea_app/widgets/BrowseItem.dart';
import 'package:http/http.dart';

class SubClubCarousel extends StatefulWidget {
  double topMargin;
  String clubName;
  SubClubCarousel(this.topMargin, this.clubName);

  @override
  _SubClubCarouselState createState() => _SubClubCarouselState();
}

class _SubClubCarouselState extends State<SubClubCarousel> {
  bool isExpanded;

  @override
  void initState() {
    isExpanded = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, widget.topMargin, 0, 0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Sub-Clubs of this Club',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
                GestureDetector(
                  onTap: () => {
                    setState(() {
                      isExpanded = !isExpanded;
                    })
                  },
                  child: Text(
                    isExpanded == false ? 'See All' : "See Less",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ConstrainedBox(
            constraints: isExpanded
                ? new BoxConstraints(minHeight: 200)
                : new BoxConstraints(maxHeight: 200),
            child: Container(
              color: const Color(0xFFDADADA),
              child: FutureBuilder(
                future: getAllSubClubs(widget.clubName),
                builder: (BuildContext context,
                    AsyncSnapshot<List<SubClub>> snapshot) {
                  if (snapshot.data != null) {
                    return GridView.builder(
                      primary: false,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10),
                      scrollDirection:
                          isExpanded ? Axis.vertical : Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        crossAxisCount: isExpanded ? 2 : 1,
                      ),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, index) {
                        return BrowseItem(
                          widget.clubName,
                          snapshot.data[index].name,
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
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<SubClub>> getAllSubClubs(String clubName) async {
    String url = 'http://' + localhost + ':8080/getallsubclubs';
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Access-Control-Allow-Origin': '*'
    };
    String jsonBody = clubName;

    // make POST request
    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonBody);
    Iterable subClubListIter = json.decode(utf8.decode(response.bodyBytes));
    List<SubClub> subClubList = List<SubClub>.from(
        subClubListIter.map((model) => SubClub.fromJson(model)));
    return subClubList;
  }
}
