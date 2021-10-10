import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend_idea_app/SharedPref.dart';
import 'package:frontend_idea_app/User.dart';
import 'package:frontend_idea_app/models/JoinedClub.dart';
import 'package:frontend_idea_app/screens/EditNameSurname.dart';
import 'package:frontend_idea_app/screens/EditEmail.dart';
import 'package:frontend_idea_app/screens/EditPassword.dart';
import 'package:frontend_idea_app/screens/SignIn.dart';
import 'package:frontend_idea_app/screens/JoinedClubScreen.dart';
import 'package:frontend_idea_app/widgets/BrowseItem.dart';
import 'package:frontend_idea_app/widgets/SubClubCarousel.dart';
import 'package:http/http.dart';

import '../main.dart';

class MemberPage extends StatelessWidget {
  final String searched;

  MemberPage(this.searched);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Body(searched),
    );
  }
}

class Body extends StatelessWidget {
  Body(this.searched);

  final String searched;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          ProfilePicture(searched),
          SizedBox(
            height: 20,
          ),
          AccountMenu(icon: "assets/icons/user_icon.svg", text: searched),
          ListView(
            shrinkWrap: true,
            children: [
              Container(
                height: 250,
                color: const Color(0xFFDADADA),
                child: FutureBuilder(
                  future: getJoinedClubs(searched),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<JoinedClub>> snapshot) {
                    if (snapshot.data != null) {
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          crossAxisCount: 1,
                        ),
                        primary: false,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(10),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, index) {
                          return BrowseItem(
                            snapshot.data[index].clubName,
                            snapshot.data[index].parentClub,
                            snapshot.data[index].imageUrl,
                            true,
                            snapshot.data[index].vote,
                            true,
                            snapshot.data[index].description,
                          );
                        },
                      );
                    } else {
                      return Container(
                        width: 0,
                        height: 0,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * (1 / 10),
                20,
                MediaQuery.of(context).size.width * (1 / 10),
                0.0),
          ),
          /*Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //MemberCarousel()
              ],
          )*/
        ],
      ),
    );
  }

  Future<List<JoinedClub>> getJoinedClubs(String searched) async {
    String url = 'http://' + localhost + ':8080/getjoinedclubs';
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Access-Control-Allow-Origin': '*'
    };

    String jsonBody = searched;

    // make POST request
    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonBody);
    Iterable l = json.decode(utf8.decode(response.bodyBytes));
    List<JoinedClub> joinedClubs =
        List<JoinedClub>.from(l.map((model) => JoinedClub.fromJson(model)));
    for (JoinedClub i in joinedClubs) {
      print(i.clubName);
      jc.add(i.clubName);
    }
    return joinedClubs;
  }
}

class AccountMenu extends StatelessWidget {
  const AccountMenu({
    Key key,
    @required this.text,
    @required this.icon,
  }) : super(key: key);
  final String text, icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      // ignore: missing_required_param, deprecated_member_use
      child: FlatButton(
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Color(0xFFF5F6F9),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 22,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePicture extends StatelessWidget {
  final String searched;

  ProfilePicture(this.searched);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getImageURL(searched),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            height: 115,
            width: 115,
            child: Stack(
              fit: StackFit.expand,
              overflow: Overflow.visible,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(snapshot.data),
                ),
                Positioned(
                  bottom: 0,
                  right: -12,
                  child: SizedBox(
                    height: 46,
                    width: 46,
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
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

class MemberCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Joined Clubs',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 140.0,
          color: Colors.grey,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  width: 110.0,
                  child: Stack(
                    children: <Widget>[
                      Container(height: 120.0, width: 200.0, color: Colors.red)
                    ],
                  ));
            },
          ),
        ),
      ],
    );
  }
}
