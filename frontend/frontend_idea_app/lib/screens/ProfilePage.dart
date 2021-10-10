import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend_idea_app/SharedPref.dart';
import 'package:frontend_idea_app/User.dart';
import 'package:frontend_idea_app/main.dart';
import 'package:frontend_idea_app/screens/EditProfileImg.dart';
import 'package:frontend_idea_app/screens/EditNameSurname.dart';
import 'package:frontend_idea_app/screens/EditEmail.dart';
import 'package:frontend_idea_app/screens/EditPassword.dart';
import 'package:frontend_idea_app/screens/SignIn.dart';
import 'package:frontend_idea_app/screens/JoinedClubScreen.dart';
import 'package:http/http.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          ProfilePicture(),
          SizedBox(
            height: 20,
          ),
          Text(user.username),
          Text(
            utf8.decode(user.name.runes.toList()) +
                " " +
                utf8.decode(user.surname.runes.toList()),
          ),
          AccountMenu(
            icon: "assets/icons/user_icon.svg",
            text: "Edit Name Surname",
            press: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditNameSurname(),
                ),
              )
            },
          ),
          Text(user.mailAddress),
          AccountMenu(
            icon: "assets/icons/email.svg",
            text: "Edit E-mail",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditEmail(),
                ),
              );
            },
          ),
          AccountMenu(
            icon: "assets/icons/lock_icon.svg",
            text: "Edit Password",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditPassword(),
                ),
              );
            },
          ),
          Container(
            margin: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * (1 / 10),
                20,
                MediaQuery.of(context).size.width * (1 / 10),
                0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text("Sign Out"),
                    IconButton(
                      icon: Icon(Icons.exit_to_app),
                      onPressed: () => postRequestSignOut().then(
                        (value) => {
                          jc = [],
                          SharedPref().remove("User"),
                          SharedPref().remove("keepMeLoggedIn"),
                          if (value != null)
                            {
                              Navigator.pushReplacement(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => SignIn(),
                                ),
                              )
                            }
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Delete Account"),
                    IconButton(
                      icon: Icon(Icons.delete_forever),
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
                                        "Are you sure you want to delete your account?"),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    RaisedButton(
                                      onPressed: () => postRequestDelete().then(
                                        (value) => {
                                          if (value != null)
                                            {
                                              Navigator.pushReplacement(
                                                context,
                                                new MaterialPageRoute(
                                                  builder: (context) =>
                                                      SignIn(),
                                                ),
                                              )
                                            }
                                        },
                                      ),
                                      child: Text("Save"),
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<User> postRequestSignOut() async {
    User user = new User();
    User.fromJson(await SharedPref().read("user"));
    if (user != null) {
      String url = 'http://' + localhost + ':8080/signout';
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Access-Control-Allow-Origin': '*'
      };
      String jsonBody = json.encode(user.toJson());

      // make POST request
      Response response =
          await post(Uri.parse(url), headers: headers, body: jsonBody);

      // check the status code for the result
      int statusCode = response.statusCode;
      print(statusCode);

      // User user = null;
      String body;
      if (statusCode == 200) {
        body = response.body;
        await SharedPref().remove("user");
      }
    }
    return user;
  }

  Future<User> postRequestDelete() async {
    User user = User.fromJson(await SharedPref().read("user"));
    if (user != null) {
      String url = 'http://' + localhost + ':8080/deleteprofile';
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Access-Control-Allow-Origin': '*'
      };
      String jsonBody = json.encode(user.toJson());
      print(jsonBody);

      // make POST request
      Response response =
          await post(Uri.parse(url), headers: headers, body: jsonBody);

      // check the status code for the result
      int statusCode = response.statusCode;
      print(statusCode);

      // User user = null;
      String body;
      if (statusCode == 200) {
        body = response.body;
        await SharedPref().remove("user");
      }
    }
    return user;
  }
}

class AccountMenu extends StatelessWidget {
  const AccountMenu({
    Key key,
    @required this.text,
    @required this.icon,
    @required this.press,
  }) : super(key: key);
  final String text, icon;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FlatButton(
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        //TODO: change color according to palette
        color: Color(0xFFF5F6F9),

        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 22,
              //TODO: add color according to palette
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
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SharedPref().read("user"),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          String image = User.fromJson(snapshot.data).imageUrl;
          image == null ? image = "" : image = image;
          print(image);
          if (snapshot.hasData) {
            return SizedBox(
              height: 115,
              width: 115,
              child: Stack(
                fit: StackFit.expand,
                overflow: Overflow.visible,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(image),
                  ),
                  Positioned(
                    bottom: 0,
                    right: -12,
                    child: SizedBox(
                      height: 46,
                      width: 46,
                      child: FlatButton(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(color: Colors.white),
                        ),
                        //TODO: change color according to palette
                        color: Color(0xFFF5F6F9),
                        //TODO: build body of the onpressed function
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfileImg(),
                            ),
                          );
                        },
                        child: SvgPicture.asset("assets/icons/camera_icon.svg"),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Scaffold();
          }
        });
  }
}
