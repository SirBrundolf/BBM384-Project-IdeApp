import 'dart:convert';

import 'package:frontend_idea_app/main.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:frontend_idea_app/SharedPref.dart';
import 'package:frontend_idea_app/User.dart';

class EditNameSurname extends StatefulWidget {
  @override
  _EditNameSurnameState createState() => _EditNameSurnameState();
}

class _EditNameSurnameState extends State<EditNameSurname> {
  final validator = GlobalKey<FormState>();
  User user;
  String username, name, surname;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SharedPref().read("user"),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            user = User.fromJson(snapshot.data);
            username = utf8.decode(user.username.runes.toList());
            name = utf8.decode(user.name.runes.toList());
            surname = utf8.decode(user.surname.runes.toList());
            final nameController = TextEditingController(text: name);
            final surnameController = TextEditingController(text: surname);
            return Scaffold(
              appBar: AppBar(
                elevation: 1,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: Container(
                padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                child: Form(
                  key: validator,
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of((context)).unfocus();
                    },
                    child: ListView(
                      children: [
                        Text(
                          "Edit Name & Surname",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFFFFFFF),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.grey,
                                size: 30,
                              ),
                              hintText: "Enter the new name:",
                              hintStyle: TextStyle(fontWeight: FontWeight.bold),
                              contentPadding: EdgeInsets.all(15)),
                          validator: (String name) {
                            if (name == null || name.isEmpty) {
                              return "This field cannot be empty";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: surnameController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFFFFFFF),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.grey,
                                size: 30,
                              ),
                              hintText: "Enter the new surname:",
                              hintStyle: TextStyle(fontWeight: FontWeight.bold),
                              contentPadding: EdgeInsets.all(15)),
                          validator: (String surname) {
                            if (surname == null || surname.isEmpty) {
                              return "This field cannot be empty";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        OutlineButton(
                          onPressed: () {
                            if (validator.currentState.validate()) {
                              name = nameController.text;
                              surname = surnameController.text;
                              user.name = name;
                              user.surname = surname;
                              postRequestEditName();
                              postRequestEditSurname();
                              SharedPref().save("user", user.toJson());
                              final snackBar = SnackBar(
                                content:
                                    Text('Name/Surname changed successfully!'),
                                backgroundColor: Colors.blue,
                                duration: const Duration(seconds: 3),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Navigator.pop(context);
                            }
                          },
                          child: Text("Save"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Scaffold();
          }
        });
  }

  Future<void> postRequestEditName() async {
    String url = 'http://' + localhost + ':8080/editprofile';
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Access-Control-Allow-Origin': '*'
    };
    String json = ' {"username" :"' +
        this.username +
        '","updatedField" :"name' +
        '","updatedData" :"' +
        this.name +
        '"}';

    // make POST request
    await post(Uri.parse(url), headers: headers, body: json);
  }

  Future<void> postRequestEditSurname() async {
    String url = 'http://' + localhost + ':8080/editprofile';
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Access-Control-Allow-Origin': '*'
    };
    String json = ' {"username" :"' +
        this.username +
        '","updatedField" :"surname' +
        '","updatedData" :"' +
        this.surname +
        '"}';

    // make POST request
    await post(Uri.parse(url), headers: headers, body: json);
  }
}
