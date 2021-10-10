import "package:flutter/material.dart";
import 'package:frontend_idea_app/SharedPref.dart';
import 'package:frontend_idea_app/User.dart';
import 'package:frontend_idea_app/main.dart';
import 'package:http/http.dart';
import "SignIn.dart";
import 'dart:convert';
import "EMailVerification.dart";

class SignUp extends StatelessWidget {
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordController2 = TextEditingController();

  final nameKey = GlobalKey<FormState>();
  final _globalKey = GlobalKey<ScaffoldMessengerState>();
  final passwordKey = GlobalKey();
  final passwordKey2 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: const Color(0xFFDADADA),
        body: Form(
          key: null,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Image.asset('assets/images/ideAppLogo.png'),
                  margin: EdgeInsets.fromLTRB(0, 40, 0, 30),
                ),
                Text(
                  "Create a new account",
                  style: TextStyle(
                    color: const Color(0xFF3A4750),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(10, 20, 10, 5),
                    child: Row(
                      children: [
                        new Flexible(
                            child: Container(
                          key: nameKey,
                          margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: TextFormField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                              hintText: "Name",
                            ),
                            validator: (String email) {
                              if (email == null || email.isEmpty) {
                                return "Please enter your name here.";
                              }
                              return null;
                            },
                          ),
                        )),
                        new Flexible(
                            child: Container(
                          margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: TextFormField(
                            controller: surnameController,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                              hintText: "Surname",
                            ),
                            validator: (String email) {
                              if (email == null || email.isEmpty) {
                                return "Please enter your surname here.";
                              }
                              return null;
                            },
                          ),
                        ))
                      ],
                    )),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.grey,
                      ),
                      hintText: "Your E-mail",
                    ),
                    validator: (String email) {
                      if (email == null || email.isEmpty) {
                        return "Please enter your E-mail here.";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.alternate_email,
                        color: Colors.grey,
                      ),
                      hintText: "Select an username",
                    ),
                    validator: (String email) {
                      if (email == null || email.isEmpty) {
                        return "Please enter your username here.";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  key: passwordKey,
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.grey,
                      ),
                      hintText: "Password",
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
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Row(
                      children: [
                        new Flexible(
                          child: Container(
                            key: passwordKey2,
                            child: TextFormField(
                              controller: passwordController2,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.grey,
                                ),
                                hintText: "Password again",
                              ),
                              validator: (String email) {
                                if (email == null || email.isEmpty) {
                                  return "Please enter your password here.";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        new Flexible(
                          child: Container(
                            width: 10,
                            child: Icon(Icons.battery_std),
                          ),
                        ),
                      ],
                    )),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 30),
                  width: double.infinity,
                  height: 50,
                  color: const Color(0xFF06A0A0),
                  child: TextButton(
                    onPressed: () {
                      if (nameController.text == '') {
                        final snackBar = SnackBar(
                          content: Text('Please enter your name'),
                          backgroundColor: const Color(0xFF3A4750),
                          duration: const Duration(seconds: 3),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (surnameController.text == '') {
                        final snackBar = SnackBar(
                          content: Text('Please enter your surname'),
                          backgroundColor: const Color(0xFF3A4750),
                          duration: const Duration(seconds: 3),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (emailController.text == '') {
                        final snackBar = SnackBar(
                          content: Text('Please enter your email address'),
                          backgroundColor: const Color(0xFF3A4750),
                          duration: const Duration(seconds: 3),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (usernameController.text == '') {
                        final snackBar = SnackBar(
                          content: Text('Please enter your username'),
                          backgroundColor: const Color(0xFF3A4750),
                          duration: const Duration(seconds: 3),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (passwordController.text == '') {
                        final snackBar = SnackBar(
                          content: Text('Please enter your password'),
                          backgroundColor: const Color(0xFF3A4750),
                          duration: const Duration(seconds: 3),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (passwordController2.text == '') {
                        final snackBar = SnackBar(
                          content: Text('Please enter your password again'),
                          backgroundColor: const Color(0xFF3A4750),
                          duration: const Duration(seconds: 3),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (passwordController.text !=
                          passwordController2.text) {
                        final snackBar = SnackBar(
                          content: Text('Passwords are not matched!'),
                          backgroundColor: const Color(0xFF3A4750),
                          duration: const Duration(seconds: 3),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        postRequestSignUp(context).then((value) => {
                              if (value != null)
                                {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EMailVerification(
                                          emailController.text,
                                          usernameController.text,
                                          3,
                                          "",
                                          ""),
                                    ),
                                    ModalRoute.withName("home"),
                                  )
                                }
                              else
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignIn(),
                                    ),
                                  )
                                }
                            });
                      }
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "have an account?",
                      style: TextStyle(
                        color: const Color(0xFF3A4750),
                      ),
                    ),
                    TextButton(
                        onPressed: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignIn(),
                                ),
                              )
                            },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: const Color(0xFF3A4750),
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<User> postRequestSignUp(BuildContext context) async {
    print(usernameController.text);

    String url = 'http://' + localhost + ':8080/signup';
    Map<String, String> headers = {"Content-type": "application/json"};
    String jsonBody = ' {"user" : {"username" :"' +
        usernameController.text +
        '","mailAddress" : "' +
        emailController.text +
        '","imageUrl" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeUGzSUbfQVEgY4TH7CZEl14ED8WXrixgU9A&usqp=CAU","isAdmin" : "0","surname": "' +
        surnameController.text +
        '","name":"' +
        nameController.text +
        '","id": "1231230","signStatus": "0","isVerified": "false"},"password" :"' +
        passwordController.text +
        '"}';

    // make POST request
    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonBody);

    // check the status code for the result
    int statusCode = response.statusCode;
    print(statusCode);
    User user = null; // risky code?
    String body;
    // this API passes back the id of the new item added to the body
    if (statusCode == 200) {
      body = response.body;
      if (json.decode(body)[0] == 0) {
        user = User.fromJson(json.decode(body)[1]);
        await SharedPref().save("user", user.toJson());
      } else if (json.decode(body)[0] == 1) {
        final snackBar = SnackBar(
          content: Text('Email/username is already registered'),
          backgroundColor: const Color(0xFF3A4750),
          duration: const Duration(seconds: 3),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    //final readedUser = await SharedPref().read("user");
    //print(readedUser);
    return user;
  }
}
