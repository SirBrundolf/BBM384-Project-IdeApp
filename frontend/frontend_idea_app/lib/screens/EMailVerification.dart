import 'package:flutter/material.dart';
import 'package:frontend_idea_app/main.dart';
import 'package:frontend_idea_app/screens/ForgotPassword.dart';
import "package:frontend_idea_app/screens/MainPage.dart";
import "package:frontend_idea_app/screens/ForgotPassword.dart";
import 'dart:convert';
import 'package:frontend_idea_app/User.dart';
import 'package:frontend_idea_app/SharedPref.dart';
import 'package:frontend_idea_app/screens/SignIn.dart';
import 'package:http/http.dart';

class EMailVerification extends StatefulWidget {
  String email, username, oldPassword, newPassword;
  int flag;
  EMailVerification(
      this.email, this.username, this.flag, this.newPassword, this.oldPassword);
  @override
  _EMailVerificationState createState() => _EMailVerificationState();
}

class _EMailVerificationState extends State<EMailVerification> {
  final verificationController = TextEditingController();
  final verificationValidator = GlobalKey<FormState>();
  String code;
  bool forgot;
  User user;

  @override
  void initState() {
    if (widget.email == "") {
      forgot = true;
      getMailAddress(widget.username).then((value) => {
            widget.email = value,
            sendCode(widget.email).then((value) => {code = value})
          });
    } else {
      forgot = false;
      sendCode(widget.email).then((value) => {code = value});
      SharedPref().read("user").then((value) => user = User.fromJson(value));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: MediaQuery.of(context).size.height / 5, // original = 200
        width: MediaQuery.of(context).size.width / 1.5, // original = 550
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 25,
              ),
              Text("A verification code is sent to your e-mail."),
              Text("Please enter the code:"),
              SizedBox(
                height: 25,
              ),
              Form(
                key: verificationValidator,
                child: TextFormField(
                  controller: verificationController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFFFFFFF),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.send_rounded,
                        color: Colors.grey,
                        size: 30,
                      ),
                      onPressed: () {
                        if (verificationValidator.currentState.validate()) {
                          if (code == verificationController.text) {
                            if (this.widget.flag == 0) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ForgotPass(widget.username),
                                ),
                              );
                              final snackBar = SnackBar(
                                content: Text('Email verified successfully!'),
                                backgroundColor: Colors.blue,
                                duration: const Duration(seconds: 3),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else if (this.widget.flag == 1) {
                              postRequestEditPassword();
                              SharedPref().save("user", user.toJson());
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainPage(),
                                ),
                              );
                              final snackBar = SnackBar(
                                content: Text('Password changed successfully!'),
                                backgroundColor: Colors.blue,
                                duration: const Duration(seconds: 3),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainPage(),
                                ),
                              );
                              final snackBar = SnackBar(
                                content: Text('Email verified successfully!'),
                                backgroundColor: Colors.blue,
                                duration: const Duration(seconds: 3),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }
                        }
                      },
                    ),
                    contentPadding: EdgeInsets.all(15),
                  ),
                  validator: (String code) {
                    if (code == null || code.isEmpty) {
                      return "This field cannot be empty";
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> getMailAddress(String username) async {
    String url = 'http://' + localhost + ':8080/getmailaddress';
    Map<String, String> headers = {"Content-type": "application/json"};
    String jsonBody = username;
    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonBody);
    return response.body;
  }

  Future<String> sendCode(String mailAddress) async {
    String result;
    String url = 'http://' + localhost + ':8080/mailverification';
    Map<String, String> headers = {"Content-type": "application/json"};
    String jsonBody = mailAddress;

    // make POST request
    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonBody);

    // check the status code for the result
    int statusCode = response.statusCode;

    String body;
    // this API passes back the id of the new item added to the body
    if (statusCode == 200) {
      body = response.body;
      result = json.decode(body).toString();
    }

    return result;
  }

  Future<void> postRequestEditPassword() async {
    String url = 'http://' + localhost + ':8080/editprofile';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = ' {"username" :"' +
        this.widget.username +
        '","updatedField" :"password' +
        '","updatedData" :"' +
        this.widget.oldPassword +
        " " +
        this.widget.newPassword +
        '"}';

    // make POST request
    await post(Uri.parse(url), headers: headers, body: json);
  }

  Future<void> postRequestEditEmail() async {
    String url = 'http://' + localhost + ':8080/editprofile';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = ' {"username" :"' +
        this.widget.username +
        '","updatedField" :"mailAddress' +
        '","updatedData" :"' +
        this.widget.email +
        '"}';

    // make POST request
    await post(Uri.parse(url), headers: headers, body: json);
  }
}
