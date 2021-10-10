import "package:flutter/material.dart";
import 'package:frontend_idea_app/main.dart';
import 'package:frontend_idea_app/screens/EMailVerification.dart';
import 'package:frontend_idea_app/screens/MainPage.dart';
import 'package:http/http.dart';
import 'package:frontend_idea_app/SharedPref.dart';
import "SignUp.dart";
import 'dart:convert';
import 'package:frontend_idea_app/screens/EMailVerification.dart';
import "package:frontend_idea_app/User.dart";
import '../main.dart';

// ignore: must_be_immutable
class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool checkBoxValue;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final validator = GlobalKey<FormState>();

  @override
  void initState() {
    checkBoxValue = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: const Color(0xFFDADADA),
        body: Form(
          key: validator,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Image.asset('assets/images/ideAppLogo.png'),
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 15),
                ),
                Container(
                  child: Text(
                    "Sign in To Your Account",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: const Color(0xFF3A4750)),
                  ),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: const Color(0xFFFFFFFF),
                        prefixIcon: Icon(
                          Icons.alternate_email,
                          color: Colors.grey,
                          size: 30,
                        ),
                        hintText: "Your Username",
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                        contentPadding: EdgeInsets.all(15)),
                    validator: (String email) {
                      if (email == null || email.isEmpty) {
                        return "Please enter an username here.";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: const Color(0xFFFFFFFF),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.grey,
                        size: 30,
                      ),
                      hintText: "Password",
                      hintStyle: TextStyle(fontWeight: FontWeight.bold),
                      contentPadding: EdgeInsets.all(15),
                    ),
                    validator: (String email) {
                      if (email == null || email.isEmpty) {
                        return "Please enter your password here.";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.fromLTRB(0, 5, 10, 0),
                  child: TextButton(
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          color: const Color(0xFF3A4750)),
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EMailVerification(
                            "",
                            usernameController.text,
                            0,
                            "",
                            "",
                          ),
                        ),
                        ModalRoute.withName("home"),
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 5),
                  child: Row(
                    children: [
                      Checkbox(
                        value: checkBoxValue,
                        onChanged: (bool boxValue) {
                          setState(() {
                            checkBoxValue = boxValue;
                          });
                        },
                      ),
                      Text(
                        "Keep me signed in",
                        style: TextStyle(
                          color: const Color(0xCC3A4750),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                  //alignment: Alignment.center,
                  width: double.infinity,
                  height: 50,
                  color: const Color(0xFF0E8E96),
                  child: TextButton(
                    onPressed: () {
                      if (usernameController.text == '') {
                        final snackBar = SnackBar(
                          content: Text('Username/email cannot be empty'),
                          backgroundColor: const Color(0xFF3A4750),
                          duration: const Duration(seconds: 3),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (passwordController.text == '') {
                        final snackBar = SnackBar(
                          content: Text('Password cannot be empty'),
                          backgroundColor: const Color(0xFF3A4750),
                          duration: const Duration(seconds: 3),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        postRequestSignIn(context).then((value) => {
                              if (value != null)
                                {
                                  print(value),
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MainPage(),
                                    ),
                                    ModalRoute.withName("home"),
                                  ),
                                }
                            });
                      }
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.white,
                      ),
                    ),
                    Text("  OR  "),
                    Expanded(
                      child: Divider(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                  width: double.infinity,
                  height: 50,
                  color: const Color(0xFF0E8E96),
                  child: TextButton(
                      onPressed: () => {
                            SharedPref().remove("user"),
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainPage(),
                              ),
                              ModalRoute.withName("home"),
                            ),
                          },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.visibility_off_outlined,
                              color: const Color(0xFF2E3A59),
                              size: 30,
                            ),
                            Text(
                              "I just want to browse             ",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? "),
                      TextButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUp(),
                            ),
                          )
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                              color: const Color(0xFF3A4750),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<User> postRequestSignIn(BuildContext context) async {
    if (validator.currentState.validate()) {
      String url = 'http://' + localhost + ':8080/signin';
      Map<String, String> headers = {"Content-type": "application/json"};
      String jsonBody = ' {"user" : {"username" :"' +
          usernameController.text +
          '"},"password" :"' +
          passwordController.text +
          '"}';

      // make POST request
      Response response =
          await post(Uri.parse(url), headers: headers, body: jsonBody);

      // check the status code for the result
      int statusCode = response.statusCode;

      User user;
      String body;
      if (statusCode == 200) {
        body = response.body;
        if (json.decode(body)[0] == 0) {
          user = User.fromJson(json.decode(body)[1]);
          await SharedPref().save("user", user.toJson());
          if (checkBoxValue) {
            SharedPref().save("keepMeLoggedIn", true);
            print(">>>kmli saved.");
          }
        } else if (json.decode(body)[0] == 2) {
          final snackBar = SnackBar(
            content: Text('Password is not correct'),
            backgroundColor: const Color(0xFF3A4750),
            duration: const Duration(seconds: 3),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          final snackBar = SnackBar(
            content: Text('Username/email is not found'),
            backgroundColor: const Color(0xFF3A4750),
            duration: const Duration(seconds: 3),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }

      return user;
    }
    return null;
  }
}
