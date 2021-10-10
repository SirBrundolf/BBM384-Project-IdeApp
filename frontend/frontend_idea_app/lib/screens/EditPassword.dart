import 'package:flutter/material.dart';
import 'package:frontend_idea_app/main.dart';
import 'package:frontend_idea_app/screens/EMailVerification.dart';
import 'package:frontend_idea_app/core/AppLogo.dart';
import 'package:frontend_idea_app/SharedPref.dart';
import 'package:frontend_idea_app/User.dart';
import 'package:http/http.dart';

class EditPassword extends StatefulWidget {
  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  final verificationController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final newPassword2Controller = TextEditingController();
  final validator = GlobalKey<FormState>();
  User user;
  @override
  initState() {
    SharedPref().read("user").then((value) => {user = User.fromJson(value)});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black54,
        ),
        title: AppLogo(),
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 100, 20, 10),
        child: Form(
          key: validator,
          child: Column(
            children: [
              TextFormField(
                controller: oldPasswordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFFFFFFF),
                    prefixIcon: Icon(
                      Icons.lock_open,
                      color: Colors.grey,
                      size: 30,
                    ),
                    hintText: "Enter old password:",
                    hintStyle: TextStyle(fontWeight: FontWeight.bold),
                    contentPadding: EdgeInsets.all(15)),
                validator: (String password) {
                  if (password == null || password.isEmpty) {
                    return "This field cannot be empty";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: newPasswordController,
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
                    hintText: "Enter new password:",
                    hintStyle: TextStyle(fontWeight: FontWeight.bold),
                    contentPadding: EdgeInsets.all(15)),
                validator: (String password) {
                  if (password == null || password.isEmpty) {
                    return "This field cannot be empty";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: newPassword2Controller,
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
                    hintText: "Enter new password again:",
                    hintStyle: TextStyle(fontWeight: FontWeight.bold),
                    contentPadding: EdgeInsets.all(15)),
                validator: (String password) {
                  if (password == null || password.isEmpty) {
                    return "This field cannot be empty";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 80,
              ),
              RaisedButton(
                onPressed: () async {
                  if (validator.currentState.validate()) {
                    //if (oldPasswordController.text == user.) {
                    if (newPasswordController.text ==
                        newPassword2Controller.text) {
                      if (newPasswordController.text.length > 4 &&
                          newPasswordController.text.length < 16) {
                        isCorrect(oldPasswordController.text, user.username)
                            .then((value) {
                          if (value == 0) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return EMailVerification(
                                      user.mailAddress,
                                      user.username,
                                      1,
                                      newPasswordController.text,
                                      oldPasswordController.text);
                                });
                          } else {
                            final snackBar = SnackBar(
                              content: Text('Password is not correct'),
                              backgroundColor: Colors.blue,
                              duration: const Duration(seconds: 3),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        });
                      } else {
                        final snackBar = SnackBar(
                          content: Text(
                              'The length of a password has to be between 4-16!'),
                          backgroundColor: Colors.blue,
                          duration: const Duration(seconds: 3),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    } else {
                      final snackBar = SnackBar(
                        content: Text(
                            'The length of a password has to be between 4-16!'),
                        backgroundColor: Colors.blue,
                        duration: const Duration(seconds: 3),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  } else {
                    final snackBar = SnackBar(
                      content: Text('New passwords are not matching!'),
                      backgroundColor: Colors.blue,
                      duration: const Duration(seconds: 3),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  //}
                  //else {
                  //  final snackBar = SnackBar(
                  //    content: Text('Old password is not matching!'),
                  //    backgroundColor: Colors.blue,
                  //    duration: const Duration(seconds: 3),
                  //  );
                  // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  //}
                },
                //},
                child: Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<int> isCorrect(String password, String username) async {
    String url = 'http://' + localhost + ':8080/password';
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Access-Control-Allow-Origin': '*'
    };
    String jsonBody =
        ' {"username" :"' + username + '","password" :"' + password + '"}';

    // make POST request
    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonBody);

    int value = int.parse(response.body);
    return value;
  }
}
