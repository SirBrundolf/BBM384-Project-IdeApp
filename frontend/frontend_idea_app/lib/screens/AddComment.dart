import "package:flutter/material.dart";
import 'package:frontend_idea_app/SharedPref.dart';
import 'package:frontend_idea_app/User.dart';
import 'package:frontend_idea_app/core/AppLogo.dart';
import 'package:frontend_idea_app/core/CoreAll.dart';
import 'package:frontend_idea_app/main.dart';
import 'package:http/http.dart';

class AddComment extends StatefulWidget {
  final String clubName, subClubName, timestamp;
  AddComment(this.clubName, this.subClubName, this.timestamp);
  @override
  _AddCommentState createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black54,
        ),
        title: AppLogo(),
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.only(top: 24),
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: contentController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFFFFFFF),
                            prefixIcon: Icon(
                              Icons.crop_original_outlined,
                              color: Colors.grey,
                              size: 30,
                            ),
                            hintText: "Enter Content",
                            hintStyle: TextStyle(fontWeight: FontWeight.bold),
                            contentPadding: EdgeInsets.all(15)),
                        validator: (String email) {
                          if (email == null || email.isEmpty) {
                            return "This field cannot be empty";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  height: MediaQuery.of(context).size.width / 1.5,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: GestureDetector(
                  child: RaisedButton(
                    color: Colors.green,
                    shape: StadiumBorder(),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      if (contentController.text != '') {
                        addComment();
                        Navigator.pop(context);
                      } else {
                        final snackBar = SnackBar(
                          content: Text('Comment cannot be empty'),
                          backgroundColor: const Color(0xFF3A4750),
                          duration: const Duration(seconds: 3),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addComment() async {
    User user = User.fromJson(await SharedPref().read("user"));
    String url = 'http://' + localhost + ':8080/addcomment';
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Access-Control-Allow-Origin': '*'
    };
    String jsonBody = '{"comment":{' +
        '"content":"' +
        contentController.text +
        '","author":"' +
        user.username +
        '","timestamp":"","vote":0 },"timestamp":"' +
        widget.timestamp +
        '","subClubName":"' +
        widget.subClubName +
        '","clubName":"' +
        widget.clubName +
        '"}';
    await post(Uri.parse(url), headers: headers, body: jsonBody);
  }
}
