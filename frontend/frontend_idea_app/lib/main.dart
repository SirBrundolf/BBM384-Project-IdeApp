import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:frontend_idea_app/SharedPref.dart';
import 'package:frontend_idea_app/User.dart';
import 'package:frontend_idea_app/screens/MainPage.dart';
import "package:frontend_idea_app/screens/SignIn.dart";

String localhost;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  bool keepMeLoggedIn = false;
  User user;

  try {
    localhost = Platform.isAndroid ? "10.0.2.2" : "127.0.0.1";
  } catch (e) {
    localhost = "127.0.0.1";
  }

  SharedPref().read("keepMeLoggedIn").then((value) => {
        value != null ? keepMeLoggedIn = value : keepMeLoggedIn = false,
        SharedPref().read("user").then((value) => {
              value != null
                  ? keepMeLoggedIn
                      ? user = User.fromJson(value)
                      : SharedPref().remove("user")
                  : user = null,
              if (user == null) keepMeLoggedIn = false,
              print(user.toString() + " " + keepMeLoggedIn.toString()),
              runApp(MyApp(user)),
            }),
      });
}

class MyApp extends StatelessWidget {
  User user;
  MyApp(this.user);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ideApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(user),
    );
  }
}

class MyHomePage extends StatefulWidget {
  User user;
  MyHomePage(this.user);

  @override
  _MyHomePageState createState() => _MyHomePageState(user);
}

class _MyHomePageState extends State<MyHomePage> {
  User user;
  _MyHomePageState(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: user != null ? MainPage() : SignIn(),
      ),
    );
  }
}
